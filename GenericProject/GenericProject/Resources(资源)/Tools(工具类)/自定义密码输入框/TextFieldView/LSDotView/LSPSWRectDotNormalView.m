//
//  LSPSWRectDotNormalView.m
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/10/18.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import "LSPSWRectDotNormalView.h"

@implementation LSPSWRectDotNormalView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self p_initUIWithFrame:frame];
    }
    return self;
}

- (void)p_initUIWithFrame:(CGRect)frame {
    [self.dotView setHidden:true];
    [self.bottomLineView setHidden:true];
    
    self.verticalLineView.frame = CGRectMake(frame.size.width - 1, 0, 1.f, frame.size.height);
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.centerY.mas_equalTo(0);
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
