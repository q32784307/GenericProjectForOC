//
//  LSImageView.h
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/12/10.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSImage.h"

NS_ASSUME_NONNULL_BEGIN

/// 支持gif/png/jpg  等图片
@interface LSImageView : UIImageView

/** 当前帧索引 默认从0开始 */
@property(nonatomic,assign)NSUInteger currentImageIndex;
/** 是否自动播放动图 默认YES */
@property(nonatomic,assign)BOOL autoPlayAnimatedImage;
/** 当前是否正在动画 */
@property(nonatomic,readonly)BOOL currentIsPlaying;
/** 设置帧缓冲池最大内存空间(字节B) 默认根据当前内存大小动态计算适合的缓存大小 */
@property(nonatomic,assign)NSUInteger maxBufferSize;
/// 图片类型
@property(nonatomic,assign,readonly)LSImageType imageType;
/// 当前动图
@property(nonatomic,strong,readonly)LSImage *animatedImage;

@end

NS_ASSUME_NONNULL_END
