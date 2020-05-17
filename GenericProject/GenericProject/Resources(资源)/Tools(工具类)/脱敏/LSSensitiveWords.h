//
//  LSSensitiveWords.h
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/11/21.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSSensitiveWords : NSObject

/// 读取敏感词
/// @param path 敏感词的路径
- (void)parseSensitiveWords:(NSString *)path;

/// 添加敏感词到敏感词树
/// @param keyword 敏感词
- (void)addSensitiveWords:(NSString *)keyword;

/// 开始过滤敏感词
/// @param message 需要过滤的文本
/// @param replaceKey 替换字符
- (NSString *)filterSensitiveWords:(NSString *)message replaceKey:(NSString *)replaceKey;

@end

NS_ASSUME_NONNULL_END
