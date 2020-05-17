//
//  LSTreeTableViewController.h
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/12/5.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import "LSBaseViewController.h"
#import "LSTreeTableManager.h"

@class LSTreeTableViewController;


// 子类中实现的 delegate
@protocol LSTreeTableViewControllerParentClassDelegate <NSObject>

/** 下拉刷新后，传出刷新通知，在子类中刷新数据 */
- (void)refreshTableViewController:(LSTreeTableViewController *)tableViewController;
/** 如果是单选，点击 cell 会直接调用，如果是多选，通过 prepareCommit 方法会调用 */
- (void)tableViewController:(LSTreeTableViewController *)tableViewController checkItems:(NSArray <LSTreeItem *>*)items;
/** 监控点击搜索框，埋点用 */
- (void)searchBarDidBeginEditingInTableViewController:(LSTreeTableViewController *)tableViewController;
/** 监听 cell 点击事件 */
- (void)tableViewController:(LSTreeTableViewController *)tableViewController didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
/** 监听 cell 的 checkbox 点击事件 */
- (void)tableViewController:(LSTreeTableViewController *)tableViewController didSelectCheckBoxRowAtIndexPath:(NSIndexPath *)indexPath;

@end

// 上一页面中实现的 delegate
@protocol LSTreeTableViewControllerDelegate <NSObject>

- (void)tableViewController:(LSTreeTableViewController *)tableViewController checkItems:(NSArray <LSTreeItem *>*)items;

@end

NS_ASSUME_NONNULL_BEGIN

@interface LSTreeTableViewController : LSBaseViewController

@property(nonatomic,weak)id<LSTreeTableViewControllerParentClassDelegate> classDelegate;
@property(nonatomic,weak)id<LSTreeTableViewControllerDelegate> delegate;

@property(nonatomic,strong)LSTreeTableManager *manager;

@property(nonatomic,assign)BOOL isShowExpandedAnimation;   // 是否显示展开/折叠动画，默认 YES
@property(nonatomic,assign)BOOL isShowArrowIfNoChildNode;  // 是否没有子节点就不显示箭头，默认 NO
@property(nonatomic,assign)BOOL isShowArrow;               // 是否显示文字前方的箭头图片，默认 YES
@property(nonatomic,assign)BOOL isShowCheck;               // 是否显示文字后方的勾选框，默认 YES
@property(nonatomic,assign)BOOL isSingleCheck;             // 是否是单选，默认 NO
@property(nonatomic,assign)BOOL isCancelSingleCheck;       // 是否单选时再次点击取消选择，默认 NO
@property(nonatomic,assign)BOOL isExpandCheckedNode;       // 是否展开已选择的节点，默认 YES
@property(nonatomic,assign)BOOL isShowLevelColor;          // 是否展示层级颜色，默认 YES
@property(nonatomic,assign)BOOL isShowSearchBar;           // 是否显示搜索框，默认 YES
@property(nonatomic,assign)BOOL isSearchRealTime;          // 是否实时查询，默认 YES

@property(nonatomic,strong)NSArray <NSString *>*checkItemIds;    // 从外部传进来的所选择的 itemIds
@property(nonatomic,strong)NSArray <UIColor *>*levelColorArray;  // 层级颜色，默认一级和二级分别为深灰色和浅灰色
@property(nonatomic,strong)UIColor *normalBackgroundColor;       // 默认背景色，默认为白色

/** 全部勾选/全部取消勾选 */
- (void)checkAllItem:(BOOL)isCheck;
/** 全部展开/全部折叠 */
- (void)expandAllItem:(BOOL)isExpand;
/** 展开/折叠到多少层级 */
- (void)expandItemWithLevel:(NSInteger)expandLevel;
/** 准备提交，调用代理方法 */
- (void)prepareCommit;
/** 获取当前显示的 showItems */
- (NSArray *)getShowItems;
/** 获取所有的 Items */
- (NSArray *)getAllItems;
/** 获取所有勾选的 Items */
- (NSArray *)getCheckItems;

@end

NS_ASSUME_NONNULL_END
