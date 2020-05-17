//
//  LSPhotoBrowserImageView.h
//  GenericProject
//
//  Created by 社科赛斯 on 2019/12/17.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLAnimatedImage.h"
@class LSProgressHUD;

typedef void(^PhotoBrowerSingleTap)(void);
typedef void(^PhotoBrowerLongPressTap)(void);

NS_ASSUME_NONNULL_BEGIN

@interface LSPhotoBrowserImageView : UIView

// all base control that can scroll
@property(nonatomic,strong)UIScrollView *scrollView;

@property(nonatomic,strong)FLAnimatedImageView *imageView;

// single tap
@property(nonatomic,copy)PhotoBrowerSingleTap singleTap;
// longPress tap
@property(nonatomic,copy)PhotoBrowerLongPressTap longPressTap;

- (void)sd_ImageWithUrl:(NSURL *)url progressHUD:(LSProgressHUD *)progressHUD placeHolder:(UIImage *)placeHolder;

@end

NS_ASSUME_NONNULL_END
