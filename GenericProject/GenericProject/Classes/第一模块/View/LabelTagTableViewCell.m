//
//  LabelTagTableViewCell.m
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2020/2/1.
//  Copyright © 2020 漠然丶情到深处. All rights reserved.
//

#import "LabelTagTableViewCell.h"

@implementation LabelTagTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createSubViews];
    }
    return self;
}

- (void)createSubViews {
    self.testTapLabel = [[UILabel alloc]init];
    self.testTapLabel.numberOfLines = 0;
    [self.contentView addSubview:self.testTapLabel];
    [self.testTapLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).with.offset(0);
        make.left.equalTo(self.contentView).with.offset(0);
        make.right.equalTo(self.contentView.mas_right).with.offset(0);
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(0);
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
