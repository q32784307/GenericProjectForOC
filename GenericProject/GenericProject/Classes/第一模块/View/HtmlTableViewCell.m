//
//  HtmlTableViewCell.m
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/11/26.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import "HtmlTableViewCell.h"

@implementation HtmlTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews {
    self.webView.frame = self.contentView.bounds;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor orangeColor];
        [self.contentView addSubview:self.webView];
    }
    return self;
}

- (WKWebView *)webView {
    if (!_webView) {
        _webView = [[WKWebView alloc]init];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://time.geekbang.org/library?category=1"]];
        [_webView loadRequest:request];
    }
    return _webView;
}

@end
