//
//  LSPhotoToast.h
//  GenericProject
//
//  Created by 社科赛斯 on 2019/12/17.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSPhotoToast : UIView

+ (instancetype)shareToast;

- (void)initWithText:(NSString *)text;
- (void)initWithText:(NSString *)text offSetY:(CGFloat)offsetY;

- (void)initWithText:(NSString *)text duration:(NSInteger)duration;
- (void)initWithText:(NSString *)text duration:(NSInteger)duration offSetY:(CGFloat)offsetY;

@end

NS_ASSUME_NONNULL_END
