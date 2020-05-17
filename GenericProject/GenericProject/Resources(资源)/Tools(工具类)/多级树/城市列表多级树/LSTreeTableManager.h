//
//  LSTreeTableManager.h
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/12/5.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LSTreeItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface LSTreeTableManager : NSObject

/** 初始化，ExpandLevel 为 0 全部折叠，为 1 展开一级，以此类推，为 NSIntegerMax 全部展开 */
- (instancetype)initWithItems:(NSSet<LSTreeItem *> *)items andExpandLevel:(NSInteger)level;

/** 获取所有的 items */
@property(nonatomic,strong,readonly)NSMutableArray<LSTreeItem *> *allItems;
/** 获取可见的 items */
@property(nonatomic,strong,readonly)NSMutableArray<LSTreeItem *> *showItems;
/** 获取指定的 item */
- (LSTreeItem *)getItemById:(NSString *)itemId;
/** 获取所有已经勾选的 item */
@property(nonatomic,strong,readonly)NSArray<LSTreeItem *> *allCheckItem;

/** 展开/折叠到多少层级 */
- (void)expandItemWithLevel:(NSInteger)expandLevel completed:(void(^)(NSArray *noExpandArray))noExpandCompleted andCompleted:(void(^)(NSArray *expandArray))expandCompleted;
/** 展开/收起 item，返回所改变的 item 的个数 */
- (NSInteger)expandItem:(LSTreeItem *)item;
- (NSInteger)expandItem:(LSTreeItem *)item isExpand:(BOOL)isExpand;

/** 勾选/取消勾选 item */
- (void)checkItem:(LSTreeItem *)item isChildItemCheck:(BOOL)isChildItemCheck;
- (void)checkItem:(LSTreeItem *)item isCheck:(BOOL)isCheck isChildItemCheck:(BOOL)isChildItemCheck;
/** 全部勾选/全部取消勾选 */
- (void)checkAllItem:(BOOL)isCheck;

/** 筛选 */
- (void)filterField:(NSString *)field isChildItemCheck:(BOOL)isChildItemCheck;

@end

NS_ASSUME_NONNULL_END
