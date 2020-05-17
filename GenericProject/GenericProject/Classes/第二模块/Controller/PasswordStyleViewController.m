//
//  PasswordStyleViewController.m
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/10/17.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import "PasswordStyleViewController.h"
#import "LSModel.h"
#import "LSPSWTextFieldContext.h"
#import "LSUIHeader.h"

@interface PasswordStyleViewController ()<LSPasswordViewDelegate>

@property (nonatomic, strong) UIView <LSPasswordViewProtocol> *textFieldView;

@property (nonatomic, strong) UIView *backView;

@end

@implementation PasswordStyleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WhiteColor;
    // Do any additional setup after loading the view.
    [self createSubViews];
}

- (void)createSubViews {
    LSPSWTextFieldViewType viewType = LSPSWTextFieldViewLineNormal;
    switch (_dataModel.styleType) {
        case LSPasswordStyleBottomLineNormal: {
            viewType = LSPSWTextFieldViewLineNormal;
            [self setUpTextFieldViewWithType:viewType];
        }
            break;
        case LSPasswordStyleBottomLineEncrypt: {
            viewType = LSPSWTextFieldViewLineEncryption;
            [self setUpTextFieldViewWithType:viewType];
        }
            break;
        case LSPasswordStyleRectangleNormal: {
            viewType = LSPSWTextFieldViewRectNormal;
            [self setUpTextFieldViewWithType:viewType];
        }
            break;
        case LSPasswordStyleRectangleEncrypt: {
            viewType = LSPSWTextFieldViewRectEncryption;
            [self setUpTextFieldViewWithType:viewType];
        }
            break;
        case LSPasswordStyleWithAnimating: {
            viewType = LSPSWTextFieldViewWithAnimating;
            [self setUpTextFieldViewWithType:viewType];
        }
    }
}

- (void)setUpTextFieldViewWithType:(LSPSWTextFieldViewType)type {
    self.textFieldView = [LSPSWTextFieldContext configureTextFieldView:type frame:CGRectMake(0, 110, ScreenWidth, ScreenHeight - 100)];
    [self.textFieldView setDelegate:self];
    [self.view addSubview:self.textFieldView];
}

- (void)textFieldView:(UIView<LSPasswordViewProtocol> *)textFieldView
               result:(NSString *)result
            eventType:(LSPasswordViewEventType)type {
    switch (type) {
        case LSPasswordViewEventAutoDone: {
            NSLog(@"输入6位密码完成,<<%@>>",result);
            if (_dataModel.styleType == LSPSWTextFieldViewWithAnimating) {
                [textFieldView showCircleAnimating];
                LSAfter(2.f, ^{
                    [textFieldView stopCircleAnimating];
                    [textFieldView showCheckAnimation];
                });
            }
            else {
                [self showAlertTitle:@"输入密码完成" message:result okTitle:@"确定" okEvent:^{
                    [self.textFieldView clearAllInputChars];
                    [self.textFieldView makeTextFieldBecomeFirstResponder];
                }];
            }
        }
            break;
        case LSPasswordViewEventOKButton: {
            NSLog(@"点击ToolBarView 使键盘下落");
        }
            break;
        case LSPasswordViewEventLengthUpdate: {
            NSLog(@"输入变化");
        }
            break;
        case LSPasswordViewAnimateViewFinish: {
            NSLog(@"支付完成,回到上一页");
            [self.navigationController popViewControllerAnimated:true];
        }
            break;
        default:
            break;
    }
}

- (void)showAlertTitle:(NSString *)title
               message:(NSString *)message
               okTitle:(NSString *)okTitle
               okEvent:(void(^)(void))okEvet{
    
    message = [NSString stringWithFormat:@"\n%@\n",message];
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    if ([okTitle length] >0) {
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:okTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            !okEvet ? : okEvet();
        }];
        [alertVC addAction:okAction];
    }
    
    [self.navigationController presentViewController:alertVC animated:true completion:nil];
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
