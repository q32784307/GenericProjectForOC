//
//  StickerKeyboardViewController.m
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/4/28.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import "StickerKeyboardViewController.h"
#import "PPStickerInputView.h"
#import "PPUtil.h"

@interface StickerKeyboardViewController ()<PPStickerInputViewDelegate>

@property (nonatomic, strong) PPStickerInputView *inputView;

@end

@implementation StickerKeyboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _inputView = [[PPStickerInputView alloc] init];
    _inputView.delegate = self;
    CGFloat height = [self.inputView heightThatFits];
    CGFloat minY = CGRectGetHeight(self.view.bounds) - height - PP_SAFEAREAINSETS(self.view).bottom;
    self.inputView.frame = CGRectMake(0, minY, CGRectGetWidth(self.view.bounds), height);
    [self.view addSubview:self.inputView];
}

- (void)stickerInputViewDidClickSendButton:(PPStickerInputView *)inputView {
    NSLog(@"%@",inputView.plainText);
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
