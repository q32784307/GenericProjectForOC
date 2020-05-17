//
//  UILabel+LSLabelAdaptive.h
//  GenericProject
//
//  Created by 社科赛斯 on 2019/12/12.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (LSLabelAdaptive)

#pragma mark - UILabel 自适应高度
/**
 *  @brief                                         UILabel 自适应高度
 *  @param width                                   控件的宽度
 *  @param title                                   控件上显示的内容
 *  @param font                                    控件上显示的内容的字体大小
 */
+ (CGFloat)getHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont *)font;

#pragma mark - UILabel 自适应宽度
/**
 *  @brief                                         UILabel 自适应宽度
 *  @param title                                   控件上显示的内容
 *  @param font                                    控件上显示的内容的字体大小
 */
+ (CGFloat)getWidthWithTitle:(NSString *)title font:(UIFont *)font;

#pragma mark - UILabel 行间距
/**
 *  @brief                                         UILabel 行间距
 *  @param label                                   控件
 *  @param space                                   间距数值
 */
+ (void)changeLineSpaceForLabel:(UILabel *)label WithSpace:(float)space;

#pragma mark - UILabel 字间距
/**
 *  @brief                                         UILabel 字间距
 *  @param label                                   控件
 *  @param space                                   间距数值
 */
+ (void)changeWordSpaceForLabel:(UILabel *)label WithSpace:(float)space;

#pragma mark - UILabel 行间距 与 字间距
/**
 *  @brief                                         UILabel 行间距 与 字间距
 *  @param label                                   控件
 *  @param lineSpace                               行间距数值
 *  @param wordSpace                               字间距数值
 */
+ (void)changeSpaceForLabel:(UILabel *)label withLineSpace:(float)lineSpace WordSpace:(float)wordSpace;

@end

NS_ASSUME_NONNULL_END
