//
//  LSImageDecoder.m
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/12/10.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import "LSImageDecoder.h"
#import <pthread.h>

#import <webp/decode.h>
#import <webp/encode.h>
#import <webp/demux.h>
#import <webp/mux.h>

//来源YYImage
#define LS_FOUR_CC(c1,c2,c3,c4) ((uint32_t)(((c4) << 24) | ((c3) << 16) | ((c2) << 8) | (c1)))
#define LS_TWO_CC(c1,c2) ((uint16_t)(((c2) << 8) | (c1)))

@implementation LSImageFrame

@end

@interface LSImageDecoder ()
{
    CGImageSourceRef _imageSource; //图像源数据
    WebPDemuxer *_webpSource; //webp格式图片的源数据  https://developers.google.com/speed/webp/docs/api
}

@end

@implementation LSImageDecoder

- (void)decoderWithData:(NSData *)data scale:(CGFloat)scale {
    _data = data;
    _scale = scale;
    _loopCount = 1;
    _totalTime = 0;
    _frameCount = 1;
    _imageType = imageDataType(_data);
    [self startDecoder];
}

- (void)startDecoder {
    [self imageFrameCount];
    switch (_imageType) {
        case LSImageTypeGIF:
            _loopCount = [self loopCountForGifData:_data];
            break;
        case LSImageTypeWebP:
            _loopCount = [self loopCountForGifData:_data];
            break;
        case LSImageTypePNG:
            _loopCount = [self loopCountForGifData:_data];
            break;
        default:
            break;
    }
}

#pragma mark - 图片信息
static void LSCGDataProviderReleaseDataCallback(void *info, const void *data, size_t size) {
    if (info) free(info);
}

CGColorSpaceRef LSCGColorSpaceGetDeviceRGB() {
    static CGColorSpaceRef space;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        space = CGColorSpaceCreateDeviceRGB();
    });
    return space;
}

/**
 返回图片的类型
 */
NSInteger imageDataType(NSData * data) {
    CFDataRef dataRef = (__bridge CFDataRef)data;
    if (!data) return LSImageTypeUnknown;
    uint64_t length = CFDataGetLength(dataRef);
    if (length < 16) return LSImageTypeUnknown;
    
    const char *bytes = (char *)CFDataGetBytePtr(dataRef);
    
    uint32_t magic4 = *((uint32_t *)bytes);
    switch (magic4) {
        case LS_FOUR_CC(0x4D, 0x4D, 0x00, 0x2A): { // big endian TIFF
            return LSImageTypeTIFF;
        } break;
            
        case LS_FOUR_CC(0x49, 0x49, 0x2A, 0x00): { // little endian TIFF
            return LSImageTypeTIFF;
        } break;
            
        case LS_FOUR_CC(0x00, 0x00, 0x01, 0x00): { // ICO
            return LSImageTypeICO;
        } break;
            
        case LS_FOUR_CC(0x00, 0x00, 0x02, 0x00): { // CUR
            return LSImageTypeICO;
        } break;
            
        case LS_FOUR_CC('i', 'c', 'n', 's'): { // ICNS
            return LSImageTypeICNS;
        } break;
            
        case LS_FOUR_CC('G', 'I', 'F', '8'): { // GIF
            return LSImageTypeGIF;
        } break;
            
        case LS_FOUR_CC(0x89, 'P', 'N', 'G'): {  // PNG
            uint32_t tmp = *((uint32_t *)(bytes + 4));
            if (tmp == LS_FOUR_CC('\r', '\n', 0x1A, '\n')) {
                return LSImageTypePNG;
            }
        } break;
            
        case LS_FOUR_CC('R', 'I', 'F', 'F'): { // WebP
            uint32_t tmp = *((uint32_t *)(bytes + 8));
            if (tmp == LS_FOUR_CC('W', 'E', 'B', 'P')) {
                return LSImageTypeWebP;
            }
        } break;
    }
    
    uint16_t magic2 = *((uint16_t *)bytes);
    switch (magic2) {
        case LS_TWO_CC('B', 'A'):
        case LS_TWO_CC('B', 'M'):
        case LS_TWO_CC('I', 'C'):
        case LS_TWO_CC('P', 'I'):
        case LS_TWO_CC('C', 'I'):
        case LS_TWO_CC('C', 'P'): { // BMP
            return LSImageTypeBMP;
        }
        case LS_TWO_CC(0xFF, 0x4F): { // JPEG2000
            return LSImageTypeJPEG2000;
        }
    }
    
    // JPG             FF D8 FF
    if (memcmp(bytes,"\377\330\377",3) == 0) return LSImageTypeJPEG;
    // JP2
    if (memcmp(bytes + 4, "\152\120\040\040\015", 5) == 0) return LSImageTypeJPEG2000;
    
    return LSImageTypeUnknown;
};

