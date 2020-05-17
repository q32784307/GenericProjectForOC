//
//  VideoPlayViewController.m
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/4/1.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import "VideoPlayViewController.h"
#import "ZQAVPlayer.h"
#import "UINavigationController+Rotation.h"

@interface VideoPlayViewController ()<ZQAVPlayerDelegate>
{
    ZQAVPlayer *_player;
    NSInteger _stratTime;
    NSInteger _breakTime;
    NSInteger _playTime;
    NSInteger _stayTime;
    BOOL _isOneLoop;
}

@end

@implementation VideoPlayViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_player play];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (_player.currentPlayState == playState_Playing) {
        [_player pause];
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _stratTime = 0;
    _breakTime = 0;
    _playTime = 0;
    _stayTime = 0;
    self.navView.isShowNavigation = NO;
    
    [self makePlayer];
    
    
}

- (void)makePlayer {
    if (_player == nil) {
        _player = [[ZQAVPlayer alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth, ScreenWidth * 0.6) url:@"http://27.112.86.59:1935/vod1//2017_11/22/1511344230826.mp4"];
        _player.delegate = self;
        _player.videoTitle = @"标题";
        [self.view addSubview:_player];
    }
}

#pragma mark PlayerDelegate
- (void)playerBackBtnClicked {
    [self.navigationController popViewControllerAnimated:true];
}

- (void)go2FullScreen {
    [_player showBackBtn:true];
    
    [self.view addSubview:_player];
    NSLog(@"全屏");
}

- (void)playerEnd {
    NSLog(@"播放结束");
}

- (void)playerStartPlay:(NSInteger)seconds {
    _stratTime = seconds;
    _isOneLoop = YES;
    
    NSLog(@"从%ld秒开始播放",seconds);
}

- (void)breakEventBecome:(NSInteger)second {
    if (_isOneLoop) {
        _isOneLoop = NO;
        _breakTime = second;
        _playTime = _breakTime - _stratTime;
        _stayTime = _stayTime + _playTime;
        _playTime = 0;
    }
    NSLog(@"从%ld秒开始停止播放",second);
}

- (void)changeEventBecome {
    NSLog(@"从这切换了视频changeEventBecome");
}

- (void)exitFullScreen {
    NSLog(@"退出了全屏changeEventBecome");
}

- (void)OrienrationChanged:(UIDeviceOrientation)orientation {
    NSLog(@"屏幕方向发生了变化");
}

- (void)errorEventBecome {
    NSLog(@"播放出错");
}

- (BOOL)shouldAutorotate {
    if (_player.locked) {
        return true;
    }else{
        return false;
    }
}

@end
