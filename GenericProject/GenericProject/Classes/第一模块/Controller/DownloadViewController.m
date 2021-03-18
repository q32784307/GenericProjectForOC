//
//  DownloadViewController.m
//  GenericProject
//
//  Created by 社科塞斯 on 2021/3/18.
//  Copyright © 2021 漠然丶情到深处. All rights reserved.
//

#import "DownloadViewController.h"

@interface DownloadViewController ()

@property(nonatomic,strong)NSData *data;

@end

@implementation DownloadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self a];
    
    UIButton *button1 = [[UIButton alloc]initWithFrame:CGRectMake(50, 100, 50, 30)];
    button1.backgroundColor = LSRedColor;
    [button1 setTitle:@"开始" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(button1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    
    UIButton *button2 = [[UIButton alloc]initWithFrame:CGRectMake(50, 150, 50, 30)];
    button2.backgroundColor = LSRedColor;
    [button2 setTitle:@"暂停" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(button2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
    UIButton *button3 = [[UIButton alloc]initWithFrame:CGRectMake(50, 200, 50, 30)];
    button3.backgroundColor = LSRedColor;
    [button3 setTitle:@"继续" forState:UIControlStateNormal];
    [button3 addTarget:self action:@selector(button3) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button3];
}

- (void)a {
    NSString *url = @"https://www.apple.com/105/media/cn/iphone-x/2017/01df5b43-28e4-4848-bf20-490c34a926a7/films/feature/iphone-x-feature-cn-20170912_1280x720h.mp4";
    [self.networkRequest downloadStartWithHTTPUrl:url headerRequest:nil fileName:nil progress:^(CGFloat progressFloat) {
        dispatch_async(dispatch_get_main_queue(), ^{
            LSNSLog(@"2---下载进度\n%.f",progressFloat);
        });
    } SuccessBlock:^(id responseDict, NSString *filePath) {
        LSNSLog(@"1---下载完成\n%@\n%@",responseDict,filePath);
    } FailureBlock:^(NSError *error) {
        
    }];
    
    
}

- (void)button1 {
    [self.networkRequest operationResume];
}

- (void)button2 {
    [self.networkRequest operationPauseSuspendedBlock:^(NSData *resumeData) {
        self.data = resumeData;
    }];
}

- (void)button3 {
    [self.networkRequest downloadStartWithHTTPUrl:nil headerRequest:nil resumeData:self.data fileName:nil progress:^(CGFloat progressFloat) {
        LSNSLog(@"3---下载进度\n%.f",progressFloat);
    } SuccessBlock:^(id responseDict, NSString *filePath) {
        NSString *path =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
        [self.networkRequest releaseZipFilesWithUnzipFileAtPath:filePath Destination:path];
    } FailureBlock:^(NSError *error) {
        
    }];
    [self.networkRequest operationResume];
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
