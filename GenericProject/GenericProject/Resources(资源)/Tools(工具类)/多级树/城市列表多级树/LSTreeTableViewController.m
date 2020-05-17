//
//  LSTreeTableViewController.m
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/12/5.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import "LSTreeTableViewController.h"
#import "LSTreeTableViewCell.h"
#import "LSTreeTableViewSearchBar.h"

@interface LSTreeTableViewController ()<LSTreeTableViewSearchBarDelegate>

@property(nonatomic,strong)LSTreeTableViewSearchBar *searchBar;
@property(nonatomic,strong)UIRefreshControl *myRefreshControl;

@end

@implementation LSTreeTableViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initialization];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createSubViews];
}

- (void)createSubViews {
    [self.view addSubview:self.mainTableView];
    
    self.searchBar = [[LSTreeTableViewSearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 40)];
    self.searchBar.delegate = self;
    
    self.myRefreshControl = [[UIRefreshControl alloc] init];
    self.myRefreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"];
    [self.myRefreshControl addTarget:self action:@selector(refreshData) forControlEvents:UIControlEventValueChanged];
    [self.mainTableView addSubview:self.myRefreshControl];
}

- (void)refreshData {
    if ([self.classDelegate respondsToSelector:@selector(refreshTableViewController:)]) {
        [self.classDelegate refreshTableViewController:self];
    }
    
    [self.mainTableView reloadData];
    [self.myRefreshControl endRefreshing];
}


#pragma mark - Set

- (void)setManager:(LSTreeTableManager *)manager {
    _manager = manager;
    
    // 遍历外部传来的所选择的 itemId
    for (NSString *itemId in self.checkItemIds) {
        LSTreeItem *item = [self.manager getItemById:itemId];
        if (item) {
            // 1. 勾选所选择的节点
            [self.manager checkItem:item isCheck:YES isChildItemCheck:!self.isSingleCheck];
            // 2. 展开所选择的节点
            if (self.isExpandCheckedNode) {
                NSMutableArray *expandParentItems = [NSMutableArray array];
                LSTreeItem *parentItem = item.parentItem;
                while (parentItem) {
                    [expandParentItems addObject:parentItem];
                    parentItem = parentItem.parentItem;
                }
                
                for (NSUInteger i = (expandParentItems.count - 1); i < expandParentItems.count; i--) {
                    [self.manager expandItem:expandParentItems[i] isExpand:YES];
                }
            }
        }
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.mainTableView reloadData];
    });
}

