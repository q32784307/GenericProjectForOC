//
//  RadiusImageView.h
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2017/10/24.
//  Copyright © 2017年 漠然丶情到深处. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, RadiusType) {
    Normal = 0,                                     //无样式
    Singel,                                         //全圆角
    TopFillet,                                      //上面圆角
    BottomFillet,                                   //下面圆角
    LeftFillet,                                     //左面圆角
    RightFillet,                                    //右面圆角
    TopLeftFillet,                                  //左上圆角
    TopRightFillet,                                 //右上圆角
    BottomLeftFillet,                               //左下圆角
    BottomRightFillet,                              //右下圆角
    TopLeftAndBottomRightFillet,                    //左上、右下圆角
    BottomLeftAndTopRightFillet,                    //左下、右上圆角
    TopLeftAndBottomLeftAndTopRightFillet,          //左上、左下、右上圆角
    TopLeftAndBottomLeftAndBottomRightFillet,       //左上、左下、右下圆角
    BottomLeftAndBottomRightAndTopRightFillet,      //左下、右下、右上圆角
    BottomRightAndTopRightAndTopLeftFillet,         //右下、右上、左上圆角
};

@interface RadiusImageView : NSObject

/**
 *  @param type                                    圆角类型
 *  @param radius                                  圆角的弧度
 */
+ (UIImageView *)bgImageViewWith:(RadiusType)type bgImageViewWithFrame:(CGRect)frame Radius:(CGFloat)radius;

@end
