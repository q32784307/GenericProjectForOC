//
//  LSPhotoVideoCell.m
//  GenericProject
//
//  Created by 社科赛斯 on 2019/12/17.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import "LSPhotoVideoCell.h"

@interface LSPhotoVideoCell()<LSPhotoAVPlayerViewDelegate>

@end

@implementation LSPhotoVideoCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        LSPhotoAVPlayerView *playerView = [[LSPhotoAVPlayerView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [playerView setDelegate:self];
        [self.contentView addSubview:playerView];
        _playerView = playerView;
    }
    return self;
}

- (void)playerWithURL:(NSString *)url placeHolder:(UIImage *_Nullable)placeHolder {
    [_playerView playerWithURL:url placeHolder:placeHolder];
}

- (void)playerWillEndDisplay {
    [_playerView videoPlayerWillReset];
}

- (void)photoAVPlayerViewDismiss {
    if ([_delegate respondsToSelector:@selector(photoVideoAVPlayerDismiss)]) {
        [_delegate photoVideoAVPlayerDismiss];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _playerView.frame = self.bounds;
}

@end
