//
//  LSTreeItem.h
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/12/5.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, LSTreeItemCheckState) {
    LSTreeItemDefault,      // 不选择（默认）
    LSTreeItemChecked,      // 全选
    LSTreeItemHalfChecked,  // 半选
};

NS_ASSUME_NONNULL_BEGIN

@interface LSTreeItem : NSObject

@property(nonatomic,readonly,copy)NSString *name;      // 名称
@property(nonatomic,readonly,copy)NSString *ID;        // 唯一标识
@property(nonatomic,readonly,copy)NSString *parentID;  // 父级节点唯一标识
@property(nonatomic,readonly,copy)NSString *orderNo;   // 序号
@property(nonatomic,readonly,copy)NSString *type;      // 类型
@property(nonatomic,readonly,assign)BOOL isLeaf;       // 是否叶子节点
@property(nonatomic,readonly,strong)id data;           // 原始数据

// 下列数据为 LSTreeTableManager 中内部设置，不能在外部直接设置
@property(nonatomic,assign)NSUInteger level;
@property(nonatomic,assign)BOOL isExpand;
@property(nonatomic,assign)LSTreeItemCheckState checkState;
@property(nonatomic,weak)LSTreeItem *parentItem;
@property(nonatomic,strong)NSMutableArray<LSTreeItem *> *childItems;

/** 初始化 */
- (instancetype)initWithName:(NSString *)name ID:(NSString *)ID parentID:(NSString *)parentID orderNo:(NSString *)orderNo type:(NSString *)type isLeaf:(BOOL)isLeaf data:(id)data;

@end

NS_ASSUME_NONNULL_END
