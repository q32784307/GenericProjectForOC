//
//  LSCropView.h
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/12/10.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class LSCropView;

@protocol LSDCropViewDelegate <NSObject>

@optional

- (void)lsdOptionalDidBeginingTailor:(LSCropView *)cropView;
- (void)lsdOptionalDidFinishTailor:(LSCropView *)cropView;

@end

@interface LSCropView : UIView

@property(nonatomic,weak)id<LSDCropViewDelegate> delegate;

@property(nonatomic,strong)UIImage *image;
@property(nonatomic,strong,readonly)UIImage *croppedImage;
@property(nonatomic,assign)CGFloat aspectRatio;
@property(nonatomic,assign)CGRect cropRect;

@end

NS_ASSUME_NONNULL_END
