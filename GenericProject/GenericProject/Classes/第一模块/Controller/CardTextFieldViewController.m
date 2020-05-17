//
//  CardTextFieldViewController.m
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/11/26.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import "CardTextFieldViewController.h"

@interface CardTextFieldViewController ()

@end

@implementation CardTextFieldViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    LSIDCardTextField * textField =[[LSIDCardTextField alloc] initWithFrame:CGRectMake(100, 100, 200, 30)];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    
    textField.placeholder = @"输入信息...";
    [self.view addSubview:textField];
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
