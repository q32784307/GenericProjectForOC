//
//  LSAdaptiveHTMLCell.h
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/11/26.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LSAdaptiveHTMLCell;

NS_ASSUME_NONNULL_BEGIN

@protocol LSAdaptiveHTMLCellDelegate <NSObject>

- (void)htmlCellDidFinishLoad:(CGFloat)height cell:(LSAdaptiveHTMLCell *)cell;

@end

/**
    自适应webView的cell，需要手动在代理后调用talebiew.loadData
 */

@interface LSAdaptiveHTMLCell : UITableViewCell

@property(nonatomic,weak)id<LSAdaptiveHTMLCellDelegate> delegate;
@property(nonatomic)WKWebView *webView;
@property(nonatomic)UIEdgeInsets webViewEdgeInsets;

+ (instancetype)cellForTableView:(UITableView *)tableView;

- (void)configCellWithUrlStr:(NSString *)urlStr tableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
