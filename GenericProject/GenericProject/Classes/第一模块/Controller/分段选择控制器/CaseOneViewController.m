//
//  CaseOneViewController.m
//  GenericProject
//
//  Created by 社科赛斯 on 2020/1/9.
//  Copyright © 2020 漠然丶情到深处. All rights reserved.
//

#import "CaseOneViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThidViewController.h"
#import "LSPageMenu.h"
#import "JSBadgeView.h"

#define NaviH (LSScreenHeight >= 812 ? 88 : 64) // 812是iPhoneX的高度
#define scrollViewHeight (LSScreenHeight-NaviH-40)

@interface CaseOneViewController ()<LSPageMenuDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, weak) LSPageMenu *pageMenu;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *myChildViewControllers;

@end

@implementation CaseOneViewController

// 示例1:LSPageMenuTrackerStyleLine,下划线样式
- (void)test1 {
    self.dataArr = @[@"生活",@"影视中心",@"交通",@"电视剧",@"搞笑",@"综艺"];

    // trackerStyle:跟踪器的样式
    LSPageMenu *pageMenu = [LSPageMenu pageMenuWithFrame:CGRectMake(0, NaviH, LSScreenWidth, 40) trackerStyle:LSPageMenuTrackerStyleLine];
    // 传递数组，默认选中第2个
    [pageMenu setItems:self.dataArr selectedItemIndex:0];
    // 设置代理
    pageMenu.delegate = self;
    // 给pageMenu传递外界的大scrollView，内部监听self.scrollView的滚动，从而实现让跟踪器跟随self.scrollView移动的效果
    pageMenu.bridgeScrollView = self.scrollView;
    [self.view addSubview:pageMenu];
    _pageMenu = pageMenu;
}

// 示例2:LSPageMenuTrackerStyleLineLongerThanItem,下划线比item略长，长度等于tem宽＋间距
// 这个例子采用自动布局
- (void)test2 {
    self.dataArr = @[@"生活",@"影视中心",@"交通",@"电视剧",@"搞笑",@"综艺"];
    
    // trackerStyle:跟踪器的样式
    LSPageMenu *pageMenu = [LSPageMenu pageMenuWithFrame:CGRectZero trackerStyle:LSPageMenuTrackerStyleLineLongerThanItem];
    pageMenu.translatesAutoresizingMaskIntoConstraints = NO;
    // 传递数组，默认选中第1个
    [pageMenu setItems:self.dataArr selectedItemIndex:0];
    // 设置代理
    pageMenu.delegate = self;
    // 给pageMenu传递外界的大scrollView，内部监听self.scrollView的滚动，从而实现让跟踪器跟随self.scrollView移动的效果
    pageMenu.bridgeScrollView = self.scrollView;
    [self.view addSubview:pageMenu];
    
    NSMutableArray *contraints = [NSMutableArray array];
    [contraints addObject:[NSLayoutConstraint constraintWithItem:pageMenu attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:NaviH]];
    [contraints addObject:[NSLayoutConstraint constraintWithItem:pageMenu attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40]];
    [contraints addObject:[NSLayoutConstraint constraintWithItem:pageMenu attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0]];
    [contraints addObject:[NSLayoutConstraint constraintWithItem:pageMenu attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0]];
    [self.view addConstraints:contraints];
  
    _pageMenu = pageMenu;
}

// 示例3:LSPageMenuTrackerStyleLineAttachment,下划线依恋样式，当滑动底下装载控制器的scrollView时，该下划线会有阻尼效果
- (void)test3 {
    self.dataArr = @[@"生活",@"影视中心",@"交通",@"电视剧",@"搞笑",@"综艺"];
    
    // trackerStyle:跟踪器的样式
    LSPageMenu *pageMenu = [LSPageMenu pageMenuWithFrame:CGRectMake(0, NaviH, LSScreenWidth, 40) trackerStyle:LSPageMenuTrackerStyleLineAttachment];
    // 传递数组，默认选中第2个
    [pageMenu setItems:self.dataArr selectedItemIndex:1];
    // 设置代理
    pageMenu.delegate = self;
    // 给pageMenu传递外界的大scrollView，内部监听self.scrollView的滚动，从而实现让跟踪器跟随self.scrollView移动的效果
    pageMenu.bridgeScrollView = self.scrollView;
    [self.view addSubview:pageMenu];
    _pageMenu = pageMenu;
}

