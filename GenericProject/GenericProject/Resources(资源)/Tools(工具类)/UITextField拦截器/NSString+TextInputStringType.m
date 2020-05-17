//
//  NSString+TextInputStringType.m
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2018/8/1.
//  Copyright © 2018年 漠然丶情到深处. All rights reserved.
//

#import "NSString+TextInputStringType.h"

@implementation NSString (TextInputStringType)

- (BOOL)isCertainStringType:(TextInputStringType)stringType {
    return [self matchRegularWith:stringType];
}

- (BOOL)isSpecialLetter {
    if ([self isCertainStringType:TextInputStringTypeNumber] || [self isCertainStringType:TextInputStringTypeLetter] || [self isCertainStringType:TextInputStringTypeChinese]) {
        return NO;
    }
    return YES;
}

#pragma mark --- 用正则判断条件
- (BOOL)matchRegularWith:(TextInputStringType)type {
    NSString *regularStr = @"";
    switch (type) {
        case TextInputStringTypeNumber:      //数字
            regularStr = @"^[0-9]*$";
            break;
        case TextInputStringTypeLetter:      //字母
            regularStr = @"^[A-Za-z]+$";
            break;
        case TextInputStringTypeChinese:     //汉字
            regularStr = @"^[\u4e00-\u9fa5]{0,}$";
            break;
        case TextInputStringTypeEmoji:       //表情
            regularStr = @"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]";
            break;
        default:
            break;
    }
    NSPredicate *regextestA = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regularStr];
    
    if ([regextestA evaluateWithObject:self] == YES){
        return YES;
    }
    return NO;
}

@end
