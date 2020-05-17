//
//  LSPSWTextFieldContext.h
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/10/18.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LSPasswordViewProtocol.h"

typedef NS_ENUM(NSInteger,LSPSWTextFieldViewType) {
    LSPSWTextFieldViewLineNormal     = 0,
    LSPSWTextFieldViewLineEncryption = 1,
    LSPSWTextFieldViewRectNormal     = 2,
    LSPSWTextFieldViewRectEncryption = 3,
    LSPSWTextFieldViewWithAnimating  = 4,
};

NS_ASSUME_NONNULL_BEGIN

@interface LSPSWTextFieldContext : NSObject

+ (UIView <LSPasswordViewProtocol> *)configureTextFieldView:(LSPSWTextFieldViewType)viewType frame:(CGRect)frame;

@end

NS_ASSUME_NONNULL_END
