//
//  FourViewController.m
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2018/5/29.
//  Copyright © 2018年 漠然丶情到深处. All rights reserved.
//

#import "FourViewController.h"
#import "FourthViewController.h"
#import "LSSpeechSynthesizer.h"

@interface FourViewController ()

@end

@implementation FourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigation];
    
    UIButton *pushButton = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    pushButton.backgroundColor = [UIColor cyanColor];
    [pushButton addTarget:self action:@selector(pushAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pushButton];
    
    
    //语音播报
    NSString *string = @"我有一只小鸭子，咿呀咿呀哟";
    LSSpeechSynthesizer *speaker = [LSSpeechSynthesizer sharedSpeechSynthesizer];
    [speaker speakString:string];
}

- (void)setNavigation {
    self.navView.isShowLeftButton = NO;
    self.navView.isShowRightButton = NO;
}

- (void)pushAction {
    FourthViewController *fourthVC = [[FourthViewController alloc]init];
    [self.navigationController pushViewController:fourthVC animated:YES];
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
