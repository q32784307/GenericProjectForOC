//
//  LSBaseTextField.m
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/10/18.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import "LSBaseTextField.h"
#import "LSKeyboardHelperView.h"

@interface LSTextFieldHelper : NSObject <UITextFieldDelegate>

@property (nonatomic, strong) LSBaseTextField *textField;

@end

@implementation LSTextFieldHelper

- (instancetype)initWithTextField:(LSBaseTextField *)textField {
    if (self = [super init]) {
        self.textField = textField;
        self.textField.delegate = self;
    }
    return self;
}

// MARK: - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    id <UITextFieldDelegate > pDelegate =  [(LSBaseTextField *)textField pDelegate];
    if ([pDelegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
        [pDelegate textField:textField shouldChangeCharactersInRange:range replacementString:string];
    }
    
    LSBaseTextField *p_textField = (LSBaseTextField *)textField;
//  判断是否达到设定的最大值
    if ([p_textField isReachMaxCountCharacterRange:range replacmentString:string ]) {
        return NO;
    }
    return true;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    id <UITextFieldDelegate>pDelegate = [(LSBaseTextField *)textField pDelegate];
    if ([pDelegate respondsToSelector:@selector(textFieldShouldClear:)]) {
        return [pDelegate textFieldShouldClear:textField];
    }
    return true;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    id <UITextFieldDelegate>pDelegate = [(LSBaseTextField *)textField pDelegate];
    if ([pDelegate respondsToSelector:@selector(textFieldShouldBeginEditing:)]) {
        return [pDelegate textFieldShouldBeginEditing:textField];
    }
    return true;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    id <UITextFieldDelegate>pDelegate = [(LSBaseTextField *)textField pDelegate];
    if ([pDelegate respondsToSelector:@selector(textFieldShouldEndEditing:)]) {
        return [pDelegate textFieldShouldEndEditing:textField];
    }
    return true;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    id<UITextFieldDelegate> pDelegate = ((LSBaseTextField *)textField).pDelegate;
    if([pDelegate respondsToSelector:@selector(textFieldDidBeginEditing:)]) {
        [pDelegate textFieldDidBeginEditing:textField];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    id<UITextFieldDelegate> pDelegate = ((LSBaseTextField *)textField).pDelegate;
    if([pDelegate respondsToSelector:@selector(textFieldShouldReturn:)]) {
        return [pDelegate textFieldShouldReturn:textField];
    }
    return YES;
}

@end

@interface LSBaseTextField ()

@property (nonatomic, strong) LSTextFieldHelper *fieldHelper;
@property (nonatomic, strong) LSKeyboardHelperView *helperView;


@end

@implementation LSBaseTextField

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

- (void)p_defaultInit {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    self.borderStyle = UITextBorderStyleNone;
    self.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.autocorrectionType = UITextAutocorrectionTypeNo;
    self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [self addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    _maxCount = 0;
    _fieldHelper = [[LSTextFieldHelper alloc] initWithTextField:self];
}

- (void)setShowToolbarView:(BOOL)showToolbarView {
    if (showToolbarView) {
        [self setInputAccessoryView:self.helperView];
    }
}

- (BOOL)isReachMaxCountCharacterRange:(NSRange)range replacmentString:(NSString *)string {
    if (self.maxCount < 1) {
        return false;
    }
    NSString *new_string = [self.text stringByReplacingCharactersInRange:range withString:string];
    if (new_string.length > _maxCount) {
        return YES;
    }
    return false;
}

- (void)textFieldChanged:(UITextField *)textField {
    
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (self.allowCopyMenu) {
        return [super canPerformAction:action withSender:sender];
    }
    UIMenuController *menuController = [UIMenuController sharedMenuController];
    if (menuController) {
        menuController.menuVisible = NO;
    }
    return false;
}

- (LSKeyboardHelperView *)helperView{
    if(!_helperView){
        __weak typeof(self) weakSelf     = self;
        _helperView = [LSKeyboardHelperView createHelerViewWithFrame:CGRectMake(0, 0, ScreenWidth, 45) keyboardDismiss:^{
            !weakSelf.ToolBarViewEvent ?  : weakSelf.ToolBarViewEvent ();
        }];
    }
    return _helperView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
