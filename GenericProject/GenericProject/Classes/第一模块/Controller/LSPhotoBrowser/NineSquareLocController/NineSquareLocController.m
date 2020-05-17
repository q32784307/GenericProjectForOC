//
//  NineSquareLocController.m
//  GenericProject
//
//  Created by 社科赛斯 on 2019/12/17.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import "NineSquareLocController.h"
#import "NineSquareModel.h"
#import "NineSquareLocCell.h"

@interface NineSquareLocController ()

@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) NineSquareLocCell *cell;

@end

@implementation NineSquareLocController

- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (instancetype)init{
    if (self = [super init]) {
        
        {
            NineSquareUrlModel *urlModel = [[NineSquareUrlModel alloc] init];
            urlModel.img = [UIImage imageNamed:@"LSPhotoBrowser1.jpg"];
            NineSquareModel *model = [[NineSquareModel alloc] init];
            model.title = @"一条数据";
            model.urlArr = [NSMutableArray array];
            [model.urlArr addObject:urlModel];
            [self.dataArr addObject:model];
        }
        
        {
            NineSquareUrlModel *urlModel = [[NineSquareUrlModel alloc] init];
            urlModel.img = [UIImage imageNamed:@"LSPhotoBrowser1.jpg"];
            NineSquareUrlModel *urlModel2 = [[NineSquareUrlModel alloc] init];
            urlModel2.img = [UIImage imageNamed:@"LSPhotoBrowser2.jpg"];
            NineSquareUrlModel *urlModel3 = [[NineSquareUrlModel alloc] init];
            urlModel3.img = [UIImage imageNamed:@"LSPhotoBrowser3.jpg"];
            NineSquareModel *model = [[NineSquareModel alloc] init];
            
            model.title = @"三条数据";
            
            model.urlArr = [NSMutableArray array];
            [model.urlArr addObject:urlModel];
            [model.urlArr addObject:urlModel2];
            [model.urlArr addObject:urlModel3];
            
            [self.dataArr addObject:model];
        }
        
        {
            NineSquareUrlModel *urlModel = [[NineSquareUrlModel alloc] init];
            urlModel.img = [UIImage imageNamed:@"LSPhotoBrowser1.jpg"];
            NineSquareUrlModel *urlModel2 = [[NineSquareUrlModel alloc] init];
            urlModel2.img = [UIImage imageNamed:@"LSPhotoBrowser2.jpg"];
            NineSquareUrlModel *urlModel3 = [[NineSquareUrlModel alloc] init];
            urlModel3.img = [UIImage imageNamed:@"LSPhotoBrowser3.jpg"];
            NineSquareUrlModel *urlModel4 = [[NineSquareUrlModel alloc] init];
            urlModel4.img = [UIImage imageNamed:@"LSPhotoBrowser4.jpg"];
            NineSquareUrlModel *urlModel5 = [[NineSquareUrlModel alloc] init];
            urlModel5.img = [UIImage imageNamed:@"LSPhotoBrowser5.jpg"];
            
            NineSquareModel *model = [[NineSquareModel alloc] init];
            model.title = @"五条数据";
            model.urlArr = [NSMutableArray array];
            [model.urlArr addObject:urlModel];
            [model.urlArr addObject:urlModel2];
            [model.urlArr addObject:urlModel3];
            [model.urlArr addObject:urlModel4];
            [model.urlArr addObject:urlModel5];
            [self.dataArr addObject:model];
        }
        
        {
            NineSquareUrlModel *urlModel = [[NineSquareUrlModel alloc] init];
            urlModel.img = [UIImage imageNamed:@"LSPhotoBrowser1.jpg"];
            NineSquareUrlModel *urlModel2 = [[NineSquareUrlModel alloc] init];
            urlModel2.img = [UIImage imageNamed:@"LSPhotoBrowser2.jpg"];
            NineSquareUrlModel *urlModel3 = [[NineSquareUrlModel alloc] init];
            urlModel3.img = [UIImage imageNamed:@"LSPhotoBrowser3.jpg"];
            NineSquareUrlModel *urlModel4 = [[NineSquareUrlModel alloc] init];
            urlModel4.img = [UIImage imageNamed:@"LSPhotoBrowser4.jpg"];
            NineSquareUrlModel *urlModel5 = [[NineSquareUrlModel alloc] init];
            urlModel5.img = [UIImage imageNamed:@"LSPhotoBrowser5.jpg"];
            NineSquareUrlModel *urlModel6 = [[NineSquareUrlModel alloc] init];
            urlModel6.img = [UIImage imageNamed:@"LSPhotoBrowser6.jpg"];
            NineSquareUrlModel *urlModel7 = [[NineSquareUrlModel alloc] init];
            urlModel7.img = [UIImage imageNamed:@"LSPhotoBrowser7.jpg"];
            
            NineSquareModel *model = [[NineSquareModel alloc] init];
            model.title = @"七条数据";
            model.urlArr = [NSMutableArray array];
            
            [model.urlArr addObject:urlModel];
            [model.urlArr addObject:urlModel2];
            [model.urlArr addObject:urlModel3];
            [model.urlArr addObject:urlModel4];
            [model.urlArr addObject:urlModel5];
            [model.urlArr addObject:urlModel6];
            [model.urlArr addObject:urlModel7];
            
            [self.dataArr addObject:model];
        }
        
        {
            NineSquareUrlModel *urlModel = [[NineSquareUrlModel alloc] init];
            urlModel.img = [UIImage imageNamed:@"LSPhotoBrowser1.jpg"];
            NineSquareUrlModel *urlModel2 = [[NineSquareUrlModel alloc] init];
            urlModel2.img = [UIImage imageNamed:@"LSPhotoBrowser2.jpg"];
            NineSquareUrlModel *urlModel3 = [[NineSquareUrlModel alloc] init];
            urlModel3.img = [UIImage imageNamed:@"LSPhotoBrowser3.jpg"];
            NineSquareUrlModel *urlModel4 = [[NineSquareUrlModel alloc] init];
            urlModel4.img = [UIImage imageNamed:@"LSPhotoBrowser4.jpg"];
            NineSquareUrlModel *urlModel5 = [[NineSquareUrlModel alloc] init];
            urlModel5.img = [UIImage imageNamed:@"LSPhotoBrowser5.jpg"];
            NineSquareUrlModel *urlModel6 = [[NineSquareUrlModel alloc] init];
            urlModel6.img = [UIImage imageNamed:@"LSPhotoBrowser6.jpg"];
            NineSquareUrlModel *urlModel7 = [[NineSquareUrlModel alloc] init];
            urlModel7.img = [UIImage imageNamed:@"LSPhotoBrowser7.jpg"];
            NineSquareUrlModel *urlModel8 = [[NineSquareUrlModel alloc] init];
            urlModel8.img = [UIImage imageNamed:@"LSPhotoBrowser8.jpg"];
            NineSquareUrlModel *urlModel9 = [[NineSquareUrlModel alloc] init];
            urlModel9.img = [UIImage imageNamed:@"LSPhotoBrowser9.jpg"];
            
            NineSquareModel *model = [[NineSquareModel alloc] init];
            model.title = @"九条数据";
            model.urlArr = [NSMutableArray array];
            
            [model.urlArr addObject:urlModel];
            [model.urlArr addObject:urlModel2];
            [model.urlArr addObject:urlModel3];
            [model.urlArr addObject:urlModel4];
            [model.urlArr addObject:urlModel5];
            [model.urlArr addObject:urlModel6];
            [model.urlArr addObject:urlModel7];
            [model.urlArr addObject:urlModel8];
            [model.urlArr addObject:urlModel9];
            
            [self.dataArr addObject:model];
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigation];
    [self createSubViews];
}

- (void)setNavigation {
    self.navView.titleLabelText = @"九宫格(本地)";
}

- (void)createSubViews {
    [self.view addSubview:self.mainTableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NineSquareLocCell *cell = [NineSquareLocCell nineSquareLocCellWithTableView:tableView];
    NineSquareModel *model = self.dataArr[indexPath.section];
    cell.squareM = model;
    _cell = cell;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return _cell.cellHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NineSquareModel *model = self.dataArr[section];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(30, 5, self.view.frame.size.width, 20)];
    label.text = model.title;
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
