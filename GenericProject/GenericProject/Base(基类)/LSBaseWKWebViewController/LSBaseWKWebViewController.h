//
//  LSBaseWKWebViewController.h
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2018/7/3.
//  Copyright © 2018年 漠然丶情到深处. All rights reserved.
//

#import "LSBaseViewController.h"

@interface LSBaseWKWebViewController : LSBaseViewController

@property(nonatomic,strong)WKWebView *webView;
@property(nonatomic,strong)UIProgressView *progressView;
@property(nonatomic)UIColor *progressViewColor;
@property(nonatomic,weak)WKWebViewConfiguration *webConfiguration;
@property(nonatomic,copy)NSString *url;

- (instancetype)initWithUrl:(NSString *)url;

//更新进度条
- (void)updateProgress:(double)progress;

@end
