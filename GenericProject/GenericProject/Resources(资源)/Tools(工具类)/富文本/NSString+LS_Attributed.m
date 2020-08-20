//
//  NSString+LS_Attributed.m
//  GenericProject
//
//  Created by 社科塞斯 on 2020/8/20.
//  Copyright © 2020 漠然丶情到深处. All rights reserved.
//

#import "NSString+LS_Attributed.h"
#import "LSAttributedMaker.h"

@implementation NSString (LS_Attributed)

- (NSMutableAttributedString *)LS_Attributed:(void(^)(LSAttributedMaker *make))attributed {
    LSAttributedMaker *make = [[LSAttributedMaker alloc]init];
    [make.stringArr addObject:self];
    [make.attributedStringArr addObject:[[NSMutableAttributedString alloc] initWithString:self]];
    attributed(make);
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] init];
    [make.attributedStringArr enumerateObjectsUsingBlock:^(NSMutableAttributedString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [attributedString appendAttributedString:obj];
    }];
    return attributedString;;
}

@end
