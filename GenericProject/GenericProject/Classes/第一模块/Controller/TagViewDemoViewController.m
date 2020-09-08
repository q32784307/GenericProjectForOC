//
//  TagViewDemoViewController.m
//  GenericProject
//
//  Created by 社科赛斯 on 2019/12/12.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import "TagViewDemoViewController.h"
#import "LSBaseTagView.h"
#import "LSTagView.h"

@interface TagViewDemoViewController ()

@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) LSBaseTagView *tagView;
@property(nonatomic, strong)LSTagView *tagView1;

@end

@implementation TagViewDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.mainTableView.frame = CGRectMake(0, HOME_INDICATOR_HEIGHT+ 60, self.view.frame.size.width, self.dataSource.count * 40);
    [self.view addSubview:self.mainTableView];
    [self.view addSubview:self.tagView];
    
    self.tagView1 = [[LSTagView alloc] init];
    self.tagView1.backgroundColor = [[UIColor orangeColor] colorWithAlphaComponent:0.3];
    [self.view addSubview:self.tagView1];
    [self.tagView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mainTableView.mas_bottom).offset(16);
        make.left.right.mas_equalTo(0);
    }];
    
    self.tagView1.tagsArray = @[@"林俊杰",@"张学友",@"刘德华",@"陶喆",@"王力宏",@"王菲",@"Taylor swift",@"周杰伦",@"owl city",@"汪苏泷",@"许嵩",@"李代沫",@"那英",@"羽泉",@"刀郎",@"田馥甄",@"庄心妍",@"林宥嘉",@"薛之谦",@"萧敬腾",@"王若琳"];
    self.tagView1.defaultSelectTags = @[@"羽泉"];
}

- (void)showTagViewWith:(NSInteger )index{
    if (index == 0) {
        _tagView.itemColunm = 2;
        _tagView.isAverage = YES;
        _tagView.tagArray = [self getNoImageData];
    }else if (index == 1){
        _tagView.isMultiSelect = YES;
        _tagView.itemColunm = 3;
        _tagView.isAverage = YES;
        _tagView.tagArray = [self getNoImageData];
    }else if (index == 2){
        _tagView.itemColunm = 3;
        _tagView.isAverage = YES;
        _tagView.borderColor = [UIColor redColor];
        _tagView.tagArray = [self getNoImageData];
   
    }else if (index == 3){
        _tagView.itemColunm = 3;
        _tagView.isAverage = YES;
        _tagView.borderColor = [UIColor redColor];
        _tagView.buttonType = LSCustomButtonImageLeft;
        _tagView.titleImageSpae = 10;
        _tagView.tagArray = [self getImageData];
    }else if (index == 4){
        _tagView.isAverage = NO;
        _tagView.itemMinWidth = 0;
        _tagView.borderColor = [UIColor redColor];
        _tagView.tagArray = [self getIrregularityData];
        
    }else if (index == 5){
        _tagView.isAverage = NO;
        _tagView.itemMinWidth = _tagView.frame.size.width / 4;
        _tagView.borderColor = [UIColor redColor];
        _tagView.tagArray = [self getIrregularityData];
        
    }
}
- (NSArray *)getImageData{
    NSMutableArray * array = [[NSMutableArray alloc]init];
    LSBaseTagViewModel * model = [[LSBaseTagViewModel alloc]init];
    model.title = @"测试1";
    model.titleImage = [UIImage imageNamed:@"duigou"];
    model.selectedTitleImage = [UIImage imageNamed:@"tabbar_home_un"];
    
    LSBaseTagViewModel * model2 = [[LSBaseTagViewModel alloc]init];
    model2.title = @"测试2";
    model2.titleImage = [UIImage imageNamed:@"duigou"];
    model2.selectedTitleImage = [UIImage imageNamed:@"tabbar_home_un"];

    LSBaseTagViewModel * model3 = [[LSBaseTagViewModel alloc]init];
    model3.title = @"测试3";
    model3.titleImage = [UIImage imageNamed:@"duigou"];
    model3.selectedTitleImage = [UIImage imageNamed:@"tabbar_home_un"];


    LSBaseTagViewModel * model4 = [[LSBaseTagViewModel alloc]init];
    model4.title = @"测试4";
    model4.titleImage = [UIImage imageNamed:@"duigou"];
    model4.selectedTitleImage = [UIImage imageNamed:@"tabbar_home_un"];


    LSBaseTagViewModel * model5 = [[LSBaseTagViewModel alloc]init];
    model5.title = @"测试5";
    model5.titleImage = [UIImage imageNamed:@"duigou"];
    model5.selectedTitleImage = [UIImage imageNamed:@"tabbar_home_un"];


    LSBaseTagViewModel * model6 = [[LSBaseTagViewModel alloc]init];
    model6.title = @"测试6";
    model6.titleImage = [UIImage imageNamed:@"duigou"];
    model6.selectedTitleImage = [UIImage imageNamed:@"tabbar_home_un"];


    
    [array addObject:model];
    [array addObject:model2];
    [array addObject:model3];
    [array addObject:model4];
    [array addObject:model5];
    [array addObject:model6];
    return array;
}

