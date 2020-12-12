//
//  LSBaseTabBarViewController.m
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2018/5/21.
//  Copyright © 2018年 漠然丶情到深处. All rights reserved.
//

#import "LSBaseTabBarViewController.h"
#import "LSBaseNavigationViewController.h"
#import "LSBaseTabBarView.h"
#import "MoreViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import "UITabBar+LSBadge.h"

@interface LSBaseTabBarViewController ()<TabBarDelegate,UITabBarControllerDelegate>

@property(nonatomic,assign)NSInteger index;

/** 之前被选中的UITabBarItem */
@property(nonatomic,strong)UITabBarItem *lastItem;

@end

@implementation LSBaseTabBarViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 将默认被选中的tabBarItem保存为属性
    self.lastItem = self.tabBar.selectedItem;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, TAB_BAR_HEIGHT)];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.tabBar insertSubview:bgView atIndex:0];
    // Do any additional setup after loading the view.
    self.delegate = self;
    
    
    [self setCustomtabbar];
    [self setViewControllers];
}

#pragma mark - 设置自定义中心按钮
- (void)setCustomtabbar {
    LSBaseTabBarView *tabbar = [[LSBaseTabBarView alloc]init];
    tabbar.BarButtonDelegate = self;
    [self setValue:tabbar forKeyPath:@"tabBar"];
}

#pragma mark - 自定义中心按钮相应方法
- (void)tabBarMoreButtonAction:(LSBaseTabBarView *)tabBar {
    MoreViewController *moreVC = [[MoreViewController alloc]init];
    UINavigationController *moreNC = [[UINavigationController alloc]initWithRootViewController:moreVC];
    [self presentViewController:moreNC animated:YES completion:nil];
}

- (void)setViewControllers {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"TabBarConfigure" ofType:@"plist"];
    NSArray *dataArray = [[NSArray alloc] initWithContentsOfFile:path];
    
    for (NSDictionary *dataDic in dataArray) {
        Class class = NSClassFromString(dataDic[@"class"]);
        NSString *title = dataDic[@"title"];
        NSString *image = dataDic[@"image"];
        NSString *selectedImage = dataDic[@"selectedImage"];
        
        [self addChildViewController:[self setViewController:class title:title image:image selectedImage:selectedImage]];
    }
}

- (LSBaseNavigationViewController *)setViewController:(Class)class title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage {
    UIViewController *vc = [class new];
    vc.tabBarItem.title = title;
    
    if (@available(iOS 13.0, *)) {
        //隐藏分割线
        UITabBarAppearance *appearance = UITabBarAppearance.new;
        NSMutableParagraphStyle *par = [[NSMutableParagraphStyle alloc]init];
        par.alignment = NSTextAlignmentCenter;
        //未选中状态
        UITabBarItemStateAppearance *normal = appearance.stackedLayoutAppearance.normal;
        if (normal) {
            normal.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"9B9B9B"],NSParagraphStyleAttributeName : par};
        }
        //选中状态
        UITabBarItemStateAppearance *selected = appearance.stackedLayoutAppearance.selected;
        if (selected) {
            selected.titleTextAttributes = @{NSForegroundColorAttributeName:MainColor,NSParagraphStyleAttributeName : par};
        }
        
        appearance.backgroundImage = [UIImage imageWithColor:[UIColor clearColor]];
        appearance.shadowImage = [UIImage imageWithColor:[UIColor clearColor]];
        [appearance configureWithTransparentBackground];
        
        self.tabBar.standardAppearance = appearance;
    }else{
        //未选中状态
        NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
        textAttrs[NSForegroundColorAttributeName] = [UIColor colorWithHexString:@"9B9B9B"];
        textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:10];
        [vc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
        
        //选中状态
        NSMutableDictionary *selectedTextAttrs = [NSMutableDictionary dictionary];
        selectedTextAttrs[NSForegroundColorAttributeName] = MainColor;
        selectedTextAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:10];
        [vc.tabBarItem setTitleTextAttributes:selectedTextAttrs forState:UIControlStateSelected];
        
        //隐藏分割线
        UITabBar.appearance.backgroundImage = [UIImage new];
        UITabBar.appearance.shadowImage = [UIImage new];
    }
    vc.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //tabbar的背景色
    [UITabBar appearance].backgroundColor = RGBAColor(0.98, 0.98, 0.98, 1);
    //解决iOS12系统下pop返回时tabbar偏移的问题
    [UITabBar appearance].translucent = NO;
    
    LSBaseNavigationViewController *nav = [[LSBaseNavigationViewController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
    
    return nav;
}

#pragma mark -- 点击tabbarItem自动调用
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    NSInteger index = [self.tabBar.items indexOfObject:item];

    if (index != _index) {
        [self playNotifySound];
        _index = index;
    }
    [self animationWithIndex:index];
    
    
    if (index == 0) {
        if (item == self.lastItem) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"0" object:nil userInfo:nil];
        }
        self.lastItem = item;
    }else if (index == 1) {
        if (item == self.lastItem) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"1" object:nil userInfo:nil];
        }
        self.lastItem = item;
    }else if (index == 2) {
        if (item == self.lastItem) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"2" object:nil userInfo:nil];
        }
        self.lastItem = item;
    }else if (index == 3) {
        if (item == self.lastItem) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"3" object:nil userInfo:nil];
        }
        self.lastItem = item;
    }
}

