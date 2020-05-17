//
//  UIScrollView+PeerRefresh.h
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/7/19.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (PeerRefresh)

- (void)setRefreshWithHeaderBlock:(void(^)(void))headerBlock
                      footerBlock:(void(^)(void))footerBlock;

//下拉刷新
- (void)setOnlyRefreshWithHeaderBlock:(void (^)(void))headerBlock;
//上拉加载更多
- (void)setRefreshWithFooterBlock:(void (^)(void))footerBlock;
- (void)headerBeginRefreshing;
- (void)headerEndRefreshing;
- (void)footerEndRefreshing;
- (void)footerNoMoreData;

- (void)hideHeaderRefresh;
- (void)hideFooterRefresh;

@end

NS_ASSUME_NONNULL_END
