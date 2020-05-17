//
//  CuttingHeadViewController.m
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/12/4.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import "CuttingHeadViewController.h"
#import "LSPhotoSelect.h"

@interface CuttingHeadViewController ()<LSDPhotoSelectDelegate>

@property(nonatomic,strong)UIImageView *headImageView;
@property(nonatomic,strong)LSPhotoSelect *photoSelect;

@end

@implementation CuttingHeadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createSubViews];
}

- (void)createSubViews {
    self.headImageView = [[UIImageView alloc]init];
    self.headImageView.backgroundColor = RedColor;
    self.headImageView.layer.masksToBounds = YES;
    self.headImageView.layer.cornerRadius = SYRealValue(120 / 2);
    [self.view addSubview:self.headImageView];
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view).with.offset(NAVIGATION_BAR_HEIGHT + SYRealValue(100 / 2));
        make.size.mas_equalTo(CGSizeMake(SYRealValue(240 / 2), SYRealValue(240 / 2)));
    }];
    
    UIButton *headButton = [[UIButton alloc]init];
    headButton.backgroundColor = RedColor;
    [headButton setTitle:@"选择头像" forState:UIControlStateNormal];
    [headButton addTarget:self action:@selector(headAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:headButton];
    [headButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headImageView.mas_bottom).with.offset(SYRealValue(100 / 2));
        make.centerX.equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(SYRealValue(200 / 2), SYRealValue(100 / 2)));
    }];

    // 初始化配置
    self.photoSelect = [[LSPhotoSelect alloc] initWithController:self delegate:self];
    self.photoSelect.isAllowEdit = YES;
}

- (void)headAction {
    // 从相册选择照片
    [self.photoSelect startPhotoSelect:LSEPhotoSelectFromLibrary];
}

#pragma mark - Private Methods
// 裁剪图片
- (UIImage *)imageFromImage:(UIImage *)image inRect:(CGRect)rect{
    //将UIImage转换成CGImageRef
    CGImageRef sourceImageRef = [image CGImage];
    
    //按照给定的矩形区域进行剪裁
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, rect);
    
    //将CGImageRef转换成UIImage
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    
    //返回剪裁后的图片
    return newImage;
}

#pragma mark - Delegates
#pragma mark - YHDPhotoSelectDelegate
// 选择完成后的回调
- (void)lsdOptionalPhotoSelect:(LSPhotoSelect *)photoSelect didFinishedWithImageArray:(NSArray *)imageArray {
    UIImage *img = imageArray.lastObject;
    UIImage *resultImg = img;
    
    // 未经过剪裁（isAllowEdit = NO）的情况下，对返回图片做裁剪，以保证 1：1
    if (img.size.width != img.size.height) {
        if (img.size.width > img.size.height) {
            CGFloat left = (img.size.width - img.size.height)/2;
            resultImg = [self imageFromImage:img inRect:CGRectMake(left, 0, img.size.height, img.size.height)];
        } else if (img.size.width < img.size.height) {
            CGFloat top = (img.size.height - img.size.width)/2;
            resultImg = [self imageFromImage:img inRect:CGRectMake(0, top, img.size.width, img.size.width)];
        }
    }
    // 展示出来
    self.headImageView.image = resultImg;
}

// 照片选择取消后的回调
- (void)lsdOptionalPhotoSelectDidCancelled:(LSPhotoSelect *)photoSelect {
    // dummy
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