// 示例4:LSPageMenuTrackerStyleTextZoom、LSPageMenuTrackerStyleNothing,缩放
- (void)test4 {
    self.dataArr = @[@"生活",@"影视中心",@"交通",@"电视剧",@"搞笑",@"综艺"];
    
    // trackerStyle:跟踪器的样式
    LSPageMenu *pageMenu = [LSPageMenu pageMenuWithFrame:CGRectMake(0, NaviH, LSScreenWidth, 40) trackerStyle:LSPageMenuTrackerStyleNothing];
    // 传递数组，默认选中第1个
    [pageMenu setItems:self.dataArr selectedItemIndex:0];
    // 设置缩放
    pageMenu.selectedItemZoomScale = 1.3;
    // 设置代理
    pageMenu.delegate = self;
    // 给pageMenu传递外界的大scrollView，内部监听self.scrollView的滚动，从而实现让跟踪器跟随self.scrollView移动的效果
    pageMenu.bridgeScrollView = self.scrollView;

    [self.view addSubview:pageMenu];
    _pageMenu = pageMenu;
}

// 示例5:LSPageMenuTrackerStyleRoundedRect,圆角矩形
- (void)test5 {
    self.dataArr = @[@"生活",@"影视中心",@"交通",@"电视剧",@"搞笑",@"综艺"];
    
    // trackerStyle:跟踪器的样式
    LSPageMenu *pageMenu = [LSPageMenu pageMenuWithFrame:CGRectMake(0, NaviH, LSScreenWidth, 40) trackerStyle:LSPageMenuTrackerStyleRoundedRect];
    // 传递数组，默认选中第1个
    [pageMenu setItems:self.dataArr selectedItemIndex:0];
    pageMenu.tracker.backgroundColor = [UIColor redColor];
    // 设置代理
    pageMenu.delegate = self;
    // 给pageMenu传递外界的大scrollView，内部监听self.scrollView的滚动，从而实现让跟踪器跟随self.scrollView移动的效果
    pageMenu.bridgeScrollView = self.scrollView;
    [self.view addSubview:pageMenu];
    _pageMenu = pageMenu;
}

// 示例6:LSPageMenuTrackerStyleRoundedRect,圆角矩形（与pageMenu同时圆角）
- (void)test6 {
    self.dataArr = @[@"生活",@"影视中心",@"交通"];

    // trackerStyle:跟踪器的样式
    LSPageMenu *pageMenu = [LSPageMenu pageMenuWithFrame:CGRectMake(15, NaviH, LSScreenWidth-30, 40) trackerStyle:LSPageMenuTrackerStyleRoundedRect];
    // 设置pageMenu边框
    pageMenu.layer.borderWidth = 1;
    pageMenu.layer.borderColor = [UIColor redColor].CGColor;
    pageMenu.layer.cornerRadius = 40 * 0.5;
    // 传递数组，默认选中第1个
    [pageMenu setItems:self.dataArr selectedItemIndex:0];
    pageMenu.unSelectedItemTitleColor = [UIColor redColor];
    // 设置跟踪器的颜色
    pageMenu.tracker.backgroundColor = [UIColor redColor];
    // 设置跟踪器的高度，与pageMenu同高，这样半径就可以跟pageMenu的圆角半径一致，实际上这里设置的半径是无效的，圆角矩形内部会根据高度自动设置圆角
    [pageMenu setTrackerHeight:40 cornerRadius:40*0.5];
    // 排列方式
    pageMenu.permutationWay = LSPageMenuPermutationWayNotScrollAdaptContent;
    pageMenu.dividingLine.hidden = YES;

    // 设置代理
    pageMenu.delegate = self;
    // 给pageMenu传递外界的大scrollView，内部监听self.scrollView的滚动，从而实现让跟踪器跟随self.scrollView移动的效果
    pageMenu.bridgeScrollView = self.scrollView;
    [self.view addSubview:pageMenu];
    _pageMenu = pageMenu;
}

// 示例7:LSPageMenuTrackerStyleRect,矩形

- (void)test7{
    self.dataArr = @[@"生活",@"影视中心",@"交通",@"电视剧",@"搞笑",@"综艺"];
    
    // trackerStyle:跟踪器的样式
    LSPageMenu *pageMenu = [LSPageMenu pageMenuWithFrame:CGRectMake(0, NaviH, LSScreenWidth, 40) trackerStyle:LSPageMenuTrackerStyleRect];
    // 传递数组，默认选中第2个
    [pageMenu setItems:self.dataArr selectedItemIndex:1];
    // 设置代理
    pageMenu.delegate = self;
    // 给pageMenu传递外界的大scrollView，内部监听self.scrollView的滚动，从而实现让跟踪器跟随self.scrollView移动的效果
    pageMenu.bridgeScrollView = self.scrollView;
    [self.view addSubview:pageMenu];
    _pageMenu = pageMenu;
}

