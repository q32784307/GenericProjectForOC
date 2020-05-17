//
//  VerifyAlertViewController.m
//  GenericProject
//
//  Created by 社科赛斯 on 2019/12/12.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import "VerifyAlertViewController.h"
#import "LSVerifyAlertView.h"

@interface VerifyAlertViewController ()

@end

@implementation VerifyAlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *pushButton = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    pushButton.backgroundColor = [UIColor cyanColor];
    [pushButton addTarget:self action:@selector(pushAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pushButton];
}

- (void)pushAction {
    LSVerifyAlertView *verifyView = [[LSVerifyAlertView alloc] initWithMaximumVerifyNumber:3 results:^(LSVerifyState state) {
        NSLog(@"%zd", state);
    }];
    [verifyView show];
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
