//
//  UIAlertView_UIAlertController_Disappear.m
//  UIActionSheet封装
//
//  Created by 丶离人梦 on 2016/10/19.
//  Copyright © 2016年  漠然丶情到深处. All rights reserved.
//

#import "UIAlertView_UIAlertController_Disappear.h"
#import <objc/runtime.h>

#pragma mark - UIAlertView类别扩充
//类别，扩充属性
@interface UIAlertView (UIAlertView_UIAlertController_Disappear)

@property(nonatomic,copy)CallBackBlock clickBlock;

@end

//runtime内联机制，实现set/get方法
@implementation UIAlertView (UIAlertView_UIAlertController_Disappear)

- (void)setClickBlock:(CallBackBlock)block {
    objc_setAssociatedObject(self, @selector(clickBlock), block, OBJC_ASSOCIATION_COPY);
}

- (CallBackBlock)clickBlock {
    return objc_getAssociatedObject(self, @selector(clickBlock));
}

@end

#pragma mark - 接口
@interface UIAlertView_UIAlertController_Disappear () <UIAlertViewDelegate>

@end

@implementation UIAlertView_UIAlertController_Disappear

+ (void)showArrayAlertWith:(UIViewController *)viewController
                     title:(NSString *)title
                   message:(NSString *)message
             callbackBlock:(CallBackBlock)block
         cancelButtonTitle:(NSString *)cancelBtnTitle
     otherButtonTitleArray:(NSArray *)otherBtnTitleArray
     otherButtonStyleArray:(NSArray *)otherBtnStyleArray
{
    if (iOS_Version >= 8.0)
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        
        //添加按钮
        if (cancelBtnTitle) {
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelBtnTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                block(0);
            }];
            [alertController addAction:cancelAction];
        }
        if (otherBtnTitleArray && otherBtnTitleArray.count) {
            int count = 0;
            if (cancelBtnTitle) {
                count = 1;
            }else{
                count = 0;
            }
            
            for (int i = 0; i < otherBtnTitleArray.count; i ++) {
                
                NSNumber * styleNum = otherBtnStyleArray[i];
                UIAlertActionStyle actionStyle =  styleNum.integerValue;
                UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherBtnTitleArray[i] style:actionStyle handler:^(UIAlertAction *action) {
                    block(count);
                }];
                [alertController addAction:otherAction];
                
                count ++;
            }
        }
        alertController.modalPresentationStyle = UIModalPresentationFullScreen;
        [viewController presentViewController:alertController animated:YES completion:nil];
        
        //如果没有按钮，自动延迟消失
        if (cancelBtnTitle == nil && (otherBtnStyleArray == nil || otherBtnStyleArray.count == 0)) {
            //此时self指本类
            [self performSelector:@selector(dismissAlertController:) withObject:alertController afterDelay:AlertViewShowTime];
        }
    }else{
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:cancelBtnTitle otherButtonTitles:nil];
        alert.clickBlock = block;
        
        if (otherBtnTitleArray && otherBtnTitleArray.count) {
            for (NSString * title in otherBtnTitleArray) {
                [alert addButtonWithTitle:title];
            }
        }
        
        [alert show];
        
        //如果没有按钮，自动延迟消失
        if (cancelBtnTitle == nil && (otherBtnStyleArray == nil || otherBtnStyleArray.count == 0)) {
            [self performSelector:@selector(dismissAlertView:) withObject:alert afterDelay:AlertViewShowTime];
        }
    }
}

+ (void)dismissAlertView:(UIAlertView*)alertView {
    [alertView dismissWithClickedButtonIndex:0 animated:YES];
}

+ (void)dismissAlertController:(UIAlertController *)alert {
    [alert dismissViewControllerAnimated:YES completion:nil];
}

@end
