//
//  LSPasswordViewProtocol.h
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/10/18.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#define LSBorderLayerCorlor          LSColorWithHex(0xDEE2EC)

#define kNormarLineColor             LSColorWithHex(0xE4E4E4)

#define kHightlightLineColor         LSColorWithHex(0x3773FF)



NS_ASSUME_NONNULL_BEGIN
//最大密码长度
#define kMaxCount 6

typedef NS_ENUM(NSInteger,LSPasswordViewEventType) {
    LSPasswordViewEventAutoDone     = 1, //输入密码达到6位
    LSPasswordViewEventLengthUpdate = 2, //输入密码长度变化
    LSPasswordViewEventOKButton     = 3, //点击了键盘工具条,使键盘下落
    LSPasswordViewAnimateViewFinish = 4, //输入密码动画完成了
};


@protocol LSPasswordViewDelegate;

@protocol LSPasswordViewProtocol <NSObject>


/**
 用户回调对应事件的委托
 */
@property (nonatomic, weak) id <LSPasswordViewDelegate> delegate;


/**
 使键盘弹出
 */
- (void)makeTextFieldBecomeFirstResponder;


/**
 使键盘关闭
 */
- (void)makeTextFieldResignFirstResponder;


/**
 自动显示键盘

 @param delay 延迟多久
 */
- (void)autoShowKeyboardDelay:(NSTimeInterval)delay;


/**
 清除已经输入的全部字符
 */
- (void)clearAllInputChars;


/**
 当前输入的字符长度

 @return length
 */
- (NSInteger)textLength;


@optional;

- (void)showCircleAnimating;

- (void)stopCircleAnimating;

- (void)showCheckAnimation;


@end

@protocol  LSPasswordViewDelegate <NSObject>

/**
 对应的代理事件
 
 @param textFieldView 响应的包含Textfield 的view
 @param result 加密后的结果(有些情况下可能为空)
 @param type 事件类型
 */
- (void)textFieldView:(UIView <LSPasswordViewProtocol> *)textFieldView
               result:(NSString *)result
            eventType:(LSPasswordViewEventType)type;

@end

NS_ASSUME_NONNULL_END
