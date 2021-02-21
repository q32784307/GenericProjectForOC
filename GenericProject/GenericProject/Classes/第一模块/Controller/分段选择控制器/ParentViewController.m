//
//  ParentViewController.m
//  GenericProject
//
//  Created by 社科赛斯 on 2020/1/9.
//  Copyright © 2020 漠然丶情到深处. All rights reserved.
//

#import "ParentViewController.h"
#import "CaseOneViewController.h"

@interface ParentViewController ()

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation ParentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigation];
    [self analysis];
    [self createSubViews];
}

- (void)setNavigation {
    self.navView.isShowRightButton = NO;
    self.navView.titleLabelText = @"案例一";
}

- (void)analysis {
    self.titles = @[@"跟踪器样式专区",@"排列方式专区",@"跟踪器跟踪模式专区",@"右侧功能按钮(插入和删除操作)",@"其它示例",@"特别属性"];
    self.dataSource = @[@[@"下划线与按钮等宽(默认)",@"下划线比按钮略长",@"下划线“依恋”样式",@"缩放",@"圆角矩形",@"圆角矩形（与pageMenu同时圆角）",@"矩形",@"无样式"],@[@"可滑动的自适应内容排列",@"不可滑动的等宽排列",@"不可滑动的自适应内容排列"],@[@"跟踪器时刻跟随外界scrollView移动",@"外界scrollVie拖动结束后，跟踪器才开始移动",@"外界scrollView拖动距离超过屏幕一半时，跟踪器开始移动"],@[@"显示右侧功能按钮",@"给功能按钮设置图片和文字"],@[@"含有图片的按钮",@"指定按钮携带图片,或同时携带图片和文字,可以设置图片的位置",@"设置背景图片",@"某个按钮上添加一个副标题",@"角标"]];
}

- (void)createSubViews {
    self.mainTableView.frame = CGRectMake(0, NAVIGATION_BAR_HEIGHT, LSScreenWidth, LSScreenHeight - NAVIGATION_BAR_HEIGHT - HOME_INDICATOR_HEIGHT);
    [self.view addSubview:self.mainTableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.textLabel.font = [UIFont systemFontOfSize:LSSYRealValue(30 / 2)];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.textLabel.text = self.dataSource[indexPath.section][indexPath.row];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CaseOneViewController *CaseOneVC = [[CaseOneViewController alloc] init];
    NSInteger testNumber = indexPath.row;
    int i = 1;
    while (i <= indexPath.section) {
        testNumber += [self.dataSource[indexPath.section-i] count];
        i++;
    }
    CaseOneVC.testNumber = testNumber;
    [self.navigationController pushViewController:CaseOneVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:18];
    label.text = self.titles[section];
    return label;
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
