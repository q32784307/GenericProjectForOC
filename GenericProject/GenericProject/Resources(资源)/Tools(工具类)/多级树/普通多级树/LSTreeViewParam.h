//
//  LSTreeViewParam.h
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/12/6.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSTreeViewParam : NSObject

LSTreeViewParam * TreeViewParam(void);

//展示数据 必传
LSTreePropStatementAndPropSetFuncStatement(strong, LSTreeViewParam, NSArray *, lsData)
//frame  必传
LSTreePropStatementAndPropSetFuncStatement(assign, LSTreeViewParam, CGRect, lsFrame)

//内容为空的时候展示的数据 default nil  (image为图片 name为文字)
LSTreePropStatementAndPropSetFuncStatement(copy,   LSTreeViewParam, NSDictionary *, lsEmptyData)
//高亮当前选中节点颜色，default是 nil。
LSTreePropStatementAndPropSetFuncStatement(strong, LSTreeViewParam, UIColor *, lsHighlightCurrent)
//节点的字体大小 default 15.0f;
LSTreePropStatementAndPropSetFuncStatement(assign, LSTreeViewParam, CGFloat, lsNodeTextFont)
//节点的字体颜色 default 333333
LSTreePropStatementAndPropSetFuncStatement(strong, LSTreeViewParam, UIColor*, lsNodeTextColor)

//是否默认展开所有节点  default NO
LSTreePropStatementAndPropSetFuncStatement(assign, LSTreeViewParam, BOOL, lsDefaultExpandAll)
//在显示复选框的情况下，是否严格的遵循父子互相关联的做法，defualt为 NO
LSTreePropStatementAndPropSetFuncStatement(assign, LSTreeViewParam, BOOL, lsCheckStrictly)
//隐藏展开图标，defualt为 NO
LSTreePropStatementAndPropSetFuncStatement(assign, LSTreeViewParam, BOOL, lsHideExpanIcon)
//节点是否可被选择 default NO
LSTreePropStatementAndPropSetFuncStatement(assign, LSTreeViewParam, BOOL, lsShowCheckbox)
//是否每次只打开一个同级树节点展开 手风琴效果 default NO
LSTreePropStatementAndPropSetFuncStatement(assign, LSTreeViewParam, BOOL, lsAccordion)
//是否开启拖拽节点功能  ⚠️目前只支持没有子节点的节点拖拽 如果有什么方便的办法可以支持多个cell一起拖拽的告知下
LSTreePropStatementAndPropSetFuncStatement(assign, LSTreeViewParam, BOOL, lsDraggable)

//默认展开的节点的 key 的数组 default nil
LSTreePropStatementAndPropSetFuncStatement(strong, LSTreeViewParam, NSArray *, lsDefaultExpandedKeys)
//相邻级节点间的水平缩进距离  默认2
LSTreePropStatementAndPropSetFuncStatement(assign, LSTreeViewParam, NSInteger, lsIndent)
//自定义树节点的图标
LSTreePropStatementAndPropSetFuncStatement(strong, LSTreeViewParam, NSString *, lsExpandIcon)
//自定义树节点展开的图标
LSTreePropStatementAndPropSetFuncStatement(strong, LSTreeViewParam, NSString *, lsSelectExpandIcon)
//自定义树节点未勾选的图标
LSTreePropStatementAndPropSetFuncStatement(strong, LSTreeViewParam, NSString *, lsCheckIcon)
//自定义树节点勾选的图标
LSTreePropStatementAndPropSetFuncStatement(strong, LSTreeViewParam, NSString *, lsSelectCheckIcon)
//自定义树节点半选中的图标 (没有全选)
LSTreePropStatementAndPropSetFuncStatement(strong, LSTreeViewParam, NSString *, lsHalfSelectCheckIcon)


//自定义节点cell
LSTreePropStatementAndPropSetFuncStatement(copy, LSTreeViewParam, CustomTreeCell, lsEventTreeCell)
//自定义cell其他交互
LSTreePropStatementAndPropSetFuncStatement(copy, LSTreeViewParam, CellUserEnabled, lsEventCellUserEnabled)
//自定义cell高度
LSTreePropStatementAndPropSetFuncStatement(copy, LSTreeViewParam, CustomTreeCellHeight, lsEventCellHeight)
//节点被点击时的回调
LSTreePropStatementAndPropSetFuncStatement(copy, LSTreeViewParam, NodeClickBlock, lsEventNodeClick)
//节点拖拽完成回调
LSTreePropStatementAndPropSetFuncStatement(copy, LSTreeViewParam, CellDraggable, lsEventNodeDraggable)
//节点选中状态发生变化时的回调
LSTreePropStatementAndPropSetFuncStatement(copy, LSTreeViewParam, NodeCheckChange, lsEventCheckChange)

@end

NS_ASSUME_NONNULL_END
