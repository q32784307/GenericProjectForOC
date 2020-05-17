//
//  LSBaseTabBarView.h
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2018/6/12.
//  Copyright © 2018年 漠然丶情到深处. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LSBaseTabBarView;

@protocol TabBarDelegate <NSObject>

@optional

- (void)tabBarMoreButtonAction:(LSBaseTabBarView *)tabBar;

@end

@interface LSBaseTabBarView : UITabBar

/** tabbar的代理 */
@property(nonatomic,weak)id<TabBarDelegate>BarButtonDelegate;

@end
