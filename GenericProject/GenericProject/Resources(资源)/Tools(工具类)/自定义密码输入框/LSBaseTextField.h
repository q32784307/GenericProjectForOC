//
//  LSBaseTextField.h
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/10/18.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSBaseTextField : UITextField

@property (nonatomic, weak) id <UITextFieldDelegate> pDelegate;
@property (nonatomic, assign) NSInteger maxCount;

/**
 是否允许长按弹出 Copy等相关选择框 (YES/NO)
 */
@property (nonatomic, assign) BOOL allowCopyMenu;


/**
 是否允许显示键盘上方的工具条
 */
@property (nonatomic, assign) BOOL showToolbarView;


/**
 工具条事件回调
 */
@property (nonatomic,copy) void (^ToolBarViewEvent)(void);



- (BOOL)isReachMaxCountCharacterRange:(NSRange)range replacmentString:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
