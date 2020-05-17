//
//  AnimatedViewController.m
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/4/16.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import "AnimatedViewController.h"
#import "Game.h"
#import "AnimatedTableViewCell.h"
#import "ViewExampleViewController.h"

@interface AnimatedViewController ()

@property(nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation AnimatedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataArray = [NSMutableArray array];
    
    
    // 设置tabAnimated相关属性
    // 可以不进行手动初始化，将使用默认属性
    
    [self.view addSubview:self.mainTableView];
    [self.mainTableView tab_startAnimation];   // 开启动画
    self.mainTableView.tabAnimated = [TABTableAnimated animatedWithCellClass:[AnimatedTableViewCell class]
    cellHeight:90];
    self.mainTableView.tabAnimated.showTableHeaderView = YES;
    self.mainTableView.tabAnimated.superAnimationType = TABViewSuperAnimationTypeShimmer;
    self.mainTableView.tabAnimated.canLoadAgain = YES;
    
    // 假设3秒后，获取到数据了，代码具体位置看你项目了。
    [self performSelector:@selector(afterGetData) withObject:nil afterDelay:3.0];
}

- (void)dealloc {
    NSLog(@"==========  dealloc  ==========");
}

/**
 获取到数据后
 */
- (void)afterGetData {
    
    // 模拟数据
    for (int i = 0; i < 10; i ++) {
        Game *game = [[Game alloc]init];
        game.gameId = [NSString stringWithFormat:@"%d",i];
        game.title = [NSString stringWithFormat:@"这里是测试数据%d",i+1];
        game.cover = @"test.jpg";
        [self.dataArray addObject:game];
    }
    // 停止动画,并刷新数据
    [self.mainTableView tab_endAnimation];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return .1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return .1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *str = @"TestTableViewCell";
    AnimatedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[AnimatedTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    AnimatedTableViewCell *myCell = (AnimatedTableViewCell *)cell;
    [myCell initWithData:self.dataArray[indexPath.row]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ViewExampleViewController *ViewExampleVC = [[ViewExampleViewController alloc]init];
    [self.navigationController pushViewController:ViewExampleVC animated:YES];
}
    
@end
