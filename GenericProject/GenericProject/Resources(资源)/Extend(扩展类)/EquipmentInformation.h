//
//  EquipmentInformation.h
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2018/6/20.
//  Copyright © 2018年 漠然丶情到深处. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EquipmentInformation : NSString

// 获取设备型号然后手动转化为对应名称
+ (NSString *)getDeviceName;

//运营商
+ (CTCarrier *)Operator;

//电池状态
+ (void)batteryState;

@end
