//
//  CityTreeViewController.m
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/12/5.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import "CityTreeViewController.h"

@interface CityTreeViewController ()<LSTreeTableViewControllerParentClassDelegate>

@end

@implementation CityTreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigation];
    self.classDelegate = self;
    [self requestData];
}

- (void)setNavigation {
    self.navView.titleLabelText = @"";
    self.navView.isShowRightButton = YES;
    self.navView.rightButtonTitle = @"提交";
    
    WeakSelf(self);
    self.navView.RightActionBlock = ^{
        StrongSelf(self);
        [self prepareCommit];
    };
    
    UIButton *allCheckButton = [[UIButton alloc]init];
    [allCheckButton setTitle:@"全选" forState:UIControlStateNormal];
    [allCheckButton addTarget:self action:@selector(allCheckAction) forControlEvents:UIControlEventTouchUpInside];
    [self.navView addSubview:allCheckButton];
    [allCheckButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navView.rightButton).with.offset(0);
        make.right.equalTo(self.navView.rightButton.mas_left).with.offset(SYRealValue(-20 / 2));
        make.height.mas_equalTo(40);
    }];
    
    UIButton *allExpandButton = [[UIButton alloc]init];
    [allExpandButton setTitle:@"全部展开" forState:UIControlStateNormal];
    [allExpandButton addTarget:self action:@selector(allExpandAction) forControlEvents:UIControlEventTouchUpInside];
    [self.navView addSubview:allExpandButton];
    [allExpandButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navView.rightButton).with.offset(0);
        make.right.equalTo(allCheckButton.mas_left).with.offset(SYRealValue(-20 / 2));
        make.height.mas_equalTo(40);
    }];
}

// 点击右上角 全选
- (void)allCheckAction {
    [self checkAllItem:YES];
}

// 点击右上角 全部展开
- (void)allExpandAction {
    [self expandAllItem:YES];
}

- (void)requestData {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = @"获取数据";
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{

        // 获取两种数据，二选一
//        self.manager = [self getManagerOfCraft];
        self.manager = [self getManagerOfCity];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [hud hideAnimated:YES];
        });
    });
}

- (LSTreeTableManager *)getManagerOfCraft {
    
    // 获取数据并创建树形结构
    NSData *JSONData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Resource" ofType:@"json"]];
    NSArray *dataArray = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingAllowFragments error:nil];

    NSMutableSet *items = [NSMutableSet set];
    for (NSDictionary *data in dataArray) {

        LSTreeItem *item = [[LSTreeItem alloc] initWithName:data[@"name"]
                                                         ID:[NSString stringWithFormat:@"%@", data[@"id"]]
                                                   parentID:[NSString stringWithFormat:@"%@", data[@"pid"]]
                                                    orderNo:[NSString stringWithFormat:@"%@", data[@"order_no"]]
                                                       type:data[@"type"]
                                                     isLeaf:[data[@"type"] isEqualToString:@"ControlPoint"]
                                                       data:data];
        [items addObject:item];
    }

    // ExpandLevel 为 0 全部折叠，为 1 展开一级，以此类推，为 NSIntegerMax 全部展开
    LSTreeTableManager *manager = [[LSTreeTableManager alloc] initWithItems:items andExpandLevel:0];

    return manager;
}

- (LSTreeTableManager *)getManagerOfCity {
    
    // 获取数据并创建树形结构
    NSData *JSONData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"cityResource" ofType:@"json"]];
    NSArray *provinceArray = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingAllowFragments error:nil];
    
    NSMutableSet *items = [NSMutableSet set];
    
    // 1. 遍历省份
    [provinceArray enumerateObjectsUsingBlock:^(NSDictionary *province, NSUInteger idx, BOOL * _Nonnull stop) {
        LSTreeItem *provinceItem = [[LSTreeItem alloc] initWithName:province[@"name"]
                                                                 ID:province[@"code"]
                                                           parentID:nil
                                                            orderNo:[NSString stringWithFormat:@"%lu", (unsigned long)idx]
                                                               type:@"province"
                                                             isLeaf:NO
                                                               data:province];
        [items addObject:provinceItem];
        
        // 2. 遍历城市
        NSArray *cityArray = province[@"children"];
        [cityArray enumerateObjectsUsingBlock:^(NSDictionary *city, NSUInteger idx, BOOL * _Nonnull stop) {
            
            LSTreeItem *cityItem = [[LSTreeItem alloc] initWithName:city[@"name"]
                                                                 ID:city[@"code"]
                                                           parentID:provinceItem.ID
                                                            orderNo:[NSString stringWithFormat:@"%lu", (unsigned long)idx]
                                                               type:@"city"
                                                             isLeaf:NO
                                                               data:city];
            [items addObject:cityItem];
            
            // 3. 遍历区
            NSArray *districtArray = city[@"children"];
            [districtArray enumerateObjectsUsingBlock:^(NSDictionary *district, NSUInteger idx, BOOL * _Nonnull stop) {
                
                LSTreeItem *districtItem = [[LSTreeItem alloc] initWithName:district[@"name"]
                                                                         ID:district[@"code"]
                                                                   parentID:cityItem.ID
                                                                    orderNo:[NSString stringWithFormat:@"%lu", (unsigned long)idx]
                                                                       type:@"district"
                                                                     isLeaf:YES
                                                                       data:district];
                [items addObject:districtItem];
            }];
        }];
    }];
    
    // ExpandLevel 为 0 全部折叠，为 1 展开一级，以此类推，为 NSIntegerMax 全部展开
    LSTreeTableManager *manager = [[LSTreeTableManager alloc] initWithItems:items andExpandLevel:0];
    
    return manager;
}


#pragma mark - MYTreeTableViewControllerParentClassDelegate

- (void)refreshTableViewController:(LSTreeTableViewController *)tableViewController {
    [self requestData];
}

- (void)tableViewController:(LSTreeTableViewController *)tableViewController checkItems:(NSArray<LSTreeItem *> *)items {
    // 这里加一个隔离带目的是可以在这里做出个性化操作，然后再将数据传出
    if ([self.delegate respondsToSelector:@selector(tableViewController:checkItems:)]) {
        [self.delegate tableViewController:self checkItems:items];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)searchBarDidBeginEditingInTableViewController:(LSTreeTableViewController *)tableViewController {
    NSLog(@"点击了搜索栏");
}

- (void)tableViewController:(LSTreeTableViewController *)tableViewController didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击了第 %ld 行", (long)indexPath.row);
}

- (void)tableViewController:(LSTreeTableViewController *)tableViewController didSelectCheckBoxRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击了第 %ld 行的 checkbox", (long)indexPath.row);
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
