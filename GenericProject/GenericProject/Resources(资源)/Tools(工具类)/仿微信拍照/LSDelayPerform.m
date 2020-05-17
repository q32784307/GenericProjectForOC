//
//  LSDelayPerform.m
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/12/10.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import "LSDelayPerform.h"

//延迟执行的回调 静态全局变量
static dispatch_block_t ls_delayBlock;

@implementation LSDelayPerform

/// 开始延迟执行  每次调用就重新开始计时   用完记得 执行sl_cancelDelayPerform
/// @param perform  执行内容
/// @param delay 延迟时间
+ (void)ls_startDelayPerform:(void(^)(void))perform afterDelay:(NSTimeInterval)delay {
    if (ls_delayBlock != nil) {
        dispatch_block_cancel(ls_delayBlock);
        ls_delayBlock = nil;
    }
    if (ls_delayBlock == nil) {
        ls_delayBlock = dispatch_block_create(DISPATCH_BLOCK_BARRIER, ^{
            perform();
        });
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(),ls_delayBlock);
}

///取消延迟执行
+ (void)ls_cancelDelayPerform {
    if (ls_delayBlock != nil) {
        dispatch_block_cancel(ls_delayBlock);
        ls_delayBlock = nil;
    }
}

@end
