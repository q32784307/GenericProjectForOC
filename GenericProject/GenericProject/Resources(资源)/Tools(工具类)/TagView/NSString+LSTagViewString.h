//
//  NSString+LSTagViewString.h
//  GenericProject
//
//  Created by 社科赛斯 on 2019/12/12.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (LSTagViewString)

- (CGFloat)widthWithFont:(UIFont *)font constrainedToHeight:(CGFloat)height;

@end

NS_ASSUME_NONNULL_END
