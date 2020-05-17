//
//  CAAnimation+Animation.h
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2018/5/31.
//  Copyright © 2018年 漠然丶情到深处. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CAAnimation (Animation)

/**
 抖动动画
 
 @param repeatTimes 重复次数
 @return 返回关键帧动画
 */
+ (CAKeyframeAnimation *)ShakeAnimation_RepeatTimes:(float)repeatTimes;


/**
 透明过渡动画
 
 @param time 持续时间
 @return 返回透明过渡动画
 */
+ (CABasicAnimation *)OpacityAnimatioinDurTimes:(float)time;


/**
 缩放动画
 
 @return 返回缩放动画
 */
+ (CABasicAnimation *)ScaleAnimation;

+ (CABasicAnimation *)TabBarRotationY;
+ (CABasicAnimation *)TabBarBoundsMin;
+ (CABasicAnimation *)TabBarBoundsMax;

@end
