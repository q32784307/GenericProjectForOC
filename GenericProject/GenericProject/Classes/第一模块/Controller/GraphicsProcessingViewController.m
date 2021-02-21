//
//  GraphicsProcessingViewController.m
//  GenericProject
//
//  Created by 社科赛斯 on 2019/12/17.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import "GraphicsProcessingViewController.h"
#import "CornerAndShaodwViewController.h"
#import "GraphicsExtensionsViewController.h"

@interface GraphicsProcessingViewController ()

@property(nonatomic,copy)NSArray *titleArray;

@end

@implementation GraphicsProcessingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigation];
    [self analysis];
    [self createSubViews];
}

- (void)setNavigation {
    self.navView.isShowRightButton = NO;
    self.navView.titleLabelText = @"圆角与阴影";
}

- (void)analysis {
    self.titleArray = @[
                        @"分类",
                        @"扩展类"
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
        CornerAndShaodwViewController *CornerAndShaodwVC = [[CornerAndShaodwViewController alloc]init];
        [self.navigationController pushViewController:CornerAndShaodwVC animated:YES];
    }
    if (indexPath.row == 1) {
        GraphicsExtensionsViewController *GraphicsExtensionsVC = [[GraphicsExtensionsViewController alloc]init];
        [self.navigationController pushViewController:GraphicsExtensionsVC animated:YES];
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
