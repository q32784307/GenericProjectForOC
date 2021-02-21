//
//  OtherViewController.m
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2018/6/26.
//  Copyright © 2018年 漠然丶情到深处. All rights reserved.
//

#import "OtherViewController.h"
#import "PasswordStyleViewController.h"
#import "LSModel.h"

@interface OtherViewController ()

@property (nonatomic, strong) LSViewModel *dataModel;

@end

@implementation OtherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigation];
    [self analysis];
    [self createSubViews];
}

- (void)setNavigation {
    self.navView.titleLabelText = @"支付密码框样式列表";
}

- (void)analysis {
    if ([self.networkRequest isNetWorkConnectionAvailable]) {
        NSLog(@"有网络");
    }else{
        NSLog(@"无网络");
    }
    self.dataModel = [LSViewModel new];
    [self.mainTableView reloadData];
}

- (void)createSubViews {
    [self.view addSubview:self.mainTableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.dataModel numberOfSections];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataModel numberOfRowInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellId = @"TableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.textLabel.font = [UIFont systemFontOfSize:LSSYRealValue(30 / 2)];
    }
    
    cell.textLabel.text = [self.dataModel rowModelOfIndexPath:indexPath].name;
   
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PasswordStyleViewController *passwordStyleVC = [PasswordStyleViewController new];
    passwordStyleVC.dataModel = [self.dataModel rowModelOfIndexPath:indexPath];
    [self.navigationController pushViewController:passwordStyleVC animated:true];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return LSSYRealValue(100 / 2);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
