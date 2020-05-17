//
//  CaseTwoViewController.m
//  GenericProject
//
//  Created by 社科赛斯 on 2020/1/9.
//  Copyright © 2020 漠然丶情到深处. All rights reserved.
//

#import "CaseTwoViewController.h"

@interface CaseTwoViewController ()

@end

@implementation CaseTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigation];
    [self analysis];
    [self createSubViews];
}

- (void)setNavigation {
    self.navView.isShowRightButton = NO;
    self.navView.titleLabelText = @"案例二";
}

- (void)analysis {
    
}

- (void)createSubViews {
//    self.mainTableView.frame = CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth, ScreenHeight - NAVIGATION_BAR_HEIGHT - HOME_INDICATOR_HEIGHT);
//    [self.view addSubview:self.mainTableView];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
