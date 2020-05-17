//
//  NSString+RegularExpression.h
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2018/5/18.
//  Copyright © 2018年 漠然丶情到深处. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (RegularExpression)

/**
 * 验证身份证号有效性
 */
- (BOOL)validateIDCardNumber:(NSString *)idCardNumber;

/**
 * 根据身份证判断性别
 */
- (NSString *)sexStringIdentifyCard:(NSString *)cardNumber;

/**
 * 验证银行卡号有效性
 */
- (BOOL)bankCardluhmCheck;

/**
 * 验证邮箱的有效性
 */
- (BOOL)isEmailAddress;

/**
 * 验证是否有特殊符号
 */
- (BOOL)effectivePassword;

/**
 * 验证密码是否有效
 */
- (BOOL)isValidPassword;

/**
 * 验证手机号有效性
 */
- (BOOL)isMobileNumberClassification;

/**
 * 验证是否符合最小长度、最长长度，是否包含中文,首字母是否可以为数字
 */
- (BOOL)isValidWithMinLenth:(NSInteger)minLenth maxLenth:(NSInteger)maxLenth containChinese:(BOOL)containChinese firstCannotBeDigtal:(BOOL)firstCannotBeDigtal;

/**
 * 验证是否符合最小长度、最长长度，是否包含中文,数字，字母，其他字符，首字母是否可以为数字
 */
- (BOOL)isValidWithMinLenth:(NSInteger)minLenth maxLenth:(NSInteger)maxLenth containChinese:(BOOL)containChinese containDigtal:(BOOL)containDigtal containLetter:(BOOL)containLetter containOtherCharacter:(NSString *)containOtherCharacter firstCannotBeDigtal:(BOOL)firstCannotBeDigtal;

#pragma 正则匹配手机号
- (BOOL)validateCellPhoneNumber:(NSString *)cellNum;

// 判断长度大于8位，且必须包含数字、字母和特殊h符号的其中2种
- (BOOL)judgePassWordLegal:(NSString *)pass;

@end
