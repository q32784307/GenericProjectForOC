//
//  NSMutableArray+ErrorHandle.h
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2018/10/12.
//  Copyright © 2018 漠然丶情到深处. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableArray (ErrorHandle)

/**
 数组中插入数据
 
 @param object 数据
 @param index 下标
 */
- (void)insertObjectVerify:(id)object atIndex:(NSInteger)index;

/**
 数组中添加数据
 
 @param object 数据
 */
- (void)addObjectVerify:(id)object;

@end

NS_ASSUME_NONNULL_END
