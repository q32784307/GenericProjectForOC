//
//  AppConfig.h
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2018/1/18.
//  Copyright © 2018年 漠然丶情到深处. All rights reserved.
//

#ifndef AppConfig_h
#define AppConfig_h

/****************************************************颜色****************************************************/
/**
 * 页面底色
 */
#define ViewBackgroundColor [UIColor colorWithRed:242 / 255.0 green:242 / 255.0 blue:242 / 255.0 alpha:1]
/**
 * 颜色
 */
#define kRGBAColor(R,G,B,A) [UIColor colorWithRed:(R)/255.0f green:(G)/255.0f blue:(B)/255.0f alpha:(A)]
#define RGBAColor(R,G,B,A) [UIColor colorWithRed:(R) green:(G) blue:(B) alpha:(A)]
/**
 * rgb颜色转换（16进制->10进制）
 */
#define ColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define ClearColor [UIColor clearColor]
#define WhiteColor [UIColor whiteColor]
#define BlackColor [UIColor blackColor]
#define GrayColor [UIColor grayColor]
#define BlueColor [UIColor blueColor]
#define RedColor [UIColor redColor]
//字体
#define BoldSystemFont(FONTSIZE)    [UIFont boldSystemFontOfSize:FONTSIZE]
#define SystemFont(FONTSIZE)    [UIFont systemFontOfSize:FONTSIZE]
#define Font(NAME, FONTSIZE)    [UIFont fontWithName:(NAME) size:(FONTSIZE)]
//定义UIImage对象
#define ImageNamed(name) [UIImage imageNamed:name]
////读取本地图片
//#define LOADIMAGE(file,ext) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:ext]]
////定义UIImage对象
//#define IMAGE(A) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:A ofType:nil]]
/***********************************************************************************************************/

/**************************************************屏幕适配**************************************************/
/**
 * 屏幕宽和高
 */
#define ScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define ScreenHeight ([UIScreen mainScreen].bounds.size.height)
#define ScreenBounds [UIScreen mainScreen].bounds
//判断横屏还是竖屏
#define IsPortrait ([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationPortrait || [[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationPortraitUpsideDown)

//----------------判断当前的iPhone设备/系统版本---------------
// 判断是否为iPhone
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
// 判断是否为iPad
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

#define SYRealValue(value) (IS_IPHONE == YES ? ((value) / 375.0f * ScreenWidth) : ((value) / 834.0f * ScreenWidth))

//----------------判断系统版本---------------
// 获取系统版本
#define IOS_SYSTEM_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
// 判断 iOS 8 或更高的系统版本
#define IOS_VERSION_8_OR_LATER (([[[UIDevice currentDevice] systemVersion] floatValue] >=8.0)? (YES):(NO))
// 判断 iOS 10 或更高的系统版本
#define IOS_VERSION_10_OR_LATER (([[[UIDevice currentDevice] systemVersion] floatValue] >=10.0)? (YES):(NO))

// 判断iPhone 4/4S
#define iPhone4_4S ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) && !IS_IPAD : NO)
// 判断iPhone 5/5S/5C/SE
#define iPhone5_5SE ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) && !IS_IPAD : NO)
// 判断iPhone 6/6S/7/8
#define iPhone6_6S ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) && !IS_IPAD : NO)
// 判断iPhone 6Plus/6SPlus/7P/8P
#define iPhone6Plus_8Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1080, 1920), [[UIScreen mainScreen] currentMode].size) && !IS_IPAD : NO)
//判断iPhone X
#define Is_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !IS_IPAD : NO)
//判断iPHone Xr
#define Is_iPhoneXr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) && !IS_IPAD : NO)
//判断iPhone Xs
#define Is_iPhoneXs ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !IS_IPAD : NO)
//判断iPhone Xs Max
#define Is_iPhoneXs_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) && !IS_IPAD : NO)
//判断iPhone 12和iPhone 12 Pro
#define Is_iPhone12 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1170, 2532), [[UIScreen mainScreen] currentMode].size) && !IS_IPAD : NO)
//判断iPhone 12 mini
#define Is_iPhone12_mini ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1080, 2340), [[UIScreen mainScreen] currentMode].size) && !IS_IPAD : NO)
//判断iPhone 12 Pro Max
#define Is_iPhone12_Pro_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1284, 2778), [[UIScreen mainScreen] currentMode].size) && !IS_IPAD : NO)
//判断iPad mini
#define Is_iPad_Mine ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1536, 2048), [[UIScreen mainScreen] currentMode].size) && !IS_IPHONE : NO)
//判断iPad
#define Is_iPad ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1536, 2048), [[UIScreen mainScreen] currentMode].size) && !IS_IPHONE : NO)
//判断iPad Pro(10.5寸)
#define Is_iPad_Pro_10_5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1668, 2224), [[UIScreen mainScreen] currentMode].size) && !IS_IPHONE : NO)
//判断iPad Pro(12.9寸)
#define Is_iPad_Pro_12_9 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(2048, 2732), [[UIScreen mainScreen] currentMode].size) && !IS_IPHONE : NO)

