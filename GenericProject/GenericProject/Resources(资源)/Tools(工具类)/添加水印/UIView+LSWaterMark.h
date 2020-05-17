//
//  UIView+LSWaterMark.h
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/10/18.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (LSWaterMark)

- (void)addWaterMarkText:(NSString *)waterText WithTextColor:(UIColor *)color WithFont:(UIFont *)font;

@end

NS_ASSUME_NONNULL_END
