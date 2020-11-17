//
//  LSSpeechSynthesizer.m
//  GenericProject
//
//  Created by 社科塞斯 on 2020/11/17.
//  Copyright © 2020 漠然丶情到深处. All rights reserved.
//

#import "LSSpeechSynthesizer.h"
#import <CoreTelephony/CTCallCenter.h>

@interface LSSpeechSynthesizer () <AVSpeechSynthesizerDelegate>

@property(nonatomic,strong)AVSpeechSynthesizer *speechSynthesizer;
@property(nonatomic,strong)CTCallCenter *callCenter;
@property(nonatomic,strong)dispatch_queue_t serialQueue;
@property(nonatomic,copy)void (^finishBlock)(BOOL);
@property(nonatomic,copy)void (^monitorBlock)(BOOL);

@end

@implementation LSSpeechSynthesizer

+ (instancetype)sharedSpeechSynthesizer {
    static id sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[LSSpeechSynthesizer alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    if (self = [super init]) {
        [self buildSpeechSynthesizer];
    }
    return self;
}

- (void)buildSpeechSynthesizer {
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0) {
        return;
    }
    
    //简单配置一个AVAudioSession以便可以在后台播放声音，更多细节参考AVFoundation官方文档
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self activateAudioSessionWithCategory:AVAudioSessionCategoryPlayback
                                       options:AVAudioSessionCategoryOptionMixWithOthers | AVAudioSessionCategoryOptionDuckOthers
                                         error:nil];
    });
    
    self.speechSynthesizer = [[AVSpeechSynthesizer alloc] init];
    [self.speechSynthesizer setDelegate:self];
    
    self.callCenter = [[CTCallCenter alloc] init];
    
    self.serialQueue = dispatch_queue_create("speech.navi.demo.lbs.amap.com", DISPATCH_QUEUE_SERIAL);
}

- (BOOL)isSpeaking {
    return self.speechSynthesizer.isSpeaking;
}

- (BOOL)isOnPhoneCall {
    BOOL hasCalls = (self.callCenter.currentCalls != nil);
    return hasCalls;
}

- (BOOL)activateAudioSessionWithCategory:(NSString *)category options:(AVAudioSessionCategoryOptions)options error:(NSError * __nullable * __nullable)error {
    NSString * sessionCategory = [[AVAudioSession sharedInstance] category];
    AVAudioSessionCategoryOptions sessionCategoryOptions = [[AVAudioSession sharedInstance] categoryOptions];
    
    if ([sessionCategory isEqualToString:category] && sessionCategoryOptions == options) {
        if ([[AVAudioSession sharedInstance] isOtherAudioPlaying]) {
            if (![[AVAudioSession sharedInstance] setActive:YES withOptions:AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation error:error]) {
                return NO;
            }
        }
        return YES;
    }
    
    if ([category isEqualToString:AVAudioSessionCategoryPlayback] && [sessionCategory isEqualToString:category] && sessionCategoryOptions != options) {
        if (![[AVAudioSession sharedInstance] setActive:NO withOptions:AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation error:error]) {
            return NO;
        }
    }
    
    BOOL result;
    NSError *err = NULL;
    if (options == 0) {
        result = [[AVAudioSession sharedInstance] setCategory:category error:&err];
    } else {
        result = [[AVAudioSession sharedInstance] setCategory:category withOptions:options error:&err];
    }
    
    if (error) {
        *error = err;
    }
    
    if (!result) {
        return NO;
    }
    
    if (![[AVAudioSession sharedInstance] setActive:YES withOptions:AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation error:error]) {
        return NO;
    }
    
    return YES;
}

- (void)configMonitorBlock:(void (^)(BOOL))block {
    if (self.monitorBlock) {
        self.monitorBlock(YES);
    }
    self.monitorBlock = block;
}

- (void)configFinishBlock:(void (^)(BOOL))block {
    if (self.finishBlock) {
        self.finishBlock(YES);
    }
    self.finishBlock = block;
}

- (void)speakString:(NSString *)string {
    dispatch_async(self.serialQueue, ^{
        
        if ([self isOnPhoneCall]) {
            return;
        }
        
        if (self.speechSynthesizer) {
            AVSpeechUtterance *aUtterance = [AVSpeechUtterance speechUtteranceWithString:string];
            [aUtterance setVoice:[AVSpeechSynthesisVoice voiceWithLanguage:@"zh-CN"]];
            
            //iOS语音合成在iOS8及以下版本系统上语速异常
            if ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0) {
                aUtterance.rate = 0.25;//iOS7设置为0.25
            } else if ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0) {
                aUtterance.rate = 0.15;//iOS8设置为0.15
            }
            
            if ([self.speechSynthesizer isSpeaking]) {
                [self.speechSynthesizer stopSpeakingAtBoundary:AVSpeechBoundaryWord];
            }
            
            [self activateAudioSessionWithCategory:AVAudioSessionCategoryPlayback
                                           options:AVAudioSessionCategoryOptionMixWithOthers | AVAudioSessionCategoryOptionDuckOthers
                                             error:nil];
            
            [self.speechSynthesizer speakUtterance:aUtterance];
        }
    });
}

- (void)stopSpeak {
    if (self.speechSynthesizer) {
        [self.speechSynthesizer stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
    }
}

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didFinishSpeechUtterance:(AVSpeechUtterance *)utterance {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if ([AVAudioSession sharedInstance].isOtherAudioPlaying) {
            [[AVAudioSession sharedInstance] setActive:NO withOptions:AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation error:nil];
        }
    });
    if (self.finishBlock) {
        self.finishBlock(YES);
        self.finishBlock = NULL;
    }
    if (self.monitorBlock) {
        self.monitorBlock(YES);
        self.monitorBlock = NULL;
    }
}

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didStartSpeechUtterance:(AVSpeechUtterance *)utterance API_AVAILABLE(ios(7.0), watchos(1.0), tvos(7.0), macos(10.14)) {
    
}

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didPauseSpeechUtterance:(AVSpeechUtterance *)utterance API_AVAILABLE(ios(7.0), watchos(1.0), tvos(7.0), macos(10.14)) {
    
}

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didContinueSpeechUtterance:(AVSpeechUtterance *)utterance API_AVAILABLE(ios(7.0), watchos(1.0), tvos(7.0), macos(10.14)) {
    
}

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didCancelSpeechUtterance:(AVSpeechUtterance *)utterance API_AVAILABLE(ios(7.0), watchos(1.0), tvos(7.0), macos(10.14)) {
    if (self.finishBlock) {
        self.finishBlock(YES);
        self.finishBlock = NULL;
    }
    if (self.monitorBlock) {
        self.monitorBlock(YES);
        self.monitorBlock = NULL;
    }
}

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer willSpeakRangeOfSpeechString:(NSRange)characterRange utterance:(AVSpeechUtterance *)utterance API_AVAILABLE(ios(7.0), watchos(1.0), tvos(7.0), macos(10.14)) {
    
}

@end
