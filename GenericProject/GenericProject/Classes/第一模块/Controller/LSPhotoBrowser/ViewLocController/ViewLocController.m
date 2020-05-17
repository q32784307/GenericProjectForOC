//
//  ViewLocController.m
//  GenericProject
//
//  Created by 社科赛斯 on 2019/12/17.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import "ViewLocController.h"
#import "LSPhotoBrowser.h"
#import "FLAnimatedImage.h"

@interface ViewLocController ()

@property (nonatomic, strong) NSMutableArray *itemsArray;

@end

@implementation ViewLocController

- (NSMutableArray *)itemsArray{
    if (!_itemsArray) {
        _itemsArray = [NSMutableArray array];
    }
    return _itemsArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigation];
    [self createSubViews];
    [self setupNineSqureView];
}

- (void)setNavigation {
    self.navView.titleLabelText = @"Normal(本地)";
}

- (void)createSubViews {
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(0, -200, 50, 50);
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewDidClick:)]];
    imageView.tag = 0;
    imageView.image = [UIImage imageNamed:@"LSPhotoBrowser9.jpg"];
    [self.view addSubview:imageView];
    
    LSPhotoItems *items = [[LSPhotoItems alloc] init];
    items.sourceView = imageView;
    [self.itemsArray addObject:items];
}

- (void)setupNineSqureView{
    CGFloat viewWidth = self.view.frame.size.width;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10, 100, viewWidth - 20, viewWidth - 20)];
    view.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:view];
    
    NSMutableArray *imageArr = [NSMutableArray array];
    [imageArr addObject:[UIImage imageNamed:@"LSPhotoBrowser8.jpg"]];
    [imageArr addObject:[UIImage imageNamed:@"LSPhotoBrowser9.jpg"]];
    [imageArr addObject:[UIImage imageNamed:@"LSPhotoBrowser3.jpg"]];
    [imageArr addObject:[UIImage imageNamed:@"LSPhotoBrowser4.jpg"]];
    [imageArr addObject:[UIImage imageNamed:@"LocationLong.JPG"]];
    [imageArr addObject:[UIImage imageNamed:@"LSPhotoBrowser6.jpg"]];
    [imageArr addObject:[UIImage imageNamed:@"LSPhotoBrowser7.jpg"]];
    [imageArr addObject:[UIImage imageNamed:@"LSPhotoBrowser8.jpg"]];
    [imageArr addObject:[UIImage imageNamed:@"LSPhotoBrowser9.jpg"]];
    
    for (NSInteger i = 0 ;i < imageArr.count; i ++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.userInteractionEnabled = YES;
        [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewDidClick:)]];
        imageView.tag = i + 1;
        imageView.image = imageArr[i];
        imageView.backgroundColor = [UIColor grayColor];
        
        imageView.clipsToBounds = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        
        CGFloat width = (view.frame.size.width - 40) / 3;
        NSInteger row = i / 3;
        NSInteger col = i % 3;
        CGFloat x = 10 + col * (10 + width);
        CGFloat y = 10 + row * (10 + width);
        imageView.frame = CGRectMake(x, y, width, width);
        
        LSPhotoItems *items = [[LSPhotoItems alloc] init];
        items.sourceView = imageView;
        [self.itemsArray addObject:items];
        [view addSubview:imageView];
    }
}

- (void)imageViewDidClick:(UITapGestureRecognizer *)tap{
    LSPhotoBrowser *photoBrower = [[LSPhotoBrowser alloc] init];
    photoBrower.itemsArr = [_itemsArray copy];
    photoBrower.currentIndex = tap.view.tag;
    
    photoBrower.isNeedPageControl = true;
    photoBrower.isNeedPageNumView = true;
    photoBrower.isNeedRightTopBtn = true;
    photoBrower.isNeedPictureLongPress = true;
    [photoBrower present];
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