// 主要是用于区分是否是 刘海屏
#define LiuHaiPhone \
({BOOL isLiuHaiPhone = NO;\
if (@available(iOS 11.0, *)) {\
isLiuHaiPhone = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isLiuHaiPhone);})

//状态栏高度
#define STATUS_BAR_HEIGHT_For_iPad ((Is_iPad_Pro_10_5 == YES || Is_iPad_Pro_12_9 == YES) ? 24.0f : 20.0f)
#define STATUS_BAR_HEIGHT_For_iPhone ((Is_iPhoneX == YES || Is_iPhoneXr == YES || Is_iPhoneXs == YES || Is_iPhoneXs_Max == YES || Is_iPhone12 || Is_iPhone12_mini || Is_iPhone12_Pro_Max) ? 44.0f : 20.0f)
#define STATUS_BAR_HEIGHT (IS_IPHONE == YES ? STATUS_BAR_HEIGHT_For_iPhone : STATUS_BAR_HEIGHT_For_iPad)
//状态栏+导航栏高度
#define NAVIGATION_BAR_HEIGHT_For_iPad ((Is_iPad_Pro_10_5 == YES || Is_iPad_Pro_12_9 == YES) ? 74.0f : 70.0f)
#define NAVIGATION_BAR_HEIGHT_For_iPhone ((Is_iPhoneX == YES || Is_iPhoneXr == YES || Is_iPhoneXs == YES || Is_iPhoneXs_Max == YES || Is_iPhone12 || Is_iPhone12_mini || Is_iPhone12_Pro_Max) ? 88.0f : 64.0f)
#define NAVIGATION_BAR_HEIGHT (IS_IPHONE == YES ? NAVIGATION_BAR_HEIGHT_For_iPhone : NAVIGATION_BAR_HEIGHT_For_iPad)
//tabBar高度
#define TAB_BAR_HEIGHT_For_iPad ((Is_iPad_Pro_10_5 == YES || Is_iPad_Pro_12_9 == YES) ? 65.0f : 50.0f)
#define TAB_BAR_HEIGHT_For_iPhone ((Is_iPhoneX == YES || Is_iPhoneXr == YES || Is_iPhoneXs == YES || Is_iPhoneXs_Max == YES || Is_iPhone12 || Is_iPhone12_mini || Is_iPhone12_Pro_Max) ? 83.0f : 49.0f)
#define TAB_BAR_HEIGHT (IS_IPHONE == YES ? TAB_BAR_HEIGHT_For_iPhone : TAB_BAR_HEIGHT_For_iPad)
//home indicator高度（底部安全曲区域）
#define HOME_INDICATOR_HEIGHT_For_iPad ((Is_iPad_Pro_10_5 == YES || Is_iPad_Pro_12_9 == YES) ? 15.0f : 0.0f)
#define HOME_INDICATOR_HEIGHT_For_iPhone ((Is_iPhoneX == YES || Is_iPhoneXr == YES || Is_iPhoneXs == YES || Is_iPhoneXs_Max == YES || Is_iPhone12 || Is_iPhone12_mini || Is_iPhone12_Pro_Max) ? 34.0f : 0.0f)
#define HOME_INDICATOR_HEIGHT (IS_IPHONE == YES ? HOME_INDICATOR_HEIGHT_For_iPhone : HOME_INDICATOR_HEIGHT_For_iPad)
/***********************************************************************************************************/

/************************************************日志打印****************************************************/
/**
 * 打印日志
 */
#ifdef DEBUG
#define NSLog(format, ...) printf("\n[%s] %s [第%d行] %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]);
#else
#define NSLog(format, ...)
#endif
/***********************************************************************************************************/

/**********************************************UserDefault**************************************************/
/**
 * UserDefault本地缓存
 */
