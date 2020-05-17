//
//  MoreViewController.m
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2018/6/26.
//  Copyright © 2018年 漠然丶情到深处. All rights reserved.
//

#import "MoreViewController.h"

@interface MoreViewController ()

@end

@implementation MoreViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"发布";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    UIButton *leftButton = [[UIButton alloc] init];
//    leftButton.frame = CGRectMake(0, 0, 12, 21);
//    leftButton.adjustsImageWhenHighlighted = NO;
//    [leftButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
//    [leftButton setImage:[UIImage imageNamed:@"back_ black"] forState:UIControlStateNormal];
//    UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
//    self.navigationItem.leftBarButtonItem = btn;
}

//- (void)backAction {
//    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
