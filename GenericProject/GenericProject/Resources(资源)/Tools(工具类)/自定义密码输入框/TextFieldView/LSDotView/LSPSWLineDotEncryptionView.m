//
//  LSPSWLineDotEncryptionView.m
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/10/18.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import "LSPSWLineDotEncryptionView.h"

@implementation LSPSWLineDotEncryptionView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self p_initUIWithFrame:frame];
    }
    return self;
}

- (void)p_initUIWithFrame:(CGRect)frame {
    [self.verticalLineView setHidden:true];
    [self.titleLab setHidden:true];
    
    self.bottomLineView.frame = CGRectMake(self.kLineLeftGap, frame.size.height - 5.f, frame.size.width - 2 * self.kLineLeftGap, 1.f);
    
    [self.dotView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.centerY.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(self.dotViewRaduis * 2, self.dotViewRaduis * 2));
    }];
}

- (void)ls_addSubviews {
    [super ls_addSubviews];
    [self.titleLab setHidden:true];
    [self.verticalLineView setHidden:true];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
