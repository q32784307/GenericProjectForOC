//
//  UIView+Extension.h
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2017/2/21.
//  Copyright © 2017年 漠然丶情到深处. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)

@property(nonatomic,assign)CGFloat x;
@property(nonatomic,assign)CGFloat y;
@property(nonatomic,assign)CGFloat width;
@property(nonatomic,assign)CGFloat height;
@property(nonatomic,assign)CGFloat centerX;
@property(nonatomic,assign)CGFloat centerY;
@property(nonatomic,assign)CGSize size;
@property(nonatomic,assign)IBInspectable CGFloat borderWidth;
@property(nonatomic,assign)IBInspectable UIColor *borderColor;
@property(nonatomic,assign)IBInspectable CGFloat cornerRadius;

/** 获取最大x */
- (CGFloat)maxX;
/** 获取最小x */
- (CGFloat)minX;

/** 获取最大y */
- (CGFloat)maxY;
/** 获取最小y */
- (CGFloat)minY;

/** 设置最小x,相当于设置x */
- (void)setMinX:(CGFloat)minX;

/** 设置最大x */
- (void)setMaxX:(CGFloat)maxX;

/** 设置最小y,相当于设置y */
- (void)setMinY:(CGFloat)minY;

/** 设置最大y */
- (void)setMaxY:(CGFloat)maxY;

/**
 *  水平居中
 */
- (void)alignHorizontal;
/**
 *  垂直居中
 */
- (void)alignVertical;
/**
 *  判断是否显示在主窗口上面
 *
 *  @return 是否
 */
- (BOOL)isShowOnWindow;

- (UIViewController *)parentController;

/// 查找子视图且不会保存
///
/// @param view      要查找的视图
/// @param clazzName 子控件类名
///
/// @return 找到的第一个子视图
+ (UIView *)foundViewInView:(UIView *)view clazzName:(NSString *)clazzName;

@end