/**
 每一帧图片的方向
 */
UIImageOrientation LSUIImageOrientationFromEXIFValue(NSInteger value) {
    switch (value) {
        case kCGImagePropertyOrientationUp: return UIImageOrientationUp;
        case kCGImagePropertyOrientationDown: return UIImageOrientationDown;
        case kCGImagePropertyOrientationLeft: return UIImageOrientationLeft;
        case kCGImagePropertyOrientationRight: return UIImageOrientationRight;
        case kCGImagePropertyOrientationUpMirrored: return UIImageOrientationUpMirrored;
        case kCGImagePropertyOrientationDownMirrored: return UIImageOrientationDownMirrored;
        case kCGImagePropertyOrientationLeftMirrored: return UIImageOrientationLeftMirrored;
        case kCGImagePropertyOrientationRightMirrored: return UIImageOrientationRightMirrored;
        default: return UIImageOrientationUp;
    }
}

/**
 获取每一帧图片解压缩后的位图
 */
CGImageRef LSCGImageCreateDecodedCopy(CGImageRef imageRef, BOOL decodeForDisplay) {
    if (!imageRef) return NULL;
    size_t width = CGImageGetWidth(imageRef);
    size_t height = CGImageGetHeight(imageRef);
    if (width == 0 || height == 0) return NULL;
    
    if (decodeForDisplay) { //decode with redraw (may lose some precision)
        CGImageAlphaInfo alphaInfo = CGImageGetAlphaInfo(imageRef) & kCGBitmapAlphaInfoMask;
        BOOL hasAlpha = NO;
        if (alphaInfo == kCGImageAlphaPremultipliedLast ||
            alphaInfo == kCGImageAlphaPremultipliedFirst ||
            alphaInfo == kCGImageAlphaLast ||
            alphaInfo == kCGImageAlphaFirst) {
            hasAlpha = YES;
        }
        // BGRA8888 (premultiplied) or BGRX8888
        // same as UIGraphicsBeginImageContext() and -[UIView drawRect:]
        CGBitmapInfo bitmapInfo = kCGBitmapByteOrder32Host;
        bitmapInfo |= hasAlpha ? kCGImageAlphaPremultipliedFirst : kCGImageAlphaNoneSkipFirst;
        CGContextRef context = CGBitmapContextCreate(NULL, width, height, 8, 0, LSCGColorSpaceGetDeviceRGB(), bitmapInfo);
        if (!context) return NULL;
        CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef); // decode
        CGImageRef newImage = CGBitmapContextCreateImage(context);
        CFRelease(context);
        return newImage;
        
    } else {
        CGColorSpaceRef space = CGImageGetColorSpace(imageRef);
        size_t bitsPerComponent = CGImageGetBitsPerComponent(imageRef);
        size_t bitsPerPixel = CGImageGetBitsPerPixel(imageRef);
        size_t bytesPerRow = CGImageGetBytesPerRow(imageRef);
        CGBitmapInfo bitmapInfo = CGImageGetBitmapInfo(imageRef);
        if (bytesPerRow == 0 || width == 0 || height == 0) return NULL;
        
        CGDataProviderRef dataProvider = CGImageGetDataProvider(imageRef);
        if (!dataProvider) return NULL;
        CFDataRef data = CGDataProviderCopyData(dataProvider); // decode
        if (!data) return NULL;
        
        CGDataProviderRef newProvider = CGDataProviderCreateWithCFData(data);
        CFRelease(data);
        if (!newProvider) return NULL;
        
        CGImageRef newImage = CGImageCreate(width, height, bitsPerComponent, bitsPerPixel, bytesPerRow, space, bitmapInfo, newProvider, NULL, false, kCGRenderingIntentDefault);
        CFRelease(newProvider);
        return newImage;
    }
}

