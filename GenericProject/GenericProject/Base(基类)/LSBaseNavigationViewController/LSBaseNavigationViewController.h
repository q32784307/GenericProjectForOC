//
//  LSBaseNavigationViewController.h
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2018/5/11.
//  Copyright © 2018年 漠然丶情到深处. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSBaseNavigationViewController : UINavigationController

/*!
 *  返回到指定的类视图
 *
 *  @param ClassName 类名
 *  @param animated  是否动画
 */
- (BOOL)popToAppointViewController:(NSString *)ClassName animated:(BOOL)animated;

@end
