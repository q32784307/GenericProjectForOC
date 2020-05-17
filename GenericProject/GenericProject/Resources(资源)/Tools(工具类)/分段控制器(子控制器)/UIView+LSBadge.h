//
//  UIView+LSBadge.h
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/6/25.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//



NS_ASSUME_NONNULL_BEGIN

@interface UIView (LSBadge)

- (void)addNormalBadgeWithBadgeOffsetSize:(CGSize)size;
- (void)addNormalBadgeWithColor:(UIColor *)color borderColor:(UIColor *)bColor badgeOffsetSize:(CGSize)size;

- (void)addNumberBadge:(NSInteger)number badgeOffsetSize:(CGSize)size;
- (void)addNumberBadge:(NSInteger)number badgeOffsetSize:(CGSize)size color:(UIColor *)color borderColor:(UIColor *)bColor;
- (void)addNumber_1;
- (void)reduceNumber_1;

- (void)clearNumberBadge;

@end

NS_ASSUME_NONNULL_END
