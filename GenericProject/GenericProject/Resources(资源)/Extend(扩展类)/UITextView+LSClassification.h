//
//  UITextView+LSClassification.h
//  SuccessSchool
//
//  Created by 漠然丶情到深处 on 2019/11/29.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^textViewInfo)(NSString *text,CGSize textViewSize);

@interface UITextView (LSClassification)

@property(nonatomic,strong)NSString *placeholder;//占位符,可与下面属性任意一个同时设置
@property(nonatomic,copy)NSNumber *limitLength;//需要限制的字数          优先级高于lines
@property(nonatomic,copy)NSNumber *limitLines;//需要限制的行数
@property(nonatomic,strong)UIFont *placeholdFont;//占位符文字          默认13号字体
@property(nonatomic,strong)UIFont *limitPlaceFont;//行数、字数限制文字     默认13号字体
@property(nonatomic,strong)UIColor *placeholdColor;//占位符文字颜色    默认灰色
@property(nonatomic,strong)UIColor *limitPlaceColor;//行数、字数限制文字颜色 默认灰色
@property(nonatomic,copy)NSNumber *autoHeight;//自动高度 默认不计算 设置@1自动计算高度
@property(nonatomic,copy)textViewInfo infoBlock;//获取当前字数、当前高度的block

/* ******特殊说明。如果你想对textView.text直接赋值*******
 *       请务必在对placehoulder和limitLength之前进行
 *       一旦你对text赋值了，你需要立马重新对placeholder赋值。
 *       格式：
 *             textView.text = @"请务必写在placeholder和limitLength之前";
 *             textView.placeholder = @"喜欢请Star";
 *             textView.limitLength = @20;//如果赋值长度大于此长度会被自动截断！
 *             textView限制行数的优先级低于字数限制
 */

@end

NS_ASSUME_NONNULL_END
