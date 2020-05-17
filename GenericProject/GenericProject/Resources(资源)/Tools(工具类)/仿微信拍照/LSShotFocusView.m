//
//  LSShotFocusView.m
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/12/10.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import "LSShotFocusView.h"

@interface LSShotFocusView ()

/** 路径 */
@property(nonatomic,strong)UIBezierPath *borderPath;

@end

@implementation LSShotFocusView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 初始化路径
        self.borderPath = [UIBezierPath bezierPath];
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        // 初始化路径
        self.borderPath = [UIBezierPath bezierPath];
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    self.borderPath = [UIBezierPath bezierPathWithRect:self.bounds];
    self.borderPath.lineCapStyle = kCGLineCapButt;//线条拐角
    self.borderPath.lineWidth = 2.0;
    UIColor *color = [UIColor colorWithRed:45 / 255.0 green:175 / 255.0 blue:45 / 255.0 alpha:1];
    [color set];// 设置边框线条颜色
    
    //起点
    [self.borderPath moveToPoint:CGPointMake(rect.size.width / 2.0, 0)];
    //连线 上
    [self.borderPath addLineToPoint:CGPointMake(rect.size.width / 2.0, 0 + 8)];
    [self.borderPath moveToPoint:CGPointMake(0, rect.size.width / 2.0)];
    //连线 左
    [self.borderPath addLineToPoint:CGPointMake(0 + 8, rect.size.width / 2.0)];
    [self.borderPath moveToPoint:CGPointMake(rect.size.width / 2.0, rect.size.height)];
    //连线 下
    [self.borderPath addLineToPoint:CGPointMake(rect.size.width / 2.0, rect.size.height - 8)];
    [self.borderPath moveToPoint:CGPointMake(rect.size.width, rect.size.height / 2.0)];
    //连线 右
    [self.borderPath addLineToPoint:CGPointMake(rect.size.width - 8, rect.size.height / 2.0)];
    
    [self.borderPath stroke];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
