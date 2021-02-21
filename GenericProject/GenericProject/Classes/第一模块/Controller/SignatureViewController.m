//
//  SignatureViewController.m
//  GenericProject
//
//  Created by 社科赛斯 on 2020/5/29.
//  Copyright © 2020 漠然丶情到深处. All rights reserved.
//

#import "SignatureViewController.h"
#import "LSSignatureView.h"

@interface SignatureViewController ()

@end

@implementation SignatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navView.titleLabelText = @"电子签名";
    
    LSSignatureView *sign = [[LSSignatureView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, LSScreenWidth, LSScreenHeight - NAVIGATION_BAR_HEIGHT - HOME_INDICATOR_HEIGHT)];
    sign.lineColor = [UIColor blueColor];
    sign.signDone = ^(UIImage *signImage) {
        self.signResult(signImage);
        //返回前一个页面生成图片并放到imageview上
        [self.navigationController popViewControllerAnimated:YES];
    };
    sign.signClear = ^(LSSignatureView *signView) {
        [signView clearSignature];
    };
    [self.view addSubview:sign];
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
