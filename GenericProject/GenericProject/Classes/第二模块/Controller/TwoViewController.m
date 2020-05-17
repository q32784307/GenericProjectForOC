//
//  TwoViewController.m
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2018/5/29.
//  Copyright © 2018年 漠然丶情到深处. All rights reserved.
//

#import "TwoViewController.h"
#import "OtherViewController.h"

@interface TwoViewController ()

@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigation];
    
    // 监听UITabBarItem被重复点击时的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarDidClick) name:@"1" object:nil];
    
    
    UIButton *pushButton = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    pushButton.backgroundColor = [UIColor cyanColor];
    [pushButton addTarget:self action:@selector(pushAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pushButton];
}

- (void)setNavigation {
    self.navView.isShowLeftButton = NO;
    self.navView.isShowRightButton = NO;
}

- (void)tabBarDidClick {
    if ([self isShowingOnKeyWindow]) {
        NSLog(@"点击了1");
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushAction {
    OtherViewController *otherVC = [[OtherViewController alloc]init];
    [self.navigationController pushViewController:otherVC animated:YES];
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