/**
 获取动图的图片帧数
 */
- (void)imageFrameCount {
    if(_imageType == LSImageTypeWebP) {
        if (_webpSource) WebPDemuxDelete(_webpSource);
        _webpSource = NULL;
        WebPData webPData = {0};
        webPData.bytes = _data.bytes;
        webPData.size = _data.length;
        WebPDemuxer *demuxer = WebPDemux(&webPData);
        if (!demuxer) _frameCount = 1;
        _webpSource = demuxer;
        NSInteger frameCout =  WebPDemuxGetI(demuxer, WEBP_FF_FRAME_COUNT);
        _frameCount = frameCout;
    } else {
        //将GIF图片转换成对应的图片源
        _imageSource = CGImageSourceCreateWithData((__bridge CFDataRef)_data, NULL);
        //获取其中图片源个数，即由多少帧图片组成
        size_t frameCout = CGImageSourceGetCount(_imageSource);
        _frameCount = frameCout;
    }
}

/**
 获取某一帧的图片信息：索引、持续时长、宽高、方向、解码后的image
 index >= 0
 */
- (LSImageFrame *)imageFrameAtIndex:(NSInteger)index {
    if(index >= _frameCount || index < 0) return nil;
    
    LSImageFrame * imageFrame = [[LSImageFrame alloc] init];
    imageFrame.index = index;
    CGFloat width = 0, height = 0;
    NSInteger orientation = UIImageOrientationUp;
    if(_imageType == LSImageTypeWebP) {
        WebPIterator iter = {0};
        if (WebPDemuxGetFrame(_webpSource, (int)index, &iter)) {
            imageFrame.index = index;
            imageFrame.duration = iter.duration / 1000.0;
            imageFrame.width = iter.width;
            imageFrame.height = iter.height;
            imageFrame.imageOrientation = UIImageOrientationUp;
            imageFrame.image = [self imageAtIndex:index];
            imageFrame.offsetX = iter.x_offset;
            imageFrame.offsetY = self.canvasSize.height - iter.y_offset - iter.height;
        };
        WebPDemuxReleaseIterator(&iter);
    }else{
        
        // image属性
        CFDictionaryRef imageProperties = CGImageSourceCopyPropertiesAtIndex(_imageSource, index, NULL);
        imageFrame.duration = [self imageDurationAtIndex:index];
        
        CFTypeRef valueWidth = CFDictionaryGetValue(imageProperties, kCGImagePropertyPixelWidth);
        if (valueWidth){
            CFNumberGetValue(valueWidth, kCFNumberCGFloatType, &width);
            imageFrame.width = width;
        }
        CFTypeRef valueHeight = CFDictionaryGetValue(imageProperties, kCGImagePropertyPixelHeight);
        if (valueHeight){
            CFNumberGetValue(valueHeight, kCFNumberCGFloatType, &height);
            imageFrame.height = height;
        }
        CFTypeRef valueOrientation = CFDictionaryGetValue(imageProperties, kCGImagePropertyOrientation);
        if (valueOrientation) {
            CFNumberGetValue(valueOrientation, kCFNumberNSIntegerType, &orientation);
            imageFrame.imageOrientation = LSUIImageOrientationFromEXIFValue(orientation);
        }
        imageFrame.image = [self imageAtIndex:index];
        CFRelease(imageProperties);
    }
    return imageFrame;
}

/**
 获取某一帧image
 */
