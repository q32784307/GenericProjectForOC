//
//  CornerAndShaodwViewController.m
//  GenericProject
//
//  Created by 社科赛斯 on 2019/12/12.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import "CornerAndShaodwViewController.h"

@interface CornerAndShaodwViewController ()

@end

@implementation CornerAndShaodwViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, LSScreenWidth, LSScreenHeight - NAVIGATION_BAR_HEIGHT - HOME_INDICATOR_HEIGHT)];
    scroll.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:scroll];
    
    /// 圆角 + 阴影
    LSShadowView *v1 = [[LSShadowView alloc] initWithFrame:CGRectMake(50, 100, 100, 100)];
    v1.backgroundColor = [UIColor whiteColor];
    [v1 ls_shaodw];
    [v1 ls_cornerRadius:10];
    UILabel *label1 = [[UILabel alloc] initWithFrame:v1.bounds];
    label1.text = @"四周阴影\n四周圆角";
    label1.numberOfLines = 2;
    label1.textColor = [UIColor darkGrayColor];
    label1.font = [UIFont systemFontOfSize:13];
    label1.textAlignment = NSTextAlignmentCenter;
    [v1 addSubview:label1];
    [scroll addSubview:v1];
    
    /// 单个圆角 + 阴影
    LSShadowView *v2 = [[LSShadowView alloc] initWithFrame:CGRectMake(200, 100, 100, 100)];
    v2.backgroundColor = [UIColor whiteColor];
    [v2 ls_shaodwRadius:10 shadowColor:[UIColor colorWithWhite:0 alpha:0.5] shadowOffset:CGSizeMake(0, 0) byShadowSide:(LSShadowSideAllSides)];
    [v2 ls_cornerRadius:10 byRoundingCorners:(UIRectCornerTopLeft)];
    UILabel *label2 = [[UILabel alloc] initWithFrame:v2.bounds];
    label2.text = @"四周阴影\n单个圆角";
    label2.numberOfLines = 2;
    label2.textColor = [UIColor darkGrayColor];
    label2.font = [UIFont systemFontOfSize:13];
    label2.textAlignment = NSTextAlignmentCenter;
    [v2 addSubview:label2];
    [scroll addSubview:v2];
    
    /// 上下阴影 + 单个圆角
    LSShadowView *v3 = [[LSShadowView alloc] initWithFrame:CGRectMake(50, 250, 100, 100)];
    v3.backgroundColor = [UIColor whiteColor];
    [v3 ls_verticalShaodwRadius:10 shadowColor:[UIColor colorWithWhite:0 alpha:0.5] shadowOffset:CGSizeZero];
    [v3 ls_cornerRadius:10 byRoundingCorners:(UIRectCornerTopRight)];
    UILabel *label3 = [[UILabel alloc] initWithFrame:v2.bounds];
    label3.text = @"上下阴影\n单个圆角";
    label3.numberOfLines = 2;
    label3.textColor = [UIColor darkGrayColor];
    label3.font = [UIFont systemFontOfSize:13];
    label3.textAlignment = NSTextAlignmentCenter;
    [v3 addSubview:label3];
    [scroll addSubview:v3];
    
    /// 单边阴影 + 单个圆角
    LSShadowView *v4 = [[LSShadowView alloc] initWithFrame:CGRectMake(200, 250, 100, 100)];
    v4.backgroundColor = [UIColor whiteColor];
    [v4 ls_shaodwRadius:10 shadowColor:[UIColor colorWithWhite:0 alpha:0.5] shadowOffset:CGSizeMake(0, 0) byShadowSide:(LSShadowSideRight)];
    [v4 ls_cornerRadius:10 byRoundingCorners:(UIRectCornerBottomLeft)];
    UILabel *label4 = [[UILabel alloc] initWithFrame:v2.bounds];
    label4.text = @"单边阴影\n单个圆角";
    label4.numberOfLines = 2;
    label4.textColor = [UIColor darkGrayColor];
    label4.font = [UIFont systemFontOfSize:13];
    label4.textAlignment = NSTextAlignmentCenter;
    [v4 addSubview:label4];
    [scroll addSubview:v4];
    
    /// 上边阴影 + 上边圆角
    LSShadowView *v5 = [[LSShadowView alloc] initWithFrame:CGRectMake(50, 400, 100, 100)];
    v5.backgroundColor = [UIColor whiteColor];
    [v5 ls_shaodwRadius:10 shadowColor:[UIColor colorWithWhite:0 alpha:0.5] shadowOffset:CGSizeMake(0, 0) byShadowSide:(LSShadowSideTop|LSShadowSideBottom)];
    [v5 ls_cornerRadius:10 byRoundingCorners:(UIRectCornerTopLeft|UIRectCornerTopRight)];
    UILabel *label5 = [[UILabel alloc] initWithFrame:v2.bounds];
    label5.text = @"上边阴影\n上边圆角";
    label5.numberOfLines = 2;
    label5.textColor = [UIColor darkGrayColor];
    label5.font = [UIFont systemFontOfSize:13];
    label5.textAlignment = NSTextAlignmentCenter;
    [v5 addSubview:label5];
    [scroll addSubview:v5];
    
    /// 下边阴影 + 下边圆角
    LSShadowView *v6 = [[LSShadowView alloc] initWithFrame:CGRectMake(200, 400, 100, 100)];
    v6.backgroundColor = [UIColor whiteColor];
    [v6 ls_shaodwRadius:10 shadowColor:[UIColor colorWithWhite:0 alpha:0.5] shadowOffset:CGSizeMake(0, 0) byShadowSide:(LSShadowSideBottom)];
    [v6 ls_cornerRadius:10 byRoundingCorners:(UIRectCornerBottomLeft|UIRectCornerBottomRight)];
    UILabel *label6 = [[UILabel alloc] initWithFrame:v2.bounds];
    label6.text = @"下边阴影\n下边圆角";
    label6.numberOfLines = 2;
    label6.textColor = [UIColor darkGrayColor];
    label6.font = [UIFont systemFontOfSize:13];
    label6.textAlignment = NSTextAlignmentCenter;
    [v6 addSubview:label6];
    [scroll addSubview:v6];
    
    CGFloat h = v6.frame.origin.y + 200 < self.view.bounds.size.height ? self.view.bounds.size.height+1 : v6.frame.origin.y + 200;
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
