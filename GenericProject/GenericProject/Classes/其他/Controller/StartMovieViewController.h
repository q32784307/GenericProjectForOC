//
//  StartMovieViewController.h
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2018/6/12.
//  Copyright © 2018年 漠然丶情到深处. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StartMovieViewController : UIViewController

@property(nonatomic,strong)NSURL *movieURL;

@end

//用法
//KNMovieViewController *KNVC = [[KNMovieViewController alloc]init];
//NSString *path =  [[NSBundle mainBundle] pathForResource:@"movie.mp4" ofType:nil];
//KNVC.movieURL = [NSURL fileURLWithPath:path];
