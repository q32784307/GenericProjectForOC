//
//  AdaptiveHtmlCellViewController.m
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/11/26.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import "AdaptiveHtmlCellViewController.h"
#import "LSAdaptiveHTMLCell.h"

@interface AdaptiveHtmlCellViewController ()<LSAdaptiveHTMLCellDelegate>

@end

@implementation AdaptiveHtmlCellViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.mainTableView.estimatedRowHeight = CGFLOAT_MIN;
    [self.view addSubview:self.mainTableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger )section {
    return 7;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 3) {
        return UITableViewAutomaticDimension;
    } else {
        return indexPath.row * 50 + 100;
    }
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellTableIndentifier = @"CellTableIdentifier";
    UITableViewCell *cell_x;
    
    if (indexPath.row == 3 ) {
        LSAdaptiveHTMLCell *cell = [LSAdaptiveHTMLCell cellForTableView:tableView];
        [cell configCellWithUrlStr:@"https://time.geekbang.org/" tableView:tableView indexPath:indexPath];
        cell.delegate = self;
        cell_x = cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellTableIndentifier];
        if(cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellTableIndentifier];
            
        }
        cell.textLabel.text = [NSString stringWithFormat:@"%zd",indexPath.row];
        cell_x = cell;
    }
    return cell_x;
}


#pragma mark KSAdaptiveHTMLCellDelegate
- (void)htmlCellDidFinishLoad:(CGFloat)height cell:(LSAdaptiveHTMLCell *)cell{
    NSLog(@"htmlCellDidFinishLoad");
    [self.mainTableView reloadData];
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
