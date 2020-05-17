//
//  LSPhotoAVPlayerActionView.h
//  GenericProject
//
//  Created by 社科赛斯 on 2019/12/17.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol LSPhotoAVPlayerActionViewDelegate <NSObject>

@optional
/**
 actionView's Pause imageView
 */
- (void)photoAVPlayerActionViewPauseOrStop;

@optional
/**
 actionView's dismiss imageView
 */
- (void)photoAVPlayerActionViewDismiss;

@optional
/**
 actionView
 */
- (void)photoAVPlayerActionViewDidClickIsHidden:(BOOL)isHidden;

@end

@interface LSPhotoAVPlayerActionView : UIView

/**
 avPlayerActionView need hidden or not
 */
- (void)avplayerActionViewNeedHidden:(BOOL)isHidden;

@property(nonatomic,weak)id<LSPhotoAVPlayerActionViewDelegate> delegate;

/**
 player is buffering or not
 */
@property(nonatomic,assign)BOOL isBuffering;

/**
 current player is playing
 */
@property(nonatomic,assign)BOOL isPlaying;

@end

NS_ASSUME_NONNULL_END
