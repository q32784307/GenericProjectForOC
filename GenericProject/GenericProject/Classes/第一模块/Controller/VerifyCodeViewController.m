//
//  VerifyCodeViewController.m
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/4/17.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import "VerifyCodeViewController.h"
#import "CheckVerifyCodeView.h"

@interface VerifyCodeViewController ()

@property(nonatomic,strong)CheckVerifyCodeView *checkVerifyCodeView;

@end

@implementation VerifyCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.checkVerifyCodeView = [[CheckVerifyCodeView alloc] init];
    [self.view addSubview:self.checkVerifyCodeView];
    [self.checkVerifyCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(265);
        make.centerX.mas_equalTo(self.view);
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(150);
    }];
    
    // 输入完成的回调
    // 做你想做的事
    __weak typeof(self) weakSelf = self;
    self.checkVerifyCodeView.inputCompletion = ^(NSString * _Nonnull verifyCode) {
        __weak typeof(self) strongSelf = weakSelf;
        NSLog(@"当前输入了--%@",verifyCode);
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"验证码错误" message:@"请重试" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            // 重置
            [strongSelf.checkVerifyCodeView reset];
        }];
        [alertController addAction:action];
        [strongSelf presentViewController:alertController animated:YES completion:nil];
    };
    
    // 开始输入
    [self.checkVerifyCodeView startInput];
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
