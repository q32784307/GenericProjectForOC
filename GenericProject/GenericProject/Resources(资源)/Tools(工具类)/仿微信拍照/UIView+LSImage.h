//
//  UIView+LSImage.h
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/12/10.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 视图转换为Image
@interface UIView (LSImage)

/// 截取视图转Image
/// @param range 截图区域
- (UIImage *)ls_imageByViewInRect:(CGRect)range;

@end

NS_ASSUME_NONNULL_END
