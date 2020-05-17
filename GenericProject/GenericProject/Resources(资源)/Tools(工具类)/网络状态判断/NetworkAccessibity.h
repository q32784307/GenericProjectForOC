//
//  NetworkAccessibity.h
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2018/8/1.
//  Copyright © 2018年 漠然丶情到深处. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const NetworkAccessibityChangedNotification;

typedef NS_ENUM(NSUInteger, NetworkAccessibleState) {
    NetworkChecking  = 0,
    NetworkUnknown,
    NetworkAccessible,
    NetworkRestricted,
};

typedef void (^NetworkAccessibleStateNotifier)(NetworkAccessibleState state);

@interface NetworkAccessibity : NSObject

/**
 开启 NetworkAccessibity
 */
+ (void)start;

/**
 停止 NetworkAccessibity
 */
+ (void)stop;

/**
 当判断网络状态为 NetworkRestricted 时，提示用户开启网络权限
 */
+ (void)setAlertEnable:(BOOL)setAlertEnable;

/**
 通过 block 方式监控网络权限变化。
 */
+ (void)setStateDidUpdateNotifier:(void (^)(NetworkAccessibleState))block;

/**
 返回的是最近一次的网络状态检查结果，若距离上一次检测结果短时间内网络授权状态发生变化，该值可能会不准确。
 */
+ (NetworkAccessibleState)currentState;

@end
