//
//  LSPhotoBaseCell.h
//  GenericProject
//
//  Created by 社科赛斯 on 2019/12/17.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSPhotoBrowserImageView.h"
#import "LSProgressHUD.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^PhotoBrowerSingleTap)(void);
typedef void(^PhotoBrowerLongPressTap)(void);

@interface LSPhotoBaseCell : UICollectionViewCell

- (void)sd_ImageWithUrl:(NSString *)url placeHolder:(UIImage *)placeHolder;

@property(nonatomic,strong)LSPhotoBrowserImageView *photoBrowerImageView;
@property(nonatomic,copy)PhotoBrowerSingleTap singleTap;
@property(nonatomic,copy)PhotoBrowerLongPressTap longPressTap;

@end

NS_ASSUME_NONNULL_END
