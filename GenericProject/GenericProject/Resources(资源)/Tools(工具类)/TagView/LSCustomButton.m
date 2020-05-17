//
//  LSCustomButton.m
//  GenericProject
//
//  Created by 社科赛斯 on 2019/12/12.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import "LSCustomButton.h"

@interface LSCustomButton ()

@end

@implementation LSCustomButton

#pragma mark Layout Subview
- (void)layoutSubviews{
    [super layoutSubviews];
    
    // 1. 得到imageView和titleLabel的宽、高
    CGFloat imageWith = self.imageView.frame.size.width;
    CGFloat imageHeight = self.imageView.frame.size.height;
    
    CGFloat labelWidth = 0.0;
    CGFloat labelHeight = 0.0;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        // 由于iOS8中titleLabel的size为0，用下面的这种设置
        labelWidth = self.titleLabel.intrinsicContentSize.width;
        labelHeight = self.titleLabel.intrinsicContentSize.height;
    } else {
        labelWidth = self.titleLabel.frame.size.width;
        labelHeight = self.titleLabel.frame.size.height;
    }
    
    if (self.frame.size.width<labelWidth) {
      //  self.titleLabel.intrinsicContentSize.width 取得是文本实际需要的宽度 如果按钮的宽度小于实际宽度 设置图片位置会有问题 所以添加这个限制
        labelWidth = self.frame.size.width-self.ls_spacing-imageWith;
    }
    // 2. 声明全局的imageEdgeInsets和labelEdgeInsets
    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets labelEdgeInsets = UIEdgeInsetsZero;
    
    //根据zqCustomButtonType和zq_spacing得到imageEdgeInsets和labelEdgeInsets的值
    switch (self.ls_buttonType) {
        case LSCustomButtonImageTop:{
            imageEdgeInsets = UIEdgeInsetsMake(-labelHeight - self.ls_spacing , 0, 0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith, -imageHeight - self.ls_spacing , 0);
            break;
        }
        case LSCustomButtonImageLeft:{
            imageEdgeInsets = UIEdgeInsetsMake(0, -self.ls_spacing , 0, self.ls_spacing );
            labelEdgeInsets = UIEdgeInsetsMake(0, self.ls_spacing , 0, -self.ls_spacing );
            break;
        }
        case LSCustomButtonImageBottom:{
            imageEdgeInsets = UIEdgeInsetsMake(0, 0, -labelHeight - self.ls_spacing , -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(-imageHeight - self.ls_spacing , -imageWith, 0, 0);
            break;
        }
        case LSCustomButtonImageRight:{
            imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth + self.ls_spacing , 0, -labelWidth - self.ls_spacing );
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith - self.ls_spacing , 0, imageWith + self.ls_spacing );
            break;
        }
        case LSCustomButtonImageLeftTopLabel:{
            imageEdgeInsets = UIEdgeInsetsMake(0, self.ls_spacing , 0, -self.ls_spacing );
            labelEdgeInsets = UIEdgeInsetsMake(-10, self.ls_spacing , 10, -self.ls_spacing );
            break;
        }
        
        case LSCustomButtonNoHaveImageLabel:{
            imageEdgeInsets = UIEdgeInsetsMake(0, 0 , 0, 0 );
            labelEdgeInsets = UIEdgeInsetsMake(0, 0 , 0, 0 );
            break;
        }
        default:
            break;
    }
    
    
    // 4. 赋值
    self.titleEdgeInsets = labelEdgeInsets;
    self.imageEdgeInsets = imageEdgeInsets;
    
}

#pragma mark lazy loading
- (CGFloat)ls_spacing {
    if (!_ls_spacing) {
        _ls_spacing = 5;
    }
    return _ls_spacing * 0.5;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
