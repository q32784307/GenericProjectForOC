//
//  ShufflingFigureView.h
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/6/25.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ShufflingFigureView;
typedef enum : NSUInteger {
    VideoAndImage,//视频
    OnlyImage,//图片
} ShufflingFigureType;

@protocol ShufflingFigureViewDelegate <NSObject>

//点击图片索引
- (void)videoView:(ShufflingFigureView *)view didSelectItemAtIndexPath:(NSInteger)index;

@end

@interface ShufflingFigureView : UIView

@property(nonatomic,weak)id<ShufflingFigureViewDelegate> delegate;
@property(nonatomic,assign)ShufflingFigureType type;

/*
 * isVideo  是否带视屏链接
 * array    数据
 */
- (void)setWithIsVideo:(ShufflingFigureType)type andDataArray:(NSArray *)array;

//清除缓存（必须写）
- (void)clearCache;

@end

NS_ASSUME_NONNULL_END
