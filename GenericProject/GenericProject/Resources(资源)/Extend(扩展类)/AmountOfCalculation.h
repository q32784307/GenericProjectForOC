//
//  AmountOfCalculation.h
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2018/7/11.
//  Copyright © 2018年 漠然丶情到深处. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AmountOfCalculation : NSObject

+ (NSInteger)refundMoneyRound:(NSInteger)centPercent;
+ (NSString *)centToYuan2Digits:(NSInteger)cent;
+ (NSString *)centToYuan1Digits:(NSInteger)cent;
+ (NSInteger)yuanToCent:(NSString *)yuan;

@end
