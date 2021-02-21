//
//  NSString+LSFuzzySearch.m
//  GenericProject
//
//  Created by 社科塞斯 on 2021/2/21.
//  Copyright © 2021 漠然丶情到深处. All rights reserved.
//

#import "NSString+LSFuzzySearch.h"

@implementation NSString (LSFuzzySearch)

+ (NSString *)tansformToMixedStringWithOriginStr:(NSString *)originStr {
    // 转成了可变字符串
    NSMutableString *str = [NSMutableString stringWithString:originStr];
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
    NSArray *pinyinArray = [str componentsSeparatedByString:@" "];
    
    NSMutableString *allString = [NSMutableString new];

    // 得到拼音
    NSMutableString *pinyinString = [NSMutableString new];
    for (NSString *s in pinyinArray) {
        [pinyinString appendString:s];
    }
    
    // 得到拼音首字母
    NSMutableString *initialStr = [NSMutableString new];
    for (NSString *s in pinyinArray){
        if (s.length > 0){
            [initialStr appendString:  [s substringToIndex:1]];
        }
    }
    
    [allString appendFormat:@"%@,",originStr];// 添加汉字
    [allString appendFormat:@"%@,",pinyinString]; // 添加小写拼音
    [allString appendFormat:@"%@,",[pinyinString uppercaseString]]; // 添加大写拼音
    [allString appendFormat:@"%@,",initialStr]; // 添加小写首字母
    [allString appendFormat:@"%@",[initialStr uppercaseString]]; // 添加大写首字母

    return [allString copy];
}

@end
