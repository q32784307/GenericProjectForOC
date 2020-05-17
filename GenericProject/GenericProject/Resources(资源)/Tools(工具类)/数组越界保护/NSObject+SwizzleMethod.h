//
//  NSObject+SwizzleMethod.h
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2018/10/12.
//  Copyright © 2018 漠然丶情到深处. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (SwizzleMethod)

/**
 *  对系统方法进行替换(交换实例方法)
 *
 *  @param systemSelector 被替换的方法
 *  @param swizzledSelector 实际使用的方法
 *  @param error            替换过程中出现的错误消息
 *
 *  @return 是否替换成功
 */
+ (BOOL)SystemSelector:(SEL)systemSelector swizzledSelector:(SEL)swizzledSelector error:(NSError *)error;

@end

NS_ASSUME_NONNULL_END
