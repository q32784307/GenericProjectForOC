//
//  LSBaseNavigationViewController.m
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2018/5/11.
//  Copyright © 2018年 漠然丶情到深处. All rights reserved.
//

#import "LSBaseNavigationViewController.h"
#import "TransitionProtocol.h"
#import "Transition.h"
#import "LSBaseViewController.h"

@interface LSBaseNavigationViewController ()<UIGestureRecognizerDelegate,UINavigationControllerDelegate>

@property(nonatomic,weak)id popDelegate;
@property(nonatomic,strong)UIPercentDrivenInteractiveTransition *interactivePopTransition;
@property(nonatomic,strong)UIScreenEdgePanGestureRecognizer *popRecognizer;
@property(nonatomic,assign)BOOL isSystemSlidBack;//是否开启系统右滑返回

@end

@implementation LSBaseNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //默认开启系统右划返回
    self.interactivePopGestureRecognizer.enabled = YES;
    self.interactivePopGestureRecognizer.delegate = self;
    
    //只有在使用转场动画时，禁用系统手势，开启自定义右划手势
    _popRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handleNavigationTransition:)];
    //下面是全屏返回
//    _popRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleNavigationTransition:)];
    _popRecognizer.edges = UIRectEdgeLeft;
    [_popRecognizer setEnabled:NO];
    [self.view addGestureRecognizer:_popRecognizer];
}

//解决手势失效问题
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (_isSystemSlidBack) {
        self.interactivePopGestureRecognizer.enabled = YES;
        [_popRecognizer setEnabled:NO];
    }else{
        self.interactivePopGestureRecognizer.enabled = NO;
        [_popRecognizer setEnabled:YES];
    }
}

//根视图禁用右划返回
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return self.childViewControllers.count == 1 ? NO : YES;
}

//push时隐藏tabbar
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        if ([viewController conformsToProtocol:@protocol(TransitionProtocol)]) {
            viewController.hidesBottomBarWhenPushed = NO;
        }else{
            viewController.hidesBottomBarWhenPushed = YES;
        }
    }
    [super pushViewController:viewController animated:animated];
    // 修改tabBra的frame
    CGRect frame = self.tabBarController.tabBar.frame;
    frame.origin.y = [UIScreen mainScreen].bounds.size.height - frame.size.height;
    self.tabBarController.tabBar.frame = frame;
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {

    if ([viewController isKindOfClass:[LSBaseViewController class]]) {
        LSBaseViewController *vc = (LSBaseViewController *)viewController;
        if (vc.isHidenNaviBar) {
            vc.view.top = 0;
            [vc.navigationController setNavigationBarHidden:YES animated:animated];
        }else{
            vc.view.top = NAVIGATION_BAR_HEIGHT;
            [vc.navigationController setNavigationBarHidden:NO animated:animated];
        }
    }
}

/**
 *  返回到指定的类视图
 *
 *  @param ClassName 类名
 *  @param animated  是否动画
 */
- (BOOL)popToAppointViewController:(NSString *)ClassName animated:(BOOL)animated {
    id vc = [self getCurrentViewControllerClass:ClassName];
    if(vc != nil && [vc isKindOfClass:[UIViewController class]]) {
        [self popToViewController:vc animated:animated];
        return YES;
    }
    
    return NO;
}

/*!
 *  获得当前导航器显示的视图
 *
 *  @param ClassName 要获取的视图的名称
 *
 *  @return 成功返回对应的对象，失败返回nil;
 */
- (instancetype)getCurrentViewControllerClass:(NSString *)ClassName {
    Class classObj = NSClassFromString(ClassName);
    
    NSArray * szArray =  self.viewControllers;
    for (id vc in szArray) {
        if([vc isMemberOfClass:classObj]) {
            return vc;
        }
    }
    
    return nil;
}

- (UIViewController *)childViewControllerForStatusBarStyle {
    return self.topViewController;
}

#pragma mark ————— 转场动画区 —————
//navigation切换是会走这个代理
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    NSLog(@"转场动画代理方法");
    self.isSystemSlidBack = YES;
    //如果来源VC和目标VC都实现协议，那么都做动画
    if ([fromVC conformsToProtocol:@protocol(TransitionProtocol)] && [toVC conformsToProtocol:@protocol(TransitionProtocol)]) {
        
        BOOL pinterestNedd = [self isNeedTransition:fromVC:toVC];
        Transition *transion = [Transition new];
        if (operation == UINavigationControllerOperationPush && pinterestNedd) {
            transion.isPush = YES;
            
            //暂时屏蔽带动画的右划返回
            self.isSystemSlidBack = NO;
        } else if(operation == UINavigationControllerOperationPop && pinterestNedd) {
            //暂时屏蔽带动画的右划返回
            transion.isPush = NO;
            self.isSystemSlidBack = NO;
        }else{
            return nil;
        }
        return transion;
    }else if([toVC conformsToProtocol:@protocol(TransitionProtocol)]){
        //如果只有目标VC开启动画，那么isSystemSlidBack也要随之改变
        BOOL pinterestNedd = [self isNeedTransition:toVC];
        self.isSystemSlidBack = !pinterestNedd;
        return nil;
    }
    return nil;
}

//判断fromVC和toVC是否需要实现pinterest效果
- (BOOL)isNeedTransition:(UIViewController<TransitionProtocol> *)fromVC :(UIViewController<TransitionProtocol> *)toVC {
    BOOL a = NO;
    BOOL b = NO;
    if ([fromVC respondsToSelector:@selector(isNeedTransition)] && [fromVC isNeedTransition]) {
        a = YES;
    }
    if ([toVC respondsToSelector:@selector(isNeedTransition)] && [toVC isNeedTransition]) {
        b = YES;
    }
    return (a && b);
}

//判断fromVC和toVC是否需要实现pinterest效果
- (BOOL)isNeedTransition:(UIViewController<TransitionProtocol> *)toVC {
    BOOL b = NO;
    if ([toVC respondsToSelector:@selector(isNeedTransition)] && [toVC isNeedTransition]) {
        b = YES;
    }
    return b;
}

#pragma mark -- NavitionContollerDelegate
- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    if (!self.interactivePopTransition) { return nil; }
    return self.interactivePopTransition;
}

#pragma mark UIGestureRecognizer handlers
- (void)handleNavigationTransition:(UIScreenEdgePanGestureRecognizer *)recognizer {
    CGFloat progress = [recognizer translationInView:self.view].x / (self.view.bounds.size.width);

    if (recognizer.state == UIGestureRecognizerStateBegan) {
        self.interactivePopTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
        [self popViewControllerAnimated:YES];
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        [self.interactivePopTransition updateInteractiveTransition:progress];
    } else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled) {
        CGPoint velocity = [recognizer velocityInView:recognizer.view];
        
        if (progress > 0.5 || velocity.x >100) {
            [self.interactivePopTransition finishInteractiveTransition];
        } else {
            [self.interactivePopTransition cancelInteractiveTransition];
        }
        self.interactivePopTransition = nil;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
