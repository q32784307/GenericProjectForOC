//
//  LSScanView.m
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2017/4/3.
//  Copyright © 2017年 漠然丶情到深处. All rights reserved.
//

#import "LSScanView.h"
#import <AVFoundation/AVFoundation.h>

NSString *const LSSuccessScanQRCodeNotification = @"LSSuccessScanQRCodeNotification";
NSString *const LSScanQRCodeMessageKey = @"LSScanQRCodeMessageKey";

#define SCANSPACEOFFSET 0.15f
#define REMINDTEXT @"将二维码/条码放入框内，即可自动扫描"
#define SCREENBOUNDS [UIScreen mainScreen].bounds
#define SCREENWIDTH CGRectGetWidth([UIScreen mainScreen].bounds)
#define SCREENHEIGHT CGRectGetHeight([UIScreen mainScreen].bounds)
/** 扫描内容的Y值 */
#define scanContent_Y self.frame.size.height * 0.15
/** 扫描内容的Y值 */
#define scanContent_X self.frame.size.width * 0.15

@interface LSScanView () <AVCaptureMetadataOutputObjectsDelegate>

@property(nonatomic,strong)AVCaptureSession *session;
@property(nonatomic,strong)AVCaptureDeviceInput *input;
@property(nonatomic,strong)AVCaptureMetadataOutput *output;
@property(nonatomic,strong)AVCaptureVideoPreviewLayer *scanView;

@property(nonatomic,strong)CAShapeLayer *maskLayer;
@property(nonatomic,strong)CAShapeLayer *shadowLayer;
@property(nonatomic,strong)CAShapeLayer *scanRectLayer;

@property(nonatomic,assign)CGRect scanRect;
@property(nonatomic,strong)UILabel *remind;

/** 扫描动画线(冲击波) **/
@property(nonatomic,strong)UIImageView *animation_line;
@property(nonatomic,strong)NSTimer *timer;

@end

@implementation LSScanView

/** 扫描动画线(冲击波) 的高度 */
static CGFloat const animation_line_H = 12;
/** 定时器和动画的时间 */
static CGFloat const timer_animation_Duration = 0.05;

#pragma mark - initial
+ (instancetype)scanViewShowInController:(UIViewController *)controller {
    if (!controller) {
        return nil;
    }
    LSScanView *scanView = [[LSScanView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    if ([controller conformsToProtocol:@protocol(LSScanViewDelegate)]) {
        scanView.delegate = (UIViewController<LSScanViewDelegate> *)controller;
    }
    
    return scanView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    frame = CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth, ScreenHeight - NAVIGATION_BAR_HEIGHT - HOME_INDICATOR_HEIGHT);
    if (self = [super initWithFrame: frame]) {
        self.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.2f];
        [self.layer addSublayer:self.scanView];
        [self setupScanRect];
        [self addSubview:self.remind];
        [self addSubview:self.FlashlightButton];
        self.layer.masksToBounds = YES;
    }
    return self;
}

#pragma mark - life
/**
 *  释放前停止会话
 */
- (void)dealloc {
    [self stop];
}

#pragma mark - operate
/**
 *  开始视频会话
 */
- (void)start {
    [self.session startRunning];
}

/**
 *  停止视频会话
 */
- (void)stop {
    [self.session stopRunning];
}

#pragma mark - lazy load
#pragma mark >> capture I/O <<
/**
 *  会话对象
 */
- (AVCaptureSession *)session {
    if (!_session) {
        _session = [AVCaptureSession new];
        [_session setSessionPreset:AVCaptureSessionPresetHigh];    //高质量采集
        [self setupIODevice];
    }
    return _session;
}

/**
 *  视频输入设备
 */
- (AVCaptureDeviceInput *)input {
    if (!_input) {
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        _input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    }
    return _input;
}

/**
 *  数据输出对象
 */
