//
//  NSObject+ViewController.m
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2017/11/2.
//  Copyright © 2017年 漠然丶情到深处. All rights reserved.
//

#import "NSObject+ViewController.h"

@implementation NSObject (ViewController)

- (UIViewController *)ViewController {
    UIViewController *viewController = [[[UIApplication sharedApplication] keyWindow] rootViewController];
    
    return viewController;
}

@end
