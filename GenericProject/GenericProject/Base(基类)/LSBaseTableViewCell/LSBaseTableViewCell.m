//
//  LSBaseTableViewCell.m
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/5/7.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import "LSBaseTableViewCell.h"

@implementation LSBaseTableViewCell

- (void)setFrame:(CGRect)frame {
    frame.size.height -= 1;
    [super setFrame:frame];
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
