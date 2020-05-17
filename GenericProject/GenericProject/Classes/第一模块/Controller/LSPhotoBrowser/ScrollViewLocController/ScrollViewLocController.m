//
//  ScrollViewLocController.m
//  GenericProject
//
//  Created by 社科赛斯 on 2019/12/17.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import "ScrollViewLocController.h"
#import "LSPhotoBrowser.h"

@interface ScrollViewLocController ()<UIScrollViewDelegate,LSPhotoBrowserDelegate>

@property (nonatomic,weak  ) UIScrollView *scrollView;

@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) NSMutableArray *itemsArr;

@end

@implementation ScrollViewLocController

- (instancetype)init{
    if (self = [super init]) {
        NSArray *urlArr = @[
                            [UIImage imageNamed:@"LSPhotoBrowser1.jpg"],
                            [UIImage imageNamed:@"LSPhotoBrowser2.jpg"],
                            [UIImage imageNamed:@"LSPhotoBrowser3.jpg"],
                            [UIImage imageNamed:@"LSPhotoBrowser4.jpg"],
                            [UIImage imageNamed:@"LSPhotoBrowser5.jpg"],
                            [UIImage imageNamed:@"LSPhotoBrowser6.jpg"],
                            [UIImage imageNamed:@"LSPhotoBrowser7.jpg"],
                            [UIImage imageNamed:@"LSPhotoBrowser8.jpg"],
                            [UIImage imageNamed:@"LSPhotoBrowser9.jpg"],
                            [UIImage imageNamed:@"LSPhotoBrowser10.jpg"],
                            [UIImage imageNamed:@"LSPhotoBrowser11.jpg"],
                            [UIImage imageNamed:@"LSPhotoBrowser12.jpg"],
                            [UIImage imageNamed:@"LSPhotoBrowser13.jpg"],
                            [UIImage imageNamed:@"LSPhotoBrowser14.jpg"],
                            ];
        self.dataArr = [urlArr mutableCopy];
    }
    return self;
}

- (NSMutableArray *)itemsArr{
    if (!_itemsArr) {
        _itemsArr = [NSMutableArray array];
    }
    return _itemsArr;
}

- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigation];
    [self createSubViews];
}

- (void)setNavigation {
    self.navView.titleLabelText = @"ScrollViewLoc";
}

- (void)createSubViews {
    CGFloat y = 10;
    CGFloat width = 180;
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, width + y * 2)];
    [scrollView setDelegate:self];
    [scrollView setShowsHorizontalScrollIndicator:NO];
    [scrollView setShowsVerticalScrollIndicator:NO];
    [scrollView setContentSize:(CGSize){(width + y * 2) * self.dataArr.count,0}];
    [scrollView setBackgroundColor:[UIColor orangeColor]];
    [self.view addSubview:scrollView];
    _scrollView = scrollView;
    
    for (NSInteger i = 0; i < self.dataArr.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [imageView setUserInteractionEnabled:YES];
        [imageView setBackgroundColor:[UIColor grayColor]];
        [imageView setTag:i];
        [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewIBAction:)]];
        CGFloat x = (y * 2 + width) * i + 10;
        imageView.image = self.dataArr[i];
        imageView.frame = CGRectMake(x, y, width, width);
        [scrollView addSubview:imageView];
        
        LSPhotoItems *items = [[LSPhotoItems alloc] init];
        items.sourceView = imageView;
        [self.itemsArr addObject:items];
    }
}

- (void)imageViewIBAction:(UITapGestureRecognizer *)tap{
    LSPhotoBrowser *photoBrowser = [[LSPhotoBrowser alloc] init];
    photoBrowser.itemsArr = [_itemsArr copy];
    photoBrowser.currentIndex = tap.view.tag;
    [photoBrowser setDelegate:self];
    photoBrowser.isNeedPageControl = true;
    photoBrowser.isNeedPageNumView = true;
    photoBrowser.isNeedRightTopBtn = true;
    photoBrowser.isNeedPictureLongPress = true;
    
    [photoBrowser present];
}


/*************************** == Delegate == ************************/
/* photoBrowser 即将消失 */
- (void)photoBrowserWillDismiss{
    NSLog(@"Will Dismiss");
}

/* photoBrowser 右上角按钮的点击 */
- (void)photoBrowserRightOperationActionWithIndex:(NSInteger)index{
    NSLog(@"operation:%zd",index);
}

/**
 *  删除当前图片
 *
 *  @param index 相对 下标
 */
- (void)photoBrowserRightOperationDeleteImageSuccessWithRelativeIndex:(NSInteger)index{
    NSLog(@"delete-Relative:%zd",index);
}

/**
 *  删除当前图片
 *
 *  @param index 绝对 下标
 */
- (void)photoBrowserRightOperationDeleteImageSuccessWithAbsoluteIndex:(NSInteger)index{
    NSLog(@"delete-Absolute:%zd",index);
}

/* photoBrowser 保存图片是否成功 */
- (void)photoBrowserWriteToSavedPhotosAlbumStatus:(BOOL)success{
    NSLog(@"saveImage:%d",success);
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
