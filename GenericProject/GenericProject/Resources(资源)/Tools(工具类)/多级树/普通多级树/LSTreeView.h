//
//  LSTreeView.h
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/12/6.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import "LSTreeBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface LSTreeView : LSTreeBaseView

/*
 *初始化
*/
- (instancetype)initWithParam:(LSTreeViewParam *)param;


/*
 *更新或者设置子节点数组
  @param currrentID 当前节点 (传@""表示更新第一级)
  @param data 子节点数组
  @return BOOL 是否更新或者设置成功
 */
- (BOOL)updateKeyChildren:(NSString *)currrentID data:(NSArray *)data;

/*
 *获取当前选中的节点数组
 @param halfSelect 包含半选中
 @return NSArray 返回数组
 */
- (NSArray *)getCheckedNodesWithHalfSelect:(BOOL)halfSelect;

/*
 *为 Tree 中的一个节点追加一个子节点
  @param currrentID 当前节点
  @param param 子节点数据
  @return BOOL 是否追加成功
 */
- (BOOL)append:(NSString *)currrentID node:(LSTreeParam *)param;

/*
 *删除节点
  @param currrentID 当前节点
  @return BOOL 是否追加成功
 */
- (BOOL)remove:(NSString *)currrentID;


/*
 *为 Tree 的一个节点的前面增加一个节点
  @param currrentID 当前节点
  @param param 子节点数据
  @return BOOL 是否追加成功
 */
- (BOOL)insertBefore:(NSString *)currrentID node:(LSTreeParam *)param;

/*
 *为 Tree 的一个节点的后面增加一个节点
  @param currrentID 当前节点
  @param param 子节点数据
  @return BOOL 是否追加成功
 */
- (BOOL)insertAfter:(NSString *)currrentID node:(LSTreeParam *)param;

/*
*更新编辑状态
*/
- (void)updateEditing;

//传进来的是JSON数组 转为树形模型
- (void)changeJSONtToTreeModel:(NSArray *)data type:(TreeDataType)type;

@end

NS_ASSUME_NONNULL_END