- (AVCaptureMetadataOutput *)output {
    if (!_output) {
        _output = [AVCaptureMetadataOutput new];
        [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    }
    return _output;
}

/**
 *  扫描视图
 */
- (AVCaptureVideoPreviewLayer *)scanView {
    if (!_scanView) {
        _scanView = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
        _scanView.videoGravity = AVLayerVideoGravityResizeAspectFill;
        _scanView.frame = self.bounds;
    }
    return _scanView;
}

#pragma mark >> common <<
/**
 *  扫描范围
 */
- (CGRect)scanRect {
    if (CGRectEqualToRect(_scanRect, CGRectZero)) {
        CGRect rectOfInterest = self.output.rectOfInterest;
        CGFloat yOffset = rectOfInterest.size.width - rectOfInterest.origin.x;
        CGFloat xOffset = 1 - 2 * SCANSPACEOFFSET;
        _scanRect = CGRectMake(rectOfInterest.origin.y * SCREENWIDTH, rectOfInterest.origin.x * SCREENHEIGHT / 2, xOffset * SCREENWIDTH, yOffset * SCREENHEIGHT);
    }
    return _scanRect;
}

/**
 *  提示文本
 */
- (UILabel *)remind {
    if (!_remind) {
        CGRect textRect = self.scanRect;
        textRect.origin.y += CGRectGetHeight(textRect) + 20;
        textRect.size.height = 25.f;
        
        _remind = [[UILabel alloc]initWithFrame:textRect];
        _remind.font = [UIFont systemFontOfSize:SYRealValue(28 / 2)];
        _remind.textColor = [UIColor whiteColor];
        _remind.textAlignment = NSTextAlignmentCenter;
        _remind.text = REMINDTEXT;
        _remind.backgroundColor = [UIColor clearColor];
    }
    return _remind;
}

/**
 * 手电筒
 */
- (UIButton *)FlashlightButton {
    if (!_FlashlightButton) {
        _FlashlightButton = [[UIButton alloc]initWithFrame:CGRectMake((ScreenWidth - SYRealValue(120 / 2)) / 2, self.remind.frame.origin.y + SYRealValue(100 / 2), SYRealValue(120 / 2), SYRealValue(150 / 2))];
        [_FlashlightButton setImage:[UIImage imageNamed:@"Glim_Off"] forState:UIControlStateNormal];
        [_FlashlightButton setImage:[UIImage imageNamed:@"Glim_On"] forState:UIControlStateSelected];
    }
    return _FlashlightButton;
}

#pragma mark >> layer <<
/**
 *  扫描框
 */
- (CAShapeLayer *)scanRectLayer {
    if (!_scanRectLayer) {
        CGRect scanRect = self.scanRect;
        scanRect.origin.x -= 1;
        scanRect.origin.y -= 1;
        scanRect.size.width += 2;
        scanRect.size.height += 2;
        
        _scanRectLayer = [CAShapeLayer layer];
        _scanRectLayer.path = [UIBezierPath bezierPathWithRect:scanRect].CGPath;
        _scanRectLayer.fillColor = [UIColor clearColor].CGColor;
        _scanRectLayer.strokeColor = [UIColor orangeColor].CGColor;
    }
    return _scanRectLayer;
}

/**
 *  阴影层
 */
- (CAShapeLayer *)shadowLayer {
    if (!_shadowLayer) {
        _shadowLayer = [CAShapeLayer layer];
        _shadowLayer.path = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
        _shadowLayer.fillColor = [UIColor colorWithWhite:0 alpha:0.75].CGColor;
        _shadowLayer.mask = self.maskLayer;
    }
    return _shadowLayer;
}

/**
 *  遮掩层
 */
- (CAShapeLayer *)maskLayer {
    if (!_maskLayer) {
        _maskLayer = [CAShapeLayer layer];
        _maskLayer = [self generateMaskLayerWithRect:SCREENBOUNDS exceptRect:self.scanRect];
    }
    return _maskLayer;
}

#pragma mark - generate
/**
 *  生成空缺部分rect的layer
 */
- (CAShapeLayer *)generateMaskLayerWithRect:(CGRect)rect exceptRect:(CGRect)exceptRect {
    CAShapeLayer * maskLayer = [CAShapeLayer layer];
    if (!CGRectContainsRect(rect, exceptRect)) {
        return nil;
    } else if (CGRectEqualToRect(rect, CGRectZero)) {
        maskLayer.path = [UIBezierPath bezierPathWithRect:rect].CGPath;
        return maskLayer;
    }
    
    CGFloat boundsInitX = CGRectGetMinX(rect);
    CGFloat boundsInitY = CGRectGetMinY(rect);
    CGFloat boundsWidth = CGRectGetWidth(rect);
    CGFloat boundsHeight = CGRectGetHeight(rect);
    
    CGFloat minX = CGRectGetMinX(exceptRect);
    CGFloat maxX = CGRectGetMaxX(exceptRect);
    CGFloat minY = CGRectGetMinY(exceptRect);
    CGFloat maxY = CGRectGetMaxY(exceptRect);
    CGFloat width = CGRectGetWidth(exceptRect);
    
    /** 添加路径*/
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(boundsInitX, boundsInitY, minX, boundsHeight)];
    [path appendPath:[UIBezierPath bezierPathWithRect:CGRectMake(minX, boundsInitY, width, minY)]];
    [path appendPath:[UIBezierPath bezierPathWithRect:CGRectMake(maxX, boundsInitY, boundsWidth - maxX, boundsHeight)]];
    [path appendPath:[UIBezierPath bezierPathWithRect:CGRectMake(minX, maxY, width, boundsHeight - maxY)]];
    maskLayer.path = path.CGPath;
    
    return maskLayer;
}


