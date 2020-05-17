//
//  LSPhotoBrowser.h
//  GenericProject
//
//  Created by 社科赛斯 on 2019/12/17.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger ,LSPhotoDownloadState) {
    LSPhotoDownloadStateUnknow,
    LSPhotoDownloadStateSuccess,
    LSPhotoDownloadStateFailure,
    LSPhotoDownloadStateDownloading
};

@interface LSPhotoItems : NSObject

/**
 if is net image, just set 'url', do not set 'sourceImage'
 */
@property(nonatomic,copy)NSString *url;

/**
 if is locate image, just set 'sourceImage' , do not set 'url'
 */
@property(nonatomic,strong)UIImage *sourceImage;

/**
 current control
 */
@property(nonatomic,strong)UIView *sourceView;

/**
 is video of not, default is false
 */
@property(nonatomic,assign)BOOL isVideo;

/**
 video is downloading or other state, Default is unknow
 */
@property(nonatomic,assign)LSPhotoDownloadState downloadState;

/**
 video is downloading, current progress
 */
@property(nonatomic,assign)float downloadProgress;

@end

/****************************** == line == ********************************/
@protocol LSPhotoBrowserDelegate <NSObject>

@optional
/**
 photoBrowser will dismiss
 */
- (void)photoBrowserWillDismiss;

@optional
/**
 photoBrowser right top button did click, and actionSheet click with Index
 
 @param index actionSheet did click with Index
 */
- (void)photoBrowserRightOperationActionWithIndex:(NSInteger)index;

@optional
/**
 photoBrowser Delete image success with relative index
 
 @param index relative index
 */
- (void)photoBrowserRightOperationDeleteImageSuccessWithRelativeIndex:(NSInteger)index;

@optional
/**
 photoBrowser Delete image success with absolute index
 
 @param index absolute index
 */
- (void)photoBrowserRightOperationDeleteImageSuccessWithAbsoluteIndex:(NSInteger)index;

@optional
/**
 is success or not of save picture
 
 @param success is success
 */
- (void)photoBrowserWriteToSavedPhotosAlbumStatus:(BOOL)success;

@end

@interface LSPhotoBrowser : UIViewController

/**
 current select index
 */
@property(nonatomic,assign)NSInteger currentIndex;

/**
 contain KNPhotoItems : url && UIView
 */
@property(nonatomic,strong)NSArray<LSPhotoItems *> *itemsArr;

/**
 contain ActionSheet alert contents ,which is belong NSString type
 */
@property(nonatomic,strong)NSArray<NSString *> *actionSheetArr;

/**
 is or not need pageNumView , Default is false
 */
@property(nonatomic,assign)BOOL isNeedPageNumView;

/**
 is or not need pageControl , Default is false (but if photobrowser contain video,then hidden)
 */
@property(nonatomic,assign)BOOL isNeedPageControl;

/**
 is or not need RightTopBtn , Default is false
 */
@property(nonatomic,assign)BOOL isNeedRightTopBtn;

/**
 is or not need PictureLongPress , Default is false
 */
@property(nonatomic,assign)BOOL isNeedPictureLongPress;

/**
 is or not need prefetch image, maxCount is 8 (KNPhotoBrowserPch.h)
 */
@property(nonatomic,assign)BOOL isNeedPrefetch;

/**
 is or not need pan Gesture, Default is false
 */
@property(nonatomic,assign)BOOL isNeedPanGesture;

/**
 photoBrowser show
 */
- (void)present;

/**
 photoBrowser dismiss
 */
- (void)dismiss;

/**
 Delegate
 */
@property(nonatomic,weak)id<LSPhotoBrowserDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
