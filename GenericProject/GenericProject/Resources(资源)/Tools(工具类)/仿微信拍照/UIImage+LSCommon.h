//
//  UIImage+LSCommon.h
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/12/10.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (LSCommon)

/// 将图片旋转弧度radians
- (UIImage *)ls_imageRotatedByRadians:(CGFloat)radians;
/// 提取图片上某位置像素的颜色
- (UIColor *)ls_colorAtPixel:(CGPoint)point;

@end

NS_ASSUME_NONNULL_END
