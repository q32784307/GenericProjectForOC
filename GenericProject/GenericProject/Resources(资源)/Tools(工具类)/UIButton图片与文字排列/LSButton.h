//
//  LSButton.h
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/10/18.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, LSButtonImagePosition) {
    LSButtonImagePositionLeft   = 0,     // 图片在文字左侧
    LSButtonImagePositionRight  = 1,     // 图片在文字右侧
    LSButtonImagePositionTop    = 2,     // 图片在文字上侧
    LSButtonImagePositionBottom = 3      // 图片在文字下侧
};

IB_DESIGNABLE

@interface LSButton : UIButton

- (instancetype)initWithImagePosition:(LSButtonImagePosition)imagePosition;

#if TARGET_INTERFACE_BUILDER // storyBoard/xib中设置
@property(nonatomic,assign)IBInspectable NSInteger imagePosition; // 图片位置
@property(nonatomic,assign)IBInspectable CGFloat imageTitleSpace; // 图片和文字之间的间距
#else // 纯代码设置
@property(nonatomic)LSButtonImagePosition imagePosition; // 图片位置
@property(nonatomic,assign)CGFloat imageTitleSpace; // 图片和文字之间的间距
#endif

@end

NS_ASSUME_NONNULL_END
