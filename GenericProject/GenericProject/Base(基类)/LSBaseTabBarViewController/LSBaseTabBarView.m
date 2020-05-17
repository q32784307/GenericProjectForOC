//
//  LSBaseTabBarView.m
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2018/6/12.
//  Copyright © 2018年 漠然丶情到深处. All rights reserved.
//

#import "LSBaseTabBarView.h"

@interface LSBaseTabBarView ()

@property(nonatomic,strong)UIButton *MoreButton;

@property(nonatomic,assign)UIEdgeInsets oldSafeAreaInsets;

@end

@implementation LSBaseTabBarView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setShadowImage:[UIImage imageWithColor:[UIColor clearColor]]];
        
        self.MoreButton = [[UIButton alloc] init];
        [self.MoreButton setBackgroundImage:[UIImage imageNamed:@"plus"] forState:UIControlStateNormal];
        [self.MoreButton addTarget:self action:@selector(MoreAction) forControlEvents:UIControlEventTouchUpInside];
        self.MoreButton.size = self.MoreButton.currentBackgroundImage.size;
        [self addSubview:self.MoreButton];
    }
    return self;
}

- (void)safeAreaInsetsDidChange {
    [super safeAreaInsetsDidChange];
    if(self.oldSafeAreaInsets.left != self.safeAreaInsets.left || self.oldSafeAreaInsets.right != self.safeAreaInsets.right || self.oldSafeAreaInsets.top != self.safeAreaInsets.top || self.oldSafeAreaInsets.bottom != self.safeAreaInsets.bottom) {
        self.oldSafeAreaInsets = self.safeAreaInsets;
        [self invalidateIntrinsicContentSize];
        [self.superview setNeedsLayout];
        [self.superview layoutSubviews];
    }
}

- (CGSize)sizeThatFits:(CGSize)size {
    size = [super sizeThatFits:size];
    
    if (@available(iOS 11.0, *)) {
        CGFloat bottomInset = self.safeAreaInsets.bottom;
        if(bottomInset > 0 && size.height < 50) {
            size.height += bottomInset;
        }
    }
    
    return size;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    self.MoreButton.center = CGPointMake(self.width * 0.5, self.height * 0.1);
    int index = 0;
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            view.width = self.width / 5;
            view.x = view.width * index;
            index++;
            if (index == 2) {
                index++;
            }
        }
    }
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (self.isHidden == NO) {
        CGPoint newPoint = [self convertPoint:point toView:self.MoreButton];
        if ([self.MoreButton pointInside:newPoint withEvent:event]) {
            return self.MoreButton;
        }else{
            return [super hitTest:point withEvent:event];
        }
    }else{
        return [super hitTest:point withEvent:event];
    }
}

//点击了发布按钮
- (void)MoreAction {
    //如果tabbar的代理实现了对应的代理方法，那么就调用代理的该方法
    if ([self.delegate respondsToSelector:@selector(tabBarMoreButtonAction:)]) {
        [self.BarButtonDelegate tabBarMoreButtonAction:self];
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
