//
//  ThreeViewController.m
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2018/5/29.
//  Copyright © 2018年 漠然丶情到深处. All rights reserved.
//

#import "ThreeViewController.h"
#import "AlertViewController.h"
#import "LSDatePickerView.h"

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
    
    UIButton *pushButton1 = [[UIButton alloc]initWithFrame:CGRectMake(80, 300, 220, 50)];
    [pushButton1 setTitle:@"时间选择器(以年为区间)" forState:UIControlStateNormal];
    pushButton1.backgroundColor = [UIColor orangeColor];
    [pushButton1 addTarget:self action:@selector(pushAction1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pushButton1];
    
    UIButton *pushButton2 = [[UIButton alloc]initWithFrame:CGRectMake(80, 400, 220, 50)];
    [pushButton2 setTitle:@"时间选择器(以季度为区间)" forState:UIControlStateNormal];
    pushButton2.backgroundColor = [UIColor orangeColor];
    [pushButton2 addTarget:self action:@selector(pushAction2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pushButton2];
    
    UIButton *pushButton3 = [[UIButton alloc]initWithFrame:CGRectMake(80, 500, 220, 50)];
    [pushButton3 setTitle:@"时间选择器(以月为区间)" forState:UIControlStateNormal];
    pushButton3.backgroundColor = [UIColor orangeColor];
    [pushButton3 addTarget:self action:@selector(pushAction3) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pushButton3];
    
    UIButton *pushButton4 = [[UIButton alloc]initWithFrame:CGRectMake(80, 600, 220, 50)];
    [pushButton4 setTitle:@"时间选择器(以周为区间)" forState:UIControlStateNormal];
    pushButton4.backgroundColor = [UIColor orangeColor];
    [pushButton4 addTarget:self action:@selector(pushAction4) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pushButton4];
    
    //天    时   即时
}

- (void)setNavigation {
    self.navView.isShowLeftButton = NO;
    self.navView.isShowRightButton = NO;
}

- (void)pushAction {
    AlertViewController *alertVC = [[AlertViewController alloc]init];
    [self.navigationController pushViewController:alertVC animated:YES];
}

- (void)pushAction1 {
    LSDatePickerView *pickerView = [[LSDatePickerView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    [self.view addSubview:pickerView];
    [pickerView show];
}

- (void)pushAction2 {
    
}

- (void)pushAction3 {
    
}

- (void)pushAction4 {
    
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
