//
//  PageViewController.m
//  GenericProject
//
//  Created by 社科赛斯 on 2020/1/6.
//  Copyright © 2020 漠然丶情到深处. All rights reserved.
//

#import "PageViewController.h"
#import "ParentViewController.h"
#import "CaseTwoViewController.h"

@interface PageViewController ()

@end

@implementation PageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigation];
    [self createSubViews];
}

- (void)setNavigation {
    self.navView.isShowRightButton = NO;
    self.navView.titleLabelText = @"分段选择控制器";
}

- (void)createSubViews {
    self.mainTableView.frame = CGRectMake(0, NAVIGATION_BAR_HEIGHT, LSScreenWidth, LSScreenHeight - NAVIGATION_BAR_HEIGHT - HOME_INDICATOR_HEIGHT);
    [self.view addSubview:self.mainTableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.textLabel.font = [UIFont systemFontOfSize:LSSYRealValue(30 / 2)];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    if (indexPath.row == 0) {
        cell.textLabel.text = @"案例一";
    }
    if (indexPath.row == 1) {
        cell.textLabel.text = @"案例二";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        ParentViewController *ParentVC = [[ParentViewController alloc]init];
        [self.navigationController pushViewController:ParentVC animated:YES];
    }
    if (indexPath.row == 1) {
        CaseTwoViewController *CaseTwoVC = [[CaseTwoViewController alloc]init];
        [self.navigationController pushViewController:CaseTwoVC animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
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
