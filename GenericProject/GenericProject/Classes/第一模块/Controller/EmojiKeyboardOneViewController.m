//
//  EmojiKeyboardOneViewController.m
//  GenericProject
//
//  Created by 社科赛斯 on 2020/5/26.
//  Copyright © 2020 漠然丶情到深处. All rights reserved.
//

#import "EmojiKeyboardOneViewController.h"
#import "PPStickerInputView.h"
#import "PPUtil.h"

@interface EmojiKeyboardOneViewController ()<PPStickerInputViewDelegate>

@property (nonatomic, strong) PPStickerInputView *inputView;

@end

@implementation EmojiKeyboardOneViewController

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
