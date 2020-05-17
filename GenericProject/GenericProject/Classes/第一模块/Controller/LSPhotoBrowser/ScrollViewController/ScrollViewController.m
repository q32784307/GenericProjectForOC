//
//  ScrollViewController.m
//  GenericProject
//
//  Created by 社科赛斯 on 2019/12/17.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import "ScrollViewController.h"
#import "UIImageView+WebCache.h"
#import "LSPhotoBrowser.h"

@interface ScrollViewController ()<UIScrollViewDelegate,LSPhotoBrowserDelegate>

@property (nonatomic,weak  ) UIScrollView *scrollView;

@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) NSMutableArray *itemsArr;

@end

@implementation ScrollViewController

- (instancetype)init{
    if (self = [super init]) {
        NSArray *urlArr = @[
                            @"https://wx3.sinaimg.cn/thumbnail/9bbc284bgy1frtdh1idwkj218g0rs7li.jpg",
                            @"http://ww2.sinaimg.cn/thumbnail/642beb18gw1ep3629gfm0g206o050b2a.gif",
                            @"http://ww2.sinaimg.cn/thumbnail/677febf5gw1erma104rhyj20k03dz16y.jpg",
                            @"https://wx3.sinaimg.cn/thumbnail/9bbc284bgy1frtdgoa9xxj218g0rsaon.jpg",
                            @"http://ww3.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr1xydcj20gy0o9q6s.jpg",
                            @"http://ww2.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr39ht9j20gy0o6q74.jpg",
                            @"http://ww3.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr3xvtlj20gy0obadv.jpg",
                            @"https://wx2.sinaimg.cn/mw690/9bbc284bgy1frtdht9q6mj21hc0u0hdt.jpg",
                            @"http://ww3.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr57tn9j20gy0obn0f.jpg"
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
    self.navView.titleLabelText = @"ScrollView(网络)";
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
        [imageView sd_setImageWithURL:[NSURL URLWithString:self.dataArr[i]] placeholderImage:nil];
        imageView.frame = CGRectMake(x, y, width, width);
        [scrollView addSubview:imageView];
        
        LSPhotoItems *items = [[LSPhotoItems alloc] init];
        items.url = [self.dataArr[i] stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
        items.sourceView = imageView;
        [self.itemsArr addObject:items];
    }
}

- (void)imageViewIBAction:(UITapGestureRecognizer *)tap{
    LSPhotoBrowser *photoBrowser = [[LSPhotoBrowser alloc] init];
    photoBrowser.itemsArr = [_itemsArr copy];
    photoBrowser.currentIndex = tap.view.tag;
    [photoBrowser setDelegate:self];
    [photoBrowser present];
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
