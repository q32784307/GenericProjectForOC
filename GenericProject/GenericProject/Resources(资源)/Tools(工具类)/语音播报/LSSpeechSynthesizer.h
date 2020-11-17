//
//  LSSpeechSynthesizer.h
//  GenericProject
//
//  Created by 社科塞斯 on 2020/11/17.
//  Copyright © 2020 漠然丶情到深处. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 *  iOS7及以上版本可以使用 AVSpeechSynthesizer 合成语音
 *
 *  或者采用"科大讯飞"等第三方的语音合成服务
 */

@interface LSSpeechSynthesizer : NSObject

+ (instancetype)sharedSpeechSynthesizer;

- (BOOL)isSpeaking;

- (void)speakString:(NSString *)string;


- (void)configMonitorBlock:(void (^)(BOOL finished))block;
- (void)configFinishBlock:(void (^)(BOOL finished))block;

- (void)stopSpeak;

@end

NS_ASSUME_NONNULL_END
