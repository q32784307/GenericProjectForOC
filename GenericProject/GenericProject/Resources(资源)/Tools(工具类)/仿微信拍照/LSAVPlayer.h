//
//  LSAVPlayer.h
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/12/10.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LSAVPlayer;
@protocol LSAVPlayerDelegate <NSObject>
@optional
/// 播放中
/// @param avPlayer 播放器
/// @param currentTime 当前时间
/// @param totalTime 总时间
- (void)avPlayer:(LSAVPlayer *)avPlayer playingToCurrentTime:(CMTime)currentTime totalTime:(CMTime)totalTime;
/// 播放结束 暂停
- (void)playDidEndOnAvplyer:(LSAVPlayer *)avPlayer;

@end

NS_ASSUME_NONNULL_BEGIN

///  简易播放器
@interface LSAVPlayer : NSObject

/// 播放源
@property(nonatomic,strong)NSURL *url;
/// 视频尺寸  单位像素 px
@property(nonatomic,assign,readonly)CGSize naturalSize;
/// 总时长
@property(nonatomic,assign,readonly)CMTime duration;
/// 视频展示区域  显示器
@property(nonatomic,strong,nullable)UIView *monitor;
/// 代理
@property(nonatomic,weak)id <LSAVPlayerDelegate> delegate;

+ (instancetype)sharedAVPlayer;
///开始播放
- (void)play;
///暂停
- (void)pause;
///结束播放 销毁播放器
- (void)stop;
///跳转到time节点并暂停
- (void)seekToTime:(CMTime)time completionHandler:(void (^_Nullable)(BOOL finished))completionHandler;

@end

NS_ASSUME_NONNULL_END
