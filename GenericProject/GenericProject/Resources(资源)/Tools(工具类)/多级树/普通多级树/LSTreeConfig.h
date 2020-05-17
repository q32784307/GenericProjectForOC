//
//  LSTreeConfig.h
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/12/6.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#ifndef LSTreeConfig_h
#define LSTreeConfig_h

#define LSTreePropStatementAndPropSetFuncStatement(propertyModifier,className, propertyPointerType, propertyName)           \
@property(nonatomic,propertyModifier)propertyPointerType  propertyName;                                                 \
- (className * (^) (propertyPointerType propertyName)) propertyName##Set;

#define LSTreePropSetFuncImplementation(className, propertyPointerType, propertyName)                                       \
- (className * (^) (propertyPointerType propertyName))propertyName##Set{                                                \
return ^(propertyPointerType propertyName) {                                                                            \
_##propertyName = propertyName;                                                                                         \
return self;                                                                                                            \
};                                                                                                                      \
}

typedef enum :NSInteger{
    TreeDataAllWithSelf   ,                    //获取全部包括自身
    TreeDataAll              ,                 //获取全部(以下全不包括自身)
    TreeDataSelectAll              ,           //全部选中的子节点
    TreeDataExpandOrNotParent        ,         //获取展开的和第一级
    TreeDataInsert           ,                 //增加
    TreeDataDelete           ,                 //删除
}TreeDataType;


/*
 * 点击
 */
typedef void (^NodeClickBlock)(id node);

/*
 * 勾选
 */
typedef void (^NodeCheckChange)(id node,BOOL isSelect);

/*
 * cell
 */
typedef UITableViewCell* (^CustomTreeCell)(id model,NSIndexPath* path,UITableView *table,id param);

/*
 * cell交互
 */
typedef void (^CellUserEnabled)(id model,NSIndexPath* path,UITableView *table,id userInfo);


/*
 * cell拖拽
 */

typedef void (^CellDraggable)(NSIndexPath* sourceIndexPath,NSIndexPath* destinationIndexPath,UITableView *table);

/*
* cell height
*/
typedef CGFloat (^CustomTreeCellHeight)(id model,NSIndexPath* path,UITableView *table);


#endif /* LSTreeConfig_h */
