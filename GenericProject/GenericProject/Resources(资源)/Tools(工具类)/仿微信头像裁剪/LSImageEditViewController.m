//
//  LSImageEditViewController.m
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/12/10.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import "LSImageEditViewController.h"
#import "LSCropView.h"

@interface LSImageEditViewController ()<LSDCropViewDelegate>

@property(nonatomic,weak)id <LSDPhotoEditVCDelegate>delegate;
@property(nonatomic,strong)UIImage *image;
@property(nonatomic,strong)LSCropView *cropView;

@end

@implementation LSImageEditViewController

- (instancetype)initWithImage:(UIImage *)aImage delegate:(id<LSDPhotoEditVCDelegate>)aDelegate {
    self = [super init];
    if (self) {
        _image = aImage;
        _delegate = aDelegate;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = LSBlackColor;
    // Do any additional setup after loading the view.
    [self setNavigation];
    // 编辑处 view
    self.cropView = [[LSCropView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, LSScreenWidth, LSScreenHeight - NAVIGATION_BAR_HEIGHT - HOME_INDICATOR_HEIGHT)];
    self.cropView.delegate = self;
    [self.view addSubview:self.cropView];
    [self.view bringSubviewToFront:self.navView];
    self.cropView.image = self.image;
}

- (void)setNavigation {
    self.navView.titleLabelText = @"裁剪照片";
    self.navView.isShowRightButton = YES;
    self.navView.rightButtonTitle = @"选取";
    LSWeakSelf(self);
    self.navView.LeftActionBlock = ^{
        LSStrongSelf(self);
        [self.navigationController popViewControllerAnimated:YES];
    };
    self.navView.RightActionBlock = ^{
        LSStrongSelf(self);
        if (self.delegate &&
            [self.delegate respondsToSelector:@selector(lsdOptionalPhotoEditVC:didFinishCroppingImage:)]) {
            [self.delegate lsdOptionalPhotoEditVC:self didFinishCroppingImage:self.cropView.croppedImage];
        }
    };
}


#pragma mark - Delegates
- (void)mmtdOptionalDidBeginingTailor:(LSCropView *)cropView {

}

- (void)mmtdOptionalDidFinishTailor:(LSCropView *)cropView {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
