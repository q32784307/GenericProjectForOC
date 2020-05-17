//
//  UIView+LSBadge.m
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/6/25.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import "UIView+LSBadge.h"

#define LSBadgeTag 1104
#define LSNumberLabelTag 1103
#define LSNormalBadgeWidth 7
#define LSNumberBadgeWidth 18 // 带数字的最小宽度

static const char *offsetSizeKey = "badgeSizeKey";

@implementation UIView (LSBadge)

#pragma mark - normal

- (void)addNormalBadgeWithBadgeOffsetSize:(CGSize)size {
    [self addNormalBadgeWithColor:[UIColor redColor] borderColor:nil badgeOffsetSize:size];
}

- (void)addNormalBadgeWithColor:(UIColor *)color borderColor:(UIColor *)bColor badgeOffsetSize:(CGSize)size {
    CGSize s = self.frame.size;
    CGFloat w = LSNormalBadgeWidth;
    UIView *badgeView = [[UIView alloc] initWithFrame:CGRectMake(s.width - size.width - w * 0.1, size.height - w * 0.7, w, w)];
    badgeView.backgroundColor = color;
    badgeView.layer.cornerRadius = w / 2;
    badgeView.clipsToBounds = YES;
    
    if (bColor) {
        badgeView.layer.borderColor = bColor.CGColor;
        badgeView.layer.borderWidth = 1.5;
    }
    
    badgeView.tag = LSBadgeTag;
    [self addSubview:badgeView];
}

#pragma mark - 带有数字的
- (void)addNumberBadge:(NSInteger)number badgeOffsetSize:(CGSize)size {
    [self addNumberBadge:number badgeOffsetSize:size color:[UIColor redColor] borderColor:nil];
}

- (void)addNumberBadge:(NSInteger)number badgeOffsetSize:(CGSize)size color:(UIColor *)color borderColor:(UIColor *)bColor {
    
    objc_setAssociatedObject(self, offsetSizeKey, [NSValue valueWithCGSize:size], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    CGSize s = self.bounds.size;
    CGFloat w = LSNumberBadgeWidth;
    UIView *badgeView =  [[UIView alloc] init];
    badgeView.backgroundColor = color;
    badgeView.hidden = number <= 0? YES : NO;
    badgeView.layer.cornerRadius = w / 2;
    badgeView.clipsToBounds = YES;
    
    if (bColor) {
        badgeView.layer.borderWidth = 1.5;
        badgeView.layer.borderColor = bColor.CGColor;
    }
    
    UILabel *numberLabel = [[UILabel alloc] init];
    numberLabel.font = [UIFont systemFontOfSize:10 weight:10];
    numberLabel.textAlignment = NSTextAlignmentCenter;
    numberLabel.text = [NSString stringWithFormat:@"%ld",(long)number];
    numberLabel.textColor = [UIColor whiteColor];
    numberLabel.tag = LSNumberLabelTag;
    
    CGSize badgeSize = [self caluateSizeWithText:numberLabel.text font:numberLabel.font];
    badgeView.frame = CGRectMake(s.width - size.width - badgeSize.width / 2, size.height - badgeSize.height / 2, badgeSize.width, badgeSize.height);
    numberLabel.frame = badgeView.bounds;
    
    badgeView.tag = LSBadgeTag;
    [badgeView addSubview:numberLabel];
    [self addSubview:badgeView];
}

- (void)addNumber_1 {
    [self numberChangeByAdd:YES];
}

- (void)reduceNumber_1 {
    [self numberChangeByAdd:NO];
}

- (void)numberChangeByAdd:(BOOL)add {
    UIView *badgeView = [self viewWithTag:LSBadgeTag];
    if (!badgeView) {
        return;
    }
    
    UILabel *numberLabel = [badgeView viewWithTag:LSNumberLabelTag];
    if (!numberLabel) {
        return;
    }
    
    CGSize offsetSize = [objc_getAssociatedObject(self, offsetSizeKey) CGSizeValue];
    
    NSInteger number = numberLabel.text.integerValue;
    
    if (add) {
        number += 1;
    } else {
        if (number == 0) {
            return;
        }
        number -= 1;
    }
    
    numberLabel.text = [NSString stringWithFormat:@"%ld", (long)number];
    CGSize badgeSize = [self caluateSizeWithText:numberLabel.text font:numberLabel.font];
    CGSize s = self.bounds.size;
    badgeView.frame = CGRectMake(s.width - offsetSize.width - badgeSize.width / 2, offsetSize.height - badgeSize.height / 2, badgeSize.width, badgeSize.height);
    numberLabel.frame = badgeView.bounds;
    
    if (number <= 0) {
        [self clearNumberBadge];
    } else {
        if (badgeView.hidden) {
            badgeView.hidden = NO;
        }
    }
}

#pragma mark - 计算Size
- (CGSize)caluateSizeWithText:(NSString *)text font:(UIFont *)font {
    CGFloat w = LSNumberBadgeWidth;
    CGSize numberSize = [text sizeWithAttributes:@{NSFontAttributeName: font}];
    return CGSizeMake(MAX(w, numberSize.width + 2 * 2), MAX(w, numberSize.height + 2 * 2));
}

#pragma mark - 移除
- (void)clearNumberBadge {
    UIView *badgeView = [self viewWithTag:LSBadgeTag];
    if (!badgeView) {
        return;
    }
    
    badgeView.hidden = YES;
}

@end
