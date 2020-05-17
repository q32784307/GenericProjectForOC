//
//  NSString+TextInputStringType.h
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2018/8/1.
//  Copyright © 2018年 漠然丶情到深处. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,TextInputStringType) {
    TextInputStringTypeNumber,         //数字
    TextInputStringTypeLetter,         //字母
    TextInputStringTypeChinese,        //汉字
    TextInputStringTypeEmoji,          //表情
};

@interface NSString (TextInputStringType)

/**
 某个字符串是不是数字、字母、汉字。
 */
- (BOOL)isCertainStringType:(TextInputStringType)stringType;

/**
 字符串是不是特殊字符，此时的特殊字符就是：出数字、字母、汉字以外的。
 */
- (BOOL)isSpecialLetter;

@end
