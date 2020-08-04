//
//  LSUserResizableView.h
//  GenericProject
//
//  Created by 社科塞斯 on 2020/8/4.
//  Copyright © 2020 漠然丶情到深处. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef struct LSUserResizableViewAnchorPoint {
    CGFloat adjustsX;
    CGFloat adjustsY;
    CGFloat adjustsH;
    CGFloat adjustsW;
} LSUserResizableViewAnchorPoint;

@protocol LSUserResizableViewDelegate;

@interface LSUserResizableView : UIView{
    CGPoint touchStart;
    CGFloat minWidth;
    CGFloat minHeight;
    
    // 用于确定哪些位置的点才能触发拖动事件.
    LSUserResizableViewAnchorPoint anchorPoint;
    
}

@property (nonatomic, strong) id <LSUserResizableViewDelegate> delegate;

/** 容器View */
@property (nonatomic, assign) UIView *contentView;

/** 距离顶部的间距 */
@property (nonatomic, assign) CGFloat topDistance;
/** 距离底部的间距 */
@property (nonatomic, assign) CGFloat bottomDistance;

@end

@protocol LSUserResizableViewDelegate <NSObject>

@optional

/** 开始拖动的时候响应的代理方法 */
- (void)userResizableViewDidBeginEditing:(LSUserResizableView *)userResizableView;

/** 结束拖动的时候响应的代理方法 */
- (void)userResizableViewDidEndEditing:(LSUserResizableView *)userResizableView;

@end

NS_ASSUME_NONNULL_END
