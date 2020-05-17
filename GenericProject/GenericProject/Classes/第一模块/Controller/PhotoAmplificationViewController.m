//
//  PhotoAmplificationViewController.m
//  GenericProject
//
//  Created by 社科赛斯 on 2019/12/12.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import "PhotoAmplificationViewController.h"

@interface PhotoAmplificationViewController ()

@property (nonatomic,strong) NSMutableArray *dataArr;

@end

@implementation PhotoAmplificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigation];
    [self createSubViews];
}

- (void)setNavigation {
    self.navView.titleLabelText = @"";
    self.navView.isShowRightButton = YES;
    self.navView.rightButtonTitle = @"清理缓存";
    
    self.navView.RightActionBlock = ^{
        
    };
}

- (void)createSubViews {
    [self.view addSubview:self.mainTableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataArr[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *const ID = @"KNPhotoBrowserID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    NSMutableArray *arr = self.dataArr[indexPath.section];
    cell.textLabel.text = arr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    
    NSArray *arr = self.dataArr[indexPath.section];
    
    Class class = NSClassFromString(arr[indexPath.row]);
    UIViewController *vc = [[class alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
        {
            NSMutableArray *arr = [NSMutableArray array];
            [arr addObject:@"VCViewController"];
            [arr addObject:@"NineSquareController"];
            [arr addObject:@"ScrollViewController"];
            [_dataArr addObject:arr];
        }
        {
            NSMutableArray *arr = [NSMutableArray array];
            [arr addObject:@"ViewLocController"];
            [arr addObject:@"NineSquareLocController"];
            [arr addObject:@"ScrollViewLocController"];
            [_dataArr addObject:arr];
        }
        {
            NSMutableArray *arr = [NSMutableArray array];
            [arr addObject:@"IMViewController"];
            [_dataArr addObject:arr];
        }
    }
    return _dataArr;
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