// 示例8:无样式
- (void)test8 {
    self.dataArr = @[@"生活",@"影视中心",@"交通",@"电视剧",@"搞笑",@"综艺"];

    // trackerStyle:跟踪器的样式
    LSPageMenu *pageMenu = [LSPageMenu pageMenuWithFrame:CGRectMake(0, NaviH, LSScreenWidth, 40) trackerStyle:LSPageMenuTrackerStyleNothing];
    // 传递数组，默认选中第2个
    [pageMenu setItems:self.dataArr selectedItemIndex:1];
    // 设置代理
    pageMenu.delegate = self;
    // 给pageMenu传递外界的大scrollView，内部监听self.scrollView的滚动，从而实现让跟踪器跟随self.scrollView移动的效果
    pageMenu.bridgeScrollView = self.scrollView;
    [self.view addSubview:pageMenu];
    _pageMenu = pageMenu;
}

// 示例9:可滑动的自适应内容排列，关键代码:pageMenu.permutationWay = LSPageMenuPermutationWayScrollAdaptContent;
- (void)test9 {
    self.dataArr = @[@"生活",@"影视中心",@"交通",@"电视剧",@"搞笑",@"综艺"];
    
    // trackerStyle:跟踪器的样式
    LSPageMenu *pageMenu = [LSPageMenu pageMenuWithFrame:CGRectMake(0, NaviH, LSScreenWidth, 40) trackerStyle:LSPageMenuTrackerStyleLine];
    // 传递数组，默认选中第2个
    [pageMenu setItems:self.dataArr selectedItemIndex:1];
    // 可滑动的自适应内容排列
    pageMenu.permutationWay = LSPageMenuPermutationWayScrollAdaptContent;
    // 设置代理
    pageMenu.delegate = self;
    // 给pageMenu传递外界的大scrollView，内部监听self.scrollView的滚动，从而实现让跟踪器跟随self.scrollView移动的效果
    pageMenu.bridgeScrollView = self.scrollView;
    [self.view addSubview:pageMenu];
    _pageMenu = pageMenu;
}

// 示例10:不可滑动的等宽排列，关键代码:pageMenu.permutationWay = LSPageMenuPermutationWayNotScrollEqualWidths;
- (void)test10 {
    self.dataArr = @[@"生活",@"影视中心",@"交通规则"];
    
    // trackerStyle:跟踪器的样式
    LSPageMenu *pageMenu = [LSPageMenu pageMenuWithFrame:CGRectMake(0, NaviH, LSScreenWidth, 40) trackerStyle:LSPageMenuTrackerStyleLine];
    // 传递数组，默认选中第2个
    [pageMenu setItems:self.dataArr selectedItemIndex:1];
    // 不可滑动的等宽排列
    pageMenu.permutationWay = LSPageMenuPermutationWayNotScrollEqualWidths;
    pageMenu.trackerWidth = 20;
    // 设置代理
    pageMenu.delegate = self;
    // 给pageMenu传递外界的大scrollView，内部监听self.scrollView的滚动，从而实现让跟踪器跟随self.scrollView移动的效果
    pageMenu.bridgeScrollView = self.scrollView;
    [self.view addSubview:pageMenu];
    _pageMenu = pageMenu;
}

// 示例11:不可滑动的自适应内容排列，关键代码:pageMenu.permutationWay = LSPageMenuPermutationWayNotScrollAdaptContent;
// 这种排列方式下,itemPadding属性无效，因为内部自动计算间距
- (void)test11 {
    self.dataArr = @[@"生活",@"音乐榜中榜",@"交通规则"];
    
    // trackerStyle:跟踪器的样式
    LSPageMenu *pageMenu = [LSPageMenu pageMenuWithFrame:CGRectMake(0, NaviH, LSScreenWidth, 40) trackerStyle:LSPageMenuTrackerStyleLine];
    // 传递数组，默认选中第2个
    [pageMenu setItems:self.dataArr selectedItemIndex:1];
    // 不可滑动的自适应内容排列
    pageMenu.permutationWay = LSPageMenuPermutationWayNotScrollAdaptContent;
    // 设置代理
    pageMenu.delegate = self;
    // 给pageMenu传递外界的大scrollView，内部监听self.scrollView的滚动，从而实现让跟踪器跟随self.scrollView移动的效果
    pageMenu.bridgeScrollView = self.scrollView;
    [self.view addSubview:pageMenu];
    _pageMenu = pageMenu;
}

