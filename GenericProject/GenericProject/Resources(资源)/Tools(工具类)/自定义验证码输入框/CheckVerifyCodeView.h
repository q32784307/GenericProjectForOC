//
//  CheckVerifyCodeView.h
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/4/17.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CheckVerifyCodeView : UIView

/** 当前用户输入的验证码 */
@property(nonatomic,copy)NSString *verifyCode;
/** 输入完成的回调 */
@property(nonatomic,copy)void(^inputCompletion)(NSString *verifyCode);

/** 开始输入 */
- (void)startInput;
/** 结束输入 */
- (void)endInput;

/** 重置 */
- (void)reset;

@end

NS_ASSUME_NONNULL_END
