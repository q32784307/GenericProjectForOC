//
//  EmojiKeyboardTwoTableViewCell.m
//  GenericProject
//
//  Created by 社科赛斯 on 2020/5/26.
//  Copyright © 2020 漠然丶情到深处. All rights reserved.
//

#import "EmojiKeyboardTwoTableViewCell.h"

@implementation EmojiKeyboardTwoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createSubviews];
    }
    return self;
}

- (void)createSubviews {
    self.contentLabel = [[UILabel alloc]init];
    self.contentLabel.font = LSSystemFont(LSSYRealValue(28 / 2));
    [self.contentView addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.contentView).with.offset(LSSYRealValue(30 / 2));
    }];
    
    self.contentImageView = [[YBEmojiGifImageView alloc]init];
    [self.contentView addSubview:self.contentImageView];
    [self.contentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.contentView).with.offset(LSSYRealValue(30 / 2));
        make.size.mas_equalTo(CGSizeMake(LSSYRealValue(100 / 2), LSSYRealValue(100 / 2)));
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
