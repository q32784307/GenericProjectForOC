//
//  LSTreeTableViewCell.m
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/12/5.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import "LSTreeTableViewCell.h"
#import "LSTreeItem.h"

@interface LSTreeTableViewCell ()

@property(nonatomic,strong)LSTreeItem *treeItem;
@property(nonatomic,strong)UIButton *checkButton;

@end

@implementation LSTreeTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView andTreeItem:(LSTreeItem *)item {
    static NSString *ID = @"LSTreeTableViewCell";
    LSTreeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[LSTreeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.treeItem = item;
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.textLabel.font   = [UIFont systemFontOfSize:14];
        self.indentationWidth = 15;
        self.selectionStyle   = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat minX = 15 + self.indentationLevel * self.indentationWidth;
    
    if (!self.treeItem.isLeaf) {
        CGRect imageViewFrame = self.imageView.frame;
        imageViewFrame.origin.x = minX;
        self.imageView.frame = imageViewFrame;
    }
    
    CGRect textLabelFrame = self.textLabel.frame;
    textLabelFrame.origin.x = minX + (self.treeItem.isLeaf ? 0 : (self.imageView.bounds.size.width + 2));
    self.textLabel.frame = textLabelFrame;
}

#pragma mark - Setter
- (void)setTreeItem:(LSTreeItem *)treeItem {
    _treeItem = treeItem;
    
    self.indentationLevel = treeItem.level;
    self.textLabel.text   = treeItem.name;
    self.imageView.image  = treeItem.isLeaf ? nil : [UIImage imageNamed:@"LSTreeTableView.bundle/arrow"];
    self.accessoryView    = self.checkButton;
   
    [self refreshArrow];
    [self.checkButton setImage:[self getCheckImage] forState:UIControlStateNormal];
}

- (void)setIsShowArrow:(BOOL)isShowArrow {
    _isShowArrow = isShowArrow;
    
    if (!isShowArrow && self.imageView.image) {
        self.imageView.image = nil;
    }
}

- (void)setIsShowCheck:(BOOL)isShowCheck {
    _isShowCheck = isShowCheck;
    
    if (!isShowCheck && self.accessoryView) {
        self.accessoryView = nil;
    }
}

#pragma mark - Public Method
- (void)updateItem {
    // 刷新 title 前面的箭头方向
    [UIView animateWithDuration:0.25 animations:^{
        [self refreshArrow];
    }];
}

#pragma mark - Lazy Load
- (UIButton *)checkButton {
    if (!_checkButton) {
        UIButton *checkButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [checkButton addTarget:self action:@selector(checkButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [checkButton setImage:[self getCheckImage] forState:UIControlStateNormal];
        checkButton.adjustsImageWhenHighlighted = NO;
        checkButton.frame = CGRectMake(0, 0, self.contentView.bounds.size.height, self.contentView.bounds.size.height);
        CGFloat aEdgeInset = (checkButton.frame.size.height - checkButton.imageView.image.size.height) / 2;
        checkButton.contentEdgeInsets = UIEdgeInsetsMake(aEdgeInset, aEdgeInset, aEdgeInset, aEdgeInset);
        
        _checkButton = checkButton;
    }
    return _checkButton;
}

#pragma mark - Private Method
- (void)refreshArrow {
    if (self.treeItem.isExpand) {
        self.imageView.transform = CGAffineTransformMakeRotation(M_PI_2);
    } else {
        self.imageView.transform = CGAffineTransformMakeRotation(0);
    }
}

- (void)checkButtonClick:(UIButton *)sender {
    if (self.checkButtonClickBlock) {
        self.checkButtonClickBlock(self.treeItem);
    }
}

- (UIImage *)getCheckImage {
    switch (self.treeItem.checkState) {
        case LSTreeItemDefault:
            return [UIImage imageNamed:@"LSTreeTableView.bundle/checkbox-uncheck"];
            break;
        case LSTreeItemChecked:
            return [UIImage imageNamed:@"LSTreeTableView.bundle/checkbox-checked"];
            break;
        case LSTreeItemHalfChecked:
            return [UIImage imageNamed:@"LSTreeTableView.bundle/checkbox-partial"];
            break;
        default:
            return nil;
            break;
    }
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
