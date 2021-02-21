//
//  LSSegmentViewController.m
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/6/25.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import "LSSegmentViewController.h"

typedef NS_ENUM(NSUInteger, LSScrollRectPosition) {
    LSScrollRectPositionOrigin, // 在原始位置
    LSScrollRectPositionAcross, // 在中间段位置
    LSScrollRectPositionTarget, // 到达目标位置
};

typedef void(^LSViewControllerIndexBlock)(NSUInteger, UIButton *, UIViewController *);
typedef void(^LSScrollRectBlock)();

@interface LSSegmentViewController ()

@property(nonatomic,strong,readwrite)UIViewController *currentViewController;
@property(nonatomic,strong,readwrite)LSSegmentView *segmentView;
@property(nonatomic,strong,readwrite)UIScrollView *containerView;
@property(nonatomic,readwrite)NSUInteger index;
@property(nonatomic,strong)NSArray *titles;
@property(nonatomic,assign)CGSize size;
@property(nonatomic,assign)CGPoint viewOrigin; // 记录原始位置
@property(nonatomic,assign)CGSize offsetSize;        /**< 这个属性是用在badge上的偏移，width是_buttonSpace,height是titleLabel的y*/
@property(nonatomic, copy)LSViewControllerIndexBlock indexBlock;

@end

@implementation LSSegmentViewController

+ (instancetype)segmentControllerWithTitles:(NSArray<NSString *> *)titles {
    return [[self alloc] initWithFrame:CGRectMake(0, 0, LSScreenBounds.size.width, LSScreenBounds.size.height) titles:titles];
}

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles {
    self = [super init];
    if (!self || titles.count == 0) {
        return nil;
    }
    
    _titles = titles;
    _size = frame.size;
    _viewOrigin = frame.origin;
    _pagingEnabled = YES;
    _bounces = NO;
    self.view.frame = frame;
    
    [self segmentPageSetting];
    [self containerViewSetting];
    
    return self;
}

- (void)segmentPageSetting {
    _segmentView = [[LSSegmentView alloc] initWithFrame:CGRectMake(0, 0, _size.width, 0) titles:_titles];
    __weak typeof(self) weakSelf = self;
    [_segmentView selectedAtIndex:^(NSUInteger index, UIButton * _Nonnull button) {
        [weakSelf moveToViewControllerAtIndex:index];
    }];
    [self.view addSubview:_segmentView];
    
    UIButton *button = _segmentView.buttons.firstObject;
    _offsetSize = CGSizeMake(_segmentView.buttonSpace, (LSSegmentHeight - [@"LS" sizeWithAttributes:@{NSFontAttributeName: button.titleLabel.font}].height) / 2);
}

- (void)containerViewSetting {
    _containerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, LSSegmentHeight, _size.width, _size.height - LSSegmentHeight)];
    _containerView.backgroundColor = [UIColor whiteColor];
    _containerView.showsVerticalScrollIndicator = NO;
    _containerView.showsHorizontalScrollIndicator = NO;
    _containerView.delegate = self;
    _containerView.pagingEnabled = _pagingEnabled;
    _containerView.bounces = _bounces;
    [self.view addSubview:_containerView];
}

#pragma mark - scrollView delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == _containerView) {
        NSInteger index = round(scrollView.contentOffset.x / _size.width);
        
        // 移除不足一页的操作
        if (index != self.index) {
            [self setSelectedAtIndex:index];
        }
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView == _containerView) {
        CGFloat offsetX = scrollView.contentOffset.x;
        
        [_segmentView adjustOffsetXToFixIndicatePosition:offsetX];
    }
}

#pragma mark - index
- (void)setSelectedAtIndex:(NSUInteger)index {
    [_segmentView setSelectedAtIndex:index];
}

- (void)moveToViewControllerAtIndex:(NSUInteger)index {
    [self scrollContainerViewToIndex:index];
    
    UIViewController *targetViewController = self.viewControllers[index];
    if ([self.childViewControllers containsObject:targetViewController] || !targetViewController) {
        return;
    }
    
    [self updateFrameChildViewController:targetViewController atIndex:index];
}

- (void)selectedAtIndex:(void (^)(NSUInteger, UIButton * _Nonnull, UIViewController * _Nonnull))indexBlock {
    if (indexBlock) {
        _indexBlock = indexBlock;
    }
}

- (void)updateFrameChildViewController:(UIViewController *)childViewController atIndex:(NSUInteger)index {
    childViewController.view.frame = CGRectOffset(CGRectMake(0, 0, _containerView.frame.size.width, _containerView.frame.size.height), index * _size.width, 0);
    
    [_containerView addSubview:childViewController.view];
    [self addChildViewController:childViewController];
}

#pragma mark - scroll
- (void)scrollContainerViewToIndex:(NSUInteger)index {
    [UIView animateWithDuration:_segmentView.duration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [_containerView setContentOffset:CGPointMake(index * _size.width, 0)];
    } completion:^(BOOL finished) {
        if (_indexBlock) {
            _indexBlock(index, _segmentView.selectedButton, self.currentViewController);
        }
    }];
}

#pragma mark - set
- (void)setViewControllers:(NSArray *)viewControllers {
    _viewControllers = viewControllers;
    _containerView.contentSize = CGSizeMake(viewControllers.count * _size.width, _size.height - LSSegmentHeight);
}

- (void)setPagingEnabled:(BOOL)pagingEnabled {
    _pagingEnabled = pagingEnabled;
    
    self.containerView.pagingEnabled = pagingEnabled;
}

- (void)setBounces:(BOOL)bounces {
    _bounces = bounces;
    
    self.containerView.bounces = bounces;
}

#pragma mark - get
- (NSUInteger)index {
    return self.segmentView.index;
}

- (UIViewController *)currentViewController {
    return self.viewControllers[self.index];
}

#pragma mark - #! 分类(UIView)
- (void)enumerateBadges:(NSArray<NSNumber *> *)badges {
    [badges enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *button = self.segmentView.buttons[idx];
        [button addNumberBadge:obj.integerValue badgeOffsetSize:_offsetSize color:_segmentView.segmentTintColor borderColor:_segmentView.backgroundColor];
    }];
}

- (void)addCurrentBadgeByNumber_1 {
    [self.segmentView.selectedButton addNumber_1];
}

- (void)reduceCurrentBadgeByNumber_1 {
    [self.segmentView.selectedButton reduceNumber_1];
}

- (void)clearAllBadges {
    [_segmentView.buttons enumerateObjectsUsingBlock:^(UIButton *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj clearNumberBadge];
    }];
}

- (void)clearCurrentBadge {
    [self.segmentView.selectedButton clearNumberBadge];
}

@end

#pragma mark - #! 分类(UIViewController)
#import <objc/runtime.h>

@implementation UIViewController(LSSegment)
@dynamic segmentController;

- (LSSegmentViewController *)segmentController {
    if ([self.parentViewController isKindOfClass:[LSSegmentViewController class]] && self.parentViewController) {
        return (LSSegmentViewController *)self.parentViewController;
    }
    return nil;
}

- (void)addSegmentController:(LSSegmentViewController *)segment {
    if (self == segment) {
        return;
    }
    
    [self.view addSubview:segment.view];
    [self addChildViewController:segment];
    
    // 默认加入第一个控制器
    UIViewController *firstViewController = segment.viewControllers.firstObject;
    [segment performSelector:@selector(updateFrameChildViewController:atIndex:) withObject:firstViewController withObject:0];
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
