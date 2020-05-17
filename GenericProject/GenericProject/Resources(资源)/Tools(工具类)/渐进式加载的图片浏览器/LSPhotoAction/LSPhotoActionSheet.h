//
//  LSPhotoActionSheet.h
//  GenericProject
//
//  Created by 社科赛斯 on 2019/12/17.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ActionBlock)(NSInteger buttonIndex);

@interface LSPhotoActionSheet : UIView

/**
 alert

 @param cancelTitle title of cancel
 @param otherTitleArr other title array
 @param ActionBlock call back
 @return alert
 */
- (instancetype)initWithCancelTitle:(NSString *)cancelTitle
                      otherTitleArr:(NSArray  *)otherTitleArr
                        actionBlock:(ActionBlock)ActionBlock;

/**
 alert  + destruction

 @param cancelTitle title of cancel
 @param destructiveTitle destructive title
 @param otherTitleArr other title array
 @param ActionBlock call back
 @return alert
 */
- (instancetype)initWithCancelTitle:(NSString *)cancelTitle
                   destructiveTitle:(NSString *)destructiveTitle
                      otherTitleArr:(NSArray  *)otherTitleArr
                        actionBlock:(ActionBlock)ActionBlock;

/**
 alert + destructive + index of destructive

 @param cancelTitle title of cancel
 @param destructiveTitle destructive title
 @param destructiveIndex destructive index
 @param otherTitleArr other title array
 @param ActionBlock call back
 @return alert
 */
- (instancetype)initWithCancelTitle:(NSString *)cancelTitle
                   destructiveTitle:(NSString *)destructiveTitle
                   destructiveIndex:(NSInteger )destructiveIndex
                      otherTitleArr:(NSArray  *)otherTitleArr
                        actionBlock:(ActionBlock)ActionBlock;


- (void)show;
- (void)dismiss;

@end

NS_ASSUME_NONNULL_END
