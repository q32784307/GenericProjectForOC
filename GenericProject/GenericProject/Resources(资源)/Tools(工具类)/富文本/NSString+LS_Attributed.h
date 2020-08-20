//
//  NSString+LS_Attributed.h
//  GenericProject
//
//  Created by 社科塞斯 on 2020/8/20.
//  Copyright © 2020 漠然丶情到深处. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class LSAttributedMaker;

@interface NSString (LS_Attributed)

- (NSMutableAttributedString *)LS_Attributed:(void(^)(LSAttributedMaker *make))attributed;

@end

NS_ASSUME_NONNULL_END
