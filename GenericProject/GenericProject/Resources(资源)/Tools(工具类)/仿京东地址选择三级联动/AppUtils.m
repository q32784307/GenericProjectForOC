//
//  AppUtils.m
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/7/10.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import "AppUtils.h"

@implementation AppUtils

+ (CGFloat)widthOfString:(NSString *)string font:(int)font height:(CGFloat)height {
    NSDictionary *dict = [NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:font]forKey:NSFontAttributeName];
    CGRect rect = [string boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    return rect.size.width;
}

@end
