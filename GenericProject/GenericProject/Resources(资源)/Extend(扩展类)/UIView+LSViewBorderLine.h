//
//  UIView+LSViewBorderLine.h
//  GenericProject
//
//  Created by 社科赛斯 on 2019/12/12.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_OPTIONS(NSUInteger, UIBorderSideType) {
    //全边框
    UIBorderSideTypeAll,
    //单边框
    UIBorderSideTypeTop,
    UIBorderSideTypeBottom,
    UIBorderSideTypeLeft,
    UIBorderSideTypeRight,
    //双边框
    UIBorderSideTypeTopAndBottom,//上下
    UIBorderSideTypeTopAndLeft,//上左
    UIBorderSideTypeTopAndRight,//上右
    UIBorderSideTypeLeftAndBottom,//左下
    UIBorderSideTypeLeftAndRight,//左右
    UIBorderSideTypeRightAndBottom,//右下
    //三边框
    UIBorderSideTypeTopAndBottomAndLeft,//上下左
    UIBorderSideTypeTopAndBottomAndRight,//上下右
    UIBorderSideTypeTopAndLeftAndRight,//左右上
    UIBorderSideTypeLeftAndRightAndBottom,//左右下
};

@interface UIView (LSViewBorderLine)

- (UIView *)borderForTopColor:(UIColor *)topColor BottomColor:(UIColor *)bottomColor LeftColor:(UIColor *)leftColor RightColor:(UIColor *)rightColor borderWidth:(CGFloat)borderWidth borderType:(UIBorderSideType)borderType;

@end

NS_ASSUME_NONNULL_END
