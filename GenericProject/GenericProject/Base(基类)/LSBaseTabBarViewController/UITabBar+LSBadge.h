//
//  UITabBar+LSBadge.h
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/10/24.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITabBar (LSBadge)

- (void)showBadgeOnItemIndex:(int)index;   //显示小红点
- (void)hideBadgeOnItemIndex:(int)index;   //隐藏小红点

@end

NS_ASSUME_NONNULL_END
