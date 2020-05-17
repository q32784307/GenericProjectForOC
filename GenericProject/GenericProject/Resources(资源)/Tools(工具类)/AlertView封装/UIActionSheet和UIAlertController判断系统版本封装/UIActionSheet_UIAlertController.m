//
//  UIActionSheet_UIAlertController.m
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2016/10/19.
//  Copyright © 2016年  漠然丶情到深处. All rights reserved.
//

#import "UIActionSheet_UIAlertController.h"

@interface UIActionSheet_UIAlertController()

@property(nonatomic,strong)UIView *backgroundView;

@end

@implementation UIActionSheet_UIAlertController

- (instancetype)initWithFrame:(CGRect)frame titleArr:(NSArray *)titleArr {
    self = [super initWithFrame:frame];
    [self setBackgroundColor:[UIColor colorWithWhite:0.5 alpha:0.5]];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenSheet)];
    [self addGestureRecognizer:tap];
    [self makeBaseUIWithTitleArr:titleArr];
    
    return self;
}

- (void)makeBaseUIWithTitleArr:(NSArray *)titleArr {
    self.backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, titleArr.count * SYRealValue(100 / 2) + SYRealValue(110 / 2) + HOME_INDICATOR_HEIGHT)];
    _backgroundView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_backgroundView];
    
    CGFloat y = [self createBtnWithTitle:@"取消" origin_y:_backgroundView.frame.size.height - SYRealValue(100 / 2) - HOME_INDICATOR_HEIGHT tag:-1 action:@selector(hiddenSheet)] - SYRealValue(110 / 2);
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, titleArr.count * SYRealValue(100 / 2), ScreenWidth, SYRealValue(20 / 2))];
    lineView.backgroundColor = [UIColor colorWithRed:0xe9/255.0 green:0xe9/255.0 blue:0xe9/255.0 alpha:1.0];
    [_backgroundView addSubview:lineView];
    
    for (int i = 0; i < titleArr.count; i++) {
        y = [self createBtnWithTitle:titleArr[i] origin_y:y tag:i action:@selector(click:)];
        
        UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(0, (i + 1) * SYRealValue(100 / 2), ScreenWidth, 1)];
        lineView1.backgroundColor = [UIColor colorWithRed:0xe9/255.0 green:0xe9/255.0 blue:0xe9/255.0 alpha:1.0];
        [self.backgroundView addSubview:lineView1];
        
        if (i == titleArr.count - 1) {
            lineView1.hidden = YES;
        }
    }
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = _backgroundView.frame;
        frame.origin.y -= frame.size.height;
        _backgroundView.frame = frame;
    }];
}

- (CGFloat)createBtnWithTitle:(NSString *)title origin_y:(CGFloat)y tag:(NSInteger)tag action:(SEL)method {
    UIButton *ActionSheetButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [ActionSheetButton setTitle:title forState:UIControlStateNormal];
    ActionSheetButton.frame = CGRectMake(0, y, [UIScreen mainScreen].bounds.size.width, SYRealValue(100 / 2));
//    ActionSheetButton.backgroundColor = [UIColor whiteColor];
    ActionSheetButton.tag = tag;
    ActionSheetButton.titleLabel.font = [UIFont systemFontOfSize:SYRealValue(30 / 2)];
    [ActionSheetButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [ActionSheetButton addTarget:self action:method forControlEvents:UIControlEventTouchUpInside];
    [_backgroundView addSubview:ActionSheetButton];
    return y -= tag == -1 ? 0 : SYRealValue(100 / 2);
}

- (void)hiddenSheet {
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = _backgroundView.frame;
        frame.origin.y += frame.size.height;
        _backgroundView.frame = frame;
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removeFromSuperview];
    });
}

- (void)click:(UIButton *)btn {
    if (self.Click) {
        _Click(btn.tag);
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
