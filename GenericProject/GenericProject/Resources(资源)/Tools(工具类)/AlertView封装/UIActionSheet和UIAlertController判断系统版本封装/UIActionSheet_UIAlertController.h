//
//  UIActionSheet_UIAlertController.h
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2016/10/19.
//  Copyright © 2016年  漠然丶情到深处. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIActionSheet_UIAlertController : UIView

@property(nonatomic,copy)void (^Click)(NSInteger clickIndex);

- (instancetype)initWithFrame:(CGRect)frame titleArr:(NSArray *)titleArr;

- (void)hiddenSheet;

@end
