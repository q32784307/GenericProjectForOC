//
//  LineDashView.m
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2017/12/19.
//  Copyright © 2017年 漠然丶情到深处. All rights reserved.
//

#import "LineDashView.h"

@interface LineDashView ()
{
    CAShapeLayer *_shapeLayer;
}

@end

@implementation LineDashView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.bounds];
        _shapeLayer = (CAShapeLayer *)self.layer;
        _shapeLayer.fillColor = [UIColor clearColor].CGColor;
        _shapeLayer.strokeStart = 0.001;
        _shapeLayer.strokeEnd = 0.499;
        _shapeLayer.lineWidth = frame.size.height;
        _shapeLayer.path = path.CGPath;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame lineDashPattern:(NSArray *)lineDashPattern endOffset:(CGFloat)endOffset {
    LineDashView *lineDashView = [[LineDashView alloc] initWithFrame:frame];
    lineDashView.lineDashPattern = lineDashPattern;
    lineDashView.endOffset = endOffset;
    
    return lineDashView;
}

#pragma mark - 修改view的backedLayer为CAShapeLayer
+ (Class)layerClass {
    return [CAShapeLayer class];
}

#pragma mark - 改写属性的getter,setter方法
@synthesize lineDashPattern = _lineDashPattern;
- (void)setLineDashPattern:(NSArray *)lineDashPattern {
    _lineDashPattern = lineDashPattern;
    _shapeLayer.lineDashPattern = lineDashPattern;
}

- (NSArray *)lineDashPattern {
    return _lineDashPattern;
}

@synthesize endOffset = _endOffset;
- (void)setEndOffset:(CGFloat)endOffset {
    _endOffset = endOffset;
    if (endOffset < 0.499 && endOffset > 0.001) {
        _shapeLayer.strokeEnd = _endOffset;
    }
}

- (CGFloat)endOffset {
    return _endOffset;
}

#pragma mark - 重写了系统的backgroundColor属性
- (void)setBackgroundColor:(UIColor *)backgroundColor {
    _shapeLayer.strokeColor = backgroundColor.CGColor;
}

- (UIColor *)backgroundColor {
    return [UIColor colorWithCGColor:_shapeLayer.strokeColor];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
