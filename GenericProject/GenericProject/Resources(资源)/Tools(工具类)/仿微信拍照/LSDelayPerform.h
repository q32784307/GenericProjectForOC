//
//  LSDelayPerform.h
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/12/10.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSDelayPerform : NSObject

/// 开始延迟执行  每次调用就重新开始计时   用完记得 执行ls_cancelDelayPerform
/// @param perform  执行内容
/// @param delay 延迟时间
+ (void)ls_startDelayPerform:(void(^)(void))perform afterDelay:(NSTimeInterval)delay;
///取消延迟执行
+ (void)ls_cancelDelayPerform;

@end

NS_ASSUME_NONNULL_END
