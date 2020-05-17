//
//  LSSensitiveWords.m
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/11/21.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import "LSSensitiveWords.h"

@interface LSSensitiveWords ()

@property(nonatomic,strong)NSMutableDictionary *keyword_chains;
@property(nonatomic,copy)NSString *delimit;

@end

@implementation LSSensitiveWords

- (instancetype)init {
    if(self == [super init]) {
        _delimit = @"\x00";
    }
    return self;
}

/// 读取解析敏感词
- (void)parseSensitiveWords:(NSString *)path {
    if(path == nil) {
        path = [[NSBundle mainBundle] pathForResource:@"shieldwords" ofType:@"txt"];
    }
    NSString *content = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSArray *keyWordList = [content componentsSeparatedByString:@","];
    for (NSString *keyword in keyWordList) {
        [self addSensitiveWords:keyword];
    }
}

/// 添加敏感词到敏感词树
- (void)addSensitiveWords:(NSString *)keyword {
    keyword = keyword.lowercaseString;
    keyword = [keyword stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if(keyword.length <= 0) {
        return;
    }
    
    NSMutableDictionary *node = self.keyword_chains;
    for (int i = 0; i < keyword.length; i ++) {
        NSString *word = [keyword substringWithRange:NSMakeRange(i, 1)];
        if (node[word] == nil) {
            node[word] = [NSMutableDictionary dictionary];
        }
        node = node[word];
    }
    //敏感词最后一个字符标识
    [node setValue:@0 forKey:self.delimit];
}

- (NSString *)filterSensitiveWords:(NSString *)message replaceKey:(NSString *)replaceKey {
    replaceKey = replaceKey == nil ? @"*" : replaceKey;
    message = message.lowercaseString;
    NSMutableArray *retArray = [[NSMutableArray alloc] init];
    NSInteger start = 0;
    while (start < message.length) {
        NSMutableDictionary *level = self.keyword_chains.mutableCopy;
        NSInteger step_ins = 0;
        NSString *message_chars = [message substringWithRange:NSMakeRange(start, message.length - start)];
        for(int i = 0; i < message_chars.length; i++) {
            NSString *chars_i = [message_chars substringWithRange:NSMakeRange(i, 1)];
            if([level.allKeys containsObject:chars_i]) {
                step_ins += 1;
                NSDictionary *level_char_dict = level[chars_i];
                if(![level_char_dict.allKeys containsObject:self.delimit]) {
                    level = level_char_dict.mutableCopy;
                }else{
                    NSMutableString *ret_str = [[NSMutableString alloc] init];
                    for(int i = 0; i < step_ins; i++) {
                         [ret_str appendString:replaceKey];
                    }
                    [retArray addObject:ret_str];
                    start += (step_ins - 1);
                    break;
                }
            }else{
                [retArray addObject:[NSString stringWithFormat:@"%C",[message characterAtIndex:start]]];
                break;
            }
        }
        start ++;
    }
    return [retArray componentsJoinedByString:@""];
}

- (NSMutableDictionary *)keyword_chains {
    if(_keyword_chains == nil) {
        _keyword_chains = [[NSMutableDictionary alloc] initWithDictionary:@{}];
    }
    return _keyword_chains;
}

@end
