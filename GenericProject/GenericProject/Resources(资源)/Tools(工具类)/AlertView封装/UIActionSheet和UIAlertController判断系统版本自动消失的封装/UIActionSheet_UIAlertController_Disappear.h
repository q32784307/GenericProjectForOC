//
//  UIActionSheet_UIAlertController_Disappear.h
//  UIActionSheet封装
//
//  Created by 丶离人梦 on 2016/10/19.
//  Copyright © 2016年  漠然丶情到深处. All rights reserved.
//

/**
 *  弹框显示的时间，默认1秒
 */
#define AlertViewShowTime 1.0

/**
 *  检测系统版本
 */
#define iOS_Version [[[UIDevice currentDevice] systemVersion] floatValue]

/**
 *  空白标题，如果title直接设置为nil，那么message设置的内容直接被上移为title，message无效，字体就是加粗的样式
 */
#define EmptyTitle iOS_Version >= 7.0 ? @"" : @" "

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

/**
 *  回调block
 */
typedef void (^CallBackBlock)(NSInteger btnIndex);

/**
 *  按钮样式，不用系统的是为了版本适配
 */
typedef enum {
    AlertActionStyleDefault = 0,
    AlertActionStyleCancel,
    AlertActionStyleDestructive
}AlertActionStyle;

@interface UIActionSheet_UIAlertController_Disappear : NSObject

/**
 *  普通 actionSheet 兼容适配
 *
 *  @param viewController      当前视图，alertControll模态弹出的指针
 *  @param title               标题
 *  @param message             信息
 *  @param block               用于执行方法的回调block
 *  @param destructiveBtnTitle 特殊按钮
 *  @param cancelBtnTitle      取消按钮标题
 *  @param otherButtonTitles   其他按钮，变参
 
 ***注意***
 message
 iOS8以前，actionSheet设置无效，因为不支持
 iOS8以后，actionSheet设置有效
 */
+ (void)showActionSheetWith:(UIViewController *)viewController
                      title:(NSString *)title
                    message:(NSString *)message
              callbackBlock:(CallBackBlock)block
     destructiveButtonTitle:(NSString *)destructiveBtnTitle
          cancelButtonTitle:(NSString *)cancelBtnTitle
          otherButtonTitles:(NSString *)otherButtonTitles, ...NS_REQUIRES_NIL_TERMINATION;

/**
 *  多按钮列表数组排布actionSheet初始化 兼容适配
 *
 *  @param viewController       当前视图，alertController模态弹出的指针
 *  @param title                标题
 *  @param message              详细信息
 *  @param block                用于执行方法的回调block
 *  @param cancelBtnTitle       取消按钮
 *  @param destructiveBtnTitle  特殊（只针对actionSheet）ios8之后设置无效
 *  @param otherBtnTitleArray   其他按钮数组
 *  @param otherBtnStyleArray   按钮样式数组（普通/特殊），alertView默认为普通样式
 
 ***注意1***
 destructiveButtonTitle
 iOS8以前，设置有效，actionSheet，但是此时btnIndex不一样，取消的为1，destructive的为0
 iOS8以后，设置无效，alertController，此时取消的btnIndex为0，该效果请设置样式数组值
 
 ***注意2***
 message
 iOS8以前，actionSheet设置无效，因为不支持
 iOS8以后，actionSheet设置有效
 
 ***注意3***
 UIAlertActionStyleCancel/JXTAlertActionStyleCancel最多只能有一个，否则崩溃
 Log:
 'UIAlertController can only have one action with a style of UIAlertActionStyleCancel'
 */
+ (void)showArrayActionSheetWith:(UIViewController *)viewController
                           title:(NSString *)title
                         message:(NSString *)message
                   callbackBlock:(CallBackBlock)block
               cancelButtonTitle:(NSString *)cancelBtnTitle
          destructiveButtonTitle:(NSString *)destructiveBtnTitle
           otherButtonTitleArray:(NSArray *)otherBtnTitleArray
           otherButtonStyleArray:(NSArray *)otherBtnStyleArray;

@end
