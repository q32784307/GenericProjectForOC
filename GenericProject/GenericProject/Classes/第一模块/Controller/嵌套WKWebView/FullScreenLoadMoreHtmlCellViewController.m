//
//  FullScreenLoadMoreHtmlCellViewController.m
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/11/26.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import "FullScreenLoadMoreHtmlCellViewController.h"
#import "LSMultistageSuperTableView.h"
#import "HtmlTableViewCell.h"
#import "LSMultistageScrollViewHelper.h"

@interface FullScreenLoadMoreHtmlCellViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic) LSMultistageSuperTableView *tableView;
@property (nonatomic) HtmlTableViewCell *cell;
@property (nonatomic) LSMultistageScrollViewHelper *scrollHelper;

@end

@implementation FullScreenLoadMoreHtmlCellViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self scrollHelper];
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
        return self.tableView.bounds.size.height;
    }else {
        return indexPath.row * 50 + 100;
    }
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellTableIndentifier2 = @"CellTableIdentifier2";
    UITableViewCell *cell_x;
    
    if (indexPath.row == 6) {
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



- (LSMultistageSuperTableView *)tableView {
    if (!_tableView) {
        _tableView = [LSMultistageSuperTableView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (HtmlTableViewCell *)cell {
    if (!_cell) {
        static NSString *CellTableIndentifier = @"HtmlTableViewCellID";
        _cell = [[HtmlTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellTableIndentifier];
    }
    return _cell;
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
