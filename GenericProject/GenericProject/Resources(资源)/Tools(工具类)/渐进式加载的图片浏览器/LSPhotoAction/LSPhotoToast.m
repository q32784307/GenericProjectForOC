//
//  LSPhotoToast.m
//  GenericProject
//
//  Created by 社科赛斯 on 2019/12/17.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import "LSPhotoToast.h"

@interface LSPhotoToast ()
{
    UIView *_toastView;
    UILabel *_msgLabel;
    BOOL _isShow;
}

@end

@implementation LSPhotoToast

static id toast;

+ (instancetype)shareToast {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        toast = [[LSPhotoToast alloc] init];
    });
    return toast;
}

- (void)initWithText:(NSString *)text {
    [self initWithText:text duration:0];
}

- (void)initWithText:(NSString *)text offSetY:(CGFloat)offsetY {
    [self initWithText:text duration:0 offSetY:offsetY];
}

- (void)initWithText:(NSString *)text duration:(NSInteger)duration {
    [self initWithText:text duration:duration offSetY:0];
}

- (void)initWithText:(NSString *)text duration:(NSInteger)duration offSetY:(CGFloat)offsetY {
    if(_isShow) return;
    
    if(text == nil || text == NULL || [text isKindOfClass:[NSNull class]] || [[text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0){
        return;
    }
    
    if(duration < 1.f) duration = 1.f;
    
    _isShow = YES;
    
    /****************************** == MsgLabel  == ********************************/
    _msgLabel = [[UILabel alloc] init];
    [_msgLabel setTextAlignment:NSTextAlignmentCenter];
    [_msgLabel setText:text];
    [_msgLabel setNumberOfLines:0];
    [_msgLabel setTextColor:[UIColor whiteColor]];
    [_msgLabel setFont:[UIFont systemFontOfSize:16]];
    
    /****************************** == ToastView == ********************************/
    _toastView = [[UIView alloc] init];
    [_toastView setBackgroundColor:[UIColor blackColor]];
    [_toastView.layer setCornerRadius:5.f];
    [_toastView setClipsToBounds:YES];
    [_toastView setAlpha:0.9f];
    [_toastView addSubview:_msgLabel];
    
    /****************************** == Arrt == ********************************/
    
    NSDictionary *attrs = @{NSFontAttributeName:[_msgLabel font]};
    CGSize size = [text boundingRectWithSize:CGSizeMake(LSScreenWidth - 20,LSScreenHeight - 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    
    CGPoint CenterPoint;
    if(offsetY <= 0 || offsetY >= LSScreenHeight){
        CenterPoint = (CGPoint){LSScreenWidth * 0.5,LSScreenHeight * 0.5};
    }else{
        CenterPoint = (CGPoint){LSScreenWidth * 0.5,offsetY + size.height};
    }
    
    _toastView.bounds = (CGRect){CGPointZero,{size.width + 20,size.height + 20}};
    _toastView.center = CenterPoint;
    
    _msgLabel.bounds = (CGRect){CGPointZero,{size.width,size.height}};
    _msgLabel.center = (CGPoint){(size.width * 0.5 + 20 * 0.5),(size.height * 0.5 + 20 * 0.5)};
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:_toastView];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:duration];
    });
}

- (void)dismiss {
    _isShow = NO;
    [_toastView removeFromSuperview];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
