//
//  LSImageDecoder.h
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/12/10.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//存储每一帧图片信息的对象
@interface LSImageFrame : NSObject

@property(nonatomic,assign)NSUInteger index;    //索引
@property(nonatomic,assign)CGFloat width;    //每一帧的图像宽 像素
@property(nonatomic,assign)CGFloat height;   //每一帧的图像高 像素
@property(nonatomic,assign)NSUInteger offsetX;  // 每一帧在画布上的偏移量X (left-bottom based)
@property(nonatomic,assign)NSUInteger offsetY;  // 每一帧在画布上的偏移量Y (left-bottom based)
@property(nonatomic,assign)NSTimeInterval duration;  //持续时长
@property(nonatomic,assign)UIImageOrientation imageOrientation; //图像方向
@property(nullable,nonatomic,strong)UIImage *image; //解码后的image

@end

/**
 图片类型
 */
typedef NS_ENUM(NSUInteger, LSImageType) {
    LSImageTypeUnknown = 0, ///< unknown
    LSImageTypeJPEG,        ///< jpeg, jpg
    LSImageTypeJPEG2000,    ///< jp2
    LSImageTypeTIFF,        ///< tiff, tif
    LSImageTypeBMP,         ///< bmp
    LSImageTypeICO,         ///< ico
    LSImageTypeICNS,        ///< icns
    LSImageTypeGIF,         ///< gif
    LSImageTypePNG,         ///< png
    LSImageTypeWebP,        ///< webp
    LSImageTypeOther,       ///< other image format
};

/**
图片解码工具
*/
@interface LSImageDecoder : NSObject

/**
 解码的数据
 */
@property(nullable,nonatomic,readonly)NSData *data;
/**
 图像比例系数
 */
@property(nonatomic,assign)CGFloat scale;
/**
 图片类型
 */
@property(nonatomic,assign,readonly)LSImageType imageType;
/**
 图像帧总个数
 */
@property(nonatomic,assign,readonly)NSInteger frameCount;
/**
 循环次数
 */
@property(nonatomic,assign,readonly)NSInteger loopCount;
/**
 循环一次的时长
 */
@property(nonatomic,assign)NSTimeInterval totalTime;
/**
 画布的大小 宽*高
 */
@property(nonatomic,readonly)CGSize canvasSize;

/**
 配置图片解码器
 @param data 图片数据
 @param scale 图像比例系数 一般情况下为[UIScreen mainScreen].scale]
 */
- (void)decoderWithData:(NSData *)data scale:(CGFloat)scale;

/**
 获取某一帧的图片信息：索引、持续时长、宽高、方向、解码后的image
 index >= 0
 */
- (LSImageFrame *)imageFrameAtIndex:(NSInteger)index;

/**
 获取解码后的第index帧image
 */
- (UIImage *)imageAtIndex:(NSInteger)index;

/**
 某一帧持续时长
 */
- (NSTimeInterval)imageDurationAtIndex:(NSUInteger)index;

@end

NS_ASSUME_NONNULL_END
