//
//  LSTreeTableViewSearchBar.m
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/12/5.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import "LSTreeTableViewSearchBar.h"

@interface LSTreeTableViewSearchBar () <UITextFieldDelegate>

@property(nonatomic,strong)UITextField *textField;

@end

@implementation LSTreeTableViewSearchBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        CGFloat x = 5;
        CGFloat y = 5;
        CGFloat w = frame.size.width - 10;
        CGFloat h = frame.size.height - 10;
        
        self.textField = [[UITextField alloc] initWithFrame:CGRectMake(x, y, w, h)];
        self.textField.backgroundColor = self.backgroundColor;
        self.textField.textColor = [self getColorWithRed:51 green:51 blue:51];
        self.textField.font = [UIFont systemFontOfSize:15];
        self.textField.placeholder = @"请输入关键字搜索";
        self.textField.borderStyle = UITextBorderStyleRoundedRect;
        self.textField.returnKeyType = UIReturnKeySearch;
        self.textField.secureTextEntry = NO;
        self.textField.clearButtonMode = UITextFieldViewModeAlways;
        self.textField.autocorrectionType = UITextAutocorrectionTypeNo;
        self.textField.leftView = [self getLeftViewWithTextFieldHeight:h];
        self.textField.leftViewMode = UITextFieldViewModeAlways;
        self.textField.delegate = self;
        [self.textField addTarget:self action:@selector(showText:) forControlEvents:UIControlEventEditingChanged];
        [self addSubview:self.textField];
    }
    return self;
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if ([self.delegate respondsToSelector:@selector(treeTableViewSearchBarDidBeginEditing:)]) {
        [self.delegate treeTableViewSearchBarDidBeginEditing:self];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([self.delegate respondsToSelector:@selector(treeTableViewSearchBarShouldReturn:)]) {
        [self.delegate treeTableViewSearchBarShouldReturn:self];
    }
    return YES;
}

- (void)showText:(UITextField *)searchTextField {
    if ([self.delegate respondsToSelector:@selector(treeTableViewSearchBarDidEditing:)]) {
        [self.delegate treeTableViewSearchBarDidEditing:self];
    }
}

#pragma mark - Public Method
- (NSString *)text {
    return self.textField.text;
}

- (void)resignFirstResponder {
    [self.textField resignFirstResponder];
}

#pragma mark - Private Method
- (UIColor *)getColorWithRed:(NSInteger)redNum green:(NSInteger)greenNum blue:(NSInteger)blueNum {
    return [UIColor colorWithRed:redNum/255.0 green:greenNum/255.0 blue:blueNum/255.0 alpha:1.0];
}

- (UIView *)getLeftViewWithTextFieldHeight:(CGFloat)height {
    CGFloat iconHeight = height;
    CGFloat iconMargin = iconHeight / 4;
    
    UIButton *iconButton = [UIButton buttonWithType:UIButtonTypeCustom];
    iconButton.frame = CGRectMake(0, 0, iconHeight, iconHeight);
    iconButton.userInteractionEnabled = NO;
    iconButton.contentEdgeInsets = UIEdgeInsetsMake(iconMargin, iconMargin, iconMargin, iconMargin);
    [iconButton setImage:[UIImage imageNamed:@"LSTreeTableView.bundle/search"] forState:UIControlStateNormal];
    
    return (UIView *)iconButton;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
