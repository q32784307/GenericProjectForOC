//
//  AmountOfCalculation.m
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2018/7/11.
//  Copyright © 2018年 漠然丶情到深处. All rights reserved.
//

#import "AmountOfCalculation.h"

@implementation AmountOfCalculation

/* 使用“分*百分比”单位的金额计算金额 */
+ (NSInteger)refundMoneyRound:(NSInteger)centPercent {
    NSInteger remainder = centPercent % 1000;
    NSInteger cents = 10 * (centPercent / 1000);
    if (remainder > 0) {
        cents += 10;
    }
    return cents;
}

+ (NSString *)centToYuan2Digits:(NSInteger)cent {
    NSInteger yuan = cent / 100;
    NSInteger remainder = cent % 100;
    return [NSString stringWithFormat:@"%ld.%02ld", (long)yuan, (long)remainder];
}

+ (NSString *)centToYuan1Digits:(NSInteger)cent {
    if (cent % 10 != 0) {
        return @"<Bad Cent Value>";
    }
    NSInteger yuan = cent / 100;
    NSInteger remainder = (cent % 100) / 10;
    return [NSString stringWithFormat:@"%ld.%ld", (long)yuan, (long)remainder];
}

+ (NSInteger)yuanToCent:(NSString *)yuan {
    if (!yuan) return -1;
    NSRegularExpression *reg = [NSRegularExpression regularExpressionWithPattern:@"^(\\d+)(\\.(\\d\\d?))?$" options: 0 error:nil];
    NSTextCheckingResult *r = [reg firstMatchInString:yuan options:0 range:NSMakeRange(0, yuan.length)];
    if (!r) return -1;
    NSString *s1 = [yuan substringWithRange:[r rangeAtIndex:1]];
    NSRange r2 = [r rangeAtIndex:3];
    if (r2.location == NSNotFound) {
        return [s1 integerValue] * 100;
    } else {
        NSString *s2 = [yuan substringWithRange:r2];
        if (s2.length == 1) {
            return [s1 integerValue] * 100 + [s2 integerValue] * 10;
        } else if (s2.length == 2) {
            return [s1 integerValue] * 100 + [s2 integerValue];
        } else {
            return -1;
        }
    }
}

@end
