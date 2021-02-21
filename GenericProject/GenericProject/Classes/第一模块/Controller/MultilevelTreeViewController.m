//
//  MultilevelTreeViewController.m
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/12/5.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import "MultilevelTreeViewController.h"
#import "CityTreeLobbyViewController.h"
#import "CommonTreeViewController.h"

@interface MultilevelTreeViewController ()

@property(nonatomic,copy)NSArray *titleArray;

@end

@implementation MultilevelTreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self analysis];
    [self createSubViews];
}

- (void)analysis {
    self.titleArray = @[@"城市列表多级树1",
                        @"普通多级树"
                        ];
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
    if (indexPath.row == 0) {
        CityTreeLobbyViewController *CityTreeLobbyVC = [[CityTreeLobbyViewController alloc]init];
        [self.navigationController pushViewController:CityTreeLobbyVC animated:YES];
    }
    if (indexPath.row == 1) {
        CommonTreeViewController *CommonTreeVC = [[CommonTreeViewController alloc]init];
        [self.navigationController pushViewController:CommonTreeVC animated:YES];
    }
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
