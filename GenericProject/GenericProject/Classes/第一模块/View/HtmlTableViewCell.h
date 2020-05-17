//
//  HtmlTableViewCell.h
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/11/26.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
最简单的HTML容器cell，啥也别管直接满屏就完事儿了
*/
@interface HtmlTableViewCell : UITableViewCell

@property (nonatomic) WKWebView *webView;

@end

NS_ASSUME_NONNULL_END
