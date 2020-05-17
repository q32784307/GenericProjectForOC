//
//  LSImageEditViewController.h
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/12/10.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import "LSBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@class LSImageEditViewController;

@protocol LSDPhotoEditVCDelegate <NSObject>

@optional

- (void)lsdOptionalPhotoEditVC:(LSImageEditViewController *)controller didFinishCroppingImage:(UIImage *)croppedImage;

@end

@interface LSImageEditViewController : LSBaseViewController

- (instancetype)initWithImage:(UIImage *)aImage delegate:(id<LSDPhotoEditVCDelegate>)aDelegate;

@end

NS_ASSUME_NONNULL_END
