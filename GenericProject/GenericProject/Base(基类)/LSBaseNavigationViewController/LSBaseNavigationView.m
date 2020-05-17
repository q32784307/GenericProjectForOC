//
//  LSBaseNavigationView.m
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2018/6/29.
//  Copyright © 2018年 漠然丶情到深处. All rights reserved.
//

#import "LSBaseNavigationView.h"

@interface LSBaseNavigationView ()

@property(nonatomic,strong)UIView *navView;
@property(nonatomic,strong)UILabel *titleLabel;

@end

@implementation LSBaseNavigationView

- (instancetype)initWithFrame:(CGRect)frame {
    CGRect selfFrame = frame;
    selfFrame.size.height = NAVIGATION_BAR_HEIGHT;
    if (self = [super initWithFrame:selfFrame]) {
        [self setNavigationViewAction];
    }
    return self;
}

- (void)setNavigationViewAction {
    //导航栏
    self.navView = [[UIView alloc]initWithFrame:self.bounds];
    self.navView.userInteractionEnabled = YES;
    //是否显示
    if (!self.isShowNavigation) {
        self.navView.hidden = NO;
    }else{
        self.navView.hidden = YES;
    }
    //颜色
    if(!self.navColor) {
        self.navView.backgroundColor = MainColor;
    }else{
        self.navView.backgroundColor = self.navColor;
    }
    //背景图片
    if (!self.navBackgroundViewImage) {
        self.navView.layer.contents = (id) [UIImage imageNamed:@""].CGImage;
    }else{
        self.navView.layer.contents = (id) [UIImage imageNamed:self.navBackgroundViewImage].CGImage;
    }
    [self addSubview:self.navView];
    
    
    //左按钮
    self.leftButton = [[UIButton alloc]init];
    //图片
    if (!self.leftButtonImage) {
        [self.leftButton setImage:[UIImage imageNamed:@"back_white"] forState:UIControlStateNormal];
    }else{
        [self.leftButton setImage:[UIImage imageNamed:self.leftButtonImage] forState:UIControlStateNormal];
    }
    self.leftButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    //文字
    if (!self.leftButtonTitle) {
        [self.leftButton setTitle:@"返回" forState:UIControlStateNormal];
    }else{
        [self.leftButton setTitle:self.leftButtonTitle forState:UIControlStateNormal];
    }
    self.leftButton.titleLabel.font = [UIFont systemFontOfSize:SYRealValue(28 / 2)];
    //颜色
    if (!self.leftButtonTitleColor) {
        [self.leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }else{
        [self.leftButton setTitleColor:self.leftButtonTitleColor forState:UIControlStateNormal];
    }
    [self.leftButton addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    //是否显示
    if (!self.isShowLeftButton) {
        self.leftButton.hidden = NO;
    }else{
        self.leftButton.hidden = YES;
    }
    [self.navView addSubview:self.leftButton];
    [self.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navView).with.offset(STATUS_BAR_HEIGHT + 2);
        make.left.equalTo(self.navView).with.offset(SYRealValue(20 / 2));
        make.height.mas_equalTo(40);
    }];
    
    
    //导航栏标题
    self.titleLabel = [[UILabel alloc]init];
    //文字
    if (!self.titleLabelText) {
        self.titleLabel.text = @"标题";
    }else{
        self.titleLabel.text = self.titleLabelText;
    }
    //颜色
    if (!self.titleLabelTextColor) {
        self.titleLabel.textColor = [UIColor whiteColor];
    }else{
        self.titleLabel.textColor = self.titleLabelTextColor;
    }
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont boldSystemFontOfSize:SYRealValue(SYRealValue(32 / 2))];
    [self.navView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navView).with.offset(STATUS_BAR_HEIGHT + 2);
        make.centerX.equalTo(self.navView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(SYRealValue(300 / 2), 40));
    }];
    
    
    //右按钮
    self.rightButton = [[UIButton alloc]init];
    //图片
    if (!self.rightButtonImage) {
        [self.rightButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    }else{
        [self.rightButton setImage:[UIImage imageNamed:self.rightButtonImage] forState:UIControlStateNormal];
    }
    self.rightButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    //文字
    if (!self.rightButtonTitle) {
        [self.rightButton setTitle:@"完成" forState:UIControlStateNormal];
    }else{
        [self.rightButton setTitle:self.rightButtonTitle forState:UIControlStateNormal];
    }
    self.rightButton.titleLabel.font = [UIFont systemFontOfSize:SYRealValue(28 / 2)];
    //颜色
    if (!self.rightButtonTitleColor) {
        [self.rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }else{
        [self.rightButton setTitleColor:self.rightButtonTitleColor forState:UIControlStateNormal];
    }
    self.rightButton.titleLabel.textAlignment = NSTextAlignmentRight;
    [self.rightButton addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    //是否显示
    if (!self.isShowRightButton) {
        self.rightButton.hidden = NO;
    }else{
        self.rightButton.hidden = YES;
    }
    [self.navView addSubview:self.rightButton];
    [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navView).with.offset(STATUS_BAR_HEIGHT + 2);
        make.right.equalTo(self.navView.mas_right).with.offset(SYRealValue(-20 / 2));
        make.height.mas_equalTo(40);
    }];
    
    //分割线
    self.navViewLine = [[UIView alloc]init];
    self.navViewLine.backgroundColor = [UIColor colorWithHexString:@"F2F2F7"];
    if (!self.isShowNavViewLine) {
        self.navViewLine.hidden = NO;
    }else{
        self.navViewLine.hidden = YES;
    }
    [self.navView addSubview:self.navViewLine];
    [self.navViewLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.navView.mas_bottom).with.offset(0);
        make.left.equalTo(self.navView).with.offset(0);
        make.right.equalTo(self.navView.mas_right).with.offset(0);
        make.height.mas_equalTo(1);
    }];
}

