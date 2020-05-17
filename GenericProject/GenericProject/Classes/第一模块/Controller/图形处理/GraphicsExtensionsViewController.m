//
//  GraphicsExtensionsViewController.m
//  GenericProject
//
//  Created by 社科赛斯 on 2019/12/17.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import "GraphicsExtensionsViewController.h"

@interface GraphicsExtensionsViewController ()

@end

@implementation GraphicsExtensionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth, ScreenHeight - NAVIGATION_BAR_HEIGHT - HOME_INDICATOR_HEIGHT)];
    scroll.backgroundColor = GrayColor;
    scroll.alpha = 0.9;
    [self.view addSubview:scroll];
    
    UIImageView *headerImageView = [[UIImageView alloc]init];
    headerImageView.image = ImageNamed(@"图形效果");
    headerImageView.circle = YES;
    headerImageView.borderColor = WhiteColor;
    headerImageView.borderWidth = SYRealValue(8 / 2);
    headerImageView.shadowColor = [UIColor yellowColor];
    headerImageView.shadowRadius = SYRealValue(40 / 2);
    headerImageView.shadowOpacity = SYRealValue(2 / 2);
    headerImageView.shadowOffset = CGSizeMake(0, SYRealValue(8 / 2));
    [scroll addSubview:headerImageView];
    [headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(scroll).with.offset(SYRealValue(100 / 2));
        make.left.equalTo(scroll).with.offset(SYRealValue(50 / 2));
        make.size.mas_equalTo(CGSizeMake(SYRealValue(200 / 2), SYRealValue(200 / 2)));
    }];
    
    UIView *view1 = [[UIView alloc]init];
    view1.backgroundColor = BlackColor;
    view1.roundTop = YES;
    view1.cornerRadius = SYRealValue(40 / 2);
    [scroll addSubview:view1];
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerImageView.mas_bottom).with.offset(SYRealValue(50 / 2));
        make.left.equalTo(scroll).with.offset(SYRealValue(50 / 2));
        make.size.mas_equalTo(CGSizeMake(SYRealValue(140 / 2), SYRealValue(140 / 2)));
    }];
    
    UIView *view2 = [[UIView alloc]init];
    view2.backgroundColor = BlackColor;
    view2.roundBottom = YES;
    view2.cornerRadius = SYRealValue(40 / 2);
    [scroll addSubview:view2];
    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerImageView.mas_bottom).with.offset(SYRealValue(50 / 2));
        make.left.equalTo(view1.mas_right).with.offset(SYRealValue(40 / 2));
        make.size.mas_equalTo(CGSizeMake(SYRealValue(140 / 2), SYRealValue(140 / 2)));
    }];
    
    UIView *view3 = [[UIView alloc]init];
    view3.backgroundColor = BlackColor;
    view3.roundLeft = YES;
    view3.cornerRadius = SYRealValue(40 / 2);
    [scroll addSubview:view3];
    [view3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerImageView.mas_bottom).with.offset(SYRealValue(50 / 2));
        make.left.equalTo(view2.mas_right).with.offset(SYRealValue(40 / 2));
        make.size.mas_equalTo(CGSizeMake(SYRealValue(140 / 2), SYRealValue(140 / 2)));
    }];
    
    UIView *view4 = [[UIView alloc]init];
    view4.backgroundColor = BlackColor;
    view4.roundRight = YES;
    view4.cornerRadius = SYRealValue(40 / 2);
    [scroll addSubview:view4];
    [view4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerImageView.mas_bottom).with.offset(SYRealValue(50 / 2));
        make.left.equalTo(view3.mas_right).with.offset(SYRealValue(40 / 2));
        make.size.mas_equalTo(CGSizeMake(SYRealValue(140 / 2), SYRealValue(140 / 2)));
    }];
    
    UIView *view5 = [[UIView alloc]init];
    view5.backgroundColor = BlackColor;
    view5.cornerRadius = SYRealValue(20 / 2);
    [scroll addSubview:view5];
    [view5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view1.mas_bottom).with.offset(SYRealValue(40 / 2));
        make.left.equalTo(scroll).with.offset(SYRealValue(50 / 2));
        make.size.mas_equalTo(CGSizeMake(SYRealValue(140 / 2), SYRealValue(140 / 2)));
    }];
    
    UIView *view6 = [[UIView alloc]init];
    view6.backgroundColor = BlackColor;
    view6.cornerRadius = SYRealValue(40 / 2);
    [scroll addSubview:view6];
    [view6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view2.mas_bottom).with.offset(SYRealValue(40 / 2));
        make.left.equalTo(view5.mas_right).with.offset(SYRealValue(40 / 2));
        make.size.mas_equalTo(CGSizeMake(SYRealValue(140 / 2), SYRealValue(140 / 2)));
    }];
    
    UIView *view7 = [[UIView alloc]init];
    view7.backgroundColor = BlackColor;
    view7.roundTop = YES;
    view7.circle = YES;
    [scroll addSubview:view7];
    [view7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view3.mas_bottom).with.offset(SYRealValue(40 / 2));
        make.left.equalTo(view6.mas_right).with.offset(SYRealValue(40 / 2));
        make.size.mas_equalTo(CGSizeMake(SYRealValue(140 / 2), SYRealValue(140 / 2)));
    }];
    
    UIView *view8 = [[UIView alloc]init];
    view8.backgroundColor = BlackColor;
    view8.circle = YES;
    [scroll addSubview:view8];
    [view8 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view4.mas_bottom).with.offset(SYRealValue(40 / 2));
        make.left.equalTo(view7.mas_right).with.offset(SYRealValue(40 / 2));
        make.size.mas_equalTo(CGSizeMake(SYRealValue(140 / 2), SYRealValue(140 / 2)));
    }];
    
    UIView *view9 = [[UIView alloc]init];
    view9.backgroundColor = BlackColor;
    view9.cornerRadius = SYRealValue(20 / 2);
    view9.borderWidth = SYRealValue(12 / 2);
    view9.borderColor = WhiteColor;
    [scroll addSubview:view9];
    [view9 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view5.mas_bottom).with.offset(SYRealValue(40 / 2));
        make.left.equalTo(scroll).with.offset(SYRealValue(50 / 2));
        make.size.mas_equalTo(CGSizeMake(SYRealValue(140 / 2), SYRealValue(140 / 2)));
    }];
    
    UIView *view10 = [[UIView alloc]init];
    view10.backgroundColor = BlackColor;
    view10.cornerRadius = SYRealValue(40 / 2);
    view10.borderWidth = SYRealValue(12 / 2);
    view10.borderColor = WhiteColor;
    view10.shadowColor = WhiteColor;
    view10.shadowRadius = SYRealValue(20 / 2);
    [scroll addSubview:view10];
    [view10 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view6.mas_bottom).with.offset(SYRealValue(40 / 2));
        make.left.equalTo(view9.mas_right).with.offset(SYRealValue(40 / 2));
        make.size.mas_equalTo(CGSizeMake(SYRealValue(140 / 2), SYRealValue(140 / 2)));
    }];
    
    UIView *view11 = [[UIView alloc]init];
    view11.backgroundColor = BlackColor;
    view11.roundTop = YES;
    view11.borderWidth = SYRealValue(12 / 2);
    view11.borderColor = WhiteColor;
    view11.shadowColor = WhiteColor;
    view11.shadowRadius = SYRealValue(20 / 2);
    view11.circle = YES;
    [scroll addSubview:view11];
    [view11 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view7.mas_bottom).with.offset(SYRealValue(40 / 2));
        make.left.equalTo(view10.mas_right).with.offset(SYRealValue(40 / 2));
        make.size.mas_equalTo(CGSizeMake(SYRealValue(140 / 2), SYRealValue(140 / 2)));
    }];
    
    UIView *view12 = [[UIView alloc]init];
    view12.backgroundColor = BlackColor;
    view12.borderWidth = SYRealValue(12 / 2);
    view12.borderColor = WhiteColor;
    view12.shadowColor = WhiteColor;
    view12.circle = YES;
    [scroll addSubview:view12];
    [view12 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view8.mas_bottom).with.offset(SYRealValue(40 / 2));
        make.left.equalTo(view11.mas_right).with.offset(SYRealValue(40 / 2));
        make.size.mas_equalTo(CGSizeMake(SYRealValue(140 / 2), SYRealValue(140 / 2)));
    }];
    
    UIView *view13 = [[UIView alloc]init];
    view13.backgroundColor = BlackColor;
    view13.cornerRadius = SYRealValue(20 / 2);
    view13.shadowColor = WhiteColor;
    view13.shadowRadius = SYRealValue(20 / 2);
    view13.shadowOpacity = SYRealValue(2 / 2);
    view13.shadowOffset = CGSizeMake(SYRealValue(-20 / 2), 0);
    [scroll addSubview:view13];
    [view13 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view9.mas_bottom).with.offset(SYRealValue(40 / 2));
        make.left.equalTo(scroll).with.offset(SYRealValue(50 / 2));
        make.size.mas_equalTo(CGSizeMake(SYRealValue(140 / 2), SYRealValue(140 / 2)));
    }];
    
    UIView *view14 = [[UIView alloc]init];
    view14.backgroundColor = BlackColor;
    view14.cornerRadius = SYRealValue(40 / 2);
    view14.shadowColor = WhiteColor;
    view14.shadowRadius = SYRealValue(20 / 2);
    view14.shadowOpacity = SYRealValue(2 / 2);
    view14.shadowOffset = CGSizeMake(0, SYRealValue(-20 / 2));
    [scroll addSubview:view14];
    [view14 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view10.mas_bottom).with.offset(SYRealValue(40 / 2));
        make.left.equalTo(view13.mas_right).with.offset(SYRealValue(40 / 2));
        make.size.mas_equalTo(CGSizeMake(SYRealValue(140 / 2), SYRealValue(140 / 2)));
    }];
    
    UIView *view15 = [[UIView alloc]init];
    view15.backgroundColor = BlackColor;
    view15.shadowColor = WhiteColor;
    view15.shadowRadius = SYRealValue(20 / 2);
    view15.shadowOpacity = SYRealValue(2 / 2);
    view15.shadowOffset = CGSizeMake(0, SYRealValue(20 / 2));
    view15.roundTop = YES;
    view15.circle = YES;
    [scroll addSubview:view15];
    [view15 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view11.mas_bottom).with.offset(SYRealValue(40 / 2));
        make.left.equalTo(view14.mas_right).with.offset(SYRealValue(40 / 2));
        make.size.mas_equalTo(CGSizeMake(SYRealValue(140 / 2), SYRealValue(140 / 2)));
    }];
    
    UIView *view16 = [[UIView alloc]init];
    view16.backgroundColor = BlackColor;
    view16.cornerRadius = SYRealValue(40 / 2);
    view16.shadowColor = WhiteColor;
    view16.shadowRadius = SYRealValue(20 / 2);
    view16.shadowOpacity = SYRealValue(2 / 2);
    view16.shadowOffset = CGSizeMake(SYRealValue(20 / 2), 0);
    view16.circle = YES;
    [scroll addSubview:view16];
    [view16 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view12.mas_bottom).with.offset(SYRealValue(40 / 2));
        make.left.equalTo(view15.mas_right).with.offset(SYRealValue(40 / 2));
        make.size.mas_equalTo(CGSizeMake(SYRealValue(140 / 2), SYRealValue(140 / 2)));
    }];
    
    UIView *view17 = [[UIView alloc]init];
    view17.gradientAColor = kRGBAColor(117, 34, 227, 1);
    view17.gradientBColor = kRGBAColor(39, 29, 101, 1);
    view17.gradientStyleEnum = SYRealValue(2 / 2);
    [scroll addSubview:view17];
    [view17 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view13.mas_bottom).with.offset(SYRealValue(40 / 2));
        make.left.equalTo(scroll).with.offset(SYRealValue(50 / 2));
        make.size.mas_equalTo(CGSizeMake(SYRealValue(200 / 2), SYRealValue(200 / 2)));
    }];
    
    UIView *view18 = [[UIView alloc]init];
    view18.gradientAColor = kRGBAColor(255, 207, 64, 1);
    view18.gradientBColor = kRGBAColor(206, 54, 33, 1);
    view18.gradientStyleEnum = SYRealValue(4 / 2);
    [scroll addSubview:view18];
    [view18 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view13.mas_bottom).with.offset(SYRealValue(40 / 2));
        make.left.equalTo(view17.mas_right).with.offset(SYRealValue(40 / 2));
        make.size.mas_equalTo(CGSizeMake(SYRealValue(200 / 2), SYRealValue(200 / 2)));
    }];
    
    UIView *view19 = [[UIView alloc]init];
    view19.themeGradientEnable = YES;
    view19.gradientStyle = GradientStyleTopToBottom;
    [scroll addSubview:view19];
    [view19 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view13.mas_bottom).with.offset(SYRealValue(40 / 2));
        make.left.equalTo(view18.mas_right).with.offset(SYRealValue(40 / 2));
        make.size.mas_equalTo(CGSizeMake(SYRealValue(200 / 2), SYRealValue(200 / 2)));
    }];
    
    CGFloat h = view17.frame.origin.y + 200 < self.view.bounds.size.height ? self.view.bounds.size.height+1 : view17.frame.origin.y + 200;
    scroll.contentSize = CGSizeMake(self.view.bounds.size.width, h);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
