//
//  UIBezierPath+LSPuzzlePathMaker.m
//  GenericProject
//
//  Created by 社科赛斯 on 2019/12/12.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import "UIBezierPath+LSPuzzlePathMaker.h"

@implementation UIBezierPath (LSPuzzlePathMaker)

+ (instancetype)bezierPathWithPathMaker:(void(^)(LSPuzzlePathMaker *maker))maker {
    UIBezierPath *path = [UIBezierPath bezierPath];
    if (maker) {
        LSPuzzlePathMaker *pathMaker = [[LSPuzzlePathMaker alloc] initWithBezierPath:path];
        maker(pathMaker);
    }
    return path;
}

@end
