//
//  AdaptiveHtmlViewController.m
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/11/26.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import "AdaptiveHtmlViewController.h"
#import "LSAdaptiveHTMLView.h"

@interface AdaptiveHtmlViewController ()

@end

@implementation AdaptiveHtmlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    LSAdaptiveHTMLView *html = [LSAdaptiveHTMLView new];
    [self.view addSubview:html];
    
    
    UILabel *lab = [UILabel new];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.text = @"原生label";
    [self.view addSubview:lab];
    
    
    
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(html);
        make.top.mas_equalTo(html.mas_bottom);
    }];
    
    [html mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(NAVIGATION_BAR_HEIGHT);
        make.left.right.equalTo(self.view);
    }];
    
    
    
    
    [html loadWithUrlStr:@"https://time.geekbang.org/comment/nice-module/30359"];

}

-(void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.translucent = NO;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
