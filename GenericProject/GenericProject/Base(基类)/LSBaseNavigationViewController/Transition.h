//
//  Transition.h
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2018/6/22.
//  Copyright © 2018年 漠然丶情到深处. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Transition : NSObject<UIViewControllerAnimatedTransitioning>

@property(nonatomic,assign)BOOL isPush;//是否是push，反之则是pop

@property(nonatomic,assign)NSTimeInterval animationDuration;//动画时长

@end
