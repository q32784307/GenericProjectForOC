//
//  UIImage+LSImage.h
//  GenericProject
//
//  Created by 社科赛斯 on 2019/12/12.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (LSImage)

/**
 *  根据颜色生成一张图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color;


#pragma mark -- 图片压缩
/**
 等比压缩
 
 @param image       原图片
 @param scaleSize   压缩比例
 @return            压缩后的图片
 */
+ (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize;

/**
 自定义尺寸压缩
 
 @param image       原图片
 @param reSize      自定义尺寸的大小
 @return            压缩后的图片
 */
+ (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize;

/**
 自定义图片质量大小压缩
 
 @param image       原图片
 @param maxLengte   自定义图片质量的大小
 @return            压缩后的图片
 */
+ (UIImage *)compressImageSize:(UIImage *)image toByte:(NSInteger)maxLengte;

/**
 指定图片质量大小压缩，尺寸不变
 
 @param image       原图片
 @param size        图片质量的大小
 @return            压缩后的图片
 */
+ (NSData *)compressOriginalImage:(UIImage *)image toMaxDataSizeKBytes:(CGFloat)size;

/**
 图片质量与图片尺寸结合压缩
 
 @param image       原图片
 @param maxLength   图片质量的大小
 @return            压缩后的图片
 */
+ (NSData *)compressWithOriginalImage:(UIImage *)image maxLength:(NSUInteger)maxLength;

//使用
/*
 NSData *compressData = [image compressWithOriginalImage:500.0f * 1024.0f];
 UIImage *compressImage = [UIImage imageWithData:compressData];
 */

@end

NS_ASSUME_NONNULL_END
