//
//  LSBaseViewController.h
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2018/5/30.
//  Copyright © 2018年 漠然丶情到深处. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSBaseViewController : UIViewController

@property(nonatomic,strong)NetworkRequest *networkRequest;
@property(nonatomic,strong)LSBaseNavigationView *navView;
@property(nonatomic,strong)UITableView *mainTableView;

/**
 *  修改状态栏颜色
 */
@property(nonatomic,assign)UIStatusBarStyle StatusBarStyle;

/**
 *  是否隐藏导航栏
 */
@property(nonatomic,assign)BOOL isHidenNaviBar;

/**
 *  是否开启刷新事件
 */
@property(nonatomic,assign)BOOL isOpenUpDate;

/**
 *  默认返回按钮的点击事件，默认是返回，子类可重写
 */
- (void)backBtnClicked;

- (BOOL)isShowingOnKeyWindow;

@end