// 示例12:跟踪器时刻跟随外界scrollView移动
- (void)test12 {
    self.dataArr = @[@"生活",@"影视中心",@"交通",@"电视剧",@"军事",@"综艺"];

    // trackerStyle:跟踪器的样式
    LSPageMenu *pageMenu = [LSPageMenu pageMenuWithFrame:CGRectMake(0, NaviH, LSScreenWidth, 40) trackerStyle:LSPageMenuTrackerStyleLine];
    // 传递数组，默认选中第2个
    [pageMenu setItems:self.dataArr selectedItemIndex:0];
    pageMenu.trackerFollowingMode = LSPageMenuTrackerFollowingModeAlways;
    // 设置代理
    pageMenu.delegate = self;
    // 给pageMenu传递外界的大scrollView，内部监听self.scrollView的滚动，从而实现让跟踪器跟随self.scrollView移动的效果
    pageMenu.bridgeScrollView = self.scrollView;
    [self.view addSubview:pageMenu];
    _pageMenu = pageMenu;
}

// 示例13:外界scrollVie拖动结束后，跟踪器才开始移动
- (void)test13 {
    self.dataArr = @[@"生活",@"影视中心",@"交通",@"电视剧",@"军事",@"综艺"];

    // trackerStyle:跟踪器的样式
    LSPageMenu *pageMenu = [LSPageMenu pageMenuWithFrame:CGRectMake(0, NaviH, LSScreenWidth, 40) trackerStyle:LSPageMenuTrackerStyleLine];
    // 传递数组，默认选中第2个
    [pageMenu setItems:self.dataArr selectedItemIndex:0];
    pageMenu.trackerFollowingMode = LSPageMenuTrackerFollowingModeEnd;
    // 设置代理
    pageMenu.delegate = self;
    // 给pageMenu传递外界的大scrollView，内部监听self.scrollView的滚动，从而实现让跟踪器跟随self.scrollView移动的效果
    pageMenu.bridgeScrollView = self.scrollView;
    [self.view addSubview:pageMenu];
    _pageMenu = pageMenu;
}

// 示例14:外界scrollView拖动距离超过屏幕一半时，跟踪器开始移动
- (void)test14 {
    self.dataArr = @[@"生活",@"影视中心",@"交通",@"电视剧",@"军事",@"综艺"];

    // trackerStyle:跟踪器的样式
    LSPageMenu *pageMenu = [LSPageMenu pageMenuWithFrame:CGRectMake(0, NaviH, LSScreenWidth, 40) trackerStyle:LSPageMenuTrackerStyleLine];
    // 传递数组，默认选中第2个
    [pageMenu setItems:self.dataArr selectedItemIndex:0];
    pageMenu.trackerFollowingMode = LSPageMenuTrackerFollowingModeHalf;
    // 设置代理
    pageMenu.delegate = self;
    // 给pageMenu传递外界的大scrollView，内部监听self.scrollView的滚动，从而实现让跟踪器跟随self.scrollView移动的效果
    pageMenu.bridgeScrollView = self.scrollView;
    [self.view addSubview:pageMenu];
    _pageMenu = pageMenu;
}

// 示例15:显示功能按钮
- (void)test15 {
    self.dataArr = @[@"生活",@"影视中心",@"交通",@"电视剧",@"军事",@"综艺"];
    
    // trackerStyle:跟踪器的样式
    LSPageMenu *pageMenu = [LSPageMenu pageMenuWithFrame:CGRectMake(0, NaviH, LSScreenWidth, 40) trackerStyle:LSPageMenuTrackerStyleLine];
    // 传递数组，默认选中第2个
    [pageMenu setItems:self.dataArr selectedItemIndex:0];
    pageMenu.showFuntionButton = YES;
    // 设置代理
    pageMenu.delegate = self;
    // 给pageMenu传递外界的大scrollView，内部监听self.scrollView的滚动，从而实现让跟踪器跟随self.scrollView移动的效果
    pageMenu.bridgeScrollView = self.scrollView;
    [self.view addSubview:pageMenu];
    _pageMenu = pageMenu;
}

