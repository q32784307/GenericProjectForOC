//
//  UIAlertView_UIAlertController.h
//  UIActionSheet封装
//
//  Created by 丶离人梦 on 2016/10/19.
//  Copyright © 2016年  漠然丶情到深处. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^ClickAction)(void);

@interface UIAlertView_UIAlertController : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *message;

/**
 * @param title    标题
 * @param message  提示内容
 */
- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message;

- (void)setTitle:(NSString *)title message:(NSString *)message;

/**
 * @brief 添加按钮及事件，多个按钮便多次调用，按钮按照添加顺序显示
 */
- (void)addBtnTitle:(NSString *)title action:(ClickAction)action;

/**
 * @brief 显示提示框
 */
- (void)showAlertWithSender:(UIViewController *)sender;

NS_ASSUME_NONNULL_END

@end
