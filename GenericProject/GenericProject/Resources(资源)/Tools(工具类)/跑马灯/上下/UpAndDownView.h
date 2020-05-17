//
//  UpAndDownView.h
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2018/6/26.
//  Copyright © 2018年 漠然丶情到深处. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UpAndDownView;

@protocol UpAndDownViewDelegate <NSObject>

// delegate 方法
- (void)advertScrollView:(UpAndDownView *)advertScrollView didSelectedItemAtIndex:(NSInteger)index;

@end

@interface UpAndDownView : UIView

/** delegate */
@property(nonatomic,weak)id<UpAndDownViewDelegate> delegate;
/** 滚动时间间隔，默认为3s */
@property(nonatomic,assign)CFTimeInterval scrollTimeInterval;
/** 标题字体字号，默认为13号字体 */
@property(nonatomic,strong)UIFont *titleFont;
/** 左边标志图片数组 */
@property(nonatomic,strong)NSArray *signImages;
/** 标题数组 */
@property(nonatomic,strong)NSArray *titles;
/** 标题字体颜色，默认为黑色 */
@property(nonatomic,strong)UIColor *titleColor;
/** 标题文字位置，默认为 NSTextAlignmentLeft，仅仅针对标题起作用 */
@property(nonatomic,assign)NSTextAlignment textAlignment;

@end
