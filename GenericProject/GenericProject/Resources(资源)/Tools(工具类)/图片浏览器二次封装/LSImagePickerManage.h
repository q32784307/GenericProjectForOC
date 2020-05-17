//
//  LSImagePickerManage.h
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/11/25.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//声明管理类型
typedef NS_ENUM(NSInteger,LSManageSelectTakeType) {
    LSManageSelectTakePhotoType,//选择拍照得到图片
    LSManageSelectTakeShootingVideoType,//选择拍照视频
    LSManageSelectTakeVideoType,//直接选择视频
    LSManageSelectTakeImagePickerType,//直接获取图片
    LSManageSelectTakePhotoAndImagePickerType//选择拍照和相册
};
@protocol LSImagePickerManageDelegate <NSObject>

///选择图片回调
- (void)selectTZImagePickerSelectedPhotos:(NSMutableArray *)selectedPhotos withSelectedAssets:(NSMutableArray *)selectAssets andIsOriginalPoto:(BOOL)isSelectOriginalPhoto andBlockData:(NSData *)data outPutPath:(NSString *)outPutPath withSelectTakeType:(LSManageSelectTakeType )selectType;
@end

@interface LSImagePickerManage : NSObject<UINavigationControllerDelegate,UIImagePickerControllerDelegate,TZImagePickerControllerDelegate>

@property(nonatomic,weak)id<LSImagePickerManageDelegate>delegate;

/**打开手机图片库
 
 @param maxCount 最大张数
 @param superController superController
 @param selectType selectType
 */
- (void)showImagePickerControllerWithMaxCount:(NSInteger)maxCount WithViewController:(UIViewController *)superController withSelectTakeType:(LSManageSelectTakeType)selectType withAssetsArr:(NSMutableArray *)CusSelectedAssets andPhotosArr:(NSMutableArray *)CusSelectedPhotos;

@end

NS_ASSUME_NONNULL_END
