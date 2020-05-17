//
//  AppDelegate.h
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2018/4/21.
//  Copyright © 2018年 漠然丶情到深处. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSBaseTabBarViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) LSBaseTabBarViewController *mainTabBar;

//单例
+ (AppDelegate *)shareAppDelegate;

@end

