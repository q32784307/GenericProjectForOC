//
//  LSShadowView.h
//  GenericProject
//
//  Created by 社科赛斯 on 2019/12/12.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_OPTIONS(NSUInteger, LSShadowSide) {
    LSShadowSideTop       = 1 << 0,
    LSShadowSideBottom    = 1 << 1,
    LSShadowSideLeft      = 1 << 2,
    LSShadowSideRight     = 1 << 3,
    LSShadowSideAllSides  = ~0UL
};

@interface LSShadowView : UIView

/**
 * 设置四周阴影: shaodwRadius:5  shadowColor:[UIColor colorWithWhite:0 alpha:0.3]
 */
- (void)ls_shaodw;
/**
 * 设置垂直方向的阴影
 *
 * @param shadowRadius   阴影半径
 * @param shadowColor    阴影颜色
 * @param shadowOffset   阴影b偏移
 */
- (void)ls_verticalShaodwRadius:(CGFloat)shadowRadius
                    shadowColor:(UIColor *)shadowColor
                   shadowOffset:(CGSize)shadowOffset;
/**
 * 设置水平方向的阴影
 *
 * @param shadowRadius   阴影半径
 * @param shadowColor    阴影颜色
 * @param shadowOffset   阴影b偏移
 */
- (void)ls_horizontalShaodwRadius:(CGFloat)shadowRadius
                      shadowColor:(UIColor *)shadowColor
                     shadowOffset:(CGSize)shadowOffset;
/**
 * 设置阴影
 *
 * @param shadowRadius   阴影半径
 * @param shadowColor    阴影颜色
 * @param shadowOffset   阴影b偏移
 * @param shadowSide     阴影边
 */
- (void)ls_shaodwRadius:(CGFloat)shadowRadius
            shadowColor:(UIColor *)shadowColor
           shadowOffset:(CGSize)shadowOffset
           byShadowSide:(LSShadowSide)shadowSide;

/**
 * 设置圆角（四周）
 *
 * @param cornerRadius   圆角半径
 */
- (void)ls_cornerRadius:(CGFloat)cornerRadius;
/**
 * 设置圆角
 *
 * @param cornerRadius   圆角半径
 * @param corners        圆角边
 */
- (void)ls_cornerRadius:(CGFloat)cornerRadius
      byRoundingCorners:(UIRectCorner)corners;

@end

NS_ASSUME_NONNULL_END
