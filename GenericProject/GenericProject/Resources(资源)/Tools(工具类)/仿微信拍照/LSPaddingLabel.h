//
//  LSPaddingLabel.h
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/12/10.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 可以设置内边距的Label
@interface LSPaddingLabel : UILabel

/// 内边距
@property(nonatomic,assign)UIEdgeInsets textPadding;

@end

NS_ASSUME_NONNULL_END
