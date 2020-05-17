//
//  JSHandler.h
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2018/6/22.
//  Copyright © 2018年 漠然丶情到深处. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSHandler : NSObject<WKScriptMessageHandler>

@property(nonatomic,weak,readonly)UIViewController *webVC;
@property(nonatomic,strong,readonly)WKWebViewConfiguration *configuration;

- (instancetype)initWithViewController:(UIViewController *)webVC configuration:(WKWebViewConfiguration *)configuration;

- (void)cancelHandler;

@end