- (NSArray *)getNoImageData{
    NSMutableArray * array = [[NSMutableArray alloc]init];
    LSBaseTagViewModel * model = [[LSBaseTagViewModel alloc]init];
    model.title = @"测试1";
    LSBaseTagViewModel * model2 = [[LSBaseTagViewModel alloc]init];
    model2.title = @"测试2";
    LSBaseTagViewModel * model3 = [[LSBaseTagViewModel alloc]init];
    model3.title = @"测试3";
    LSBaseTagViewModel * model4 = [[LSBaseTagViewModel alloc]init];
    model4.title = @"测试4";
    LSBaseTagViewModel * model5 = [[LSBaseTagViewModel alloc]init];
    model5.title = @"测试5";
    LSBaseTagViewModel * model6 = [[LSBaseTagViewModel alloc]init];
    model6.title = @"测试6";
    
    [array addObject:model];
    [array addObject:model2];
    [array addObject:model3];
    [array addObject:model4];
    [array addObject:model5];
    [array addObject:model6];
    return array;
}

- (NSArray *)getIrregularityData{
    NSMutableArray * array = [[NSMutableArray alloc]init];
    LSBaseTagViewModel * model = [[LSBaseTagViewModel alloc]init];
    model.title = @"测试不规则折行显示1";
    LSBaseTagViewModel * model2 = [[LSBaseTagViewModel alloc]init];
    model2.title = @"测试不规则折行显示1测试2";
    LSBaseTagViewModel * model3 = [[LSBaseTagViewModel alloc]init];
    model3.title = @"测试不规则折行显示1测试不规则折行显示1测试3";
    LSBaseTagViewModel * model4 = [[LSBaseTagViewModel alloc]init];
    model4.title = @"不规则折行显";
    LSBaseTagViewModel * model5 = [[LSBaseTagViewModel alloc]init];
    model5.title = @"测试5";
    LSBaseTagViewModel * model6 = [[LSBaseTagViewModel alloc]init];
    model6.title = @"不规则折行显";
    
    [array addObject:model];
    [array addObject:model2];
    [array addObject:model3];
    [array addObject:model4];
    [array addObject:model5];
    [array addObject:model6];
    return array;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * reuseId = @"UITableViewCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:reuseId];
    }
    
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self showTagViewWith:indexPath.row];
}

- (NSArray *)dataSource{
    if (!_dataSource) {
        _dataSource = @[@"单选两列均分",@"多选三列均分",@"边框圆角",@"带图片",@"不规则显示",@"不规则显示单个item可设置最小宽度等"];
    }
    return _dataSource;
}

- (LSBaseTagView *)tagView{
    if (!_tagView) {
        _tagView = [[LSBaseTagView alloc]initWithFrame:CGRectMake(20, self.view.frame.size.height - self.dataSource.count * 40 , self.view.frame.size.width - 40, self.view.frame.size.height - self.dataSource.count * 40 )];
        _tagView.itemSpace = 12;
        _tagView.rowSpace = 12;
        _tagView.itemHeight = 40;
        _tagView.contentInset = 8;
        _tagView.bgColor = [UIColor lightGrayColor];
        _tagView.textColor = [UIColor blueColor];
        _tagView.selectedTextColor = [UIColor greenColor];
        _tagView.textFont = [UIFont systemFontOfSize:12];
        _tagView.cornerRadius = 4;
        _tagView.buttonType = LSCustomButtonNoHaveImageLabel;
        _tagView.selectedBgColor = [UIColor yellowColor];
        _tagView.selectedBorderColor = [UIColor blueColor];
    }
    return _tagView;
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
