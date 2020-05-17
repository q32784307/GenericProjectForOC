//
//  LSEditSelectedBox.m
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/12/10.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import "LSEditSelectedBox.h"

@interface LSEditSelectedBox ()

@end

@implementation LSEditSelectedBox

#pragma mark - Override
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        [self initView];
    }
    return self;
}

#pragma mark - help Methods
- (void)initView {
    // 初始化遮罩
    self.userInteractionEnabled = YES;
    self.layer.borderColor = [UIColor colorWithRed:45/255.0 green:175/255.0 blue:45/255.0 alpha:1].CGColor;
    self.layer.borderWidth = 2;
    self.backgroundColor = [UIColor clearColor];
    self.clipsToBounds = NO;
}

- (void)didMoveToSuperview {
    if (self.superview) {
        [self.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
        // 缩放系数
        CGAffineTransform transform = self.superview.transform;
        CGFloat scale = sqrt(transform.a*transform.a + transform.c*transform.c);
        scale = scale <= 1 ? 1 : scale ;
        
        self.layer.borderWidth = 2/scale;
        
        CALayer *_topLeft = [CALayer layer];
        _topLeft.frame = CGRectMake(-2/scale, -2/scale, 6/scale, 6/scale);
        _topLeft.backgroundColor = self.layer.borderColor;
        [self.layer addSublayer:_topLeft];
        
        CALayer *_topRight = [CALayer layer];
        _topRight.frame = CGRectMake((self.bounds.size.width - 4/scale), -2/scale, 6/scale, 6/scale);
        _topRight.backgroundColor = self.layer.borderColor;
        [self.layer addSublayer:_topRight];
        
        CALayer *_bottomLeft = [CALayer layer];
        _bottomLeft.frame = CGRectMake(-2/scale, (self.bounds.size.height - 4/scale), 6/scale, 6/scale);
        _bottomLeft.backgroundColor = self.layer.borderColor;
        [self.layer addSublayer:_bottomLeft];
        
        CALayer *_bottomRight = [CALayer layer];
        _bottomRight.frame = CGRectMake((self.bounds.size.width - 4/scale), (self.bounds.size.height - 4/scale), 6/scale, 6/scale);
        _bottomRight.backgroundColor = self.layer.borderColor;
        [self.layer addSublayer:_bottomRight];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
