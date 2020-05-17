//
//  LSTreeItem.m
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/12/5.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import "LSTreeItem.h"

@implementation LSTreeItem

- (instancetype)initWithName:(NSString *)name ID:(NSString *)ID parentID:(NSString *)parentID orderNo:(NSString *)orderNo type:(NSString *)type isLeaf:(BOOL)isLeaf data:(id)data {
    self = [super init];
    if (self) {
        _name = [NSString stringWithFormat:@"%@", name];
        _ID = [NSString stringWithFormat:@"%@", ID];
        _parentID = [NSString stringWithFormat:@"%@", parentID];
        _orderNo = [NSString stringWithFormat:@"%@", orderNo];
        _type = [NSString stringWithFormat:@"%@", type];
        _isLeaf = isLeaf;
        _data = data;
        _level = 0;
        _isExpand = NO;
        _checkState = LSTreeItemDefault;
        _childItems = [NSMutableArray array];
    }
    return self;
}

@end
