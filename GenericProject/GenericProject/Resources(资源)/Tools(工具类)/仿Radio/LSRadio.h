//
//  LSRadio.h
//  GenericProject
//
//  Created by 社科塞斯 on 2020/8/11.
//  Copyright © 2020 漠然丶情到深处. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSRadio : UIButton

@property(nonatomic,copy,readonly)NSString *name;
@property(nonatomic,copy,readonly)NSString *val;
///初始化
+ (LSRadio *)creatRadioWithName:(NSString *)name val:(NSString *)val selected:(BOOL)selected;

@end

NS_ASSUME_NONNULL_END
