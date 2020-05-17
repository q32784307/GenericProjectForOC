//
//  AlertController.h
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2018/6/25.
//  Copyright © 2018年 漠然丶情到深处. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class AlertController;
/**
 AlertController: alertAction配置链
 
 @param title 标题
 @return      AlertController对象
 */
typedef AlertController * _Nonnull (^AlertActionTitle)(NSString *title);

/**
 AlertController: alert按钮执行回调
 
 @param buttonIndex 按钮index(根据添加action的顺序)
 @param action      UIAlertAction对象
 @param alertSelf   本类对象
 */
typedef void (^AlertActionBlock)(NSInteger buttonIndex, UIAlertAction *action, AlertController *alertSelf);

NS_CLASS_AVAILABLE_IOS(8_0) @interface AlertController : UIAlertController

/**
 AlertController: 禁用alert弹出动画，默认执行系统的默认弹出动画
 */
- (void)alertAnimateDisabled;

/**
 AlertController: alert弹出后，可配置的回调
 */
@property (nullable, nonatomic, copy) void (^alertDidShown)(void);

/**
 AlertController: alert关闭后，可配置的回调
 */
@property (nullable, nonatomic, copy) void (^alertDidDismiss)(void);

/**
 AlertController: 设置toast模式展示时间：如果alert未添加任何按钮，将会以toast样式展示，这里设置展示时间，默认1s
 */
@property (nonatomic, assign) NSTimeInterval toastStyleDuration; //deafult alertShowDurationDefault = 1s


/**
 AlertController: 链式构造alert视图按钮，添加一个alertAction按钮，默认样式，参数为标题
 
 @return AlertController对象
 */
- (AlertActionTitle)addActionDefaultTitle;

/**
 AlertController: 链式构造alert视图按钮，添加一个alertAction按钮，取消样式，参数为标题(warning:一个alert该样式只能添加一次!!!)
 
 @return AlertController对象
 */
- (AlertActionTitle)addActionCancelTitle;

/**
 AlertController: 链式构造alert视图按钮，添加一个alertAction按钮，警告样式，参数为标题
 
 @return AlertController对象
 */
- (AlertActionTitle)addActionDestructiveTitle;

@end

#pragma mark - II.UIViewController扩展使用AlertController

/**
 AlertController: alert构造块
 
 @param alertMaker AlertController配置对象
 */
typedef void(^AlertAppearanceProcess)(AlertController *alertMaker);

@interface UIViewController (AlertController)

/**
 AlertController: show-alert(iOS8)
 
 @param title             title
 @param message           message
 @param appearanceProcess alert配置过程
 @param actionBlock       alert点击响应回调
 */
- (void)showAlertWithTitle:(nullable NSString *)title
                       message:(nullable NSString *)message
             appearanceProcess:(AlertAppearanceProcess)appearanceProcess
                  actionsBlock:(nullable AlertActionBlock)actionBlock NS_AVAILABLE_IOS(8_0);

/**
 AlertController: show-actionSheet(iOS8)
 
 @param title             title
 @param message           message
 @param appearanceProcess actionSheet配置过程
 @param actionBlock       actionSheet点击响应回调
 */
- (void)showActionSheetWithTitle:(nullable NSString *)title
                             message:(nullable NSString *)message
                   appearanceProcess:(AlertAppearanceProcess)appearanceProcess
                        actionsBlock:(nullable AlertActionBlock)actionBlock NS_AVAILABLE_IOS(8_0);

@end

NS_ASSUME_NONNULL_END
