//
//  LSPSWTextFieldContext.m
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/10/18.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import "LSPSWTextFieldContext.h"
#import "LSPSWLineNormalTextFiledView.h"
#import "LSPSWLineEncryptTextFiledView.h"
#import "LSPSWRectNormalTextFieldView.h"
#import "LSPSWRectEncryptTextFiledView.h"
#import "LSPSWRectAnimateTextFieldView.h"

@interface LSPSWTextFieldContext ()

@property (nonatomic, strong) UIView <LSPasswordViewProtocol> * textFiledView;

@end

@implementation LSPSWTextFieldContext

+ (UIView <LSPasswordViewProtocol> *)configureTextFieldView:(LSPSWTextFieldViewType)viewType frame:(CGRect)frame {
    return [[self alloc] configureWithType:viewType frame:frame];
}

- (UIView <LSPasswordViewProtocol> *)configureWithType:(LSPSWTextFieldViewType)type frame:(CGRect)frame {
    switch (type) {
        case LSPSWTextFieldViewLineNormal: {
            self.textFiledView = [[LSPSWLineNormalTextFiledView alloc] initWithFrame:frame];
        }
            break;
        case LSPSWTextFieldViewLineEncryption: {
            self.textFiledView = [[LSPSWLineEncryptTextFiledView alloc] initWithFrame:frame];
        }
            break;
        case LSPSWTextFieldViewRectNormal: {
            self.textFiledView = [[LSPSWRectNormalTextFieldView alloc] initWithFrame:frame];
        }
            break;
        case LSPSWTextFieldViewRectEncryption: {
            self.textFiledView = [[LSPSWRectEncryptTextFiledView alloc] initWithFrame:frame];
        }
            break;
        case LSPSWTextFieldViewWithAnimating: {
            self.textFiledView = [[LSPSWRectAnimateTextFieldView alloc] initWithFrame:frame];
        }
            break;
            
        default:
            break;
    }
    [self.textFiledView autoShowKeyboardDelay:0.5f];
    return self.textFiledView;
}

@end
