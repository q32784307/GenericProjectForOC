//
//  LSPhotoVideoCell.h
//  GenericProject
//
//  Created by 社科赛斯 on 2019/12/17.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSPhotoAVPlayer/LSPhotoAVPlayerView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol LSPhotoVideoCellDelegate <NSObject>

- (void)photoVideoAVPlayerDismiss;

@end

@interface LSPhotoVideoCell : UICollectionViewCell

- (void)playerWithURL:(NSString *)url placeHolder:(UIImage *_Nullable)placeHolder;

- (void)playerWillEndDisplay;

@property(nonatomic,weak)LSPhotoAVPlayerView *playerView;
@property(nonatomic,weak)id<LSPhotoVideoCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
