//
//  UIView+LSViewBorderLine.m
//  GenericProject
//
//  Created by 社科赛斯 on 2019/12/12.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import "UIView+LSViewBorderLine.h"

@implementation UIView (LSViewBorderLine)

- (UIView *)borderForTopColor:(UIColor *)topColor BottomColor:(UIColor *)bottomColor LeftColor:(UIColor *)leftColor RightColor:(UIColor *)rightColor borderWidth:(CGFloat)borderWidth borderType:(UIBorderSideType)borderType {

    if (borderType == UIBorderSideTypeAll) {
        [self.layer addSublayer:[self addLineOriginPoint:CGPointMake(-1.0f, 0.0f) toPoint:CGPointMake(self.frame.size.width + 1, 0.0f) color:topColor borderWidth:borderWidth]];
        [self.layer addSublayer:[self addLineOriginPoint:CGPointMake(-1.0f, self.frame.size.height) toPoint:CGPointMake( self.frame.size.width + 1, self.frame.size.height) color:bottomColor borderWidth:borderWidth]];
        [self.layer addSublayer:[self addLineOriginPoint:CGPointMake(0.f, 0.f) toPoint:CGPointMake(0.0f, self.frame.size.height) color:leftColor borderWidth:borderWidth]];
        [self.layer addSublayer:[self addLineOriginPoint:CGPointMake(self.frame.size.width, 0.0f) toPoint:CGPointMake( self.frame.size.width, self.frame.size.height) color:rightColor borderWidth:borderWidth]];
    }
    //左侧
    if (borderType & UIBorderSideTypeLeft) {
        [self.layer addSublayer:[self addLineOriginPoint:CGPointMake(0.f, 0.f) toPoint:CGPointMake(0.0f, self.frame.size.height) color:leftColor borderWidth:borderWidth]];
    }
    //右侧
    if (borderType & UIBorderSideTypeRight) {
        [self.layer addSublayer:[self addLineOriginPoint:CGPointMake(self.frame.size.width, 0.0f) toPoint:CGPointMake( self.frame.size.width, self.frame.size.height) color:rightColor borderWidth:borderWidth]];
    }
    //顶部
    if (borderType & UIBorderSideTypeTop) {
        [self.layer addSublayer:[self addLineOriginPoint:CGPointMake(0.0f, 0.0f) toPoint:CGPointMake(self.frame.size.width, 0.0f) color:topColor borderWidth:borderWidth]];
    }
    //底部
    if (borderType & UIBorderSideTypeBottom) {
        [self.layer addSublayer:[self addLineOriginPoint:CGPointMake(0.0f, self.frame.size.height) toPoint:CGPointMake( self.frame.size.width, self.frame.size.height) color:bottomColor borderWidth:borderWidth]];
    }
    //上下
    if (borderType & UIBorderSideTypeTopAndBottom) {
        [self.layer addSublayer:[self addLineOriginPoint:CGPointMake(0.f, 0.f) toPoint:CGPointMake(self.frame.size.width, 0.0f) color:topColor borderWidth:borderWidth]];
        [self.layer addSublayer:[self addLineOriginPoint:CGPointMake(0.0f, self.frame.size.height) toPoint:CGPointMake( self.frame.size.width, self.frame.size.height) color:bottomColor borderWidth:borderWidth]];
    }
    //上左
    if (borderType & UIBorderSideTypeTopAndLeft) {
        [self.layer addSublayer:[self addLineOriginPoint:CGPointMake(-1.f, 0.f) toPoint:CGPointMake(self.frame.size.width, 0.0f) color:topColor borderWidth:borderWidth]];
        [self.layer addSublayer:[self addLineOriginPoint:CGPointMake(0.f, 0.f) toPoint:CGPointMake(0.0f, self.frame.size.height) color:leftColor borderWidth:borderWidth]];
    }
    //上右
    if (borderType & UIBorderSideTypeTopAndRight) {
        [self.layer addSublayer:[self addLineOriginPoint:CGPointMake(0.f, 0.f) toPoint:CGPointMake(self.frame.size.width, 0.0f) color:topColor borderWidth:borderWidth]];
        [self.layer addSublayer:[self addLineOriginPoint:CGPointMake(self.frame.size.width, -1.0f) toPoint:CGPointMake( self.frame.size.width, self.frame.size.height) color:rightColor borderWidth:borderWidth]];
    }
    //左下
    if (borderType & UIBorderSideTypeLeftAndBottom) {
        [self.layer addSublayer:[self addLineOriginPoint:CGPointMake(0.f, 0.f) toPoint:CGPointMake(0.0f, self.frame.size.height) color:leftColor borderWidth:borderWidth]];
        [self.layer addSublayer:[self addLineOriginPoint:CGPointMake(-1.0f, self.frame.size.height) toPoint:CGPointMake(self.frame.size.width, self.frame.size.height) color:bottomColor borderWidth:borderWidth]];
    }
    //左右
    if (borderType & UIBorderSideTypeLeftAndRight) {
        [self.layer addSublayer:[self addLineOriginPoint:CGPointMake(0.f, 0.f) toPoint:CGPointMake(0.0f, self.frame.size.height) color:leftColor borderWidth:borderWidth]];
        [self.layer addSublayer:[self addLineOriginPoint:CGPointMake(self.frame.size.width, 0.0f) toPoint:CGPointMake(self.frame.size.width, self.frame.size.height) color:rightColor borderWidth:borderWidth]];
    }
    //右下
    if (borderType & UIBorderSideTypeRightAndBottom) {
        [self.layer addSublayer:[self addLineOriginPoint:CGPointMake(self.frame.size.width, 0.0f) toPoint:CGPointMake(self.frame.size.width, self.frame.size.height) color:rightColor borderWidth:borderWidth]];
        [self.layer addSublayer:[self addLineOriginPoint:CGPointMake(0.0f, self.frame.size.height) toPoint:CGPointMake(self.frame.size.width + 1, self.frame.size.height) color:bottomColor borderWidth:borderWidth]];
    }
    //上下左
    if (borderType & UIBorderSideTypeTopAndBottomAndLeft) {
        [self.layer addSublayer:[self addLineOriginPoint:CGPointMake(-1.f, 0.f) toPoint:CGPointMake(self.frame.size.width, 0.0f) color:topColor borderWidth:borderWidth]];
        [self.layer addSublayer:[self addLineOriginPoint:CGPointMake(-1.0f, self.frame.size.height) toPoint:CGPointMake(self.frame.size.width, self.frame.size.height) color:bottomColor borderWidth:borderWidth]];
        [self.layer addSublayer:[self addLineOriginPoint:CGPointMake(0.f, 0.f) toPoint:CGPointMake(0.0f, self.frame.size.height) color:leftColor borderWidth:borderWidth]];
    }
    //上下右
    if (borderType & UIBorderSideTypeTopAndBottomAndRight) {
        [self.layer addSublayer:[self addLineOriginPoint:CGPointMake(0.f, 0.f) toPoint:CGPointMake(self.frame.size.width + 1, 0.0f) color:topColor borderWidth:borderWidth]];
        [self.layer addSublayer:[self addLineOriginPoint:CGPointMake(0.0f, self.frame.size.height) toPoint:CGPointMake(self.frame.size.width + 1, self.frame.size.height) color:bottomColor borderWidth:borderWidth]];
        [self.layer addSublayer:[self addLineOriginPoint:CGPointMake(self.frame.size.width, 0.0f) toPoint:CGPointMake(self.frame.size.width, self.frame.size.height) color:rightColor borderWidth:borderWidth]];
    }
    //左右上
    if (borderType & UIBorderSideTypeTopAndLeftAndRight) {
        [self.layer addSublayer:[self addLineOriginPoint:CGPointMake(0.f, -1.f) toPoint:CGPointMake(0.0f, self.frame.size.height) color:leftColor borderWidth:borderWidth]];
        [self.layer addSublayer:[self addLineOriginPoint:CGPointMake(self.frame.size.width, -1.0f) toPoint:CGPointMake(self.frame.size.width, self.frame.size.height) color:rightColor borderWidth:borderWidth]];
        [self.layer addSublayer:[self addLineOriginPoint:CGPointMake(0.f, 0.f) toPoint:CGPointMake(self.frame.size.width, 0.0f) color:topColor borderWidth:borderWidth]];
    }
    //左右下
    if (borderType & UIBorderSideTypeLeftAndRightAndBottom) {
        [self.layer addSublayer:[self addLineOriginPoint:CGPointMake(0.f, 0.f) toPoint:CGPointMake(0.0f, self.frame.size.height + 1) color:leftColor borderWidth:borderWidth]];
        [self.layer addSublayer:[self addLineOriginPoint:CGPointMake(self.frame.size.width, 0.0f) toPoint:CGPointMake(self.frame.size.width, self.frame.size.height + 1) color:rightColor borderWidth:borderWidth]];
        [self.layer addSublayer:[self addLineOriginPoint:CGPointMake(0.0f, self.frame.size.height) toPoint:CGPointMake(self.frame.size.width, self.frame.size.height) color:bottomColor borderWidth:borderWidth]];
    }
    
    return self;
}

- (CAShapeLayer *)addLineOriginPoint:(CGPoint)p0 toPoint:(CGPoint)p1 color:(UIColor *)color borderWidth:(CGFloat)borderWidth {
    //线的路径
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:p0];
    [bezierPath addLineToPoint:p1];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = color.CGColor;
    shapeLayer.fillColor  = [UIColor clearColor].CGColor;
    //添加路径
    shapeLayer.path = bezierPath.CGPath;
    //线宽度
    shapeLayer.lineWidth = borderWidth;
    
    
    
    
    return shapeLayer;
}

@end
