//
//  LSBaseWKWebViewController.m
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2018/7/3.
//  Copyright © 2018年 漠然丶情到深处. All rights reserved.
//

#import "LSBaseWKWebViewController.h"
#import "JSHandler.h"

@interface LSBaseWKWebViewController ()<WKNavigationDelegate>

@property(nonatomic,strong)JSHandler *jsHandler;
@property(nonatomic,assign)double lastProgress;//上次进度条位置

@property(nonatomic,strong)UIButton *closeItem;

@end

@implementation LSBaseWKWebViewController

- (instancetype)initWithUrl:(NSString *)url {
    self = [super init];
    if (self) {
        self.url = url;
        _progressViewColor = [UIColor colorWithHexString:@"0485d1"];
    }
    return self;
}

- (void)setUrl:(NSString *)url {
    if (_url != url) {
        _url = url;
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:_url]];
        [self.webView loadRequest:request];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navView.titleLabelText = nil;
    [self initWKWebView];
    //适配iOS11
    if (@available(iOS 11.0, *)) {
        self.webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

#pragma mark 初始化webview
- (void)initWKWebView {
    WKWebViewConfiguration * configuration = [[WKWebViewConfiguration alloc]init];
    configuration.preferences.javaScriptEnabled = YES;//打开js交互
    _webConfiguration = configuration;
    _jsHandler = [[JSHandler alloc]initWithViewController:self configuration:configuration];
    
    
    self.webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, LSScreenWidth, LSScreenHeight - NAVIGATION_BAR_HEIGHT - HOME_INDICATOR_HEIGHT) configuration:configuration];
    _webView.navigationDelegate = self;
    _webView.backgroundColor = [UIColor clearColor];
    _webView.allowsBackForwardNavigationGestures = YES;//打开网页间的 滑动返回
    _webView.scrollView.decelerationRate = UIScrollViewDecelerationRateNormal;
    //监控进度
    [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [self.view addSubview:_webView];
    //进度条
    _progressView = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleDefault];
    _progressView.tintColor = _progressViewColor;
    _progressView.trackTintColor = [UIColor clearColor];
    _progressView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 3.0);
    [_webView addSubview:_progressView];
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:_url]];
    [_webView loadRequest:request];
    
    self.closeItem = [[UIButton alloc]init];
    [self.closeItem setTitle:@"关闭" forState:UIControlStateNormal];
    [self.closeItem setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.closeItem.titleLabel.font = [UIFont systemFontOfSize:LSSYRealValue(30 / 2)];
    [self.closeItem addTarget:self action:@selector(closeNative) forControlEvents:UIControlEventTouchUpInside];
    [self.navView addSubview:self.closeItem];
    [self.closeItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navView).with.offset(STATUS_BAR_HEIGHT + 2);
        make.left.equalTo(self.navView.leftButton.mas_right).with.offset(LSSYRealValue(20 / 2));
        make.height.mas_equalTo(40);
    }];
}

- (void)backButtonClicked {
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    } else {
        [self closeNative];
    }
}

- (void)closeNative {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark --进度条
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    [self updateProgress:_webView.estimatedProgress];
}

#pragma mark -  更新进度条
- (void)updateProgress:(double)progress {
    self.progressView.alpha = 1;
    if(progress > _lastProgress){
        [self.progressView setProgress:self.webView.estimatedProgress animated:YES];
    }else{
        [self.progressView setProgress:self.webView.estimatedProgress];
    }
    _lastProgress = progress;
    
    if (progress >= 1) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.progressView.alpha = 0;
            [self.progressView setProgress:0];
            _lastProgress = 0;
        });
    }
}

#pragma mark --navigation delegate
//加载完毕
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    self.navView.titleLabelText = webView.title;
    [self updateProgress:webView.estimatedProgress];
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    if(webView != self.webView) {
        decisionHandler(WKNavigationActionPolicyAllow);
        return;
    }
    
    NSURL * url = webView.URL;
    //打开wkwebview禁用了电话和跳转appstore 通过这个方法打开
    UIApplication *app = [UIApplication sharedApplication];
    if ([url.scheme isEqualToString:@"tel"]) {
        if ([app canOpenURL:url]) {
            [app openURL:url];
            decisionHandler(WKNavigationActionPolicyCancel);
            return;
        }
    }
    if ([url.absoluteString containsString:@"itunes.apple.com"]) {
        if ([app canOpenURL:url]) {
            [app openURL:url];
            decisionHandler(WKNavigationActionPolicyCancel);
            return;
        }
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_jsHandler cancelHandler];
    self.webView.navigationDelegate = nil;
    [_webView removeObserver:self forKeyPath:@"estimatedProgress"];
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
