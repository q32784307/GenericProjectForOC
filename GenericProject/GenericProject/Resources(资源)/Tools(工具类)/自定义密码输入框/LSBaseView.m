//
//  LSBaseView.m
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/10/18.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import "LSBaseView.h"

@implementation LSBaseView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self ls_addSubviews];
    [self ls_addConstraints];
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self ls_addSubviews];
        [self ls_addConstraints];
    }
    return self;
}

- (void)ls_addSubviews {
    
}

- (void)ls_addConstraints {
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
