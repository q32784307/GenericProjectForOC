//
//  MerchantScanCodeViewController.m
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/8/28.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import "MerchantScanCodeViewController.h"
#import "LSScanView.h"
#import <AVFoundation/AVFoundation.h>

@interface MerchantScanCodeViewController ()<LSScanViewDelegate,UIAlertViewDelegate>

@property(nonatomic,strong)LSScanView *scanView;

@end

@implementation MerchantScanCodeViewController

- (void)dealloc {
    [self.scanView stop];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.scanView start];
    [self.scanView StartTimer];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.scanView stop];
    [self.scanView removeTimer];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNav];
    [self createSubViews];
}

- (void)setNav {
    self.navView.titleLabelText = @"扫码";
}

- (void)createSubViews {
    self.scanView = [LSScanView scanViewShowInController:self];
    [self.view addSubview:self.scanView];
    
    [self.scanView.FlashlightButton addTarget:self action:@selector(FlashlightAction:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - LXDScanCodeController
/**
 *  扫描成功时回调
 */
- (void)scanView:(LSScanView *)scanView codeInfo:(NSString *)codeInfo {
    [self playSoundEffect:@"sound.caf"];
    if ([codeInfo containsString:@"http"]) {
//        ScanResultViewController *ScanResultVC = [[ScanResultViewController alloc] init];
//        ScanResultVC.jump_URL = codeInfo;
//        [self.navigationController pushViewController:ScanResultVC animated:YES];
        NSLog(@"%@",codeInfo);
        [self.navigationController popViewControllerAnimated:YES];
    }else{ // 扫描结果为条形码
//        ScanResultViewController *ScanResultVC = [[ScanResultViewController alloc] init];
//        ScanResultVC.jump_bar_code = codeInfo;
//        [self.navigationController pushViewController:ScanResultVC animated:YES];
        NSLog(@"%@",codeInfo);
        [self.navigationController popViewControllerAnimated:YES];
    }
}

//开启手电筒
- (void)FlashlightAction:(UIButton *)btn {
    btn.selected = !btn.selected;
    [self turnTorchOn:btn.selected];
}

- (void)turnTorchOn:(bool)on {
    Class captureDeviceClass = NSClassFromString(@"AVCaptureDevice");
    if (captureDeviceClass !=nil) {
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        if ([device hasTorch] && [device hasFlash]){
            [device lockForConfiguration:nil];
            if (on) {
                [device setTorchMode:AVCaptureTorchModeOn];
                [device setFlashMode:AVCaptureFlashModeOn];
            } else {
                [device setTorchMode:AVCaptureTorchModeOff];
                [device setFlashMode:AVCaptureFlashModeOff];
            }
            [device unlockForConfiguration];
        }else{
            NSLog(@"初始化失败");
        }
    }else{
        NSLog(@"没有闪光设备");
    }
}

#pragma mark - - - 扫描提示声
/**
 *  播放完成回调函数
 *
 *  @param soundID    系统声音ID
 *  @param clientData 回调时传递的数据
 */
void soundCompleteCallback(SystemSoundID soundID,void * clientData){
    NSLog(@"播放完成...");
}

/**
 *  播放音效文件
 *
 *  @param name 音频文件名称
 */
- (void)playSoundEffect:(NSString *)name{
    NSString *audioFile = [[NSBundle mainBundle] pathForResource:name ofType:nil];
    NSURL *fileUrl = [NSURL fileURLWithPath:audioFile];
    // 1、获得系统声音ID
    SystemSoundID soundID = 0;
    /**
     * inFileUrl:音频文件url
     * outSystemSoundID:声音id（此函数会将音效文件加入到系统音频服务中并返回一个长整形ID）
     */
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(fileUrl), &soundID);
    
    // 如果需要在播放完之后执行某些操作，可以调用如下方法注册一个播放完成回调函数
    AudioServicesAddSystemSoundCompletion(soundID, NULL, NULL, soundCompleteCallback, NULL);
    
    // 2、播放音频
    AudioServicesPlaySystemSound(soundID); // 播放音效
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
