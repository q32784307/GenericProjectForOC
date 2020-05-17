//
//  LSPSWRectAnimateTextFieldView.m
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/10/18.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import "LSPSWRectAnimateTextFieldView.h"
#import "LSPasswordDotView.h"
#import "LSMaskView.h"
#import "LSBaseTextField.h"
#import "LSPasswordViewProtocol.h"

#import "LSCircleAnimatedView.h"
#import "LSSuccessLoadingView.h"

@interface LSPSWRectAnimateTextFieldView ()

@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) LSPasswordDotView *dotView;
@property (nonatomic, strong) LSMaskView *maskView;
@property (nonatomic, strong) LSBaseTextField *textField;
@property (nonatomic, strong) NSMutableArray <LSPasswordDotView *> *dotViews;

@property (nonatomic, strong) LSCircleAnimatedView *circleAnimatedView;
@property (nonatomic, strong) LSSuccessLoadingView *successCheckView;

@end

@implementation LSPSWRectAnimateTextFieldView

@synthesize delegate = _delegate;

- (void)ls_addSubviews {
    self.titleLab = CreateCenterAlignmentLabel(Font(16.f), LSColorWithHex(0x333333));
    [self addSubview:self.titleLab];
    [self.titleLab setText:@"请输入密码"];
    
    _textField = [LSBaseTextField new];
    _textField.textColor = [UIColor whiteColor];
    _textField.tintColor = [UIColor whiteColor];
    _textField.secureTextEntry = true;
    _textField.maxCount = kMaxCount;
    _textField.allowCopyMenu = false;
    _textField.keyboardType = UIKeyboardTypeNumberPad;
    [_textField addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
    __weak typeof(self) weakSelf = self;
    _textField.showToolbarView = true;
    _textField.ToolBarViewEvent = ^{
        [weakSelf callOkButtonFunnctionWithText:weakSelf.textField.text];
    };
    
    [self addSubview:_textField];
    
    _maskView = [[LSMaskView alloc] init];
    _maskView.layer.cornerRadius = 8.f;
    _maskView.layer.borderColor = LSBorderLayerCorlor.CGColor;
    _maskView.layer.borderWidth = 1.f;
    [_maskView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:_maskView];
}

- (void)ls_addConstraints {
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(60);
    }];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(self.titleLab.mas_bottom).offset(60);
        make.height.mas_equalTo(50);
    }];
    [self.maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.equalTo(self.textField);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(50);
    }];
    [_textField layoutIfNeeded];
    [_maskView layoutIfNeeded];
    [self p_initDotViewWithFrame:_maskView.bounds];
}

- (void)p_initDotViewWithFrame:(CGRect)frame {
    self.dotViews = [[NSMutableArray alloc] initWithCapacity:6];
    CGFloat viewW = frame.size.width / kMaxCount;
    CGFloat viewH = frame.size.height;
    for (int i = 0; i < kMaxCount; i ++) {
        CGRect frame = CGRectMake(viewW * i , 0, viewW , viewH );
        LSPasswordDotView *dotView = [LSPasswordDotView createDotViewWithType:LSPasswordRectangleEncryption
                                                                        frame:frame];
        [dotView.verticalLineView setHidden:i == kMaxCount - 1];
        [self.maskView addSubview:dotView];
        [self.dotViews addObject:dotView];
    }
    [self updateInputNumWithText:_textField.text];
    
    [self addAnimatedView];
}

- (void)addAnimatedView {
    [self layoutIfNeeded];
    
    __weak typeof(self) weakSelf = self;
    
    self.circleAnimatedView = [[LSCircleAnimatedView alloc] initWithFrame:self.bounds];
    [self.circleAnimatedView setHidden:true];
    
    self.successCheckView = [[LSSuccessLoadingView alloc] initWithFrame:self.bounds];
    //动画完成了
    self.successCheckView.LSSuccessLoadEnd = ^{
        if (weakSelf.delegate && [weakSelf.delegate
                                  respondsToSelector:@selector(textFieldView:result:eventType:)]) {
            [weakSelf.delegate textFieldView:weakSelf
                                      result:@""
                                   eventType:LSPasswordViewAnimateViewFinish];
        }
        [weakSelf.circleAnimatedView     setHidden:true];
        [weakSelf.successCheckView       setHidden:true];
    };
    [self.successCheckView setHidden:true];
    
    [self addSubview:self.circleAnimatedView];
    [self addSubview:self.successCheckView];
}

- (void)textFieldDidChanged:(UITextField *)textFiled {
    [self updateInputNumWithText:textFiled.text];
}

- (void)updateInputNumWithText:(NSString *)text {
    NSInteger length = text.length;
    [self.dotViews enumerateObjectsUsingBlock:^(LSPasswordDotView * obj, NSUInteger idx, BOOL * stop) {
        if (length < kMaxCount) {
            [obj setDotBottomLineHightlight:idx == length];
        }
        [obj setDotPointHide:!(idx < length)];
    }];
    if (length == kMaxCount) {
        [self callBackAutoDoneFunnctionWithText:text];
    }
    else {
        [self callBackInpuTextLengthUpdateWithText:text];
    }
}

- (void)showCircleAnimating {
    [self.circleAnimatedView setHidden:false];
    [self.circleAnimatedView beginAnimating];
}

- (void)stopCircleAnimating {
    [self.circleAnimatedView endAnimating];
    [self.circleAnimatedView setHidden:true];
}

- (void)showCheckAnimation {
    [self.successCheckView setHidden:false];
    [self.successCheckView beginAnimating];
}

- (void)callBackAutoDoneFunnctionWithText:(NSString *)text {
    [self makeTextFieldResignFirstResponder];
    if (_delegate && [_delegate respondsToSelector:@selector(textFieldView:result:eventType:)]) {
        [_delegate textFieldView:self result:text eventType:LSPasswordViewEventAutoDone];
    }
}
- (void)callBackInpuTextLengthUpdateWithText:(NSString *)text {
    if (_delegate && [_delegate respondsToSelector:@selector(textFieldView:result:eventType:)]) {
        [_delegate textFieldView:self result:text eventType:LSPasswordViewEventLengthUpdate];
    }
}

- (void)callOkButtonFunnctionWithText:(NSString *)text {
    [self makeTextFieldResignFirstResponder];
    if (_delegate && [_delegate respondsToSelector:@selector(textFieldView:result:eventType:)]) {
        [_delegate textFieldView:self result:text eventType:LSPasswordViewEventOKButton];
    }
}

- (void)makeTextFieldBecomeFirstResponder {
    [_textField becomeFirstResponder];
}

- (void)makeTextFieldResignFirstResponder {
    [_textField resignFirstResponder];
}

- (void)clearAllInputChars {
    [self.textField setText:@""];
    [self updateInputNumWithText:@""];
}

- (void)autoShowKeyboardDelay:(NSTimeInterval)delay {
    LSAfter(delay, ^{
        [_textField becomeFirstResponder];
    });
}

- (NSInteger)textLength {
    return _textField.text.length;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
