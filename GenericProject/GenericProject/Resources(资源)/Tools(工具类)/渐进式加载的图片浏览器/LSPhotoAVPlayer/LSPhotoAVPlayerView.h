//
//  LSPhotoAVPlayerView.h
//  GenericProject
//
//  Created by 社科赛斯 on 2019/12/17.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol LSPhotoAVPlayerViewDelegate <NSObject>

/**
 avplayer dimiss
 */
- (void)photoAVPlayerViewDismiss;

@end

@interface LSPhotoAVPlayerView : UIView

/**
 create observe player with url ,ready to play

 @param url url
 @param placeHolder placeHolder image
 */
- (void)playerWithURL:(NSString *)url placeHolder:(UIImage *_Nullable)placeHolder;

/**
 reset avplayer
 */
- (void)videoPlayerWillReset;

/**
 swipe player by hand
 */
- (void)videoWillSwipe;

/**
 player view
 */
@property(nonatomic,strong,nullable)UIView *playerView;

/**
 player background view (as locate current location for swipe)
 */
@property(nonatomic,strong,nullable)UIView *playerBgView;

/**
 placeHolder imageView
*/
@property(nonatomic,strong,nullable)UIImageView *placeHolderImgView;

/**
 current url
 */
@property(nonatomic,copy)NSString *url;

/**
 placeHolder image for temp image of current url
 */
@property(nonatomic,strong)UIImage *placeHolder;

/**
 layer of player
 */
@property(nonatomic,strong,nullable)AVPlayerLayer *playerLayer;

@property(nonatomic,weak)id<LSPhotoAVPlayerViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
