//
//  TextInputIntercepter.h
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2018/8/1.
//  Copyright © 2018年 漠然丶情到深处. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TextInputIntercepter;

typedef void(^TextInputIntercepterBlock) (TextInputIntercepter *textInputIntercepter, NSString *string);

typedef NS_ENUM(NSUInteger, TextInputIntercepterNumberType) {
    // 非数字
    TextInputIntercepterNumberTypeNone = 0,
    // 只允许 数字
    TextInputIntercepterNumberTypeNumberOnly,
    // 分数 (默认 两位 小数)
    TextInputIntercepterNumberTypeDecimal,
};

@interface TextInputIntercepter : NSObject<UITextFieldDelegate, UITextViewDelegate>

// maxCharacterNum 限制 最大 字符
@property(nonatomic,assign)NSUInteger maxCharacterNum;

// decimalPlaces 小数 位数
// (当intercepterNumberType 为FJFTextInputIntercepterNumberTypeDecimal 有用)
@property(nonatomic,assign)NSUInteger decimalPlaces;

// beyoudLimitBlock 超过限制 最大 字符数 回调
@property(nonatomic,copy)TextInputIntercepterBlock beyoudLimitBlock;

// emojiAdmitted 是否 允许 输入 表情
@property(nonatomic,assign,getter = isEmojiAdmitted)BOOL emojiAdmitted;

// intercepterNumberType 数字 类型
// TextInputIntercepterNumberTypeNone 默认
// TextInputIntercepterNumberTypeNumberOnly 只允许 输入 数字，emojiAdmitted，decimalPlaces 不起作用
// TextInputIntercepterNumberTypeDecimal 分数 emojiAdmitted 不起作用 decimalPlaces 小数 位数
@property(nonatomic,assign)TextInputIntercepterNumberType  intercepterNumberType;

/**
 doubleBytePerChineseCharacter 为 NO
 字母、数字、汉字都是1个字节 表情是两个字节
 doubleBytePerChineseCharacter 为 YES
 不允许 输入表情 一个汉字是否代表两个字节 default YES
 允许 输入表情 一个汉字代表3个字节 表情 代表 4个字节
 */
@property(nonatomic,assign,getter = isDoubleBytePerChineseCharacter)BOOL doubleBytePerChineseCharacter;

/**
 设置 需要 拦截的输入框
 
 @param textInputView 输入框
 */
- (void)textInputView:(UIView *)textInputView;

/**
 设置 拦截器和拦截的输入框
 
 @param textInputView 输入框
 @param intercepter 拦截器
 */
+ (void)textInputView:(UIView *)textInputView setInputIntercepter:(TextInputIntercepter *)intercepter;

/**
 生成 输入框 拦截器
 
 @param textInputView 需要限制的输入框
 @param beyoudLimitBlock 超过限制 回调
 @return 生成 输入框 拦截器
 */
+ (TextInputIntercepter *)textInputView:(UIView *)textInputView beyoudLimitBlock:(TextInputIntercepterBlock)beyoudLimitBlock;

@end
