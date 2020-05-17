//
//  NSArray+ErrorHandle.h
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2018/10/12.
//  Copyright © 2018 漠然丶情到深处. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (ErrorHandle)

/**
 为数组分类添加的方法  可以在应用中直接调用 可以防止数组越界导致的crash
 
 @param index 传入的取值下标
 @return id类型的数据
 */
- (id)objectAtIndexVerify:(NSUInteger)index;
- (id)objectAtIndexedSubscriptVerify:(NSUInteger)idx;

@end

NS_ASSUME_NONNULL_END


//使用方法
//[self.dataSource objectAtIndexVerify:indexPath.row];
