//
//  LSUIHeader.h
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/10/18.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#define Font(a)       [UIFont systemFontOfSize:a]
#define BFont(a)      [UIFont boldSystemFontOfSize:a]
#define LSImage(name) [UIImage imageNamed:name]

#define LSWinodwWidth        [UIScreen mainScreen].bounds.size.width
#define LSWinodwHeight       [UIScreen mainScreen].bounds.size.height



#define LSColorWithHex(value) [UIColor \
colorWithRed:((float)((value & 0xFF0000) >> 16))/255.0 \
green:((float)((value & 0xFF00) >> 8))/255.0 \
blue:((float)(value & 0xFF))/255.0 alpha:1.0]

#define LSAfter(timer,block)     dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(timer * NSEC_PER_SEC)), dispatch_get_main_queue(),block)


static inline UILabel * CreateLeftAlignmentLabel(UIFont *font,UIColor *textColor) {
    UILabel *leftLabel = [UILabel new];
    leftLabel.font = font;
    leftLabel.textColor = textColor;
    leftLabel.textAlignment = NSTextAlignmentLeft;
    leftLabel.adjustsFontSizeToFitWidth = true;
    //宽度不够时压缩
    [leftLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    //宽度够时正常显示
    [leftLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    return leftLabel;
}

static inline UILabel * CreateCenterAlignmentLabel(UIFont *font,UIColor *textColor) {
    UILabel *leftLabel = [UILabel new];
    leftLabel.font = font;
    leftLabel.textColor = textColor;
    leftLabel.textAlignment = NSTextAlignmentCenter;
    leftLabel.adjustsFontSizeToFitWidth = true;
    //宽度不够时压缩
    [leftLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    //宽度够时正常显示
    [leftLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    return leftLabel;
}

static inline UILabel * CreateRightAlignmentLabel(UIFont *font,UIColor *textColor) {
    UILabel *leftLabel = [UILabel new];
    leftLabel.font     = font;
    leftLabel.textColor = textColor;
    leftLabel.textAlignment = NSTextAlignmentRight;
    leftLabel.adjustsFontSizeToFitWidth = true;
    //宽度不够时压缩
    [leftLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    //宽度够时正常显示
    [leftLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    return leftLabel;
}

NS_ASSUME_NONNULL_BEGIN

@interface LSUIHeader : NSObject

@end

NS_ASSUME_NONNULL_END
