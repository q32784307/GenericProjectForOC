//
//  UITextField+LSExtension.h
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/11/26.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (LSExtension)

- (NSRange)selectedRange;

- (void)setSelectedRange:(NSRange)range;

@end

NS_ASSUME_NONNULL_END
