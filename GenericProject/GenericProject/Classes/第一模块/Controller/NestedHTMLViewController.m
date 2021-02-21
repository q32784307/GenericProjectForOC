//
//  NestedHTMLViewController.m
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/11/26.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import "NestedHTMLViewController.h"
#import "AdaptiveHtmlViewController.h"
#import "AdaptiveHtmlCellViewController.h"
#import "MultistageScrollViewController.h"
#import "FullScreenLoadMoreHtmlCellViewController.h"
#import "AdaptiveLoadMoreHtmlCellViewController.h"
#import "PluralHtmlCellViewController.h"

@interface NestedHTMLViewController ()

@property(nonatomic,copy)NSArray *titleArray;

@end

@implementation NestedHTMLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self analysis];
    [self createSubViews];
}

- (void)analysis {
    self.titleArray = @[@"Adaptive html view",//自适应的网页view
                        @"Adaptive html cell",//任意位置自适应，全部展开的网页cell
                        @"Multistage scrollView",//两个scrollView联动,html加载更多的原理
                        @"Full screen load more html cell", //位于最后一个可以加载更多，直接设置成全屏的普通网页cell。如果能接受满屏cell，这个方案是最稳妥的
                        @"Adaptive load more html cell", //位于最后一个可以加载更多，内容过短时也可以自适应高度的网页cell。
                        @"Plural html cell",//复数网页cell
                        ];
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
    
    cell.textLabel.text = _titleArray[indexPath.row];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        AdaptiveHtmlViewController *AdaptiveHtmlVC = [[AdaptiveHtmlViewController alloc]init];
        [self.navigationController pushViewController:AdaptiveHtmlVC animated:YES];
    }
    if (indexPath.row == 1) {
        AdaptiveHtmlCellViewController *AdaptiveHtmlCellVC = [[AdaptiveHtmlCellViewController alloc]init];
        [self.navigationController pushViewController:AdaptiveHtmlCellVC animated:YES];
    }
    if (indexPath.row == 2) {
        MultistageScrollViewController *MultistageScrollVC = [[MultistageScrollViewController alloc]init];
        [self.navigationController pushViewController:MultistageScrollVC animated:YES];
    }
    if (indexPath.row == 3) {
        FullScreenLoadMoreHtmlCellViewController *FullScreenLoadMoreHtmlCellVC = [[FullScreenLoadMoreHtmlCellViewController alloc]init];
        [self.navigationController pushViewController:FullScreenLoadMoreHtmlCellVC animated:YES];
    }
    if (indexPath.row == 4) {
        AdaptiveLoadMoreHtmlCellViewController *AdaptiveLoadMoreHtmlCellVC = [[AdaptiveLoadMoreHtmlCellViewController alloc]init];
        [self.navigationController pushViewController:AdaptiveLoadMoreHtmlCellVC animated:YES];
    }
    if (indexPath.row == 5) {
        PluralHtmlCellViewController *PluralHtmlCellVC = [[PluralHtmlCellViewController alloc]init];
        [self.navigationController pushViewController:PluralHtmlCellVC animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return LSSYRealValue(100 / 2);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 25;
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
