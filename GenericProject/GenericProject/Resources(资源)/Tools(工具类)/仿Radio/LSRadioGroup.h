//
//  LSRadioGroup.h
//  GenericProject
//
//  Created by 社科塞斯 on 2020/8/11.
//  Copyright © 2020 漠然丶情到深处. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class LSRadio;
typedef void(^radioSelect)(LSRadio *radio);

@interface LSRadioGroup : UIView

/// 核心方法
/// @param view   父视图
/// @param select 点击选择的回掉block(block里需避免循环引用！请用weakSelf)
/// @param radio  可变参数，可往里添加多个radio对象，组成一组
+ (LSRadioGroup *)onView:(UIView *)view select:(radioSelect)select radios:(LSRadio *)radio, ...;
/// 获取已选中的radio
- (LSRadio *)getSelectedRadio;

@end

NS_ASSUME_NONNULL_END
