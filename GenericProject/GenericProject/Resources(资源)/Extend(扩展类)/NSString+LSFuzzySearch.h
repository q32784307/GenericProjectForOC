//
//  NSString+LSFuzzySearch.h
//  GenericProject
//
//  Created by 社科塞斯 on 2021/2/21.
//  Copyright © 2021 漠然丶情到深处. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (LSFuzzySearch)

+ (NSString *)tansformToMixedStringWithOriginStr:(NSString *)originStr;

@end

NS_ASSUME_NONNULL_END
