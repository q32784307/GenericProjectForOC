//
//  UIButton+LSButtonGradient.m
//  GenericProject
//
//  Created by 社科赛斯 on 2019/12/12.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import "UIButton+LSButtonGradient.h"

@implementation UIButton (LSButtonGradient)

- (UIButton *)gradientButtonWithSize:(CGSize)btnSize colorArray:(NSArray *)clrs percentageArray:(NSArray *)percent gradientType:(GradientType)type {
    
    UIImage *backImage = [[UIImage alloc]createImageWithSize:btnSize gradientColors:clrs percentage:percent gradientType:type];
    
    [self setBackgroundImage:backImage forState:UIControlStateNormal];
    
    return self;
}

@end
