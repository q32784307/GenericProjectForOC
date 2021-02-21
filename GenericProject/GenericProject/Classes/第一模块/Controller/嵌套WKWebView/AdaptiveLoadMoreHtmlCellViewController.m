//
//  AdaptiveLoadMoreHtmlCellViewController.m
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/11/26.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import "AdaptiveLoadMoreHtmlCellViewController.h"
#import "LSMultistageSuperTableView.h"
#import "HtmlTableViewCell.h"
#import "LSAdaptiveHTMLCell.h"
#import "LSMultistageScrollViewHelper.h"

@interface AdaptiveLoadMoreHtmlCellViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,LSAdaptiveHTMLCellDelegate>

@property (nonatomic) LSMultistageSuperTableView *tableView;
@property (nonatomic) LSAdaptiveHTMLCell *cell;
@property (nonatomic) LSMultistageScrollViewHelper *scrollHelper;
@property (nonatomic) CGFloat cellHeight;

@end

@implementation AdaptiveLoadMoreHtmlCellViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self scrollHelper];
    self.cellHeight = UITableViewAutomaticDimension;
    [self.view addSubview:self.tableView];
    self.tableView.frame = CGRectMake(0, NAVIGATION_BAR_HEIGHT, LSScreenWidth, LSScreenHeight - NAVIGATION_BAR_HEIGHT - HOME_INDICATOR_HEIGHT);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger )section {
    return 7;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 6) {
        return self.cellHeight;
    }else {
        return indexPath.row * 50 + 100;
    }
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellTableIndentifier2 = @"CellTableIdentifier2";
    UITableViewCell *cell_x;
    
    if (indexPath.row == 6) {
        [self.cell configCellWithUrlStr:@"https://time.geekbang.org/library?category=1" tableView:tableView indexPath:indexPath];
        //        [self.cell configCellWithUrlStr:@"https://time.geekbang.org/comment/nice-module/30359" tableView:tableView indexPath:indexPath];
        self.cell.delegate = self;
        cell_x = self.cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellTableIndentifier2];
        if(cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellTableIndentifier2];
            
        }
        cell.textLabel.text = [NSString stringWithFormat:@"%zd",indexPath.row];
        cell_x = cell;
    }
    return cell_x;
}


#pragma mark KSAdaptiveHTMLCellDelegate
- (void)htmlCellDidFinishLoad:(CGFloat)height cell:(LSAdaptiveHTMLCell *)cell{
    if (height >= self.tableView.bounds.size.height) {
        self.cellHeight = self.tableView.bounds.size.height;
        self.cell.webView.scrollView.scrollEnabled = YES;
    }else {
        //这里、如果改变了就刷新的话。如果html那边也做了屏幕高度适应去尝试充满整个屏幕，会导致连续刷新tableView，直到cell满屏。
        //如果直接是一个固定高度的html，不会有什么问题只刷新一次tableView
        self.cellHeight = height;
        self.cell.webView.scrollView.scrollEnabled = NO;
    }
}


- (LSMultistageSuperTableView *)tableView {
    if (!_tableView) {
        _tableView = [LSMultistageSuperTableView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (LSAdaptiveHTMLCell *)cell {
    if (!_cell) {
        static NSString *CellTableIndentifier = @"KSAdaptiveHTMLCellID";
        _cell = [[LSAdaptiveHTMLCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellTableIndentifier];
    }
    return _cell;
}

- (void)setCellHeight:(CGFloat)cellHeight {
    if (_cellHeight != cellHeight) {
        NSLog(@"setCellHeight==%lf",cellHeight);
        [self.cell removeFromSuperview];
        [self.tableView reloadData];
    }
    _cellHeight = cellHeight;
}

- (LSMultistageScrollViewHelper *)scrollHelper {
    if (!_scrollHelper) {
        _scrollHelper = [[LSMultistageScrollViewHelper alloc]initWithBaseScrollView:self.tableView subScrollView:self.cell.webView.scrollView];
    }
    return _scrollHelper;
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
