//
//  DataPickerView.m
//  DoctorYL
//
//  Created by chenTengfei on 15/2/5.
//  Copyright (c) 2015年 yuntai. All rights reserved.
//

#import "TFDatePickerView.h"

#define kScreenBoundWidth [UIScreen mainScreen].bounds.size.width

#define kScreenBoundHeight [UIScreen mainScreen].bounds.size.height

@interface TFDatePickerView ()

@property (weak, nonatomic) IBOutlet UIButton *submitButton;

@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *locationConstraint;

@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (nonatomic, strong)UIWindow *datePickerWindow;

@end

@implementation TFDatePickerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (UIWindow *)datePickerWindow
{
    if (_datePickerWindow == nil) {
        _datePickerWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _datePickerWindow.windowLevel = 1997;
        _datePickerWindow.hidden = YES;
        
        UIGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] init];
        [gesture addTarget:self action:@selector(tf_hideWindow)];
        [_datePickerWindow addGestureRecognizer:gesture];
    }
    return _datePickerWindow;
}

#pragma mark - 公共方法
+ (TFDatePickerView *)tfDatePickerViewWithDatePickerMode:(UIDatePickerMode)datePickerMode Delegate:(id<TFDatePickerViewDelegate>)delegate{
    
    TFDatePickerView *datePickerView = [[[NSBundle mainBundle] loadNibNamed:kTFDatePickerView owner:self options:nil] lastObject];
    datePickerView.datePickerMode = UIDatePickerModeDate;
    datePickerView.tf_DatePickerDelegate = delegate;
    
    return datePickerView;
}

- (void)tf_show
{
    // 初始化
    self.datePickerWindow.hidden = NO;
    [self.datePickerWindow makeKeyAndVisible];
    self.frame = self.datePickerWindow.bounds;
    [self.datePickerWindow addSubview:self];
    
    self.locationConstraint.constant = -self.contentView.bounds.size.height;
    self.contentView.frame = CGRectMake(0, kScreenBoundHeight, kScreenBoundWidth, self.contentView.bounds.size.height);
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionLayoutSubviews
     | UIViewAnimationOptionBeginFromCurrentState
     | UIViewAnimationOptionCurveEaseIn animations:^{
         self.locationConstraint.constant = 0;
         self.contentView.frame = CGRectMake(0, kScreenBoundHeight - self.contentView.bounds.size.height, kScreenBoundWidth, self.contentView.bounds.size.height);
     } completion:^(BOOL finished) {
         
     }];
    
    // 设置模式
    self.datePicker.datePickerMode = self.datePickerMode;
}

- (void)tf_hideWindow {
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionLayoutSubviews
     | UIViewAnimationOptionBeginFromCurrentState
     | UIViewAnimationOptionCurveEaseOut animations:^{
         self.locationConstraint.constant = -self.contentView.frame.size.height;
         self.contentView.frame = CGRectMake(0, kScreenBoundHeight, kScreenBoundWidth, self.contentView.frame.size.height);
     } completion:^(BOOL finished) {
         _datePickerWindow.hidden = YES;
         _datePickerWindow = nil;
     }];
}

#pragma mark - 私有方法

- (IBAction)cancelClick:(UIButton *)sender {
    [self tf_hideWindow];
}

- (IBAction)submitClick:(UIButton *)sender {
    if ([self.tf_DatePickerDelegate submitWithSelectedDate:self.datePicker.date]) {
        [self tf_hideWindow];
    }
}

@end
