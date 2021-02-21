//
//  UIColor+LSDartOrLight.h
//  GenericProject
//
//  Created by 社科塞斯 on 2021/2/21.
//  Copyright © 2021 漠然丶情到深处. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (LSDartOrLight)

+ (UIColor *)lsLigthColor:(UIColor *)lightColor darkColor:(UIColor *)darkColor;

@end

NS_ASSUME_NONNULL_END