- (void)leftAction {
    if (self.LeftActionBlock) {
        self.LeftActionBlock();
    }
}

- (void)rightAction {
    if (self.RightActionBlock) {
        self.RightActionBlock();
    }
}

#pragma mark - 是否显示导航栏
- (void)setIsShowNavigation:(BOOL)isShowNavigation {
    _isShowNavigation = isShowNavigation;
    if (isShowNavigation) {
        self.navView.hidden = NO;
    }else{
        self.navView.hidden = YES;
    }
}

#pragma mark - 导航栏颜色
- (void)setNavColor:(UIColor *)navColor {
    _navColor = navColor;
    self.navView.backgroundColor = _navColor;
}

#pragma mark - 导航栏背景图
- (void)setNavBackgroundViewImage:(NSString *)navBackgroundViewImage {
    _navBackgroundViewImage = navBackgroundViewImage;
    self.navView.layer.contents = (id) [UIImage imageNamed:_navBackgroundViewImage].CGImage;
}

#pragma mark - 左按钮图片
- (void)setLeftButtonImage:(NSString *)leftButtonImage {
    _leftButtonImage = leftButtonImage;
    [self.leftButton setImage:[UIImage imageNamed:_leftButtonImage] forState:UIControlStateNormal];
}

#pragma mark - 左按钮文字
- (void)setLeftButtonTitle:(NSString *)leftButtonTitle {
    _leftButtonTitle = leftButtonTitle;
    [self.leftButton setTitle:_leftButtonTitle forState:UIControlStateNormal];
}

#pragma mark - 左按钮文字颜色
- (void)setLeftButtonTitleColor:(UIColor *)leftButtonTitleColor {
    _leftButtonTitleColor = leftButtonTitleColor;
    [self.leftButton setTitleColor:_leftButtonTitleColor forState:UIControlStateNormal];
}

#pragma mark - 是否显示左按钮
- (void)setIsShowLeftButton:(BOOL)isShowLeftButton {
    _isShowLeftButton = isShowLeftButton;
    if (isShowLeftButton) {
        self.leftButton.hidden = NO;
    }else{
        self.leftButton.hidden = YES;
    }
}

#pragma mark - 标题文字
- (void)setTitleLabelText:(NSString *)titleLabelText {
    _titleLabelText = titleLabelText;
    self.titleLabel.text = _titleLabelText;
}

#pragma mark - 标题文字颜色
- (void)setTitleLabelTextColor:(UIColor *)titleLabelTextColor {
    _titleLabelTextColor = titleLabelTextColor;
    self.titleLabel.textColor = _titleLabelTextColor;
}

#pragma mark - 右按钮图片
- (void)setRightButtonImage:(NSString *)rightButtonImage {
    _rightButtonImage = rightButtonImage;
    [self.rightButton setImage:[UIImage imageNamed:_rightButtonImage] forState:UIControlStateNormal];
}

#pragma mark - 右按钮文字
- (void)setRightButtonTitle:(NSString *)rightButtonTitle {
    _rightButtonTitle = rightButtonTitle;
    [self.rightButton setTitle:_rightButtonTitle forState:UIControlStateNormal];
}

#pragma mark - 右按钮文字颜色
- (void)setRightButtonTitleColor:(UIColor *)rightButtonTitleColor {
    _rightButtonTitleColor = rightButtonTitleColor;
    [self.rightButton setTitleColor:_rightButtonTitleColor forState:UIControlStateNormal];
}

#pragma mark - 是否显示右按钮
- (void)setIsShowRightButton:(BOOL)isShowRightButton {
    _isShowRightButton = isShowRightButton;
    if (isShowRightButton) {
        self.rightButton.hidden = NO;
    }else{
        self.rightButton.hidden = YES;
    }
}

#pragma mark - 是否显示导航栏分割线
- (void)setIsShowNavViewLine:(BOOL)isShowNavViewLine {
    _isShowNavViewLine = isShowNavViewLine;
    if (isShowNavViewLine) {
        self.navViewLine.hidden = NO;
    }else{
        self.navViewLine.hidden = YES;
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