//存
#define SaveUserDefault(obj,key) {[[NSUserDefaults standardUserDefaults]setObject:obj forKey:key];\
[[NSUserDefaults standardUserDefaults] synchronize];}
//取
#define GetUserDefault(key) [[NSUserDefaults standardUserDefaults]objectForKey:key]
//删除
#define RemoveUserDefault(key) {[[NSUserDefaults standardUserDefaults]removeObjectForKey:key];\
[[NSUserDefaults standardUserDefaults] synchronize];}
/***********************************************************************************************************/

/***************************************************其他*****************************************************/
// 字符串是否为空
#define IsNilString(__String) ([__String isKindOfClass:[NSNull class]] || __String == nil || [__String length] < 1 ? YES : NO )
// 数组是否为空
#define IsNullArray(__Array) (__Array == nil || [__Array isKindOfClass:[NSNull class]] || __Array.count == 0 ||[__Array isEqual:[NSNull null]])
// 字典是否为空
#define IsNullDict(__Dic) (__Dic == nil || [__Dic isKindOfClass:[NSNull class]] || __Dic.allKeys == 0 || [__Dic isEqual:[NSNull null]])
// 是否是空对象
#define IsNullObject(__Object) (__Object == nil \
|| [__Object isKindOfClass:[NSNull class]] \
|| ([__Object respondsToSelector:@selector(length)] && [(NSData *)__Object length] == 0) \
|| ([__Object respondsToSelector:@selector(count)] && [(NSArray *)__Object count] == 0))

/**
 * 弱引用
 */
#define WeakSelf(type)  __weak typeof(type) weak##type = type;
/**
 * 强引用
 */
#define StrongSelf(type)  __strong typeof(type) type = weak##type;
/***********************************************************************************************************/

/**************************************************GCD******************************************************/
//GCD - 一次性执行
#define DISPATCH_ONCE_BLOCK(onceBlock) static dispatch_once_t onceToken; dispatch_once(&onceToken, onceBlock);
//GCD - 在Main线程上运行
#define DISPATCH_MAIN_THREAD(mainQueueBlock) dispatch_async(dispatch_get_main_queue(), mainQueueBlock);
//GCD - 开启异步线程
#define DISPATCH_GLOBAL_QUEUE_DEFAULT(globalQueueBlock) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), globalQueueBlocl);
/***********************************************************************************************************/

/**************************************************通知******************************************************/
//创建通知
#define AddNotification(selectorName,key) [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(selectorName) name:key object:nil];
//发送通知
#define SendNotification(key) [[NSNotificationCenter defaultCenter] postNotificationName:key object:self userInfo:nil];
//移除通知
#define RemoveNotification(key) [[NSNotificationCenter defaultCenter]removeObserver:self name:key object:nil];
/***********************************************************************************************************/

/************************************************手机信息****************************************************/
//设备名称
#define systemName [[UIDevice currentDevice] systemName]
//手机名称
#define iPhoneName [[UIDevice currentDevice] name]
//允许监听电池状态
#define batteryMonitoring [UIDevice currentDevice].batteryMonitoringEnabled
//电池电量
#define batteryLevel [[UIDevice currentDevice] batteryLevel] * 100
//当前系统版本号
#define iOSVersion [[UIDevice currentDevice] systemVersion]
//设备型号
#define iPhoneModel [[UIDevice currentDevice] model]
//UUID
#define uuid [[UIDevice currentDevice].identifierForVendor UUIDString]
//app版本号
#define appVerion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
//app名称
#define appName [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]
//app build版本
#define buildVerion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]
/***********************************************************************************************************/
//拼接字符串
#define NSStringFormat(format,...) [NSString stringWithFormat:format,##__VA_ARGS__]

#define EmptyTitle nil
#define MessageTiele @"请检查您的网络"

/***********************************************************************************************************/
//获取系统时间戳
#define getCurentTime [NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]]


//系统Notification定义
#define TNCancelFavoriteProductNotification     @"TNCancelFavoriteProductNotification"      //取消收藏时
#define TNMarkFavoriteProductNotification       @"TNMarkFavoriteProductNotification"        //标记收藏时
#define kNotficationDownloadProgressChanged     @"kNotficationDownloadProgressChanged"      //下载进度变化
#define kNotificationPauseDownload              @"kNotificationPauseDownload"               //暂停下载
#define kNotificationStartDownload              @"kNotificationStartDownload"               //开始下载
#define kNotificationDownloadSuccess            @"kNotificationDownloadSuccess"             //下载成功
#define kNotificationDownloadFailed             @"kNotificationDownloadFailed"              //下载失败
#define kNotificationDownloadNewMagazine        @"kNotificationDownloadNewMagazine"
/***********************************************************************************************************/

#endif /* AppConfig_h */

