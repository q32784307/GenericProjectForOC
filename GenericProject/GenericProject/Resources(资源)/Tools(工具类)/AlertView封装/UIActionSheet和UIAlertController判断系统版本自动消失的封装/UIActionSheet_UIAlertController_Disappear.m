//
//  UIActionSheet_UIAlertController_Disappear.m
//  UIActionSheet封装
//
//  Created by 丶离人梦 on 2016/10/19.
//  Copyright © 2016年  漠然丶情到深处. All rights reserved.
//

#import "UIActionSheet_UIAlertController_Disappear.h"
#import <objc/runtime.h>

#pragma mark - UIActionSheet类别扩充
//类别，扩充属性
@interface UIActionSheet (UIActionSheet_UIAlertController_Disappear)

@property (nonatomic, copy) CallBackBlock clickBlock;

@end

//runtime内联机制，实现set/get方法
@implementation UIActionSheet (UIActionSheet_UIAlertController_Disappear)

- (void)setClickBlock:(CallBackBlock)block {
    objc_setAssociatedObject(self, @selector(clickBlock), block, OBJC_ASSOCIATION_COPY);
}

- (CallBackBlock)clickBlock {
    return objc_getAssociatedObject(self, @selector(clickBlock));
}

@end

#pragma mark - 接口
@interface UIActionSheet_UIAlertController_Disappear () <UIActionSheetDelegate>

@end

@implementation UIActionSheet_UIAlertController_Disappear

+ (void)showActionSheetWith:(UIViewController *)viewController
                      title:(NSString *)title
                    message:(NSString *)message
              callbackBlock:(CallBackBlock)block
     destructiveButtonTitle:(NSString *)destructiveBtnTitle
          cancelButtonTitle:(NSString *)cancelBtnTitle
          otherButtonTitles:(NSString *)otherButtonTitles, ...
{
    if (iOS_Version >= 8.0) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
        
        //添加按钮
        if (destructiveBtnTitle) {
            UIAlertAction *destructiveAction = [UIAlertAction actionWithTitle:destructiveBtnTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                block(0);
            }];
            [alertController addAction:destructiveAction];
        }
        if (cancelBtnTitle) {
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelBtnTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                if (destructiveBtnTitle) {block(1);}
                else {block(0);}
            }];
            [alertController addAction:cancelAction];
        }
        if (otherButtonTitles) {
            UIAlertAction *otherActions = [UIAlertAction actionWithTitle:otherButtonTitles style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                if (!cancelBtnTitle && !destructiveBtnTitle) {
                    block(0);
                }else if ((cancelBtnTitle && !destructiveBtnTitle) || (!cancelBtnTitle && destructiveBtnTitle)) {
                    block(1);
                }else if (cancelBtnTitle && destructiveBtnTitle) {
                    block(2);
                }
            }];
            [alertController addAction:otherActions];
            
            va_list args;//定义一个指向个数可变的参数列表指针;
            va_start(args, otherButtonTitles);//va_start 得到第一个可变参数地址
            NSString *title = nil;
            
            int count = 2;
            if (!cancelBtnTitle && !destructiveBtnTitle) {
                count = 0;
            }else if ((cancelBtnTitle && !destructiveBtnTitle) || (!cancelBtnTitle && destructiveBtnTitle)) {
                count = 1;
            }else if (cancelBtnTitle && destructiveBtnTitle) {
                count = 2;
            }
            
            while ((title = va_arg(args, NSString *)))//指向下一个参数地址
            {
                count ++;
                
                UIAlertAction *otherAction = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    block(count);
                }];
                [alertController addAction:otherAction];
            }
            va_end(args);//置空指针
        }
        alertController.modalPresentationStyle = UIModalPresentationFullScreen;
        [viewController presentViewController:alertController animated:YES completion:nil];
        
        //如果没有按钮，自动延迟消失
        if (cancelBtnTitle == nil && destructiveBtnTitle == nil && otherButtonTitles == nil) {
            //此时self指本类
            [self performSelector:@selector(dismissAlertController:) withObject:alertController afterDelay:AlertViewShowTime];
        }
    }else{
        UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:title delegate:self cancelButtonTitle:cancelBtnTitle destructiveButtonTitle:destructiveBtnTitle otherButtonTitles:nil];
        actionSheet.clickBlock = block;
        if (otherButtonTitles) {
            [actionSheet addButtonWithTitle:otherButtonTitles];
            va_list args;//定义一个指向个数可变的参数列表指针;
            va_start(args, otherButtonTitles);//va_start 得到第一个可变参数地址
            NSString *title = nil;
            while ((title = va_arg(args, NSString *)))//指向下一个参数地址
            {
                [actionSheet addButtonWithTitle:title];
            }
            va_end(args);//置空指针
        }
        
        [actionSheet showInView:viewController.view];
        
        //如果没有按钮，自动延迟消失
        if (cancelBtnTitle == nil && otherButtonTitles == nil) {
            [self performSelector:@selector(dismissActionSheet:) withObject:actionSheet afterDelay:AlertViewShowTime];
        }
    }
}

#pragma mark - 多按钮列表数组排布actionSheet初始化 兼容适配
+ (void)showArrayActionSheetWith:(UIViewController *)viewController
                           title:(NSString *)title
                         message:(NSString *)message
                   callbackBlock:(CallBackBlock)block
               cancelButtonTitle:(NSString *)cancelBtnTitle
          destructiveButtonTitle:(NSString *)destructiveBtnTitle
           otherButtonTitleArray:(NSArray *)otherBtnTitleArray
           otherButtonStyleArray:(NSArray *)otherBtnStyleArray
{
    if (iOS_Version >= 8.0) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
        
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
        //关联代理有警告，但是不能用对象否则代理无效
        UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:title delegate:self cancelButtonTitle:cancelBtnTitle destructiveButtonTitle:destructiveBtnTitle otherButtonTitles:nil];
        actionSheet.clickBlock = block;
        
        if (otherBtnTitleArray && otherBtnTitleArray.count) {
            for (NSString * title in otherBtnTitleArray) {
                [actionSheet addButtonWithTitle:title];
            }
        }
        
        [actionSheet showInView:viewController.view];
        
        //如果没有按钮，自动延迟消失
        if (cancelBtnTitle == nil && (otherBtnStyleArray == nil || otherBtnStyleArray.count == 0)) {
            [self performSelector:@selector(dismissActionSheet:) withObject:actionSheet afterDelay:AlertViewShowTime];
        }
    }
}

+ (void)dismissActionSheet:(UIActionSheet *)actionSheet {
    [actionSheet dismissWithClickedButtonIndex:0 animated:YES];
}

+ (void)dismissAlertController:(UIAlertController *)alert {
    [alert dismissViewControllerAnimated:YES completion:nil];
}

@end