- (UIImage *)imageAtIndex:(NSInteger)index {
    if(index >= _frameCount || index < 0) return nil;
    
    CGImageRef imageRef;
    
    if(_imageType == LSImageTypeWebP) {
        
        WebPIterator iter;
        if (!WebPDemuxGetFrame(_webpSource, (int)(index), &iter)) return NULL; // demux webp frame data
        
        int frameWidth = iter.width;
        int frameHeight = iter.height;
        if (frameWidth < 1 || frameHeight < 1) return NULL;
        
        int width = frameWidth;
        int height = frameHeight;
        
        const uint8_t *payload = iter.fragment.bytes;
        size_t payloadSize = iter.fragment.size;
        
        WebPDecoderConfig config;
        if (!WebPInitDecoderConfig(&config)) {
            WebPDemuxReleaseIterator(&iter);
            return NULL;
        }
        if (WebPGetFeatures(payload , payloadSize, &config.input) != VP8_STATUS_OK) {
            WebPDemuxReleaseIterator(&iter);
            return NULL;
        }
        
        size_t bitsPerComponent = 8;
        size_t bitsPerPixel = 32;
        
        size_t bytesPerRow = ((bitsPerPixel / 8 * width + (32 - 1)) / 32) * 32;
        size_t length = bytesPerRow * height;
        CGBitmapInfo bitmapInfo = kCGBitmapByteOrder32Host | kCGImageAlphaPremultipliedFirst; //bgrA
        
        void *pixels = calloc(1, length);
        if (!pixels) {
            WebPDemuxReleaseIterator(&iter);
            return NULL;
        }
        
        config.output.colorspace = MODE_bgrA;
        config.output.is_external_memory = 1;
        config.output.u.RGBA.rgba = pixels;
        config.output.u.RGBA.stride = (int)bytesPerRow;
        config.output.u.RGBA.size = length;
        VP8StatusCode result = WebPDecode(payload, payloadSize, &config); // decode
        if ((result != VP8_STATUS_OK) && (result != VP8_STATUS_NOT_ENOUGH_DATA)) {
            WebPDemuxReleaseIterator(&iter);
            free(pixels);
            return NULL;
        }
        WebPDemuxReleaseIterator(&iter);
        
        CGDataProviderRef provider = CGDataProviderCreateWithData(pixels, pixels, length, LSCGDataProviderReleaseDataCallback);
        if (!provider) {
            free(pixels);
            return NULL;
        }
        pixels = NULL; // hold by provider
        
        imageRef = CGImageCreate(width, height, bitsPerComponent, bitsPerPixel, bytesPerRow, LSCGColorSpaceGetDeviceRGB(), bitmapInfo, provider, NULL, false, kCGRenderingIntentDefault);
        CFRelease(provider);
        
    } else {
        //从GIF图片中取出某一帧源图片  https://www.jianshu.com/p/e9843d5b70a2
        imageRef = CGImageSourceCreateImageAtIndex(_imageSource, index, (CFDictionaryRef)@{(id)kCGImageSourceShouldCache:@(NO),(id)kCGImageSourceShouldCacheImmediately:@(NO)}); //默认会缓存到内存，和imageNamed一样；这里我们选择不缓存，减少内存占用
    }
    
    //将图片源解码后转换成UIImageView能直接使用的图片源NO
    CGImageRef imageRefDecoded = LSCGImageCreateDecodedCopy(imageRef, YES);
    if (imageRefDecoded) {
        CFRelease(imageRef);
        imageRef = imageRefDecoded;
    }
    UIImage* image = [UIImage imageWithCGImage:imageRef scale:_scale orientation:UIImageOrientationUp];
    if(imageRef){
        CFRelease(imageRef);
    }
    return image;
}

/**
 某一帧持续时长
 */
