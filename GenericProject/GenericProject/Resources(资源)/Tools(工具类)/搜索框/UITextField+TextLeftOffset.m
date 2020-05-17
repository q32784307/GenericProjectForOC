//
//  UITextField+TextLeftOffset.m
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2018/7/20.
//  Copyright © 2018年 漠然丶情到深处. All rights reserved.
//

#import "UITextField+TextLeftOffset.h"

@implementation UITextField (TextLeftOffset)

- (void)setTextOffsetWithLeftViewRect:(CGRect)rect WithMode:(UITextFieldViewMode)mode {
    UIView *view = [[UIView alloc]initWithFrame:rect];
    self.leftView = view;
    self.leftViewMode = mode; //枚举 默认为no 不显示leftView
}

@end
