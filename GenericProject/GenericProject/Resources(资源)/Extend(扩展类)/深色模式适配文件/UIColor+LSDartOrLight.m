//
//  UIColor+LSDartOrLight.m
//  GenericProject
//
//  Created by 社科塞斯 on 2021/2/21.
//  Copyright © 2021 漠然丶情到深处. All rights reserved.
//

#import "UIColor+LSDartOrLight.h"

@implementation UIColor (LSDartOrLight)

+ (UIColor *)lsLigthColor:(UIColor *)lightColor darkColor:(UIColor *)darkColor {
    if (@available(iOS 13.0, *)) {
        return [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
            if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
                return darkColor;
            } else {
                return lightColor;
            }
        }];
    }
    return nil;
}

@end
