//
//  CommonTreeViewController.m
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/12/6.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import "CommonTreeViewController.h"
#import "CommonTreeDetailsViewController.h"

@interface CommonTreeViewController ()

@property(nonatomic,copy)NSArray *titleArray;

@end

@implementation CommonTreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self analysis];
    [self createSubViews];
}

- (void)analysis {
    self.titleArray = @[@"正常多叉树显示",
                        @"可选中树形+选中高亮显示",
                        @"自定义节点内容+增删节点",
                        @"手风琴效果+指定层级可勾选",
                        @"勾选不关联父节点和子节点+默认选中+默认全部展开",
                        @"开启拖拽",
                        @"传字典数据"];
}

- (void)createSubViews {
    [self.view addSubview:self.mainTableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellId = @"TableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.textLabel.font = [UIFont systemFontOfSize:LSSYRealValue(30 / 2)];
    }
    
    cell.textLabel.text = _titleArray[indexPath.row];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CommonTreeDetailsViewController *CommonTreeDetailsVC = [[CommonTreeDetailsViewController alloc]init];
    CommonTreeDetailsVC.type = indexPath.row + 1;
    [self.navigationController pushViewController:CommonTreeDetailsVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return LSSYRealValue(100 / 2);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 25;
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
