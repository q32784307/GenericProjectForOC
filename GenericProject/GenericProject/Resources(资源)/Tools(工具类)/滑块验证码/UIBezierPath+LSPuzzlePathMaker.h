//
//  UIBezierPath+LSPuzzlePathMaker.h
//  GenericProject
//
//  Created by 社科赛斯 on 2019/12/12.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSPuzzlePathMaker.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIBezierPath (LSPuzzlePathMaker)

+ (instancetype)bezierPathWithPathMaker:(void(^)(LSPuzzlePathMaker *maker))maker;

@end

NS_ASSUME_NONNULL_END
