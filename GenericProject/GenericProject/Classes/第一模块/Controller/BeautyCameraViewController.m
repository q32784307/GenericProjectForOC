//
//  BeautyCameraViewController.m
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/11/28.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import "BeautyCameraViewController.h"
#import "GPUImage.h"

@interface BeautyCameraViewController ()

@property(nonatomic,strong)UIImageView *iconImageView;

@end

@implementation BeautyCameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.iconImageView = [[UIImageView alloc]init];
    self.iconImageView.image = ImageNamed(@"方图.JPG");
    [self.view addSubview:self.iconImageView];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(NAVIGATION_BAR_HEIGHT);
        make.left.equalTo(self.view).with.offset(0);
        make.right.equalTo(self.view.mas_right).with.offset(0);
        make.height.mas_equalTo(ScreenHeight / 2);
    }];
    
    UIButton *addFilterButton = [[UIButton alloc]init];
    addFilterButton.backgroundColor = RedColor;
    [addFilterButton setTitle:@"添加滤镜" forState:UIControlStateNormal];
    [addFilterButton addTarget:self action:@selector(addFilterAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addFilterButton];
    [addFilterButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconImageView.mas_bottom).with.offset(SYRealValue(100 / 2));
        make.left.equalTo(self.view).with.offset(SYRealValue(60 / 2));
        make.size.mas_equalTo(CGSizeMake(SYRealValue(200 / 2), SYRealValue(80 / 2)));
    }];
}

- (void)addFilterAction {
    NSLog(@"添加滤镜");
    GPUImageSketchFilter *disFilter = [[GPUImageSketchFilter alloc]init];
    //设置要渲染的区域
    [disFilter forceProcessingAtSize:self.iconImageView.bounds.size];
    [disFilter useNextFrameForImageCapture];
    //获取数据源
    GPUImagePicture *stillImageSource = [[GPUImagePicture alloc]initWithImage:self.iconImageView.image];
    //添加上滤镜
    [stillImageSource addTarget:disFilter];
    //开始渲染
    [stillImageSource processImage];
    //获取渲染后的图片
    UIImage *newImage = [disFilter imageFromCurrentFramebuffer];
    //加载出来
    UIImageView *newImageView = [[UIImageView alloc]initWithImage:newImage];
    self.iconImageView.hidden = YES;
    [self.view addSubview:newImageView];
    [newImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(NAVIGATION_BAR_HEIGHT);
        make.left.equalTo(self.view).with.offset(0);
        make.right.equalTo(self.view.mas_right).with.offset(0);
        make.height.mas_equalTo(ScreenHeight / 2);
    }];
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
