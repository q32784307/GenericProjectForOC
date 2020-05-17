//
//  ToastView.h
//  ProductLeasing
//
//  Created by 漠然丶情到深处 on 2019/7/15.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ToastView : UIView

// @brief 单例
+ (instancetype)shareClient;

// @brief 文本提示框
- (void)popUpToastWithMessage:(NSString *)message;

@end

NS_ASSUME_NONNULL_END
