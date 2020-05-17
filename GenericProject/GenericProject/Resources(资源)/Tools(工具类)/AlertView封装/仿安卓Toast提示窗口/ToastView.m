//
//  ToastView.m
//  ProductLeasing
//
//  Created by 漠然丶情到深处 on 2019/7/15.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import "ToastView.h"

@interface ToastView ()

// @brief 存放文本的UILabel
@property(nonatomic,strong)UILabel *textLabel;
@property(nonatomic,strong)ToastView *toastView;
@property(nonatomic,strong)NSTimer *timer;
// @brief 记录是否移除
@property(nonatomic,assign)NSInteger currentDate;

@end

@implementation ToastView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.currentDate = 0;
    }
    return self;
}

+ (instancetype)shareClient {
    static ToastView *Toast = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Toast = [[ToastView alloc] init];
    });
    return Toast;
}

- (void)popUpToastWithMessage:(NSString *)message {
    //创建定时器
    [self createTimer];
    //初始化Label
    [self initLabel:message];
    //初始化底层视图
    [self initBottomView];
}

#pragma mark - 创建定时器
- (void)createTimer {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(onTimer) userInfo:nil repeats:YES];
    //暂停定时器
    [self.timer setFireDate:[NSDate distantFuture]];
}

#pragma mark - 初始化Label
- (void)initLabel:(NSString *)message {
    //获取屏幕宽度
    CGFloat screenWidth = CGRectGetWidth([[UIScreen mainScreen] bounds]);
    //获取屏幕高度
    CGFloat screenHeight = CGRectGetHeight([[UIScreen mainScreen] bounds]);
    //Label的字号
    UIFont *font = [UIFont systemFontOfSize:SYRealValue(30 / 2)];
    //控件的宽
    CGFloat width = screenWidth / 3.0 * 2.0;
    //Label所需的宽高
    CGSize labelSize = [self calculationTextNeedSize:message andFont:SYRealValue(30 / 2) andWidth:width];
    self.textLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, labelSize.width, labelSize.height)];
    self.textLabel.backgroundColor = [UIColor clearColor];
    self.textLabel.textColor = [UIColor whiteColor];
    self.textLabel.font = font;
    self.textLabel.text = message;
    self.textLabel.numberOfLines = 0;
    self.textLabel.textAlignment = NSTextAlignmentCenter;
}

#pragma mark - 初始化底层视图
- (void)initBottomView {
    //获取屏幕宽度
    CGFloat screenWidth = CGRectGetWidth([[UIScreen mainScreen] bounds]);
    //获取屏幕高度
    CGFloat screenHeight = CGRectGetHeight([[UIScreen mainScreen] bounds]);
    self.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.8];
    self.frame = CGRectMake((screenWidth - self.textLabel.frame.size.width)/2.0, (screenHeight - self.textLabel.frame.size.height)/2.0, self.textLabel.frame.size.width + 20, self.textLabel.frame.size.height + 20);
    [self addSubview:self.textLabel];
    //设置ImageView是否可以设为圆角
    self.layer.masksToBounds = YES;
    //设置圆角度数
    self.layer.cornerRadius = 10;
    UIViewController *vc = [self getCurrentVC];
    [vc.view addSubview:self];
    //启动定时器
    [self.timer setFireDate:[NSDate distantPast]];
}

#pragma mark - 取到当前控制器
- (UIViewController *)getCurrentVC {
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows) {
            if (tmpWin.windowLevel == UIWindowLevelNormal) {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

- (void)onTimer {
    self.currentDate++;
    if (self.currentDate == 2) {
        //暂停定时器
        [self.timer setFireDate:[NSDate distantFuture]];
        [self removeFromSuperview];
        self.currentDate = 0;
    }
}

#pragma mark - 计算文本所需大小
- (CGSize)calculationTextNeedSize:(NSString *)text andFont:(CGFloat)font andWidth:(CGFloat)width {
    CGSize labelSize = [text sizeWithFont: [UIFont boldSystemFontOfSize:font]
                        constrainedToSize: CGSizeMake(width, MAXFLOAT )
                            lineBreakMode: UILineBreakModeWordWrap];
    
    return labelSize;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
