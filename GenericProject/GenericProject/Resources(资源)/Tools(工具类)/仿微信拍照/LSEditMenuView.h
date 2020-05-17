//
//  LSEditMenuView.h
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/12/10.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

///编辑对象类型 视频 Or  图片
typedef NS_ENUM(NSUInteger, LSEditObject) {
    ///没有编辑对象
    LSEditObjectUnknow = 0,
    /// 图片编辑
    LSEditObjectPicture = 1,
    /// 视频编辑
    LSEditObjectVideo
};
///视频和图片的编辑类型
typedef NS_ENUM(NSUInteger, LSEditMenuType) {
    /// 无类型
    LSEditMenuTypeUnknown = 0,
    /// 涂鸦
    LSEditMenuTypeGraffiti = 1,
    /// 文字
    LSEditMenuTypeText,
    /// 贴画
    LSEditMenuTypeSticking,
    /// 视频裁剪
    LSEditMenuTypeVideoClipping,
    /// 图片马赛克
    LSEditMenuTypePictureMosaic,
    /// 图片裁剪
    LSEditMenuTypePictureClipping
};

/// 底部音视频、图片编辑主菜单栏
@interface LSEditMenuView : UIView

/// 编辑对象
@property(nonatomic,assign)LSEditObject editObject;
/// 选择编辑的子菜单回调
@property(nonatomic,copy)void(^selectEditMenu)(LSEditMenuType editMenuType,  NSDictionary * _Nullable setting);

@end

NS_ASSUME_NONNULL_END