- (NSTimeInterval)imageDurationAtIndex:(NSUInteger)index {
    if(index >= _frameCount || index < 0) return 0;
    
    NSTimeInterval duration = 0;
    
    if(_imageType == LSImageTypeWebP) {
        WebPIterator iter = {0};
        if (WebPDemuxGetFrame(_webpSource, (int)index, &iter)) {
            duration = iter.duration / 1000.0;
        };
        WebPDemuxReleaseIterator(&iter);
    }else{
        // image属性
        CFDictionaryRef imageProperties = CGImageSourceCopyPropertiesAtIndex(_imageSource, index, NULL);
        if (imageProperties) {
            CFDictionaryRef gifProperties;
            BOOL result = CFDictionaryGetValueIfPresent(imageProperties, kCGImagePropertyGIFDictionary, (const void **)&gifProperties);
            if (result) {
                const void *durationValue;
                if (CFDictionaryGetValueIfPresent(gifProperties, kCGImagePropertyGIFUnclampedDelayTime, &durationValue)) {
                    duration = [(__bridge NSNumber *)durationValue doubleValue];
                    if (duration < 0) {
                        if (CFDictionaryGetValueIfPresent(gifProperties, kCGImagePropertyGIFDelayTime, &durationValue)) {
                            duration = [(__bridge NSNumber *)durationValue doubleValue];
                        }
                    }
                }
            }
        }
        CFRelease(imageProperties);
    }
    
    if (duration < 0.02) duration = 0.1;
    return duration;
}

/**
 返回gif文件的循环次数 0表示无限循环
 */
- (NSInteger)loopCountForGifData:(NSData *)data {
    NSInteger loopCount = 1;
    
    if (_imageType == LSImageTypeWebP) {
        loopCount =  WebPDemuxGetI(_webpSource, WEBP_FF_LOOP_COUNT);
    } else {
        //gif相关属性
        CFDictionaryRef properties = CGImageSourceCopyProperties(_imageSource, NULL);
        if (properties) {
            CFDictionaryRef gif = CFDictionaryGetValue(properties, kCGImagePropertyGIFDictionary);
            if (gif) {
                CFTypeRef loop = CFDictionaryGetValue(gif, kCGImagePropertyGIFLoopCount);
                if (loop) {
                    //如果loop == NULL，表示不循环播放，当loopCount  == 0时，表示无限循环；
                    CFNumberGetValue(loop, kCFNumberNSIntegerType, &loopCount);
                    if(loopCount == 0){
                        //                    NLSog(@"无限循环播放");
                    }else{
                        //                    NLSog(@"循环次数：%ld ",loopCount);
                    }
                }else{
                    //                NLSog(@"循环一次");
                };
            }
        }
        CFRelease(properties);
    }
    return loopCount;
}

/**
 循环一次所需的总时长
 */
- (NSTimeInterval)totalTimeOfLoopOnce {
    NSTimeInterval duration = 0;
    @autoreleasepool {
        for(int i = 0; i < _frameCount; i++){
            duration += [self imageDurationAtIndex:i];
        }
    }
    return duration;
}

#pragma mark - Getter
- (CGSize)canvasSize{
    if(_imageType == LSImageTypeWebP) {
        CGFloat width = WebPDemuxGetI(_webpSource, WEBP_FF_CANVAS_WIDTH);
        CGFloat height = WebPDemuxGetI(_webpSource, WEBP_FF_CANVAS_HEIGHT);
        return CGSizeMake(width, height);
    }else{
        // image属性
        CFDictionaryRef imageProperties = CGImageSourceCopyPropertiesAtIndex(_imageSource, 0, NULL);
        NSDictionary *properties = (__bridge NSDictionary *)imageProperties;
        CGFloat width = [properties[(NSString *)kCGImagePropertyPixelWidth] floatValue];
        CGFloat height = [properties[(NSString *)kCGImagePropertyPixelHeight] floatValue];
        CFRelease(imageProperties);
        return CGSizeMake(width, height);
    }
}

- (NSTimeInterval)totalTime {
    if (_totalTime == 0) {
        _totalTime = [self totalTimeOfLoopOnce];
    }
    return _totalTime;
}

- (void)dealloc {
    if (_imageSource) {
        CFRelease(_imageSource);
    }
    if (_webpSource) {
        WebPDemuxDelete(_webpSource);
    }
}

@end
