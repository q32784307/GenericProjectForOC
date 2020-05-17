//
//  LSNSTimerProxy.m
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2020/3/18.
//  Copyright © 2020 漠然丶情到深处. All rights reserved.
//

#import "LSNSTimerProxy.h"

@interface LSNSTimerProxy ()

@property(nonatomic,weak)id target;

@end

@implementation LSNSTimerProxy

+ (instancetype)proxyWithTarget:(id)target {
    LSNSTimerProxy *proxy = [LSNSTimerProxy alloc]; //注意：没有init方法
    proxy.target = target;
    return proxy;
}

// NSProxy接收到消息会自动进入到调用这个方法 进入消息转发流程
- (nullable NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    return [self.target methodSignatureForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    [invocation invokeWithTarget:self.target];
}

@end
