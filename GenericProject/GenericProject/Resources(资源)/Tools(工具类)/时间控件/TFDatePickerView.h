//
//  DataPickerView.h
//  DoctorYL
//
//  Created by chenTengfei on 15/2/5.
//  Copyright (c) 2015年 yuntai. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kTFDatePickerView @"TFDatePickerView"

@protocol TFDatePickerViewDelegate <NSObject>

@required
/**
 *  设置确定按钮执行的操作
 *
 *  @param selectedDate 选择的时间
 *
 *  @return YES关闭视图
 */
- (BOOL)submitWithSelectedDate:(NSDate *)selectedDate;

@end

/// 日历选择View
@interface TFDatePickerView : UIView

@property (nonatomic, assign) UIDatePickerMode datePickerMode;

@property (nonatomic, assign) id<TFDatePickerViewDelegate> tf_DatePickerDelegate;

+ (TFDatePickerView *)tfDatePickerViewWithDatePickerMode:(UIDatePickerMode)datePickerMode Delegate:(id<TFDatePickerViewDelegate>)delegate;

/**
 *  显示日历选择器
 */
- (void)tf_show;


/**
 *  关闭日历选择器
 */
- (void)tf_hideWindow;


@end
