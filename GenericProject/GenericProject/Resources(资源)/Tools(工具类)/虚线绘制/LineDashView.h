//
//  LineDashView.h
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2017/12/19.
//  Copyright © 2017年 漠然丶情到深处. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LineDashView : UIView

@property(nonatomic,strong)NSArray *lineDashPattern;  // 线段分割模式--->@[@5,@5]   第一个参数为虚线的长度，第二个参数为间隔距离
@property(nonatomic,assign)CGFloat endOffset;        // 取值在 0.001 --> 0.499 之间

- (instancetype)initWithFrame:(CGRect)frame lineDashPattern:(NSArray *)lineDashPattern endOffset:(CGFloat)endOffset;

@end
