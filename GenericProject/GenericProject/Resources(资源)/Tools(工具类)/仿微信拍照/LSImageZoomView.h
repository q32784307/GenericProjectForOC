//
//  LSImageZoomView.h
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/12/10.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol LSImageZoomViewDelegate;
/// 缩放视图 用于图片编辑
@interface LSImageZoomView : UIScrollView

@property(nonatomic,strong)UIImage *image;
//
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,weak)id<LSImageZoomViewDelegate> zoomViewDelegate;

@end

/// 缩放视图代理
@protocol LSImageZoomViewDelegate <NSObject>
@optional

/// 开始移动图像位置
- (void)zoomViewDidBeginMoveImage:(LSImageZoomView *)zoomView;
/// 结束移动图像
- (void)zoomViewDidEndMoveImage:(LSImageZoomView *)zoomView;

@end

NS_ASSUME_NONNULL_END
