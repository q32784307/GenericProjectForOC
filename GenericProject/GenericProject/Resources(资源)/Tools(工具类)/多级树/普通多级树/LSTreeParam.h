//
//  LSTreeParam.h
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/12/6.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSTreeParam : NSObject

//子数据
@property(nonatomic,strong)NSMutableArray <LSTreeParam *> *children;
//半选中
@property(nonatomic,assign)BOOL halfSelect;
//全选中
@property(nonatomic,assign)BOOL isSelected;
//全选中
@property(nonatomic,assign)NSInteger depath;

LSTreeParam * TreeParam(void);


//能否选中 默认NO
LSTreePropStatementAndPropSetFuncStatement(assign, LSTreeParam, BOOL, canSelect)

//是否展开 默认NO
LSTreePropStatementAndPropSetFuncStatement(assign, LSTreeParam, BOOL, isExpand)

//name
LSTreePropStatementAndPropSetFuncStatement(strong, LSTreeParam, NSString *, name)

//其他数据
LSTreePropStatementAndPropSetFuncStatement(strong, LSTreeParam, id, data)

//当前节点ID 必传
LSTreePropStatementAndPropSetFuncStatement(strong, LSTreeParam, NSString *, currentId)

//父节点ID
LSTreePropStatementAndPropSetFuncStatement(strong, LSTreeParam, NSString *, parentId)

@end

NS_ASSUME_NONNULL_END
