//
//  AppDelegate.m
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2018/4/21.
//  Copyright © 2018年 漠然丶情到深处. All rights reserved.
//
//                            _ooOoo_
//                           o8888888o
//                           88" . "88
//                           (| -_- |)
//                            O\ = /O
//                        ____/`---'\____
//                      .  .' \\| |// `.  .
//                       / \\||| : |||// \
//                     / _||||| -:- |||||_ \
//                       | | \\\ - /// | |
//                     | \_| ''\---/'' |_/ |
//                      \ .-\__ `-` __/-. /
//                   ___`. .' /--.--\ `. .'___
//                ."" '< `.___\_<|>_/___.' >' "".
//               | | : `- \`.;`\ _ /`;.`/ -` : | |
//                 \ \ `-. \_ __\ /__ _/ .-` / /
//         ======`-.____`-.___\_____/___.-`____.-'======
//                            `=---='
//
//         .............................................
//                  佛祖镇楼            BUG滚粗
//          佛曰:
//                  写字楼里写字间，写字间里程序员；
//                  程序人员写程序，又拿程序换酒钱。
//                  酒醒只在网上坐，酒醉还来网下眠；
//                  酒醉酒醒日复日，网上网下年复年。
//                  但愿老死电脑间，不愿鞠躬老板前；
//                  奔驰宝马贵者趣，公交自行程序员。
//                  别人笑我忒疯癫，我笑自己命太贱；
//                  不见满街漂亮妹，哪个归得程序员？
//

#import "AppDelegate.h"
#import "LSBaseNavigationViewController.h"
#import "LSBaseWKWebViewController.h"

@interface AppDelegate ()

@property(nonatomic,strong,nullable)UIVisualEffectView *visualEffectView;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    LSBaseTabBarViewController *TabBarVC = [[LSBaseTabBarViewController alloc]init];
    self.window.rootViewController = TabBarVC;
    
    
    [self.window makeKeyAndVisible];
    
    //设置角标
    [TabBarVC setBadgeValue:@"11" index:2];
    
    //检查网络
    [NetworkAccessibity setAlertEnable:YES];
    [NetworkAccessibity setStateDidUpdateNotifier:^(NetworkAccessibleState state) {
        NSLog(@"setStateDidUpdateNotifier > %zd", state);
    }];
    [NetworkAccessibity start];
    
    
    //添加广告
    [self advertisingView];

    //FPS实时监测
    OttoFPSButton *btn = [OttoFPSButton setTouchWithFrame:CGRectMake(0, 300, 80, 30) titleFont:[UIFont systemFontOfSize:15] backgroundColor:LSGrayColor backgroundImage:nil];
    [self.window addSubview:btn];
    
    
    // 设置TABAnimated相关属性
    [[TABAnimated sharedAnimated] initWithOnlySkeleton];
    
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    NSLog(@"将要进入后台");
    
    //毛玻璃效果
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    self.visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    self.visualEffectView.alpha = 0;
    self.visualEffectView.frame = self.window.frame;
    [self.window addSubview:self.visualEffectView];
    [UIView animateWithDuration:0.5 animations:^{
        self.visualEffectView.alpha = 1;
    }];
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    NSLog(@"进入后台");
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    NSLog(@"将要进入前台");
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    NSLog(@"进入前台");
    
    [UIView animateWithDuration:0.5 animations:^{
        self.visualEffectView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.visualEffectView removeFromSuperview];
    }];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

+ (AppDelegate *)shareAppDelegate{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

//强制竖屏(iPad用，Device中取消横屏无效，必须用这个方法。iPhone在Device中取消有效，不需要用这个方法)
- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    return UIInterfaceOrientationMaskPortrait;
}

