//
//  LSBaseViewController.m
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2018/5/30.
//  Copyright © 2018年 漠然丶情到深处. All rights reserved.
//

#import "LSBaseViewController.h"
#import "UIScrollView+PeerEmpty.h"
#import "UIScrollView+PeerRefresh.h"

@interface LSBaseViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation LSBaseViewController

static NSString * NSStringFromZYNetworkAccessibleState(NetworkAccessibleState state) {
    return state == NetworkChecking   ? @"NetworkChecking"   :
    state == NetworkUnknown    ? @"NetworkUnknown"    :
    state == NetworkAccessible ? @"NetworkAccessible" :
    state == NetworkRestricted ? @"NetworkRestricted" : nil;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lsLigthColor:ViewBackgroundColor darkColor:LSBlackColor];
    // Do any additional setup after loading the view.
    //是否隐藏系统导航栏
    self.isHidenNaviBar = YES;
    [self setNavigationView];
    
    //检查网络通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkChanged:) name:NetworkAccessibityChangedNotification object:nil];
}

//检查网络通知处理
- (void)networkChanged:(NSNotification *)notification {
    NetworkAccessibleState state = NetworkAccessibity.currentState;
    NSLog(@"networkChanged : %@",NSStringFromZYNetworkAccessibleState(state));
}

//创建自定义导航栏
- (void)setNavigationView {
    LSWeakSelf(self);
    self.navView = [[LSBaseNavigationView alloc]initWithFrame:CGRectMake(0, 0, LSScreenWidth, NAVIGATION_BAR_HEIGHT)];
    self.navView.isShowRightButton = NO;
    [self.navView setLeftActionBlock:^{
        [weakself backBtnClicked];
    }];
    [self.view addSubview:self.navView];
}

- (void)backBtnClicked {
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

//隐藏系统导航栏
- (void)setIsHidenNaviBar:(BOOL)isHidenNaviBar {
    _isHidenNaviBar = isHidenNaviBar;
    if (isHidenNaviBar) {
        [self.navigationController setNavigationBarHidden:YES animated:NO];
    }else{
        [self.navigationController setNavigationBarHidden:NO animated:NO];
    }
}

//请求数据
- (void)analysis {
    
}

//创建布局
- (void)createSubViews {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/** 该方法在UIView的分类中实现 */
- (BOOL)isShowingOnKeyWindow {
    // 主窗口
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    // 以主窗口左上角为坐标原点, 计算self的矩形框
    CGRect newFrame = [keyWindow convertRect:self.view.frame fromView:self.view.superview];
    CGRect winBounds = keyWindow.bounds;
    
    // 主窗口的bounds 和 self的矩形框 是否有重叠
    BOOL intersects = CGRectIntersectsRect(newFrame, winBounds);
    
    return !self.view.isHidden && self.view.alpha > 0.01 && self.view.window == keyWindow && intersects;
}

#pragma mark - 懒加载
- (NetworkRequest *)networkRequest {
    if (!_networkRequest) {
        _networkRequest = [NetworkRequest sharedInstance];
    }
    return _networkRequest;
}

//是否开启下拉刷新上拉加载
- (void)setIsOpenUpDate:(BOOL)isOpenUpDate {
    _isOpenUpDate = isOpenUpDate;
    if (isOpenUpDate) {
        [self setupRefresh];
    }
}

- (void)setupRefresh {
    //下拉刷新
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
    //隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    //隐藏状态
    header.stateLabel.hidden = YES;
    // 设置文字
    [header setTitle:@"下拉刷新数据" forState:MJRefreshStateIdle];
    [header setTitle:@"松开立即刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"Loading ..." forState:MJRefreshStateRefreshing];
    // 设置字体
    header.stateLabel.font = [UIFont systemFontOfSize:15];
    header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:14];
    // 设置颜色
    header.stateLabel.textColor = [UIColor redColor];
    header.lastUpdatedTimeLabel.textColor = [UIColor blueColor];
    // 设置刷新控件
    self.mainTableView.mj_header = header;
    
    
    //上拉加载
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
    // 设置文字
    [footer setTitle:@"上拉可加载更多数据" forState:MJRefreshStateIdle];
    [footer setTitle:@"Loading more ..." forState:MJRefreshStateRefreshing];
    // 设置字体
    footer.stateLabel.font = [UIFont systemFontOfSize:17];
    // 设置颜色
    footer.stateLabel.textColor = [UIColor blueColor];
    // 设置footer
    self.mainTableView.mj_footer = footer;
}

#pragma mark - 设置下拉刷新
- (void)headerRereshing {
    
}

#pragma mark - 设置上拉加载
- (void)footerRereshing {

}

- (UITableView *)mainTableView {
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, LSScreenWidth, LSScreenHeight - TAB_BAR_HEIGHT - HOME_INDICATOR_HEIGHT) style:UITableViewStyleGrouped];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.estimatedRowHeight = 0;
        _mainTableView.estimatedSectionHeaderHeight = 0;
        _mainTableView.estimatedSectionFooterHeight = 0;
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        // 获取系统左滑手势
        for (UIGestureRecognizer *ges in _mainTableView.gestureRecognizers) {
            if ([ges isKindOfClass:NSClassFromString(@"_UISwipeActionPanGestureRecognizer")]) {
                [ges addTarget:self action:@selector(_swipeRecognizerDidRecognize:)];
            }
        }
        
//        [_mainTableView setupEmptyDataText:@"无数据" tapBlock:^{
//            NSLog(@"没有数据");
//            [self analysis];
//        }];
        
//        [_mainTableView setRefreshWithHeaderBlock:^{
//            
//        } footerBlock:^{
//            
//        }];
        
        if (@available(iOS 11.0, *)) {
            _mainTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    return _mainTableView;
}

//禁止tableView左滑删除时，按住左滑再向右滑动时有弹簧效果的问题
- (void)_swipeRecognizerDidRecognize:(UISwipeGestureRecognizer *)swip {
    CGPoint currentPoint = [swip locationInView:self.mainTableView];
    for (UITableViewCell *cell in self.mainTableView.visibleCells) {
        if (CGRectContainsPoint(cell.frame, currentPoint)) {
            if (cell.frame.origin.x > 0) {
                cell.frame = CGRectMake(0, cell.frame.origin.y,cell.bounds.size.width, cell.bounds.size.height);
            }
        }
    }
}

//动态更新状态栏颜色
- (void)setStatusBarStyle:(UIStatusBarStyle)StatusBarStyle {
    _StatusBarStyle = StatusBarStyle;
    [self setNeedsStatusBarAppearanceUpdate];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return _StatusBarStyle;
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
