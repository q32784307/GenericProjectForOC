//
//  AnimatedTableViewCell.m
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/4/26.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import "AnimatedTableViewCell.h"
#import "UIView+TABAnimated.h"
#import "Game.h"

@interface AnimatedTableViewCell ()

@property (nonatomic,strong) UIImageView *gameImg;
@property (nonatomic,strong) UILabel *titleLab;
@property (nonatomic,strong) UILabel *timeLab;
@property (nonatomic,strong) UIButton *statusBtn;

@end

@implementation AnimatedTableViewCell

+ (NSNumber *)cellHeight {
    return [NSNumber numberWithFloat:100.0];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    //布局
    self.gameImg.frame = CGRectMake(15, 10, (self.frame.size.height-20)*1.5, (self.frame.size.height-20));
    self.gameImg.layer.cornerRadius = 5;
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.gameImg.mas_right).mas_offset(15);
        make.top.mas_offset(10);
        make.right.mas_equalTo(self).mas_offset(-20);
        make.height.mas_offset(20);
    }];
    
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLab);
        make.top.mas_equalTo(self.titleLab.mas_bottom).mas_offset(5);
        make.right.mas_equalTo(self).mas_offset(-40);
        make.height.mas_offset(15);
    }];
    
    [self.statusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.gameImg.mas_right).mas_offset(15);
        make.top.mas_equalTo(self.timeLab.mas_bottom).mas_offset(10);
        make.width.mas_offset(70);
        make.height.mas_offset(20);
    }];
    self.statusBtn.layer.cornerRadius = 5;
}

#pragma mark - Public Methods

- (void)initWithData:(Game *)game {
    
    self.titleLab.text = [NSString stringWithFormat:@"赛事标题赛事标题%@～",game.gameId];
    self.timeLab.text = @"报名时间：2018-09-12";
    [self.gameImg setImage:[UIImage imageNamed:@"test.jpg"]];
    
    [self.statusBtn setTitle:@"已结束" forState:UIControlStateNormal];
    [self.statusBtn setBackgroundColor:[UIColor grayColor]];
}

#pragma mark - Initize Methods

- (void)initUI {
    
    {
        UIImageView *iv = [[UIImageView alloc] init];
        iv.contentMode = UIViewContentModeScaleAspectFill;
        iv.layer.masksToBounds = YES;
        iv.layer.borderWidth = 1.0f;
        iv.layer.borderColor = UIColor.redColor.CGColor;
        
        self.gameImg = iv;
        [self addSubview:iv];
    }
    
    {
        UILabel *lab = [[UILabel alloc]init];
        [lab setFont:kFont(15)];
        [lab setTextColor:[UIColor blackColor]];
        [lab setText:@"测试测试测试"];
        
        self.titleLab = lab;
        [self addSubview:lab];
    }
    
    {
        UILabel *lab = [[UILabel alloc]init];
        [lab setFont:kFont(12)];
        [lab setText:@"测试测试测试"];
        
        self.timeLab = lab;
        [self addSubview:lab];
    }
    
    {
        UIButton *btn = [[UIButton alloc]init];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn.titleLabel setFont:kFont(12)];
        btn.layer.borderWidth = 1.0f;
        btn.layer.borderColor = UIColor.redColor.CGColor;
        [btn setTitle:@"测试测试测试" forState:UIControlStateNormal];
        
        self.statusBtn = btn;
        [self addSubview:btn];
    }
}

@end
