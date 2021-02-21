//
//  UIView+LSWaterMark.m
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/10/18.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import "UIView+LSWaterMark.h"

@implementation UIView (LSWaterMark)

- (void)addWaterMarkText:(NSString *)waterText WithTextColor:(UIColor *)color WithFont:(UIFont *)font {
    //计算水印文字的宽高
    NSString *waterMark = waterText;
    CGSize textSize = [waterMark sizeWithAttributes:@{NSFontAttributeName:font}];
    NSInteger line = LSScreenHeight * 3.5 / 80; //多少行
    NSInteger row = 20;
   
    for (int i = 0; i < line; i++) {
        for (int j = 0; j < row; j++) {
            CATextLayer *textLayer = [[CATextLayer alloc]init];
            textLayer.contentsScale = [UIScreen mainScreen].scale;//按当前屏幕分辨显示，否则会模糊
            CFStringRef fontName = (__bridge CFStringRef)font.fontName;
            CGFontRef fontRef =CGFontCreateWithFontName(fontName);
            textLayer.font = fontRef;
            textLayer.fontSize = font.pointSize;
            textLayer.foregroundColor = color.CGColor;
            textLayer.string = waterMark;
            textLayer.frame = CGRectMake(j * (textSize.width + 30), i * 60, textSize.width, textSize.height);
            //旋转文字
            textLayer.transform = CATransform3DMakeRotation(-M_PI / 5,0,0,3);
            [self.layer addSublayer:textLayer];
        }
    }
}

@end