// 示例16:给功能按钮设置图片和文字
- (void)test16 {
    self.dataArr = @[@"生活",@"娱乐",@"交通"];
    
    // trackerStyle:跟踪器的样式
    LSPageMenu *pageMenu = [LSPageMenu pageMenuWithFrame:CGRectMake(0, NaviH, LSScreenWidth, 40) trackerStyle:LSPageMenuTrackerStyleLine];
    // 传递数组，默认选中第2个
    [pageMenu setItems:self.dataArr selectedItemIndex:1];
    // 同时设置图片和文字，如果只想要文字，image传nil，如果只想要图片，title传nil，imagePosition和ratio传0即可
    [pageMenu setFunctionButtonContent:[LSPageMenuButtonItem itemWithTitle:@"更多" image:[UIImage imageNamed:@"Expression_1"] imagePosition:LSItemImagePositionTop] forState:UIControlStateNormal];
    [pageMenu setFunctionButtonTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} forState:UIControlStateNormal];
    pageMenu.showFuntionButton = YES;
    // 设置代理
    pageMenu.delegate = self;
    // 给pageMenu传递外界的大scrollView，内部监听self.scrollView的滚动，从而实现让跟踪器跟随self.scrollView移动的效果
    pageMenu.bridgeScrollView = self.scrollView;
    [self.view addSubview:pageMenu];
    _pageMenu = pageMenu;
}

// 示例17:含有图片的按钮
- (void)test17 {
    self.dataArr = @[@"生活",[UIImage imageNamed:@"Expression_1"],@"交通",[UIImage imageNamed:@"Expression_2"],@"搞笑",@"综艺"];
    LSPageMenu *pageMenu = [LSPageMenu pageMenuWithFrame:CGRectMake(0, NaviH, LSScreenWidth, 40) trackerStyle:LSPageMenuTrackerStyleLineLongerThanItem];
    // 传递数组，默认选中第2个
    [pageMenu setItems:self.dataArr selectedItemIndex:1];
    pageMenu.delegate = self;
    // 给pageMenu传递外界的大scrollView，内部监听self.scrollView的滚动，从而实现让跟踪器跟随self.scrollView移动的效果
    pageMenu.bridgeScrollView = self.scrollView;
    [self.view addSubview:pageMenu];

    _pageMenu = pageMenu;
}

// 示例18:指定按钮携带图片,或同时携带图片和文字,可以设置图片的位置和图文间距
- (void)test18 {
    self.dataArr = @[@"生活",@"影视中心",@"交通",@"电视剧",@"搞笑",@"综艺"];

    LSPageMenu *pageMenu = [LSPageMenu pageMenuWithFrame:CGRectMake(0, NaviH, LSScreenWidth, 40) trackerStyle:LSPageMenuTrackerStyleRect];
    // 传递数组，默认选中第1个
    [pageMenu setItems:self.dataArr selectedItemIndex:0];
    // 指定第1个item为图片
    [pageMenu setImage:[UIImage imageNamed:@"Expression_1"] forItemAtIndex:0];
    // 指定第2个item同时含有图片和文字，图片在上
    LSPageMenuButtonItem *item1 = [LSPageMenuButtonItem itemWithTitle:@"害羞" image:[UIImage imageNamed:@"Expression_2"]];
    item1.imagePosition = LSItemImagePositionTop;
    [pageMenu setItem:item1 forItemAtIndex:1];
    // 指定第4个item同时含有图片和文字，图片在右
//    [pageMenu setTitle:@"可爱的小狗" image:[UIImage imageNamed:@"dog"] imagePosition:SPItemImagePositionDefault imageRatio:0.4 imageTitleSpace:0 forItemIndex:3];
    LSPageMenuButtonItem *item2 = [LSPageMenuButtonItem itemWithTitle:@"歌曲" image:[UIImage imageNamed:@"asc"] imagePosition:LSItemImagePositionRight];
    [pageMenu setItem:item2 forItemAtIndex:3];
    pageMenu.delegate = self;
    // 给pageMenu传递外界的大scrollView，内部监听self.scrollView的滚动，从而实现让跟踪器跟随self.scrollView移动的效果
    pageMenu.bridgeScrollView = self.scrollView;
    [self.view addSubview:pageMenu];
    _pageMenu = pageMenu;
}

// 示例19:设置背景图片
- (void)test19 {
    self.dataArr = @[@"生活",@"校园",@"交通",@"军事",@"搞笑",@"综艺"];

    LSPageMenu *pageMenu = [LSPageMenu pageMenuWithFrame:CGRectMake(0, NaviH, LSScreenWidth, 40) trackerStyle:LSPageMenuTrackerStyleNothing];
    // 传递数组，默认选中第2个
    [pageMenu setItems:self.dataArr selectedItemIndex:1];
    pageMenu.selectedItemTitleColor = [UIColor whiteColor];
    pageMenu.unSelectedItemTitleColor = [UIColor whiteColor];
    pageMenu.selectedItemZoomScale = 1.5;
    pageMenu.delegate = self;
    // 给pageMenu传递外界的大scrollView，内部监听self.scrollView的滚动，从而实现让跟踪器跟随self.scrollView移动的效果
    pageMenu.bridgeScrollView = self.scrollView;

    UIImage *image = [UIImage imageNamed:@"mateor.jpg"];
    [pageMenu setBackgroundImage:image barMetrics:0];

    [self.view addSubview:pageMenu];

    _pageMenu = pageMenu;
}

