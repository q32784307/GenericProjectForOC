//
//  MarqueeView.h
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2018/6/26.
//  Copyright © 2018年 漠然丶情到深处. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MarqueeView;

@protocol MarqueeViewDelegate <NSObject>

/** 跑马灯view上的关闭按钮点击时回调 */
- (void)marqueeView:(MarqueeView *)marqueeView closeButtonDidClick:(UIButton *)sender;

@end

@interface MarqueeView : UIView

/** 跑马灯展示的文本数组 */
@property(nonatomic,strong)NSArray *marqueeTextArray;
@property(nonatomic,weak)id<MarqueeViewDelegate> delegate;

@end
