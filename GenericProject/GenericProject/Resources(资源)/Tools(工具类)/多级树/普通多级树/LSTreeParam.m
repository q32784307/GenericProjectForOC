//
//  LSTreeParam.m
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/12/6.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import "LSTreeParam.h"

@implementation LSTreeParam

LSTreePropSetFuncImplementation(LSTreeParam, BOOL, canSelect)
LSTreePropSetFuncImplementation(LSTreeParam, BOOL, isSelected)
LSTreePropSetFuncImplementation(LSTreeParam, BOOL, isExpand)
LSTreePropSetFuncImplementation(LSTreeParam, NSString *, currentId)
LSTreePropSetFuncImplementation(LSTreeParam, NSString *, parentId)
LSTreePropSetFuncImplementation(LSTreeParam, NSString *, name)
LSTreePropSetFuncImplementation(LSTreeParam, id, data)

- (instancetype)init{
    if (self = [super init]) {
        _canSelect = YES;
    }
    return self;
}

LSTreeParam * TreeParam(void){
    return  [LSTreeParam new];
}

-(NSMutableArray<LSTreeParam *> *)children{
    if (!_children) {
        _children =[NSMutableArray new];
    }
    return _children;
}

-  (NSString *)description{
    return [NSString stringWithFormat:@"currentID %@ parentId %@ isExpand %d isSelect %d isHalf %d ",self.currentId,self.parentId, self.isExpand,self.isSelected,self.halfSelect];
}

@end
