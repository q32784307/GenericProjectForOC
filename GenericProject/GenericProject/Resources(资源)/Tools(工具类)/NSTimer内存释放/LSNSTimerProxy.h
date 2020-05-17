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

+ (instancetype)proxyWithTarget:(id)target;

@end

NS_ASSUME_NONNULL_END
