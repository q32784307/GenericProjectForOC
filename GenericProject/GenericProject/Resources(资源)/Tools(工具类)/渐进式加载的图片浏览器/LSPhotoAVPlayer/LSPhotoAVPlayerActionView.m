//
//  LSPhotoAVPlayerActionView.m
//  GenericProject
//
//  Created by 社科赛斯 on 2019/12/17.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import "LSPhotoAVPlayerActionView.h"

@interface LSPhotoAVPlayerActionView()

/**
 stop || play view
 */
@property(nonatomic,weak)UIImageView *pauseImgView;

/**
 dismiss view
 */
@property(nonatomic,weak)UIImageView *dismissImgView;

/**
 loading view
 */
@property(nonatomic,strong)UIActivityIndicatorView *indicatorView;

@end

@implementation LSPhotoAVPlayerActionView

- (UIActivityIndicatorView *)indicatorView {
    if (!_indicatorView) {
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        [_indicatorView setHidesWhenStopped:true];
    }
    return _indicatorView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:UIColor.clearColor];
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionViewDidClick)]];
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
    // 1.stop || play imageView
    UIImageView *pauseImgView = [[UIImageView alloc] init];
    [pauseImgView setUserInteractionEnabled:true];
    [pauseImgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pauseImageViewDidClick)]];
    [pauseImgView setImage:[UIImage imageNamed:@"LSPhotoBrowser.bundle/playCenter@2x.png"]];
    [self addSubview:pauseImgView];
    _pauseImgView = pauseImgView;
    
    // 2.dismiss imageView
    UIImageView *dismissImageView = [[UIImageView alloc] init];
    [dismissImageView setUserInteractionEnabled:true];
    [dismissImageView setImage:[UIImage imageNamed:@"LSPhotoBrowser.bundle/dismiss@2x.png"]];
    [dismissImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissImageViewDidClick)]];
    [dismissImageView setHidden:true];
    [self addSubview:dismissImageView];
    _dismissImgView = dismissImageView;
    
    // 3.loading imageView
    [self addSubview:self.indicatorView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _pauseImgView.frame = CGRectMake((self.frame.size.width - 80) * 0.5, (self.frame.size.height - 80) * 0.5, 80, 80);
    
    
    CGFloat y = 25;
    CGFloat x = 10;
    if(Is_iPhoneX || Is_iPhoneXr || Is_iPhoneXs_Max){
        y = 45;
        x = 20;
    }
    
    if(!IsPortrait){
        y = 15;
        x = 35;
    }
    _dismissImgView.frame = CGRectMake(x, y, 20, 20);
    _indicatorView.frame = CGRectMake((self.frame.size.width - 30) * 0.5, (self.frame.size.height - 30) * 0.5, 30, 30);
}

- (void)pauseImageViewDidClick {
    if (_pauseImgView.hidden == false) {
        _pauseImgView.hidden = true;
    }
    
    if ([_delegate respondsToSelector:@selector(photoAVPlayerActionViewPauseOrStop)]) {
        [_delegate photoAVPlayerActionViewPauseOrStop];
    }
}

- (void)dismissImageViewDidClick {
    if ([_delegate respondsToSelector:@selector(photoAVPlayerActionViewDismiss)]) {
        [_delegate photoAVPlayerActionViewDismiss];
    }
}

- (void)actionViewDidClick {
    [_dismissImgView setHidden:!_dismissImgView.hidden];
    
    if ([_delegate respondsToSelector:@selector(photoAVPlayerActionViewDidClickIsHidden:)]) {
        [_delegate photoAVPlayerActionViewDidClickIsHidden:_dismissImgView.isHidden];
    }
}

/**
 avPlayerActionView need hidden or not
 */
- (void)avplayerActionViewNeedHidden:(BOOL)isHidden {
    if (isHidden == true) {
        [_dismissImgView setHidden:true];
        [_indicatorView setHidden:true];
        [_pauseImgView setHidden:true];
    }
}

- (void)setIsBuffering:(BOOL)isBuffering {
    _isBuffering = isBuffering;
    if (isBuffering) {
        [_indicatorView startAnimating];
    }else{
        [_indicatorView stopAnimating];
    }
}

- (void)setIsPlaying:(BOOL)isPlaying {
    _isPlaying = isPlaying;
    [_pauseImgView setHidden:isPlaying];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
