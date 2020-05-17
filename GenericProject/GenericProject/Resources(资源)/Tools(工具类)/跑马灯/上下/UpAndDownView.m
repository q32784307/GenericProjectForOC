//
//  UpAndDownView.m
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2018/6/26.
//  Copyright © 2018年 漠然丶情到深处. All rights reserved.
//

#import "UpAndDownView.h"

static NSInteger const UpAndDownTitleFont = 13;

@interface UpAndDownCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *signImageView;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation UpAndDownCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.signImageView];
        [self.contentView addSubview:self.titleLabel];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    self.signImageView.frame = CGRectMake(0, 0, 40, 40);
    
    CGFloat labelX = 0;
    if (self.signImageView.image == nil) {
        labelX = 0;
    } else {
        labelX = CGRectGetMaxX(self.signImageView.frame) + 0.5 * 5;
    }
    CGFloat labelY = 0;
    CGFloat labelW = self.frame.size.width - labelX;
    CGFloat labelH = self.frame.size.height;
    self.titleLabel.frame = CGRectMake(labelX, labelY, labelW, labelH);
    
    CGPoint topPoint = self.signImageView.center;
    topPoint.y = _titleLabel.center.y;
    _signImageView.center = topPoint;
}

- (UIImageView *)signImageView {
    if (!_signImageView) {
        _signImageView = [[UIImageView alloc] init];
    }
    return _signImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:UpAndDownTitleFont];
    }
    return _titleLabel;
}

@end

@interface UpAndDownView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSArray *titleArr;
@property (nonatomic, strong) NSArray *imageArr;
@property (nonatomic, strong) NSArray *bottomImageArr;
@property (nonatomic, strong) NSArray *bottomTitleArr;
@end

@implementation UpAndDownView

static NSInteger const advertScrollViewMaxSections = 100;

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initialization];
    [self setupSubviews];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initialization];
        [self setupSubviews];
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    if (!newSuperview) {
        [self removeTimer];
    }
}

- (void)dealloc {
    _collectionView.delegate = nil;
    _collectionView.dataSource = nil;
}

- (void)initialization {
    _scrollTimeInterval = 3.0;
    [self addTimer];
}

- (void)setupSubviews {
    UIView *tempView = [[UIView alloc] initWithFrame:CGRectZero];
    [self addSubview:tempView];
    [self addSubview:self.collectionView];
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.minimumLineSpacing = 0;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:_flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.scrollsToTop = NO;
        _collectionView.scrollEnabled = NO;
        _collectionView.pagingEnabled = YES;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:[UpAndDownCell class] forCellWithReuseIdentifier:@"UpAndDownCell"];
    }
    return _collectionView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _flowLayout.itemSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
    _collectionView.frame = self.bounds;
    
    if (self.titleArr.count > 1) {
        [self defaultSelectedScetion];
    }
}

- (void)defaultSelectedScetion {
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0.5 * advertScrollViewMaxSections] atScrollPosition:UICollectionViewScrollPositionBottom animated:NO];
}

#pragma mark - - - UICollectionView 的 dataSource、delegate方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return advertScrollViewMaxSections;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.titleArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UpAndDownCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UpAndDownCell" forIndexPath:indexPath];
    NSInteger imagesCount = self.imageArr.count;
    if (imagesCount > 0) {
        NSString *imagePath = self.imageArr[indexPath.item];
        if (imagePath == nil || [imagePath isEqualToString:@""]) { // 解决 iOS 11 无图片，控制台打印问题
            if ([imagePath hasPrefix:@"http"]) {
                [cell.signImageView sd_setImageWithURL:[NSURL URLWithString:@"www.kingsic22.com"]];
                
            } else {
                cell.signImageView.image = [UIImage imageNamed:@"kingsic"];
            }
        } else {
            if ([imagePath hasPrefix:@"http"]) {
                [cell.signImageView sd_setImageWithURL:[NSURL URLWithString:imagePath]];
                
            } else {
                cell.signImageView.image = [UIImage imageNamed:imagePath];
            }
        }
    }
    cell.titleLabel.text = self.titleArr[indexPath.item];
    cell.titleLabel.numberOfLines = 0;
    
    
    
    if (self.textAlignment) {
        cell.titleLabel.textAlignment = self.textAlignment;
    }
    if (self.titleFont) {
        cell.titleLabel.font = self.titleFont;
    }
    if (self.titleColor) {
        cell.titleLabel.textColor = self.titleColor;
    }
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate && [self.delegate respondsToSelector:@selector(advertScrollView:didSelectedItemAtIndex:)]) {
        [self.delegate advertScrollView:self didSelectedItemAtIndex:indexPath.item];
    }
}

