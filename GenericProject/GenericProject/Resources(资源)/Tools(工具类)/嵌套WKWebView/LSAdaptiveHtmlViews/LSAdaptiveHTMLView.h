//
//  LSAdaptiveHTMLView.h
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/11/26.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WKWebView;

NS_ASSUME_NONNULL_BEGIN

@protocol LSAdaptiveHtmlViewDelegate <NSObject>

- (void)htmlViewDidFinishLoad:(CGFloat)height;

@end

/**
   能够自适应的WebView，展示文本页面用.如果给cell，需要承接代理然后reload
*/

@interface LSAdaptiveHTMLView : UIView

@property(nonatomic,weak)id<LSAdaptiveHtmlViewDelegate> delegate;

@property(nonatomic)WKWebView *webView;

- (void)loadWithUrlStr:(NSString *)urlStr;

@end

NS_ASSUME_NONNULL_END
