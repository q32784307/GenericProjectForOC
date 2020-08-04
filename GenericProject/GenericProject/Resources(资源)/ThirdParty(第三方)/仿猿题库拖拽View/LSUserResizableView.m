//
//  LSUserResizableView.m
//  GenericProject
//
//  Created by 社科塞斯 on 2020/8/4.
//  Copyright © 2020 漠然丶情到深处. All rights reserved.
//

#import "LSUserResizableView.h"

static LSUserResizableViewAnchorPoint LSUserResizableViewNoResizeAnchorPoint = { 0.0, 0.0, 0.0, 0.0 };
static LSUserResizableViewAnchorPoint LSUserResizableViewUpperLeftAnchorPoint = { 1.0, 1.0, -1.0, 1.0 };
static LSUserResizableViewAnchorPoint LSUserResizableViewUpperMiddleAnchorPoint = { 0.0, 1.0, -1.0, 0.0 };
static LSUserResizableViewAnchorPoint LSUserResizableViewUpperRightAnchorPoint = { 0.0, 1.0, -1.0, -1.0 };

@implementation LSUserResizableView

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setContentView:(UIView *)newContentView {
    [_contentView removeFromSuperview];
    _contentView = newContentView;
    _contentView.backgroundColor = [UIColor clearColor];
    _contentView.frame = CGRectInset(self.bounds, 0, 0);
    [self addSubview:_contentView];
}

- (void)setFrame:(CGRect)newFrame {
    [super setFrame:newFrame];
    _contentView.frame = CGRectInset(self.bounds, 0, 0);
}

static CGFloat LSDistanceBetweenTwoPoints(CGPoint point1, CGPoint point2) {
    CGFloat dx = point2.x - point1.x;
    CGFloat dy = point2.y - point1.y;
    return sqrt(dx*dx + dy*dy);
};

typedef struct CGPointLSUserResizableViewAnchorPointPair {
    CGPoint point;
    LSUserResizableViewAnchorPoint anchorPoint;
} CGPointLSUserResizableViewAnchorPointPair;

- (LSUserResizableViewAnchorPoint)anchorPointForTouchLocation:(CGPoint)touchPoint {
    // (1) 计算点击锚点的位置.
    CGPointLSUserResizableViewAnchorPointPair upperLeft = { CGPointMake(0.0, 0.0), LSUserResizableViewUpperLeftAnchorPoint };
    CGPointLSUserResizableViewAnchorPointPair upperMiddle = { CGPointMake(self.bounds.size.width/2, 0.0), LSUserResizableViewUpperMiddleAnchorPoint };
    CGPointLSUserResizableViewAnchorPointPair upperRight = { CGPointMake(self.bounds.size.width, 0.0), LSUserResizableViewUpperRightAnchorPoint };
    CGPointLSUserResizableViewAnchorPointPair centerPoint = { CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2), LSUserResizableViewNoResizeAnchorPoint };
    
    // (2) 遍历每一个锚点,找到一个最靠近的点.
    CGPointLSUserResizableViewAnchorPointPair allPoints[4] = { upperLeft, upperRight, upperMiddle, centerPoint };
    CGFloat smallestDistance = MAXFLOAT;
    CGPointLSUserResizableViewAnchorPointPair closestPoint = centerPoint;
    for (NSInteger i = 0; i < 4; i++) {
        CGFloat distance = LSDistanceBetweenTwoPoints(touchPoint, allPoints[i].point);
        
        if (distance < smallestDistance) {
            closestPoint = allPoints[i];
            smallestDistance = distance;
        }
    }
    
    return closestPoint.anchorPoint;
}

- (BOOL)isResizing {
    return (anchorPoint.adjustsY);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    anchorPoint = [self anchorPointForTouchLocation:[touch locationInView:self]];
    touchStart = [touch locationInView:self.superview];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    // 响应代理.
    if (self.delegate && [self.delegate respondsToSelector:@selector(userResizableViewDidEndEditing:)]) {
        [self.delegate userResizableViewDidEndEditing:self];
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    // 响应代理.
    if (self.delegate && [self.delegate respondsToSelector:@selector(userResizableViewDidEndEditing:)]) {
        [self.delegate userResizableViewDidEndEditing:self];
    }
}

- (void)resizeUsingTouchLocation:(CGPoint)touchPoint {
    // (1) 更新坐标且判断是否超过规定的最高或最低Y值.
    if (touchPoint.y <= _topDistance) {
        touchPoint.y = _topDistance;
        return;
    }
    if (touchPoint.y >= ScreenHeight - _bottomDistance) {
        touchPoint.y = ScreenHeight - _bottomDistance;
        return;
    }
    
    // (2) 使用当前的锚点计算增量.
    CGFloat deltaH = anchorPoint.adjustsH * (touchPoint.y - touchStart.y);
    CGFloat deltaY = anchorPoint.adjustsY * (-1.0 * deltaH);
    
    // (3) 计算新的Frame.
    CGFloat newY = self.frame.origin.y + deltaY;
    CGFloat newHeight = self.frame.size.height + deltaH;
    
    self.frame = CGRectMake(0, newY, self.frame.size.width, newHeight);
    
    touchStart = touchPoint;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {

    if ([self isResizing]) {
        [self resizeUsingTouchLocation:[[touches anyObject] locationInView:self.superview]];
        
        // 响应代理.
        if (self.delegate && [self.delegate respondsToSelector:@selector(userResizableViewDidBeginEditing:)]) {
            [self.delegate userResizableViewDidBeginEditing:self];
        }
    }
}

- (void)dealloc {
    [_contentView removeFromSuperview];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