#pragma mark -- tabbar按钮点击动画
- (void)animationWithIndex:(NSInteger)index {
    NSMutableArray *tabbarbuttonArray = [NSMutableArray array];
    for (UIView *tabBarButton in self.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabbarbuttonArray addObject:tabBarButton];
        }
    }
    /**
     CABasicAnimation类的使用方式就是基本的关键帧动画。
     所谓关键帧动画，就是将Layer的属性作为KeyPath来注册，指定动画的起始帧和结束帧，然后自动计算和实现中间的过渡动画的一种动画方式。
     */
    CABasicAnimation *pulse = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    pulse.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pulse.duration = 0.2;
    pulse.repeatCount = 1;
    pulse.autoreverses = YES;
    pulse.fromValue = [NSNumber numberWithFloat:0.7];
    pulse.toValue = [NSNumber numberWithFloat:1.3];
    
    UIView *tabbarbuttonView = tabbarbuttonArray[index];
    [[tabbarbuttonView layer] addAnimation:pulse forKey:nil];
}

#pragma mark -- tabbar按钮点击声音
- (void)playNotifySound {
    //获取路径
    NSString *path = [[NSBundle mainBundle] pathForResource:@"error" ofType:@"wav"];
    //定义一个带振动的SystemSoundID
    SystemSoundID soundID = 1000;
    //判断路径是否存在
    if (path) {
        //创建一个音频文件的播放系统声音服务器
        OSStatus error = AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)([NSURL fileURLWithPath:path]), &soundID);
        //判断是否有错误
        if (error != kAudioServicesNoError) {
            NSLog(@"%d",(int)error);
        }
    }
    //只播放声音，没振动
    AudioServicesPlaySystemSound(soundID);
}

#pragma 设置小红点数值
//设置指定tabar 小红点的值
- (void)setBadgeValue:(NSString *)badgeValue index:(NSInteger)index {
    if (index + 1 > self.viewControllers.count || index < 0) {
        //越界或者数据异常直接返回
        return;
    }
    LSBaseNavigationViewController *base = self.viewControllers[index];
    if (base.viewControllers.count == 0) {
        return;
    }
    UIViewController *vc = base.viewControllers[0];
    vc.tabBarItem.badgeValue = badgeValue.intValue > 0 ? badgeValue : nil;
}

#pragma 设置小红点显示或者隐藏
//显示小红点 没有数值
- (void)showBadgeWithIndex:(int)index {
    [self.tabBar showBadgeOnItemIndex:index];
}

//隐藏小红点 没有数值
- (void)hideBadgeWithIndex:(int)index {
    [self.tabBar hideBadgeOnItemIndex:index];
}

//防止在iPad上，tabbar的文字和图片变成左右排列
- (UITraitCollection *)traitCollection {
    if (UIDevice.currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        return [UITraitCollection traitCollectionWithVerticalSizeClass:UIUserInterfaceSizeClassCompact];
    }

    return [super traitCollection];
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
