//
//  LSNSTimerProxy.h
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2020/3/18.
//  Copyright © 2020 漠然丶情到深处. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSNSTimerProxy : NSObject

//利用消息转发来断开NSTimer对象与视图之间的引用关系。初始化NSTimer时把触发事件的target替换成一个单独的对象，然后这个对象中NSTimer的SEL方法触发时让这个方法在当前的视图self中实现。
//NSProxy 是一个抽象类,它接收到任何自己没有定义的方法他都会产生一个异常,所以一个实际的子类必须提供一个初始化方法或者创建方法，并且重载forwardInvocation:方法和methodSignatureForSelector:方法来处理自己没有实现的消息。
//从类名来看是代理类,专门负责代理对象转发消息的。相比NSObject类来说NSProxy更轻量级，通过NSProxy可以帮助Objective-C间接的实现多重继承的功能。
+ (instancetype)proxyWithTarget:(id)target;

@end

NS_ASSUME_NONNULL_END
