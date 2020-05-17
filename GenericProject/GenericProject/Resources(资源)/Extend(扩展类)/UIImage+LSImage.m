//
//  UIImage+LSImage.m
//  GenericProject
//
//  Created by 社科赛斯 on 2019/12/12.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import "UIImage+LSImage.h"

@implementation UIImage (LSImage)

+ (UIImage *)imageWithColor:(UIColor *)color {
    //描述一个矩形
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    //开启图形上下文
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    //获得图形上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //使用color演示填充上下文
    CGContextSetFillColorWithColor(ctx, [color CGColor]);
    //渲染上下文
    CGContextFillRect(ctx, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //关闭图形上下文
    UIGraphicsEndImageContext();
    
    return image;
}

#pragma mark -- 图片压缩
/**
 等比压缩
 
 @param image       原图片
 @param scaleSize   压缩比例
 @return            压缩后的图片
 */
+ (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize {
    CGFloat imageW = image.size.width * scaleSize;
    CGFloat imageH = image.size.height * scaleSize;
    UIGraphicsBeginImageContext(CGSizeMake(imageW, imageH));
    [image drawInRect:CGRectMake(0, 0, imageW, imageH)];
    UIImage *scaleImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaleImage;
}

/**
 自定义尺寸压缩
 
 @param image       原图片
 @param reSize      自定义尺寸的大小
 @return            压缩后的图片
 */
+ (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize {
    UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
    [image drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return reSizeImage;
}

/**
 自定义图片质量大小压缩
 
 @param image       原图片
 @param maxLengte   自定义图片质量的大小
 @return            压缩后的图片
 */
+ (UIImage *)compressImageSize:(UIImage *)image toByte:(NSInteger)maxLengte {
    UIImage *resultImage = image;
    NSData *data = UIImageJPEGRepresentation(resultImage, 1);
    NSUInteger lastDataLength = 0;
    while (data.length > maxLengte && data.length != lastDataLength) {
        lastDataLength = data.length;
        CGFloat ratio = (CGFloat)maxLengte / data.length;
        CGSize size = CGSizeMake((NSInteger)(resultImage.size.width * sqrtf(ratio)), (NSInteger)(resultImage.size.height * (sqrtf(ratio))));
        UIGraphicsBeginImageContext(size);
        [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        data = UIImageJPEGRepresentation(resultImage, 1);
    }
    
    return resultImage;
}

/**
 指定图片质量大小压缩，尺寸不变
 
 @param image       原图片
 @param size        图片质量的大小
 @return            压缩后的图片
 */
+ (NSData *)compressOriginalImage:(UIImage *)image toMaxDataSizeKBytes:(CGFloat)size {
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(image, compression);
    if (data.length <= size) {
        return data;
    }
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(image, compression);
        if (data.length < size) {
            min = compression;
        }else if (data.length > size * 0.9) {
            max = compression;
        }else{
            break;
        }
    }
    return data;
}

/**
 图片质量与图片尺寸结合压缩
 
 @param image       原图片
 @param maxLength   图片质量的大小
 @return            压缩后的图片
 */
+ (NSData *)compressWithOriginalImage:(UIImage *)image maxLength:(NSUInteger)maxLength {
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(image, compression);
    if (data.length <= maxLength) {
        return data;
    }
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        UIImage *resultImage = [UIImage imageWithData:data];
        CGFloat ratio = (CGFloat)maxLength / data.length;
        CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)), (NSUInteger)(resultImage.size.height * sqrtf(ratio)));
        UIGraphicsBeginImageContext(size);
        [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        data = UIImageJPEGRepresentation(resultImage, 1);
        compression = (max + min) / 2;
        
        if (data.length <= maxLength) {
            return data;
        }
        if (data.length < maxLength) {
            min = compression;
        }else if (data.length > maxLength * 0.9) {
            max = compression;
        }else{
            break;
        }
        
        data = UIImageJPEGRepresentation(resultImage, compression);
        if (data.length <= maxLength) {
            return data;
        }
    }
    return data;
}

@end