// 示例20:某个按钮上添加一个副标题
- (void)test20 {
    self.dataArr = @[@"点菜",@"评论",@"商家",@"已购"];
    
    LSPageMenu *pageMenu = [LSPageMenu pageMenuWithFrame:CGRectMake(0, NaviH, LSScreenWidth, 40) trackerStyle:LSPageMenuTrackerStyleLineAttachment];
    // 传递数组，默认选中第2个
    [pageMenu setItems:self.dataArr selectedItemIndex:0];
    pageMenu.itemTitleFont = [UIFont  boldSystemFontOfSize:17];
    pageMenu.selectedItemTitleColor = [UIColor blackColor];
    pageMenu.unSelectedItemTitleColor = [UIColor grayColor];
    pageMenu.trackerWidth = 20;
    // 设置第一个按钮后面的自定义间距为60，增大第一个和第二个按钮之间的间距，腾出空间方便在第一个按钮的后面放置一个副标题
    [pageMenu setCustomSpacing:60 afterItemAtIndex:1];
    pageMenu.delegate = self;
    pageMenu.permutationWay = LSPageMenuPermutationWayNotScrollEqualWidths;
    // 给pageMenu传递外界的大scrollView，内部监听self.scrollView的滚动，从而实现让跟踪器跟随self.scrollView移动的效果
    pageMenu.bridgeScrollView = self.scrollView;
    [self.view addSubview:pageMenu];
    _pageMenu = pageMenu;
    
    // 获取第1个item上文字相对pageMenu的位置大小
    CGRect titleRect = [pageMenu titleRectRelativeToPageMenuForItemAtIndex:1];
    
    UILabel *detailLabel = [[UILabel alloc] init];
    detailLabel.text = @"8384";
    detailLabel.font = [UIFont systemFontOfSize:11];
    detailLabel.textColor = [UIColor lightGrayColor];
    detailLabel.frame = CGRectMake(CGRectGetMaxX(titleRect),CGRectGetMaxY(titleRect)-16, 50, 16);
    [pageMenu addComponentViewInScrollView:detailLabel];
}

// 示例21:给指定按钮加角标
- (void)test21 {
    self.dataArr = @[@"生活",@"军事",@"水木年华",@"综艺"];

    LSPageMenu *pageMenu = [LSPageMenu pageMenuWithFrame:CGRectMake(0, NaviH, LSScreenWidth, 40) trackerStyle:LSPageMenuTrackerStyleNothing];
    // 传递数组，默认选中第2个
    [pageMenu setItems:self.dataArr selectedItemIndex:1];
    pageMenu.delegate = self;
    pageMenu.permutationWay = LSPageMenuPermutationWayNotScrollAdaptContent;
    // 给pageMenu传递外界的大scrollView，内部监听self.scrollView的滚动，从而实现让跟踪器跟随self.scrollView移动的效果
    pageMenu.bridgeScrollView = self.scrollView;

    // 这里通过KVC的形式取出按钮数组，再通过下标获取指定的按钮。本框架没有特别提供返回指定按钮的方法，因为按钮是不能返回的，一旦返回，该按钮的属性就可以被外界轻松地任意修改，这是一个框架该考虑的安全问题。如果专门提供一个设置角标的方法，那么角标的样式又可以自定义，角标并非本框架的核心功能，所以没必要因为它将框架搞得过于臃肿。
    NSArray *buttons = [pageMenu valueForKey:@"_buttons"];
    UIButton *button0 = [buttons objectAtIndex:0];
    JSBadgeView *badgeView0 = [[JSBadgeView alloc] initWithParentView:button0.titleLabel alignment:JSBadgeViewAlignmentTopRight];
    badgeView0.badgePositionAdjustment = CGPointMake(10, 0);
    badgeView0.badgeBackgroundColor = [UIColor redColor];
    badgeView0.badgeOverlayColor = [UIColor clearColor];
    badgeView0.badgeStrokeColor = [UIColor redColor];
    badgeView0.badgeText = @"3";

    UIButton *button1 = [buttons objectAtIndex:2];
    JSBadgeView *badgeView2 = [[JSBadgeView alloc] initWithParentView:button1.titleLabel alignment:JSBadgeViewAlignmentTopRight];
    badgeView2.badgePositionAdjustment = CGPointMake(10, 0);
    badgeView2.badgeBackgroundColor = [UIColor whiteColor];
    badgeView2.badgeOverlayColor = [UIColor clearColor];
    badgeView2.badgeStrokeColor = [UIColor redColor];
    badgeView2.badgeTextColor = [UIColor redColor];
    badgeView2.badgeMinWidth = 1.0 / [UIScreen mainScreen].scale;
    badgeView2.badgeText = @"99";

    [self.view addSubview:pageMenu];

    _pageMenu = pageMenu;
}

