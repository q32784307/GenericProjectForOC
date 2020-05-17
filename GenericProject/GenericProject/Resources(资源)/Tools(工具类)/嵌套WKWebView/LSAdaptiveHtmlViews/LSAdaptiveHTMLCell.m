//
//  LSAdaptiveHTMLCell.m
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/11/26.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import "LSAdaptiveHTMLCell.h"
#import "LSAdaptiveHTMLView.h"

@interface LSAdaptiveHTMLCell () <LSAdaptiveHtmlViewDelegate>

@property(nonatomic)LSAdaptiveHTMLView *htmlView;
@property(nonatomic)CGFloat HtmlHeight;

@end

@implementation LSAdaptiveHTMLCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellForTableView:(UITableView *)tableView {
    static NSString *cellID1 = @"LSAdaptiveHTMLCellID";
    LSAdaptiveHTMLCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID1];
    if (cell == nil) {
        cell = [[LSAdaptiveHTMLCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID1];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    [self.contentView addSubview:self.htmlView];
    self.webViewEdgeInsets = UIEdgeInsetsZero;
}

#pragma mark - KSAdaptiveHtmlViewDelegate
- (void)htmlViewDidFinishLoad:(CGFloat)height {
    if ([self.delegate respondsToSelector:@selector(htmlCellDidFinishLoad:cell:)]) {
        self.HtmlHeight = height;
        [self.delegate htmlCellDidFinishLoad:height cell:self];
    }
}

- (void)configCellWithUrlStr:(NSString *)urlStr tableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    [self.htmlView loadWithUrlStr:urlStr];
}

- (LSAdaptiveHTMLView *)htmlView {
    if (!_htmlView) {
        _htmlView = [LSAdaptiveHTMLView new];
        _htmlView.delegate = self;
    }
    return _htmlView;
}

-(WKWebView *)webView {
    return self.htmlView.webView;
}

- (void)setWebViewEdgeInsets:(UIEdgeInsets)webViewEdgeInsets {
    _webViewEdgeInsets = webViewEdgeInsets;
    [self.htmlView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(webViewEdgeInsets);
    }];
}

- (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize withHorizontalFittingPriority:(UILayoutPriority)horizontalFittingPriority verticalFittingPriority:(UILayoutPriority)verticalFittingPriority {
    return CGSizeMake(self.contentView.bounds.size.width, self.HtmlHeight+self.webViewEdgeInsets.top+self.webViewEdgeInsets.bottom);
}

@end
