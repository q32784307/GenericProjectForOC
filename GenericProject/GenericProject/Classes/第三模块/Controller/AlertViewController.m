//
//  AlertViewController.m
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2018/6/25.
//  Copyright © 2018年 漠然丶情到深处. All rights reserved.
//

#import "AlertViewController.h"
#import "BalloonRefreshHeader.h"

@interface AlertViewController ()

@property(nonatomic,copy)NSArray *titleArray;

@end

@implementation AlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self analysis];
    [self createSubViews];
    self.isOpenUpDate = YES;
    
    BalloonRefreshHeader *header = [BalloonRefreshHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.mainTableView.mj_header endRefreshing];
        });
    }];
    self.mainTableView.mj_header = header;
}

- (void)analysis {
    self.titleArray = @[@"2.1.常规alertController-Alert",
    @"2.2.一个按钮",
    @"2.3.无按钮alert-toast",
    @"2.4.常规alertController-ActionSheet",
    @"2.5.无按钮actionSheet-toast",
    @"直角边UIAlertSheetView"];
}

- (void)createSubViews {
    [self.view addSubview:self.mainTableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellId = @"TableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.textLabel.font = [UIFont systemFontOfSize:LSSYRealValue(30 / 2)];
    }
    cell.backgroundColor = [self randomColor];
    cell.textLabel.text = _titleArray[indexPath.row];
    cell.textLabel.numberOfLines = 0;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        [self showAlertWithTitle:@"常规alertController-Alert" message:@"基于系统UIAlertController封装，按钮以链式语法模式快捷添加，可根据按钮index区分响应，可根据action区分响应，支持配置弹出、关闭回调，可关闭弹出动画" appearanceProcess:^(AlertController * _Nonnull alertMaker) {
            alertMaker.
            addActionCancelTitle(@"cancel").
            addActionDestructiveTitle(@"按钮1");
        } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, AlertController * _Nonnull alertSelf) {
            if (buttonIndex == 0) {
                NSLog(@"cancel");
            }
            else if (buttonIndex == 1) {
                NSLog(@"按钮1");
            }
            NSLog(@"%@--%@", action.title, action);
        }];
    }
    
    if (indexPath.row == 1) {
        [self showAlertWithTitle:LSEmptyTitle message:@"一个按钮" appearanceProcess:^(AlertController * _Nonnull alertMaker) {
            alertMaker.
            addActionCancelTitle(@"确定");
        } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, AlertController * _Nonnull alertSelf) {
            if (buttonIndex == 0) {
                NSLog(@"确定");
            }
            NSLog(@"%@--%@", action.title, action);
        }];
    }
    
    if (indexPath.row == 2) {
        [self showAlertWithTitle:LSEmptyTitle message:@"toast样式，可自定义展示延时时间，支持配置弹出、关闭回调，可关闭弹出动画" appearanceProcess:^(AlertController * _Nonnull alertMaker) {
            alertMaker.toastStyleDuration = 2;
        } actionsBlock:NULL];
    }
    
    if (indexPath.row == 3) {
        [self showActionSheetWithTitle:@"常规alertController-ActionSheet" message:@"基于系统UIAlertController封装，按钮以链式语法模式快捷添加，可根据按钮index区分响应，可根据action区分响应，支持配置弹出、关闭回调，可关闭弹出动画" appearanceProcess:^(AlertController * _Nonnull alertMaker) {
            alertMaker.
            addActionCancelTitle(@"cancel").
            addActionDestructiveTitle(@"按钮1").
            addActionDefaultTitle(@"按钮2").
            addActionDefaultTitle(@"按钮3").
            addActionDestructiveTitle(@"按钮4");
        } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, AlertController * _Nonnull alertSelf) {
            
            if ([action.title isEqualToString:@"cancel"]) {
                NSLog(@"cancel");
            }
            else if ([action.title isEqualToString:@"按钮1"]) {
                NSLog(@"按钮1");
            }
            else if ([action.title isEqualToString:@"按钮2"]) {
                NSLog(@"按钮2");
            }
            else if ([action.title isEqualToString:@"按钮3"]) {
                NSLog(@"按钮3");
            }
            else if ([action.title isEqualToString:@"按钮4"]) {
                NSLog(@"按钮4");
            }
        }];
    }
    
    if (indexPath.row == 4) {
        [self showActionSheetWithTitle:@"无按钮actionSheet-toast" message:@"toast样式，可自定义展示延时时间，支持配置弹出、关闭回调，可关闭弹出动画" appearanceProcess:^(AlertController * _Nonnull alertMaker) {
            alertMaker.toastStyleDuration = 3;
            //关闭动画效果
            [alertMaker alertAnimateDisabled];
        } actionsBlock:NULL];
    }
    if (indexPath.row == 5) {
        UIActionSheet_UIAlertController *a = [[UIActionSheet_UIAlertController alloc] initWithFrame:self.view.bounds titleArr:@[@"从手机相册选择", @"拍照", @"小视频"]];
        __weak typeof(a) weakA = a;
        a.Click = ^(NSInteger clickIndex) {
            switch (clickIndex) {
                case 0:
                    NSLog(@"相册选择");
                    break;
                case 1:
                    NSLog(@"拍照");
                    break;
                case 2:
                    NSLog(@"小视频");
                    break;
                default:
                    break;
            }
            [weakA hiddenSheet];
        };
        [self.navigationController.view addSubview:a];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return LSSYRealValue(100 / 2);
}

#pragma mark - 随机色
- (UIColor *)randomColor {
    CGFloat r = arc4random_uniform(255);
    CGFloat g = arc4random_uniform(255);
    CGFloat b = arc4random_uniform(255);
    
    return [UIColor colorWithRed:(r / 255.0) green:(g / 255.0) blue:(b / 255.0) alpha:0.3f];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UILabel *)labelWithText:(NSString *)text {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 20)];
    label.text = text;
    label.font = [UIFont boldSystemFontOfSize:20];
    label.backgroundColor = [[self randomColor] colorWithAlphaComponent:0.5];
    label.textAlignment = NSTextAlignmentCenter;
    
    return label;
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