// ------------------------------------------------------------------------------------------------

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    switch (_testNumber) {
        case 0:
            [self test1];
            break;
        case 1:
            [self test2];
            break;
        case 2:
            [self test3];
            break;
        case 3:
            [self test4];
            break;
        case 4:
            [self test5];
            break;
        case 5:
            [self test6];
            break;
        case 6:
            [self test7];
            break;
        case 7:
            [self test8];
            break;
        case 8:
            [self test9];
            break;
        case 9:
            [self test10];
            break;
        case 10:
            [self test11];
            break;
        case 11:
            [self test12];
            break;
        case 12:
            [self test13];
            break;
        case 13:
            [self test14];
            break;
        case 14:
            [self test15];
            break;
        case 15:
            [self test16];
            break;
        case 16:
            [self test17];
            break;
        case 17:
            [self test18];
            break;
        case 18:
            [self test19];
            break;
        case 19:
            [self test20];
            break;
        case 20:
            [self test21];
            break;
    }
    
    [self.view addSubview:self.scrollView];
    
    FirstViewController *FirstVC = [[FirstViewController alloc]init];
    SecondViewController *SecondVC = [[SecondViewController alloc]init];
    ThidViewController *ThidVC = [[ThidViewController alloc]init];
    
    [self.myChildViewControllers addObject:FirstVC];
    [self.myChildViewControllers addObject:SecondVC];
    [self.myChildViewControllers addObject:ThidVC];
    
    if (self.pageMenu.selectedItemIndex < self.myChildViewControllers.count) {
        LSBaseViewController *baseVc = self.myChildViewControllers[self.pageMenu.selectedItemIndex];
        [self.scrollView addSubview:baseVc.view];
        baseVc.view.frame = CGRectMake(LSScreenWidth*self.pageMenu.selectedItemIndex, 0, LSScreenWidth, scrollViewHeight);
        self.scrollView .contentOffset = CGPointMake(LSScreenWidth*self.pageMenu.selectedItemIndex, 0);
        self.scrollView .contentSize = CGSizeMake(self.dataArr.count*LSScreenWidth, 0);
    }
}

- (void)pageMenu:(LSPageMenu *)pageMenu itemSelectedAtIndex:(NSInteger)index {
    NSLog(@"%zd",index);
}

- (void)pageMenu:(LSPageMenu *)pageMenu itemSelectedFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    NSLog(@"%zd------->%zd",fromIndex,toIndex);

    // 如果该代理方法是由拖拽self.scrollView而触发，说明self.scrollView已经在用户手指的拖拽下而发生偏移，此时不需要再用代码去设置偏移量，否则在跟踪模式为SPPageMenuTrackerFollowingModeHalf的情况下，滑到屏幕一半时会有闪跳现象。闪跳是因为外界设置的scrollView偏移和用户拖拽产生冲突
    if (!self.scrollView.isDragging) { // 判断用户是否在拖拽scrollView
        // 如果fromIndex与toIndex之差大于等于2,说明跨界面移动了,此时不动画.
        if (labs(toIndex - fromIndex) >= 2) {
            [self.scrollView setContentOffset:CGPointMake(LSScreenWidth * toIndex, 0) animated:NO];
        } else {
            [self.scrollView setContentOffset:CGPointMake(LSScreenWidth * toIndex, 0) animated:YES];
        }
    }

    if (self.myChildViewControllers.count <= toIndex) {return;}

    UIViewController *targetViewController = self.myChildViewControllers[toIndex];
    // 如果已经加载过，就不再加载
    if ([targetViewController isViewLoaded]) return;

    targetViewController.view.frame = CGRectMake(LSScreenWidth * toIndex, 0, LSScreenWidth, scrollViewHeight);
    [_scrollView addSubview:targetViewController.view];

}

- (void)pageMenu:(LSPageMenu *)pageMenu functionButtonClicked:(UIButton *)functionButton {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"插入一个带标题的item" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self insertItemWithObject:@"十九大" toIndex:0];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"插入一个带图片的item" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self insertItemWithObject:[UIImage imageNamed:@"Expression_1"] toIndex:0];
    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"删除一个item" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self removeItemAtIndex:0];
    }];
    UIAlertAction *action4 = [UIAlertAction actionWithTitle:@"删除所有item" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self removeAllItems];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:action1];
    [alertController addAction:action2];
    [alertController addAction:action3];
    [alertController addAction:action4];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - insert or remove

