//
//  LSImage.h
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/12/10.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSImageDecoder.h"

NS_ASSUME_NONNULL_BEGIN

//利用解码工具进行解码并存储解码后的信息
@interface LSImage : UIImage

/** 图片类型 */
@property(nonatomic,assign,readonly)LSImageType imageType;
/** 图像帧总个数 */
@property(nonatomic,assign,readonly)NSInteger frameCount;
/** 循环次数 0:无限循环 */
@property(nonatomic,assign,readonly)NSInteger loopCount;
/// 循环一次的时长
@property(nonatomic,assign,readonly)NSTimeInterval totalTime;
/** 图片所占的内存大小 */
@property(nonatomic,readonly)NSUInteger animatedImageMemorySize;
/** 是否预加载所有的帧 注意内存大小 默认NO */
@property(nonatomic,assign)BOOL preloadAllAnimatedImageFrames;

/**
 重写系统方法，用法尽量和原来保持一致
 */
+ (LSImage *)imageNamed:(NSString *)name;
+ (LSImage *)imageWithContentsOfFile:(NSString *)path;
+ (LSImage *)imageWithData:(NSData *)data;

/**
 某一帧的图片信息：索引、持续时长、宽高、方向、解码后的image
 */
- (LSImageFrame *)imageFrameAtIndex:(NSInteger)index;
/**
 动图中的某一帧image
 */
- (UIImage *)imageAtIndex:(NSUInteger)index;
/**
 某一帧持续时长
 */
- (NSTimeInterval)imageDurationAtIndex:(NSUInteger)index;
/**
 一帧所占的内存大小 假设每一帧大小相同
 */
- (NSUInteger)imageFrameBytes;

@end

NS_ASSUME_NONNULL_END
