//
//  LmitationWXTakingPicturesViewController.m
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/12/9.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import "LmitationWXTakingPicturesViewController.h"
#import "LSShotViewController.h"

@interface LmitationWXTakingPicturesViewController ()

@end

@implementation LmitationWXTakingPicturesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *takingPicturesButton = [[UIButton alloc]init];
    takingPicturesButton.backgroundColor = RedColor;
    [takingPicturesButton setTitle:@"拍照" forState:UIControlStateNormal];
    [takingPicturesButton setTitleColor:BlackColor forState:UIControlStateNormal];
    [takingPicturesButton addTarget:self action:@selector(takingPicturesAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:takingPicturesButton];
    [takingPicturesButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(SYRealValue(500 / 2));
        make.centerX.equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(SYRealValue(200 / 2), SYRealValue(200 / 2)));
    }];
}

- (void)takingPicturesAction {
    LSShotViewController * LSShotVC = [[LSShotViewController alloc] init];
    LSShotVC.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:LSShotVC animated:YES completion:nil];
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
