//
//  RootTableViewCell.m
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2018/9/20.
//  Copyright © 2018年 漠然丶情到深处. All rights reserved.
//

#import "RootTableViewCell.h"
#import "RootModel.h"

@interface RootTableViewCell ()

@end

@implementation RootTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *identifier = @"RootTableViewCell";
    
    RootTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[RootTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initView];
    }
    return self;
}
- (void)initView{
    
    
    // 剪头 展示下一级数据
    _imageUpView = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth - 30, 12.5, 15, 15)];
    _imageUpView.image = [UIImage imageNamed:@""];
    //    _imageUpView.backgroundColor = [UIColor redColor];
    //剪头 展示下一级数据 的 ges
    UIButton *showNextLevelBgItem = [UIButton buttonWithType:UIButtonTypeCustom];
    showNextLevelBgItem.backgroundColor = [UIColor clearColor];
    showNextLevelBgItem.frame = CGRectMake(ScreenWidth - 40, 0, 40, 40);
    [showNextLevelBgItem addTarget:self action:@selector(showNextLevelDataEvent) forControlEvents:(UIControlEventTouchUpInside)];
    showNextLevelBgItem.userInteractionEnabled = YES;
    
    
    
    //选中当前数据
    _imageSelectView = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth - 60, 12, 16, 16)];
    _imageSelectView.image = [UIImage imageNamed:@""];
    _imageSelectView.hidden = YES;
    
    _imageUpView.userInteractionEnabled = YES;
    _imageSelectView.userInteractionEnabled = YES;
    
    _label = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, self.frame.size.width - 40, 40)];
    _label.backgroundColor = [UIColor colorWithRed:204.0/255 green:238.0/255 blue:208.0/255 alpha:0.0];
    
    [self addSubview:_label];
    [self addSubview:_imageUpView];
    [self addSubview:_imageSelectView];
    [self addSubview:showNextLevelBgItem];
    
    
    
    
    
}
#pragma mark-剪头 展示下一级数据
- (void)showNextLevelDataEvent{
    NSLog(@"剪头 展示下一级数据 的 ges");
    
    if ([self.delegate respondsToSelector:@selector(showCell:)]) {
        [self.delegate showCell:self];
    }
}

- (void)levelNameString:(NSString *)levelNameString levelString:(NSString *)levelString isSelect:(BOOL)isSelect{
    
    _label.text = levelNameString;
    
    if (isSelect) {
        _imageSelectView.hidden = NO;
    }else{
        _imageSelectView.hidden = YES;
    }
    
    if ([levelString intValue] == 2) {
        
        CGRect leftLabelFrame = _label.frame;
        leftLabelFrame.origin.x = 45;
        _label.frame = leftLabelFrame;
        
        _imageUpView.hidden = YES;
    }else if([levelString intValue] == 1){
        
        CGRect leftLabelFrame = _label.frame;
        leftLabelFrame.origin.x = 30;
        _label.frame = leftLabelFrame;
        
        _imageUpView.hidden = NO;
    }else{
        
        CGRect leftLabelFrame = _label.frame;
        leftLabelFrame.origin.x = 15;
        _label.frame = leftLabelFrame;
        
        _imageUpView.hidden = NO;
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
