//
//  UIColor+LSColor.h
//  GenericProject
//
//  Created by 社科赛斯 on 2019/12/12.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (LSColor)

+ (UIColor *)colorWithHexString:(NSString *)color Alpha:(CGFloat)alpha;

//16进制颜色转换
+ (UIColor *)colorWithHexString:(NSString *)color;

@end

NS_ASSUME_NONNULL_END