// object是插入的对象(NSString、UIImage或SPPageMenuButtonItem),insertNumber是插入到第几个
- (void)insertItemWithObject:(id)object toIndex:(NSInteger)insertNumber {
    if (insertNumber > self.myChildViewControllers.count) return;
    // 插入之前，先将新控制器之后的控制器view往后偏移
    for (int i = 0; i < self.myChildViewControllers.count; i++) {
        if (i >= insertNumber) {
            UIViewController *childController = self.myChildViewControllers[i];
            childController.view.frame = CGRectMake(LSScreenWidth * (i+1), 0, LSScreenWidth, scrollViewHeight);
            [self.scrollView addSubview:childController.view];
        }
    }
    if (insertNumber <= self.pageMenu.selectedItemIndex && self.myChildViewControllers.count) { // 如果新插入的item在当前选中的item之前
        // scrollView往后偏移
        self.scrollView.contentOffset = CGPointMake(LSScreenWidth*(self.pageMenu.selectedItemIndex+1), 0);
    } else {
        self.scrollView.contentOffset = CGPointMake(0, 0);
    }

    // 要先添加控制器，再添加item，如果先添加item，会立即调代理方法，此时myChildViewControllers的个数还是0，在代理方法中retun了
    if ([object isKindOfClass:[NSString class]]) {
        [self.pageMenu insertItemWithTitle:object atIndex:insertNumber animated:YES];
    } else if([object isKindOfClass:[UIImage class]]) {
        [self.pageMenu insertItemWithImage:object atIndex:insertNumber animated:YES];
    } else {
        [self.pageMenu insertItem:object atIndex:insertNumber animated:YES];
    }
    
    // 重新设置scrollView容量
    self.scrollView.contentSize = CGSizeMake(LSScreenWidth*self.myChildViewControllers.count, 0);
}

- (void)removeItemAtIndex:(NSInteger)index {
    // 示例中index给的是1，所以当只剩下一个子控制器时，会走该if语句，无法继续删除
    if (index >= self.myChildViewControllers.count) {
        return;
    }
    
    [self.pageMenu removeItemAtIndex:index animated:YES];
    
    // 删除之前，先将新控制器之后的控制器view往前偏移
    for (int i = 0; i < self.myChildViewControllers.count; i++) {
        if (i >= index) {
            UIViewController *childController = self.myChildViewControllers[i];
            childController.view.frame = CGRectMake(LSScreenWidth * (i>0?(i-1):i), 0, LSScreenWidth, scrollViewHeight);
            [self.scrollView addSubview:childController.view];
        }
    }
    if (index <= self.pageMenu.selectedItemIndex) { // 移除的item在当前选中的item之前
        // scrollView往前偏移
        NSInteger offsetIndex = self.pageMenu.selectedItemIndex-1;
        if (offsetIndex < 0) {
            offsetIndex = 0;
        }
        self.scrollView.contentOffset = CGPointMake(LSScreenWidth*offsetIndex, 0);
    }
    
    UIViewController *vc = [self.myChildViewControllers objectAtIndex:index];
    [self.myChildViewControllers removeObjectAtIndex:index];
    [vc removeFromParentViewController];
    [vc.view removeFromSuperview];
    
    // 重新设置scrollView容量
    self.scrollView.contentSize = CGSizeMake(LSScreenWidth*self.myChildViewControllers.count, 0);
}

- (void)removeAllItems {
    [self.pageMenu removeAllItems];
    for (UIViewController *vc in self.myChildViewControllers) {
        [vc removeFromParentViewController];
        [vc.view removeFromSuperview];
    }
    [self.myChildViewControllers removeAllObjects];
    
    self.scrollView.contentOffset = CGPointMake(0, 0);
    self.scrollView.contentSize = CGSizeMake(0, 0);
    
}

#pragma mark - scrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    // 这一步是实现跟踪器时刻跟随scrollView滑动的效果,如果对self.pageMenu.scrollView赋了值，这一步可省
    // [self.pageMenu moveTrackerFollowScrollView:scrollView];
}


#pragma mark - getter

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NaviH+40, LSScreenWidth, scrollViewHeight)];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
    }
    return  _scrollView;
}

- (NSMutableArray *)myChildViewControllers {
    
    if (!_myChildViewControllers) {
        _myChildViewControllers = [NSMutableArray array];
        
    }
    return _myChildViewControllers;
}

- (void)dealloc {
    NSLog(@"父控制器被销毁了");
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
