//
//  LSPhotoBaseCell.m
//  GenericProject
//
//  Created by 社科赛斯 on 2019/12/17.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import "LSPhotoBaseCell.h"

@implementation LSPhotoBaseCell
{
    LSProgressHUD *_progressHUD;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupImageView];
    }
    return self;
}

- (void)setupImageView {
    // 1.photoBrowerView
    LSPhotoBrowserImageView *photoBrowerView = [[LSPhotoBrowserImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _photoBrowerImageView = photoBrowerView;
    [self.contentView addSubview:photoBrowerView];
    
    
    __weak typeof(self) weakself = self;
    photoBrowerView.singleTap = ^{
        if (weakself.singleTap) {
            weakself.singleTap();
        }
    };
    
    photoBrowerView.longPressTap = ^{
        if (weakself.longPressTap) {
            weakself.longPressTap();
        }
    };
    
    // 2.progressHUD
    LSProgressHUD *progressHUD = [[LSProgressHUD alloc] initWithFrame:(CGRect){{([UIScreen mainScreen].bounds.size.width - 40) * 0.5,([UIScreen mainScreen].bounds.size.height - 40) * 0.5},{40,40}}];
    _progressHUD = progressHUD;
    [self.contentView addSubview:progressHUD];
}

- (void)sd_ImageWithUrl:(NSString *)url placeHolder:(UIImage *)placeHolder {
    [_photoBrowerImageView sd_ImageWithUrl:[NSURL URLWithString:url]
                               progressHUD:_progressHUD
                               placeHolder:placeHolder];
}

- (void)prepareForReuse {
    [_photoBrowerImageView.scrollView setZoomScale:1.f animated:false];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_photoBrowerImageView.scrollView setZoomScale:1.f animated:false];
    _photoBrowerImageView.frame = self.bounds;
    _progressHUD.center = self.contentView.center;
}

@end
