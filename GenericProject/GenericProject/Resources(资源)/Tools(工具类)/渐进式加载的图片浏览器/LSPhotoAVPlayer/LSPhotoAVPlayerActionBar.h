//
//  LSPhotoAVPlayerActionBar.h
//  GenericProject
//
//  Created by 社科赛斯 on 2019/12/17.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol LSPhotoAVPlayerActionBarDelegate <NSObject>

@optional
/**
 actionBar pause or stop btn did click
 
 @param isNeedPlay isNeedPlay
 */
- (void)photoAVPlayerActionBarClickWithIsPlay:(BOOL)isNeedPlay;

@optional
/**
 actionBar value has changed by slider
 
 @param value value
 */
- (void)photoAVPlayerActionBarChangeValue:(float)value;

@end

@interface LSPhotoAVPlayerActionBar : UIView

/**
 current play time of the video
 */
@property(nonatomic,assign)float currentTime;

/**
 duration of the video
 */
@property(nonatomic,assign)float allDuration;

@property(nonatomic,weak)id<LSPhotoAVPlayerActionBarDelegate> delegate;

/**
 setter or getter of isPlaying of ActionBar
 */
@property(nonatomic,assign)BOOL isPlaying;

/**
 reset all information of ActionBar
 */
- (void)resetActionBarAllInfo;

@end

NS_ASSUME_NONNULL_END
