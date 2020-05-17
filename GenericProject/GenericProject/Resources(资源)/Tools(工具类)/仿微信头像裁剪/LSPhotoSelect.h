//
//  LSPhotoSelect.h
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/12/10.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class LSPhotoSelect;

@protocol LSDPhotoSelectDelegate <NSObject>

@optional
// 选择完成后的回调
- (void)lsdOptionalPhotoSelect:(LSPhotoSelect *)photoSelect didFinishedWithImageArray:(NSArray *)imageArray;

// 照片选择取消后的回调
- (void)lsdOptionalPhotoSelectDidCancelled:(LSPhotoSelect *)photoSelect;

@end

typedef enum{
    LSEPhotoSelectTakePhoto, //拍照
    LSEPhotoSelectFromLibrary,//从相册中读取
} LSEPhotoSelectType;

@interface LSPhotoSelect : NSObject

/**
 *  PhotoSelect Designated init method
 *
 *  @param viewController 需要 push or model 方式弹出Controller时的父Controller
 *  @param delegate       图片选择完成后的回调
 *
 *  @return self
 */
- (id)initWithController:(UIViewController *)viewController delegate:(id<LSDPhotoSelectDelegate>)delegate;

@property (nonatomic, strong, readonly) UIImagePickerController *pickerController;

/**
 *  用户最多能选择的照片数, default is NO
 */
@property (nonatomic, assign) BOOL isAllowEdit;

/**
 *  用户最多能选择的照片数, default is 0
 */
@property (assign, nonatomic)NSInteger maxSelectCount;

/**
 *  是否是多个图片选择, default is NO
 */
@property (assign, nonatomic, getter = isMultiPickImage) BOOL multiPickImage;

/**
 *  开始选取照片
 *  1、选择成功后, 会将之前选择的照片清空, 需要手动保存之前选择的照片
 *  2、如果只是开始选择照片, 但取消拍照或者选择照片, 不会清空
 *
 *  @param type 选取照片时, 需要使用的类型
 */
- (void)startPhotoSelect:(LSEPhotoSelectType)type;

/**
 *  返回已选择的image数组, 由 UIImage 组成
 *
 *  @return 数组
 */
- (NSArray *)selectedImageArray;

@end

NS_ASSUME_NONNULL_END