#pragma mark - UITableViewDelegate and UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.manager.showItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LSTreeItem *item = self.manager.showItems[indexPath.row];
    
    LSTreeTableViewCell *cell = [LSTreeTableViewCell cellWithTableView:tableView andTreeItem:item];
    cell.isShowArrow = self.isShowArrow;
    cell.isShowCheck = self.isShowCheck;
    cell.isShowLevelColor = self.isShowLevelColor;
    
    if ((item.level < self.levelColorArray.count) && self.isShowLevelColor) {
        cell.backgroundColor = self.levelColorArray[item.level];
    } else {
        cell.backgroundColor = self.normalBackgroundColor;
    }

    __weak typeof(self)wself = self;
    cell.checkButtonClickBlock = ^(LSTreeItem *item) {
        
        // 单选
        if (wself.isSingleCheck) {
            // 如果再次点击已经选中的 item 则取消选择
            if (wself.isCancelSingleCheck && (item.checkState == LSTreeItemChecked)) {
                [wself.manager checkItem:item isCheck:NO isChildItemCheck:NO];
                
                if ([wself.classDelegate respondsToSelector:@selector(tableViewController:checkItems:)]) {
                    [wself.classDelegate tableViewController:wself checkItems:@[]];
                }
            } else {
                [wself.manager checkItem:item isCheck:YES isChildItemCheck:NO];
                
                if ([wself.classDelegate respondsToSelector:@selector(tableViewController:checkItems:)]) {
                    [wself.classDelegate tableViewController:wself checkItems:@[item]];
                }
            }
        }
        // 多选
        else {
            [wself.manager checkItem:item isChildItemCheck:YES];
        }
        
        if ([wself.classDelegate respondsToSelector:@selector(tableViewController:didSelectCheckBoxRowAtIndexPath:)]) {
            [wself.classDelegate tableViewController:wself didSelectCheckBoxRowAtIndexPath:indexPath];
        }
        
        [wself.mainTableView reloadData];
    };
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return self.isShowSearchBar ? self.searchBar : [[UIView alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return self.isShowSearchBar ? self.searchBar.bounds.size.height : 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    LSTreeItem *item = self.manager.showItems[indexPath.row];
    
    [self tableView:tableView didSelectItems:@[item] isExpand:!item.isExpand];
    
    if ([self.classDelegate respondsToSelector:@selector(tableViewController:didSelectRowAtIndexPath:)]) {
        [self.classDelegate tableViewController:self didSelectRowAtIndexPath:indexPath];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [(LSTreeTableViewSearchBar *)self.mainTableView.tableHeaderView resignFirstResponder];
}

#pragma mark - MYSearchTextFieldDelegate
// 点击搜索框 - 用于埋点
- (void)treeTableViewSearchBarDidBeginEditing:(LSTreeTableViewSearchBar *)searchBar {
    if ([self.classDelegate respondsToSelector:@selector(searchBarDidBeginEditingInTableViewController:)]) {
        [self.classDelegate searchBarDidBeginEditingInTableViewController:self];
    }
}

// 实时查询搜索框中的文字
- (void)treeTableViewSearchBarDidEditing:(LSTreeTableViewSearchBar *)searchBar {
    [self.manager filterField:searchBar.text isChildItemCheck:!self.isSingleCheck];
    [self.mainTableView reloadData];
}

// 点击搜索键
- (void)treeTableViewSearchBarShouldReturn:(LSTreeTableViewSearchBar *)searchBar {
    [self.manager filterField:searchBar.text isChildItemCheck:!self.isSingleCheck];
    [self.mainTableView reloadData];
    [searchBar resignFirstResponder];
}

#pragma mark - Private Method
- (NSArray <NSIndexPath *>*)getUpdateIndexPathsWithCurrentIndexPath:(NSIndexPath *)indexPath andUpdateNum:(NSInteger)updateNum {
    NSMutableArray *tmpIndexPaths = [NSMutableArray arrayWithCapacity:updateNum];
    for (int i = 0; i < updateNum; i++) {
        NSIndexPath *tmp = [NSIndexPath indexPathForRow:(indexPath.row + 1 + i) inSection:indexPath.section];
        [tmpIndexPaths addObject:tmp];
    }
    return tmpIndexPaths;
}

- (UIColor *)getColorWithRed:(NSInteger)redNum green:(NSInteger)greenNum blue:(NSInteger)blueNum {
    return [UIColor colorWithRed:redNum/255.0 green:greenNum/255.0 blue:blueNum/255.0 alpha:1.0];
}

- (void)tableView:(UITableView *)tableView didSelectItems:(NSArray <LSTreeItem *>*)items isExpand:(BOOL)isExpand {
    NSMutableArray *updateIndexPaths = [NSMutableArray array];
    NSMutableArray *editIndexPaths = [NSMutableArray array];
    
    for (LSTreeItem *item in items) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[self.manager.showItems indexOfObject:item] inSection:0];
        [updateIndexPaths addObject:indexPath];
        
        NSInteger updateNum = [self.manager expandItem:item];
        NSArray *tmp = [self getUpdateIndexPathsWithCurrentIndexPath:indexPath andUpdateNum:updateNum];
        [editIndexPaths addObjectsFromArray:tmp];
    }
    
    if (self.isShowExpandedAnimation) {
        if (isExpand) {
            [tableView insertRowsAtIndexPaths:editIndexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
        } else {
            [tableView deleteRowsAtIndexPaths:editIndexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
        }
    } else {
        [tableView reloadData];
    }
    
    for (NSIndexPath *indexPath in updateIndexPaths) {
        LSTreeTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [cell updateItem];
    }
}

- (void)initialization {
    self.isShowExpandedAnimation = YES;
    self.isShowArrowIfNoChildNode = NO;
    self.isShowArrow = YES;
    self.isShowCheck = YES;
    self.isSingleCheck = NO;
    self.isCancelSingleCheck = NO;
    self.isExpandCheckedNode = YES;
    self.isShowLevelColor = YES;
    self.isShowSearchBar = YES;
    self.isSearchRealTime = YES;
    
    self.normalBackgroundColor = [UIColor whiteColor];
    self.levelColorArray = @[[self getColorWithRed:230 green:230 blue:230],
                             [self getColorWithRed:238 green:238 blue:238]];
}

#pragma mark - Public Method
// 全部勾选/全部取消勾选
- (void)checkAllItem:(BOOL)isCheck {
    [self.manager checkAllItem:isCheck];
    [self.mainTableView reloadData];
}

// 全部展开/全部折叠
- (void)expandAllItem:(BOOL)isExpand {
    [self expandItemWithLevel:(isExpand ? NSIntegerMax : 0)];
}

// 展开/折叠到多少层级
- (void)expandItemWithLevel:(NSInteger)expandLevel {
    __weak typeof(self)wself = self;
    [self.manager expandItemWithLevel:expandLevel completed:^(NSArray *noExpandArray) {
        [wself tableView:wself.mainTableView didSelectItems:noExpandArray isExpand:NO];
    } andCompleted:^(NSArray *expandArray) {
        [wself tableView:wself.mainTableView didSelectItems:expandArray isExpand:YES];
    }];
}

- (void)prepareCommit {
    if ([self.classDelegate respondsToSelector:@selector(tableViewController:checkItems:)]) {
        [self.classDelegate tableViewController:self checkItems:self.manager.allCheckItem];
    }
}

- (NSArray *)getShowItems {
    return self.manager.showItems;
}

- (NSArray *)getAllItems {
    return self.manager.allItems;
}

- (NSArray *)getCheckItems {
    return self.manager.allCheckItem;
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
