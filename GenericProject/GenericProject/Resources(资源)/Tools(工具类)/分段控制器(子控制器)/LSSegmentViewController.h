//
//  LSSegmentViewController.h
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/6/25.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSSegmentView.h"
#import "UIView+LSBadge.h"

NS_ASSUME_NONNULL_BEGIN

@interface LSSegmentViewController : UIViewController<UIScrollViewDelegate>

+ (__nullable instancetype)segmentControllerWithTitles:(NSArray <NSString *>*)titles;
- (__nullable instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles;

@property(nonatomic,strong)NSArray<UIViewController *> *viewControllers;
@property(nonatomic,strong,readonly)LSSegmentView *segmentView;
@property(nonatomic,strong,readonly)UIViewController *currentViewController;
@property(nonatomic,strong,readonly)UIScrollView *containerView;
@property(nonatomic,readonly)NSUInteger index;
@property(nonatomic,getter=isPagingEnabled)BOOL pagingEnabled;
@property(nonatomic,getter=isBounces)BOOL bounces;

/// index
- (void)selectedAtIndex:(void(^)(NSUInteger index, UIButton *button, UIViewController *viewController))indexBlock;
- (void)setSelectedAtIndex:(NSUInteger)index;

/// number badge
- (void)enumerateBadges:(NSArray <NSNumber *>*)badges;
- (void)reduceCurrentBadgeByNumber_1;
- (void)addCurrentBadgeByNumber_1;
- (void)clearCurrentBadge;
- (void)clearAllBadges;

@end

@interface UIViewController (LSSegment)

@property(nonatomic,strong,readonly,nullable)LSSegmentViewController *segmentController;

- (void)addSegmentController:(LSSegmentViewController *)segment;

@end

NS_ASSUME_NONNULL_END