//添加广告
- (void)advertisingView {
//    //设置你工程的启动页使用的是:LaunchImage 还是 LaunchScreen.storyboard(不设置默认:LaunchImage)
//    [XHLaunchAd setLaunchSourceType:SourceTypeLaunchImage];
//     //1.因为数据请求是异步的,请在数据请求前,调用下面方法配置数据等待时间.
//    //2.设为3即表示:启动页将停留3s等待服务器返回广告数据,3s内等到广告数据,将正常显示广告,否则将不显示
//    //3.数据获取成功,配置广告数据后,自动结束等待,显示广告
//    //注意:请求广告数据前,必须设置此属性,否则会先进入window的的根控制器
//    [XHLaunchAd setWaitDataDuration:3];
//    //配置广告数据
//    XHLaunchImageAdConfiguration *imageAdconfiguration = [XHLaunchImageAdConfiguration new];
//    //广告停留时间
//    imageAdconfiguration.duration = 3;
//    //广告frame
//    imageAdconfiguration.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
//    //广告图片URLString/或本地图片名(.jpg/.gif请带上后缀)
//    imageAdconfiguration.imageNameOrURLString = @"http://imgsrc.baidu.com/forum/pic/item/9213b07eca80653846dc8fab97dda144ad348257.jpg";
//    //设置GIF动图是否只循环播放一次(仅对动图设置有效)
//    imageAdconfiguration.GIFImageCycleOnce = NO;
//    //缓存机制(仅对网络图片有效)
//    //为告展示效果更好,可设置为XHLaunchAdImageCacheInBackground,先缓存,下次显示
//    imageAdconfiguration.imageOption = XHLaunchAdImageDefault;
//    //图片填充模式
//    imageAdconfiguration.contentMode = UIViewContentModeScaleToFill;
//    //广告点击打开页面参数(openModel可为NSString,模型,字典等任意类型)
//    imageAdconfiguration.openModel = @"http://www.hao123.com";
//    //广告显示完成动画
//    imageAdconfiguration.showFinishAnimate =ShowFinishAnimateLite;
//    //广告显示完成动画时间
//    imageAdconfiguration.showFinishAnimateTime = 0.8;
//    //跳过按钮类型
//    imageAdconfiguration.skipButtonType = SkipTypeTimeText;
//    //后台返回时,是否显示广告
//    imageAdconfiguration.showEnterForeground = NO;
//    //设置要添加的自定义视图(可选)
//    //imageAdconfiguration.subViews = ...
//    //显示开屏广告
//    [XHLaunchAd imageAdWithImageAdConfiguration:imageAdconfiguration delegate:self];
    
    //设置你工程的启动页使用的是:LaunchImage 还是 LaunchScreen.storyboard(不设置默认:LaunchImage)
    [XHLaunchAd setLaunchSourceType:SourceTypeLaunchImage];
    //1.因为数据请求是异步的,请在数据请求前,调用下面方法配置数据等待时间.
    //2.设为3即表示:启动页将停留3s等待服务器返回广告数据,3s内等到广告数据,将正常显示广告,否则将不显示
    //3.数据获取成功,配置广告数据后,自动结束等待,显示广告
    //注意:请求广告数据前,必须设置此属性,否则会先进入window的的根控制器
    [XHLaunchAd setWaitDataDuration:3];
    //配置广告数据
    XHLaunchVideoAdConfiguration *videoAdconfiguration = [XHLaunchVideoAdConfiguration new];
    //广告停留时间
    videoAdconfiguration.duration = 5;
    //广告frame
    videoAdconfiguration.frame = CGRectMake(0, 0, LSScreenWidth, LSScreenHeight);
    //广告视频URLString/或本地视频名(请带上后缀)
    //注意:视频广告只支持先缓存,下次显示(看效果请二次运行)
    videoAdconfiguration.videoNameOrURLString = @"https://statics.yanxian.org/files/20190628/7c1aca65282be23957a3d6a6251ea86c.mp4";
    //是否关闭音频
    videoAdconfiguration.muted = NO;
    //视频填充模式
    videoAdconfiguration.videoGravity = AVLayerVideoGravityResizeAspectFill;
    //是否只循环播放一次
    videoAdconfiguration.videoCycleOnce = NO;
     //广告点击打开页面参数(openModel可为NSString,模型,字典等任意类型)
    videoAdconfiguration.openModel = @"http://www.hao123.com";
    //广告显示完成动画
    videoAdconfiguration.showFinishAnimate =ShowFinishAnimateFadein;
    //广告显示完成动画时间
    videoAdconfiguration.showFinishAnimateTime = 0.8;
    //后台返回时,是否显示广告
    videoAdconfiguration.showEnterForeground = NO;
    //跳过按钮类型
    videoAdconfiguration.skipButtonType = SkipTypeTimeText;
    //设置要添加的自定义视图(可选)
    //videoAdconfiguration.subViews = ..
    [XHLaunchAd videoAdWithVideoAdConfiguration:videoAdconfiguration delegate:self];
}

- (void)xhLaunchAd:(XHLaunchAd *)launchAd clickAndOpenModel:(id)openModel clickPoint:(CGPoint)clickPoint {

    NSLog(@"广告点击事件");

    /** openModel即配置广告数据设置的点击广告时打开页面参数(configuration.openModel) */
     
    if(openModel==nil) return;

    NSString *urlString = (NSString *)openModel;
    
    LSBaseNavigationViewController *loginNavi = [[LSBaseNavigationViewController alloc] initWithRootViewController:[[LSBaseWKWebViewController alloc] initWithUrl:urlString]];
    loginNavi.modalPresentationStyle = UIModalPresentationFullScreen;
    [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:loginNavi animated:YES completion:nil];
}


@end
