//
//  LSScanView.h
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2017/4/3.
//  Copyright © 2017年 漠然丶情到深处. All rights reserved.
//

#import <UIKit/UIKit.h>

/*! 扫描成功发送通知（在代理实现的情况下不发送）*/
extern NSString *const LSSuccessScanQRCodeNotification;
/*! 通知传递数据中存储二维码信息的关键字*/
extern NSString *const LSScanQRCodeMessageKey;

@class LSScanView;
@protocol LSScanViewDelegate <NSObject>

- (void)scanView:(LSScanView *)scanView codeInfo:(NSString *)codeInfo;

@end

@interface LSScanView : UIView

/*! 扫描回调代理人*/
@property (nonatomic, weak) id<LSScanViewDelegate> delegate;

/*! 创建扫描视图，建议使用LXDScanCodeController*/
+ (instancetype)scanViewShowInController: (UIViewController *)controller;

/*! 开始扫描*/
- (void)start;

/*! 结束扫描*/
- (void)stop;

/*! 开启定时器*/
- (void)StartTimer;

/*! 移除定时器(切记：一定要在Controller视图消失的时候，停止定时器)*/
- (void)removeTimer;

@property(nonatomic,strong)UIButton *FlashlightButton;

@end
