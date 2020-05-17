//
//  ThreeViewController.m
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2018/5/29.
//  Copyright © 2018年 漠然丶情到深处. All rights reserved.
//

#import "ThreeViewController.h"
#import "AlertViewController.h"

@interface ThreeViewController ()

@end

@implementation ThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigation];
    
    UIButton *pushButton = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    pushButton.backgroundColor = [UIColor redColor];
    [pushButton addTarget:self action:@selector(pushAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pushButton];
}

- (void)setNavigation {
    self.navView.isShowLeftButton = NO;
    self.navView.isShowRightButton = NO;
}

- (void)pushAction {
    AlertViewController *alertVC = [[AlertViewController alloc]init];
    [self.navigationController pushViewController:alertVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
