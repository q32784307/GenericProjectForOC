//
//  CheckVerifyCodeCell.m
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/4/17.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import "CheckVerifyCodeCell.h"

@interface CheckVerifyCodeCell ()

@property(nonatomic,strong)UILabel *codeLabel;

@end

@implementation CheckVerifyCodeCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.codeLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.codeLabel];
        self.codeLabel.textAlignment = NSTextAlignmentCenter;
        self.codeLabel.font = [UIFont boldSystemFontOfSize:25];
        self.codeLabel.textColor = [UIColor colorWithRed:0.67 green:0.67 blue:0.67 alpha:1.00];
        [self.codeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.contentView);
        }];
        
        UIView *lineView = [[UIView alloc] init];
        [self.contentView addSubview:lineView];
        lineView.backgroundColor = [UIColor colorWithRed:0.67 green:0.67 blue:0.67 alpha:1.00];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_offset(0);
            make.height.mas_equalTo(1);
        }];
    }
    return self;
}

- (void)setCode:(NSString *)code {
    _code = code;
    self.codeLabel.text = code;
}

@end
