//
//  UIScrollView+PeerRefresh.m
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/7/19.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import "UIScrollView+PeerRefresh.h"

@implementation UIScrollView (PeerRefresh)

- (void)setRefreshWithHeaderBlock:(void (^)())headerBlock footerBlock:(void (^)())footerBlock {
    if (headerBlock) {
        MJRefreshNormalHeader *header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            if (headerBlock) {
                headerBlock();
            }
        }];
        self.mj_header = header;
    }
    if (footerBlock) {
        MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            footerBlock();
        }];
        [footer setTitle:@"暂无更多数据" forState:MJRefreshStateNoMoreData];
        [footer setTitle:@"" forState:MJRefreshStateIdle];
        footer.refreshingTitleHidden = YES;
        self.mj_footer = footer;
    }
    
}

//下拉刷新
- (void)setOnlyRefreshWithHeaderBlock:(void (^)())headerBlock {
    if (headerBlock) {
        MJRefreshNormalHeader *header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            if (headerBlock) {
                headerBlock();
            }
        }];
        self.mj_header = header;
    }
}

//上拉加载更多
- (void)setRefreshWithFooterBlock:(void (^)())footerBlock {
    if (footerBlock) {
        MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            footerBlock();
        }];
        [footer setTitle:@"暂无更多数据" forState:MJRefreshStateNoMoreData];
        [footer setTitle:@"" forState:MJRefreshStateIdle];
        footer.refreshingTitleHidden = YES;
        self.mj_footer = footer;
    }
}

- (void)headerBeginRefreshing {
    [self.mj_header beginRefreshing];
}

- (void)headerEndRefreshing {
    [self.mj_header endRefreshing];
}

- (void)footerEndRefreshing {
    [self.mj_footer endRefreshing];
}

- (void)footerNoMoreData {
    [self.mj_footer setState:MJRefreshStateNoMoreData];
}

- (void)hideFooterRefresh {
    self.mj_footer.hidden = YES;
}

- (void)hideHeaderRefresh {
    self.mj_header.hidden = YES;
}

@end
