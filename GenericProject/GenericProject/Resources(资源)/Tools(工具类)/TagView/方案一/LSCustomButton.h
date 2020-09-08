//
//  LSCustomButton.h
//  GenericProject
//
//  Created by 社科赛斯 on 2019/12/12.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,LSCustomButtonType) {
    LSCustomButtonImageTop          = 0, //图片在上边
    LSCustomButtonImageLeft         = 1, //图片在左边
    LSCustomButtonImageBottom       = 2, //图片在下边
    LSCustomButtonImageRight        = 3,  //图片在右边
    LSCustomButtonImageLeftTopLabel = 4,  //图片在左边 文字右上角
    LSCustomButtonNoHaveImageLabel  = 5   //无图片
};

@interface LSCustomButton : UIButton

/** 图片和文字间距 默认10px*/
@property(nonatomic,assign)CGFloat ls_spacing;

/** 按钮类型 默认YSLCustomButtonImageTop 图片在上边*/
@property(nonatomic,assign)LSCustomButtonType ls_buttonType;

@end

NS_ASSUME_NONNULL_END