#pragma mark - setup
/**
 *  配置输入输出设置
 */
- (void)setupIODevice {
    if ([self.session canAddInput:self.input]) {
        [_session addInput:_input];
    }
    if ([self.session canAddOutput:self.output]) {
        [_session addOutput:_output];
        _output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode, AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    }
}

/**
 *  配置扫描范围
 */
- (void)setupScanRect {
    CGFloat size = SCREENWIDTH * (1 - 2 * SCANSPACEOFFSET);
    CGFloat minY = (SCREENHEIGHT - size) * 0.5 / SCREENHEIGHT;
    CGFloat maxY = (SCREENHEIGHT + size) * 0.5 / SCREENHEIGHT;
    self.output.rectOfInterest = CGRectMake(minY, SCANSPACEOFFSET, maxY, 1 - SCANSPACEOFFSET * 2);
    
    [self.layer addSublayer:self.shadowLayer];
    [self.layer addSublayer:self.scanRectLayer];
}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate
/**
 *  二维码扫描数据返回
 */
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    if (metadataObjects.count > 0) {
        [self stop];
        AVMetadataMachineReadableCodeObject *metadataObject = metadataObjects[0];
        if ([self.delegate respondsToSelector:@selector(scanView:codeInfo:)]) {
            [self.delegate scanView:self codeInfo:metadataObject.stringValue];
        } else {
            [[NSNotificationCenter defaultCenter]postNotificationName:LSSuccessScanQRCodeNotification object:self userInfo:@{LSScanQRCodeMessageKey:metadataObject.stringValue }];
        }
    }
}

#pragma mark - - - 执行定时器方法
- (void)animation_line_action {
    __block CGRect frame = _animation_line.frame;
    
    static BOOL flag = YES;
    
    if (flag) {
        frame.origin.y = scanContent_Y;
        flag = NO;
        [UIView animateWithDuration:timer_animation_Duration animations:^{
            frame.origin.y += 5;
            _animation_line.frame = frame;
        } completion:nil];
    } else {
        if (_animation_line.frame.origin.y >= scanContent_Y) {
            CGFloat scanContent_MaxY = scanContent_Y + self.frame.size.width - 2 * scanContent_X;
            if (_animation_line.frame.origin.y >= scanContent_MaxY - 5) {
                frame.origin.y = scanContent_Y;
                _animation_line.frame = frame;
                flag = YES;
            } else {
                [UIView animateWithDuration:timer_animation_Duration animations:^{
                    frame.origin.y += 5;
                    _animation_line.frame = frame;
                } completion:nil];
            }
        } else {
            flag = !flag;
        }
    }
}

/**
 *  添加扫描动画线(冲击波)
 *  开启定时器
 */
- (void)StartTimer {
    // 扫描动画添加
    self.animation_line = [[UIImageView alloc] init];
    self.animation_line.image = [UIImage imageNamed:@"QRCodeLine"];
    self.animation_line.frame = CGRectMake(scanContent_X * 0.5, scanContent_Y, self.frame.size.width - scanContent_X , animation_line_H);
    [self.layer addSublayer:_animation_line.layer];
    
    // 添加定时器
    self.timer =[NSTimer scheduledTimerWithTimeInterval:timer_animation_Duration target:self selector:@selector(animation_line_action) userInfo:nil repeats:YES];
}

/** 移除定时器 */
- (void)removeTimer {
    [self.timer invalidate];
    [self.animation_line removeFromSuperview];
    self.animation_line = nil;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
