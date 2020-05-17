//
//  LSTreeCustomTableViewCell.m
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/12/6.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import "LSTreeCustomTableViewCell.h"

@implementation LSTreeCustomTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier parentModel:(LSTreeViewParam *)parentModel{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.parentModel = parentModel;
        [self UI];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat offset = 10;
    CGFloat width = self.contentView.frame.size.width;
    CGFloat height = self.contentView.frame.size.height;
    
    CGRect rect = CGRectMake(self.model.depath <= 1 ? offset:(offset * self.parentModel.lsIndent * (self.model.depath - 1)), (height - 18) / 2, 18, 18);
    if (self.parentModel.lsDraggable) {
        rect.origin.x-=38;
       self.icon.frame = rect;
    }else{
       self.icon.frame = rect;
    }
    self.la.frame = CGRectMake(CGRectGetMaxX(self.icon.frame),offset , width - CGRectGetMaxX(self.icon.frame) - offset * 2, height - offset * 2);
    CGFloat iconHeight = 17;
    self.check.frame = CGRectMake(width - iconHeight - offset, (height - iconHeight) / 2, iconHeight, iconHeight);
}

- (void)UI {
    self.icon.userInteractionEnabled = NO;
    [self.icon setImage:[self bundleImage:self.parentModel.lsExpandIcon] forState:UIControlStateNormal];
    [self.icon setImage:[self bundleImage:self.parentModel.lsSelectExpandIcon] forState:UIControlStateSelected];
    [self.contentView addSubview:self.icon];
    
    [self.check setImage:[self bundleImage:self.parentModel.lsCheckIcon] forState:UIControlStateNormal];
    if (!self.parentModel.lsCheckStrictly) {
        [self.check setImage:[self bundleImage:self.parentModel.lsSelectCheckIcon] forState:UIControlStateSelected];
    }
    [self.check addTarget:self action:@selector(checkAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.check];
    
    self.la.textColor = self.parentModel.lsNodeTextColor;
    self.la.font = [UIFont systemFontOfSize:self.parentModel.lsNodeTextFont];
    [self.contentView addSubview:self.la];

}

- (void)setModel:(LSTreeParam *)model {
    _model = model;
    self.la.text = model.name;
    self.check.selected = model.isSelected;
    self.icon.hidden = !model.children.count;
    
    if (self.parentModel.lsHighlightCurrent && model.canSelect && self.parentModel.lsShowCheckbox) {
        if (self.model.isSelected||self.model.halfSelect) {
            self.la.textColor = self.parentModel.lsHighlightCurrent;
        }else{
            self.la.textColor = self.parentModel.lsNodeTextColor;
        }
    }
    if (self.parentModel.lsShowCheckbox) {
        self.check.hidden = !model.canSelect;
    }else{
        self.check.hidden = YES;
    }
    if (!self.icon.hidden) {
        self.icon.selected = model.isExpand;
    }
    
    
    if (self.model.halfSelect) {
        [self.check setImage:[self bundleImage:self.parentModel.lsHalfSelectCheckIcon] forState:UIControlStateNormal];
        [self.check setImage:[self bundleImage:self.parentModel.lsSelectCheckIcon] forState:UIControlStateSelected];
    }else{
        [self.check setImage:[self bundleImage:self.parentModel.lsCheckIcon] forState:UIControlStateNormal];
        [self.check setImage:[self bundleImage:self.parentModel.lsSelectCheckIcon] forState:UIControlStateSelected];
    }

}

- (void)checkAction:(UIButton *)btn {
    
    self.model.isSelected = !self.model.isSelected;
    if (self.delagete && [self.delagete respondsToSelector:@selector(selectNode:checkStrictly:)]) {
        [self.delagete selectNode:self.model checkStrictly:self.parentModel.lsCheckStrictly];
    }
    
    if (self.model.isSelected) {
        self.model.halfSelect = NO;
    }
    
    if (self.model.halfSelect) {
        [self.check setImage:[self bundleImage:self.parentModel.lsHalfSelectCheckIcon] forState:UIControlStateNormal];
        [self.check setImage:[self bundleImage:self.parentModel.lsSelectCheckIcon] forState:UIControlStateSelected];
    }else{
        [self.check setImage:[self bundleImage:self.parentModel.lsCheckIcon] forState:UIControlStateNormal];
        [self.check setImage:[self bundleImage:self.parentModel.lsSelectCheckIcon] forState:UIControlStateSelected];
    }
    btn.selected = ![btn isSelected];
}

- (UIImage *)bundleImage:(NSString *)name {
    NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle bundleForClass:[LSTreeCustomTableViewCell class]] pathForResource:@"LSTreeView" ofType:@"bundle"]];
    NSString *path = [bundle pathForResource:name ofType:@"png"];
    
    if (!path) {
        return [UIImage imageNamed:name];
    }else{
        return [UIImage imageWithContentsOfFile:path];
    }
}

- (UIButton *)icon {
    if (!_icon) {
        _icon = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _icon;
}

- (UILabel *)la {
    if (!_la) {
        _la = [UILabel new];
    }
    return _la;
}

- (UIButton *)check {
    if (!_check) {
        _check = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _check;
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
