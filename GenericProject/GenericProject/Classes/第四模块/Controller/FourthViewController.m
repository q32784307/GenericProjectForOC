//
//  FourthViewController.m
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2018/6/26.
//  Copyright © 2018年 漠然丶情到深处. All rights reserved.
//

#import "FourthViewController.h"
#import "RootTableViewCell.h"
#import "RootModel.h"
#import "LSNSTimerProxy.h"

@interface FourthViewController ()<UITableViewDelegate,UITableViewDataSource,RootTableViewCellDelegate>

@property(nonatomic,strong)UITableView *rootTableView;
@property(nonatomic,strong)UIView *backView;
@property(nonatomic,assign)NSInteger totalHeight;
@property(nonatomic,strong)NSMutableDictionary *didSelectDic;
@property(nonatomic,assign)NSInteger tag;
@property(nonatomic,strong)NSMutableArray<__kindof RootModel *> *data;
@property(nonatomic,strong)NSMutableArray *netArr;


@property(nonatomic,assign)NSInteger num;
@property(nonatomic,strong)NSTimer *timer;

@end

@implementation FourthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.StatusBarStyle = UIStatusBarStyleDefault;
    self.navView.navColor = [UIColor cyanColor];
    self.navView.leftButtonImage = @"back_black";
    self.navView.leftButtonTitle = @"11";
    self.navView.leftButtonTitleColor = [UIColor blackColor];
    self.navView.titleLabelText = @"11";
    self.navView.titleLabelTextColor = [UIColor blackColor];
    
    NSLog(@"%@",NSStringFormat(@"%.2fM",[self filePath]));
    
    
    _didSelectDic = [NSMutableDictionary dictionaryWithCapacity:0];
    [self analysis];
    [self createSubViews];
    
    self.num = 0;
    LSNSTimerProxy *proxy = [LSNSTimerProxy proxyWithTarget:self];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:proxy selector:@selector(timerFire:) userInfo:nil repeats:YES];
}

#pragma mark ————— 计算缓存大小 —————
// 显示缓存大小
- (float)filePath {
    NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    return [self folderSizeAtPath:cachPath];
}

- (float)folderSizeAtPath:(NSString *)path {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    cachePath = [cachePath stringByAppendingPathComponent:path];
    long long folderSize = 0;
    if ([fileManager fileExistsAtPath:cachePath]) {
        NSArray *childerFiles = [fileManager subpathsAtPath:cachePath];
        for (NSString *fileName in childerFiles) {
            NSString *fileAbsolutePath=[cachePath stringByAppendingPathComponent:fileName];
            long long size = [self fileSizeAtPath:fileAbsolutePath];
            folderSize += size;
        }
        return folderSize/1024.0/1024.0;
    }
    return 0;
}

- (long long)fileSizeAtPath:(NSString *)path {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:path]) {
        long long size = [fileManager attributesOfItemAtPath:path error:nil].fileSize;
        return size;
    }
    return 0;
}

- (void)analysis {
    self.data = [NSMutableArray new];
    for (int i = 0; i < _netArr.count; i++) {
        RootModel *foldCellModel = [RootModel modelWithDic:(NSDictionary *)_netArr[i]];
        [self.data addObject:foldCellModel];
    }
    [self.rootTableView reloadData];
}

