//
//  LSKeyboardHelperView.m
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/10/18.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import "LSKeyboardHelperView.h"

@interface LSKeyboardHelperView ()

@property (nonatomic, strong) UIButton *downButton;
@property (nonatomic, strong) UIView *sepratorLine;
@property (nonatomic, strong) UIView *bottomSepratorLine;
@property (nonatomic,copy) void (^DismissEvent)(void);


@end

@implementation LSKeyboardHelperView

static CGFloat const kButtonW = 40.f;

+ (instancetype)createHelerViewWithFrame:(CGRect)frame
                         keyboardDismiss:(void(^)(void))dismiss {
    LSKeyboardHelperView *helerView = [[LSKeyboardHelperView alloc] initWithFrame:frame];
    helerView.DismissEvent = dismiss;
    return helerView;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _downButton = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *image = LSImage(@"wx_Back_icon_normal");
        [_downButton setBackgroundImage:image forState:UIControlStateNormal];
        [_downButton setBackgroundImage:image forState:UIControlStateSelected];
        [_downButton setBackgroundImage:image forState:UIControlStateHighlighted];
        _downButton.transform = [self rotateTransform];
        CGFloat w = CGRectGetWidth(frame);
        CGFloat h = CGRectGetHeight(frame);
        _downButton.frame = CGRectMake((w - kButtonW)/2.0, ( h - kButtonW )/2.0, kButtonW, kButtonW);
        [_downButton addTarget:self action:@selector(downEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_downButton];
        
        _sepratorLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, w, 1.f)];
        [_sepratorLine setBackgroundColor:LSColorWithHex(0xF4F4F4)];
        [self addSubview:_sepratorLine];
        
        _bottomSepratorLine = [[UIView alloc] initWithFrame:CGRectMake(0, h - 1, w, 1.f)];
        [_bottomSepratorLine setBackgroundColor:LSColorWithHex(0xF4F4F4)];
        [self addSubview:_bottomSepratorLine];
    }
    return self;
}

- (CGAffineTransform)rotateTransform {
    CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI_2 + M_PI);
    return transform;
}

- (void)downEvent:(UIButton *)sender {
    !self.DismissEvent ? : self.DismissEvent();
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