#pragma mark - - - NSTimer
- (void)addTimer {
    [self removeTimer];
    
    self.timer = [NSTimer timerWithTimeInterval:self.scrollTimeInterval target:self selector:@selector(beginUpdateUI) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)removeTimer {
    [_timer invalidate];
    _timer = nil;
}

- (void)beginUpdateUI {
    if (self.titleArr.count == 0) return;
    
    // 1、当前正在展示的位置
    NSIndexPath *currentIndexPath = [[self.collectionView indexPathsForVisibleItems] lastObject];
    
    // 马上显示回最中间那组的数据
    NSIndexPath *resetCurrentIndexPath = [NSIndexPath indexPathForItem:currentIndexPath.item inSection:0.5 * advertScrollViewMaxSections];
    [self.collectionView scrollToItemAtIndexPath:resetCurrentIndexPath atScrollPosition:UICollectionViewScrollPositionBottom animated:NO];
    
    // 2、计算出下一个需要展示的位置
    NSInteger nextItem = resetCurrentIndexPath.item + 1;
    NSInteger nextSection = resetCurrentIndexPath.section;
    if (nextItem == self.titleArr.count) {
        nextItem = 0;
        nextSection++;
    }
    
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:nextItem inSection:nextSection];
    
    // 3、通过动画滚动到下一个位置
    [self.collectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionBottom animated:YES];
}

#pragma mark - - - setting
- (void)setSignImages:(NSArray *)signImages {
    _signImages = signImages;
    if (signImages) {
        self.imageArr = [NSArray arrayWithArray:signImages];
    }
}

- (void)setTitles:(NSArray *)titles {
    _titles = titles;
    if (titles.count > 1) {
        [self addTimer];
    } else {
        [self removeTimer];
    }
    
    self.titleArr = [NSArray arrayWithArray:titles];
    [self.collectionView reloadData];
}

- (void)setTitleFont:(UIFont *)titleFont {
    _titleFont = titleFont;
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment {
    _textAlignment = textAlignment;
}

- (void)setTopSignImages:(NSArray *)topSignImages {
    if (topSignImages) {
        self.imageArr = [NSArray arrayWithArray:topSignImages];
    }
}

- (void)setTopTitles:(NSArray *)topTitles {
    if (topTitles.count > 1) {
        [self addTimer];
    } else {
        [self removeTimer];
    }
    
    self.titleArr = [NSArray arrayWithArray:topTitles];
    [self.collectionView reloadData];
}

- (void)setBottomSignImages:(NSArray *)bottomSignImages {
    if (bottomSignImages) {
        self.bottomImageArr = [NSArray arrayWithArray:bottomSignImages];
    }
}

- (void)setBottomTitles:(NSArray *)bottomTitles {
    if (bottomTitles) {
        self.bottomTitleArr = [NSArray arrayWithArray:bottomTitles];
    }
}

- (void)setScrollTimeInterval:(CFTimeInterval)scrollTimeInterval {
    _scrollTimeInterval = scrollTimeInterval;
    if (scrollTimeInterval) {
        [self addTimer];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