- (void)createSubViews {
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(pushAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)pushAction {
    NSArray *arr = @[@"全国",@"全国省",@"全国市",@"全国县"];
    for (int i = 0; i<4; i++) {
        
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 45 * i + NAVIGATION_BAR_HEIGHT, LSScreenWidth, 45)];
        bgView.backgroundColor = [UIColor whiteColor];
        bgView.tag = 1000+i;
        [self.view addSubview:bgView];
        
        UILabel *addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 7.5, 100, 30)];
        addressLabel.text = arr[i];
        addressLabel.tag = 2000+i;
        addressLabel.textAlignment = NSTextAlignmentLeft;
        [bgView addSubview:addressLabel];
        
        UIImageView *selectImage = [[UIImageView alloc] initWithFrame:CGRectMake(LSScreenWidth - 30, 14.5, 16, 16)];
        selectImage.tag = 3000+i;
        selectImage.userInteractionEnabled = YES;
        selectImage.hidden = YES;
        selectImage.image = [UIImage imageNamed:@""];
        [bgView addSubview:selectImage];
        
        if (i != 3) {
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(15, 44, bgView.frame.size.width - 15, 1)];
            lineView.backgroundColor = [UIColor colorWithHexString:@"f0f0f0"];
            [bgView addSubview:lineView];
        }
        
        //有箭头的添加手势
        UITapGestureRecognizer *viewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTap:)];
        [bgView addGestureRecognizer:viewTap];
        
        if (i == 3) {
            _totalHeight = CGRectGetMaxY(bgView.frame) + 10;
            
            _backView = [[UIView alloc] initWithFrame:CGRectMake(0, _totalHeight, LSScreenWidth, LSScreenHeight - _totalHeight)];
            _backView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
            [self.view addSubview:_backView];
        }
    }
    
    
    self.rootTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT, LSScreenWidth, LSScreenHeight - HOME_INDICATOR_HEIGHT) style:UITableViewStyleGrouped];
    self.rootTableView.delegate = self;
    self.rootTableView.dataSource = self;
    self.rootTableView.estimatedRowHeight = 0;
    self.rootTableView.estimatedSectionHeaderHeight = 0;
    self.rootTableView.estimatedSectionFooterHeight = 0;
    [self.view addSubview:self.rootTableView];
    if (@available(iOS 11.0, *)) {
        self.rootTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (void)viewTap:(UITapGestureRecognizer *)tap{
    
    UIImageView *image = (UIImageView *)[self.view viewWithTag:tap.view.tag + 2000];
    UILabel *label = (UILabel *)[self.view viewWithTag:tap.view.tag + 1000];
    NSString *codeString = [NSString string];
    if ([label.text isEqualToString:@"全国"]) {
        codeString = @"0";
    }else if ([label.text isEqualToString:@"全国省"]){
        codeString = @"1";
        
    }else if ([label.text isEqualToString:@"全国市"]){
        codeString = @"2";
        
    }else if ([label.text isEqualToString:@"全国县"]){
        codeString = @"3";
    }
    
    
    BOOL isShow = image.hidden;
    for (int i=0; i<4; i++) {
        UIImageView *imageall = (UIImageView *)[self.view viewWithTag:3000+i];
        imageall.hidden = YES;
        if (!isShow) {
            image.hidden = NO;
        }
    }
    if (_tag == image.tag) {
        if (image.hidden == YES) {
            [self.view bringSubviewToFront:_backView];
            [image setHidden:NO];
            [_didSelectDic removeAllObjects];
            [_didSelectDic setObject:[NSString stringWithFormat:@"%@*%@",label.text,codeString] forKey:codeString];
        }else{
            image.hidden = YES;
            [_didSelectDic removeAllObjects];
            [self.view bringSubviewToFront:self.rootTableView];
            [self.rootTableView reloadData];
        }
    }else{
        [self.view bringSubviewToFront:_backView];
        image.hidden = NO;
        [_didSelectDic removeAllObjects];
        [_didSelectDic setObject:[NSString stringWithFormat:@"%@*%@",label.text,codeString] forKey:codeString];
    }
    _tag = image.tag;
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RootTableViewCell * cell = [RootTableViewCell cellWithTableView:tableView];
    cell.delegate = self;
    RootModel *foldCellModel = self.data[indexPath.row];
    [cell levelNameString:foldCellModel.levelName levelString:foldCellModel.level isSelect:NO];
    
    //复用是保留之前勾选数据
    for (NSString *string in [_didSelectDic allValues]) {
        NSArray *array = [string componentsSeparatedByString:@"*"]; //从字符A中分隔成2个元素的数组
        if ([foldCellModel.levelName isEqualToString:array[0]]) {
            
            [cell levelNameString:foldCellModel.levelName levelString:foldCellModel.level isSelect:YES];
            
        }
    }
    //北京上海重庆天津只有两级联动
    NSString *string = foldCellModel.supermodel.levelName;
    if ([string isEqualToString:@"北京"] || [string isEqualToString:@"重庆"]||[string isEqualToString:@"上海"]||[string isEqualToString:@"天津"]) {
        cell.imageUpView.hidden = YES;
    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath {
    RootModel *foldCellModel = self.data[indexPath.row];
    return foldCellModel.level.intValue;
}

#pragma mark- 点击显示下一级
- (void)showCell:(RootTableViewCell *)cell {
    NSIndexPath *indexPath = [self.rootTableView indexPathForCell:cell];
    RootModel *didSelectFoldCellModel = self.data[indexPath.row];
    if ([didSelectFoldCellModel.level intValue] != 2) {
        [self.rootTableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    
    [self.rootTableView beginUpdates];
    //打开子数据
    if (didSelectFoldCellModel.belowCount == 0) {
        
        if ([didSelectFoldCellModel.level intValue] != 2) {
            
            cell.imageUpView.image = [UIImage imageNamed:@""];
            NSString *string = didSelectFoldCellModel.supermodel.levelName;
            
            if ([didSelectFoldCellModel.level intValue] == 1) {
                
                if ([string isEqualToString:@"北京"] || [string isEqualToString:@"重庆"]||[string isEqualToString:@"上海"]||[string isEqualToString:@"天津"]) {
                    
                    if (cell.imageSelectView.hidden == YES) {
                        cell.imageSelectView.hidden = NO;
                        [_didSelectDic setObject:[NSString stringWithFormat:@"%@*%@",didSelectFoldCellModel.levelName,didSelectFoldCellModel.busiAreaId] forKey:didSelectFoldCellModel.busiAreaId];
                    }else{
                        [_didSelectDic removeObjectForKey:didSelectFoldCellModel.busiAreaId];
                        cell.imageSelectView.hidden = YES;
                    }
                }
            }
        }else{
            //关闭子数据
            if (cell.imageSelectView.hidden == YES) {
                cell.imageSelectView.hidden = NO;
                
                [_didSelectDic setObject:[NSString stringWithFormat:@"%@*%@",didSelectFoldCellModel.levelName,didSelectFoldCellModel.busiAreaId] forKey:didSelectFoldCellModel.busiAreaId];
            }else{
                cell.imageSelectView.hidden = YES;
                [_didSelectDic removeObjectForKey:didSelectFoldCellModel.busiAreaId];
            }
        }
        //Data
        NSArray *submodels = [didSelectFoldCellModel open];
        
        NSIndexSet *indexes = [NSIndexSet indexSetWithIndexesInRange:((NSRange){indexPath.row + 1,submodels.count})];
        [self.data insertObjects:submodels atIndexes:indexes];
        
        //Rows
        NSMutableArray *indexPaths = [NSMutableArray new];
        for (int i = 0; i < submodels.count; i++) {
            NSIndexPath *insertIndexPath = [NSIndexPath indexPathForRow:(indexPath.row + 1 + i) inSection:indexPath.section];
            [indexPaths addObject:insertIndexPath];
        }
        [self.rootTableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
        
    }else {
        if ([didSelectFoldCellModel.level intValue] != 2) {
            
            cell.imageUpView.image = [UIImage imageNamed:@""];
        }
        //Data
        NSArray *submodels = [self.data subarrayWithRange:((NSRange){indexPath.row + 1,didSelectFoldCellModel.belowCount})];
        [didSelectFoldCellModel closeWithSubmodels:submodels];
        [self.data removeObjectsInArray:submodels];
        
        //Rows
        NSMutableArray *indexPaths = [NSMutableArray new];
        for (int i = 0; i < submodels.count; i++) {
            NSIndexPath *insertIndexPath = [NSIndexPath indexPathForRow:(indexPath.row + 1 + i) inSection:indexPath.section];
            [indexPaths addObject:insertIndexPath];
        }
        [self.rootTableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
    }
    [self.rootTableView endUpdates];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //选中
    RootModel *didSelectFoldCellModel = self.data[indexPath.row];
    if ([didSelectFoldCellModel.level intValue] != 2) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    
    RootTableViewCell * cell = (RootTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    [tableView beginUpdates];
    
    //打开子数据
    if (didSelectFoldCellModel.belowCount == 0) {
        //关闭子数据
        if (cell.imageSelectView.hidden == YES) {
            cell.imageSelectView.hidden = NO;
            [_didSelectDic setObject:[NSString stringWithFormat:@"%@*%@",didSelectFoldCellModel.levelName,didSelectFoldCellModel.busiAreaId] forKey:didSelectFoldCellModel.busiAreaId];
        }else{
            cell.imageSelectView.hidden = YES;
            [_didSelectDic removeObjectForKey:didSelectFoldCellModel.busiAreaId];
        }
    }else{
        if ([didSelectFoldCellModel.level intValue] != 2) {
            cell.imageUpView.image = [UIImage imageNamed:@""];
        }
    }
    [tableView endUpdates];
}

- (void)dealloc {
    NSLog(@"BViewController dealloc");
    // invalidate：停止定时器，并把timer从RunLoop中移除，并把timer的target强引用去除
    [self.timer invalidate];
    self.timer = nil;
}

- (void)timerFire:(NSTimer *)timer {
    self.num ++;
    NSLog(@"num = %ld", self.num);
}

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
