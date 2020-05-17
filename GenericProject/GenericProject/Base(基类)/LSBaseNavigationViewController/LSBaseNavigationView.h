//
//  LSBaseNavigationView.h
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2018/6/29.
//  Copyright © 2018年 漠然丶情到深处. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSBaseNavigationView : UIView

/**
 *  左按钮点击事件
 */
@property(nonatomic,copy)void(^LeftActionBlock)(void);
/**
 *  右按钮点击事件
 */
@property(nonatomic,copy)void(^RightActionBlock)(void);

//左按钮
@property(nonatomic,strong)UIButton *leftButton;
//右按钮
@property(nonatomic,strong)UIButton *rightButton;

//是否显示导航栏(默认YES显示)
@property(nonatomic,assign)BOOL isShowNavigation;
//导航栏颜色
@property(nonatomic,strong)UIColor *navColor;
//导航栏背景图
@property(nonatomic,copy)NSString *navBackgroundViewImage;
//左按钮图片
@property(nonatomic,copy)NSString *leftButtonImage;
//左按钮文字
@property(nonatomic,copy)NSString *leftButtonTitle;
//左按钮文字颜色
@property(nonatomic,strong)UIColor *leftButtonTitleColor;
//是否显示左按钮(默认YES显示)
@property(nonatomic,assign)BOOL isShowLeftButton;
//标题文字
@property(nonatomic,copy)NSString *titleLabelText;
//标题文字颜色
@property(nonatomic,strong)UIColor *titleLabelTextColor;
//右按钮图片
@property(nonatomic,copy)NSString *rightButtonImage;
//右按钮文字
@property(nonatomic,copy)NSString *rightButtonTitle;
//右按钮颜色
@property(nonatomic,strong)UIColor *rightButtonTitleColor;
//是否显示右按钮(默认YES显示)
@property(nonatomic,assign)BOOL isShowRightButton;
//导航栏分割线
@property(nonatomic,strong)UIView *navViewLine;
//是否显示导航栏分割线(默认YES显示)
@property(nonatomic,assign)BOOL isShowNavViewLine;


- (instancetype)initWithFrame:(CGRect)frame;

@end
