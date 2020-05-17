//
//  LSTreeViewParam.m
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/12/6.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import "LSTreeViewParam.h"

@implementation LSTreeViewParam

LSTreePropSetFuncImplementation(LSTreeViewParam, NSArray *, lsData)
LSTreePropSetFuncImplementation(LSTreeViewParam, CGRect, lsFrame)
LSTreePropSetFuncImplementation(LSTreeViewParam, NSDictionary *, lsEmptyData)
LSTreePropSetFuncImplementation(LSTreeViewParam, UIColor *, lsHighlightCurrent)
LSTreePropSetFuncImplementation(LSTreeViewParam, CGFloat, lsNodeTextFont)
LSTreePropSetFuncImplementation(LSTreeViewParam, UIColor *, lsNodeTextColor)
LSTreePropSetFuncImplementation(LSTreeViewParam, NSArray *, lsDefaultExpandedKeys)
LSTreePropSetFuncImplementation(LSTreeViewParam, BOOL, lsShowCheckbox)
LSTreePropSetFuncImplementation(LSTreeViewParam, BOOL, lsAccordion)
LSTreePropSetFuncImplementation(LSTreeViewParam, BOOL, lsCheckStrictly)
LSTreePropSetFuncImplementation(LSTreeViewParam, BOOL, lsDraggable)
LSTreePropSetFuncImplementation(LSTreeViewParam, BOOL, lsDefaultExpandAll)
LSTreePropSetFuncImplementation(LSTreeViewParam, BOOL, lsHideExpanIcon)
LSTreePropSetFuncImplementation(LSTreeViewParam, NSInteger, lsIndent)
LSTreePropSetFuncImplementation(LSTreeViewParam, NSString *, lsExpandIcon)
LSTreePropSetFuncImplementation(LSTreeViewParam, NSString *, lsSelectExpandIcon)
LSTreePropSetFuncImplementation(LSTreeViewParam, NSString *, lsCheckIcon)
LSTreePropSetFuncImplementation(LSTreeViewParam, NSString *, lsSelectCheckIcon)
LSTreePropSetFuncImplementation(LSTreeViewParam, NSString *, lsHalfSelectCheckIcon)
LSTreePropSetFuncImplementation(LSTreeViewParam, NodeClickBlock, lsEventNodeClick)
LSTreePropSetFuncImplementation(LSTreeViewParam, NodeCheckChange, lsEventCheckChange)
LSTreePropSetFuncImplementation(LSTreeViewParam, CustomTreeCell, lsEventTreeCell)
LSTreePropSetFuncImplementation(LSTreeViewParam, CellUserEnabled, lsEventCellUserEnabled)
LSTreePropSetFuncImplementation(LSTreeViewParam, CustomTreeCellHeight, lsEventCellHeight)
LSTreePropSetFuncImplementation(LSTreeViewParam, CellDraggable, lsEventNodeDraggable)

LSTreeViewParam * TreeViewParam(void){
    return  [LSTreeViewParam new];
}

- (instancetype)init{
    if (self = [super init]) {
        _lsNodeTextFont = 15.0f;
        _lsNodeTextColor = [UIColor blackColor];
        _lsIndent = 2;
        _lsExpandIcon = @"close";
        _lsSelectExpandIcon = @"open";
        _lsCheckIcon = @"treeCheck";
        _lsSelectCheckIcon = @"treeCheckSelect";
        _lsHalfSelectCheckIcon = @"treeHalfSelect";
        _lsCheckStrictly = YES;
    }
    return self;
}

@end
