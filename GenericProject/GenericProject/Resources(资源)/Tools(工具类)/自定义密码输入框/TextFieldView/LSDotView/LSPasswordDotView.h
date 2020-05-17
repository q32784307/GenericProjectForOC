//
//  LSPasswordDotView.h
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/10/18.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import "LSBaseView.h"
#import "LSMaskView.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,LSPasswordType) {
    LSPasswordBottomLineNormal    = 0, //下划线正常样式
    LSPasswordBottomLineEncrytion = 1, //下划线加密样式
    LSPasswordRectangleNormal     = 2, //矩形框正常样式
    LSPasswordRectangleEncryption = 3, //矩形框加密样式
};

@interface LSPasswordDotView : LSBaseView

@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UIView *bottomLineView;
@property (nonatomic, strong) UIView *verticalLineView;
@property (nonatomic, strong) LSMaskView *dotView;

//实心圆点半径
@property (nonatomic, assign) CGFloat dotViewRaduis;
//底部分割线与view的gap
@property (nonatomic, assign) CGFloat kLineLeftGap;
//垂直分割线与View的gap
@property (nonatomic, assign) CGFloat kLineTopGap;



+ (instancetype)createDotViewWithType:(LSPasswordType)type
                                frame:(CGRect)frame;


/**
 设置 bottomLine 是否高亮

 @param isHightlight YES/NO
 */
- (void)setDotBottomLineHightlight:(BOOL)isHightlight;

/**
 设置Title

 @param aTitle title
 */
- (void)setDotTitle:(NSString *)aTitle;


/**
 设置实心圆点是否显示

 @param isHide  yes/no
 */
- (void)setDotPointHide:(BOOL)isHide;

@end

NS_ASSUME_NONNULL_END
