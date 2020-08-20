//
//  LSAttributedMaker.m
//  GenericProject
//
//  Created by 社科塞斯 on 2020/8/20.
//  Copyright © 2020 漠然丶情到深处. All rights reserved.
//

#import "LSAttributedMaker.h"

@interface LSAttributedMaker ()
@property(nonatomic,strong)NSMutableArray<NSString *> *stringArr;
@property(nonatomic,strong)NSMutableArray<NSMutableAttributedString *> *attributedStringArr;
@property(nonatomic,assign)float pLineSpacing;
@property(nonatomic,assign)NSLineBreakMode pLineBreakMode;
@property(nonatomic,assign)NSTextAlignment pAlignment;

@end

@implementation LSAttributedMaker

- (instancetype)init {
    self = [super init];
    if (self) {
        _stringArr = [[NSMutableArray alloc] initWithCapacity:0];
        _attributedStringArr = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}

- (LSAttributedMaker *(^)(UIFont *value))font {
    __weak typeof (self) weakSelf = self;
    return ^(UIFont *value ) {
        NSString *string = weakSelf.stringArr.lastObject;
        NSMutableAttributedString *attributedString = weakSelf.attributedStringArr.lastObject;
        [attributedString addAttribute:NSFontAttributeName
                                 value:value
                                 range:NSMakeRange(0, string.length)];
        return weakSelf;
    };
}

- (LSAttributedMaker *(^)(UIColor *value))foregroundColor {
    __weak typeof (self) weakSelf = self;
    return ^(UIColor *value ) {
        NSString *string = weakSelf.stringArr.lastObject;
        NSMutableAttributedString *attributedString = weakSelf.attributedStringArr.lastObject;
        [attributedString addAttribute: NSForegroundColorAttributeName
                                 value:value
                                 range:NSMakeRange(0, string.length)];
        return weakSelf;
    };
}

- (LSAttributedMaker *(^)(UIColor *value))backgroundColor {
    __weak typeof (self) weakSelf = self;
    return ^(UIColor *value ) {
        NSString *string = weakSelf.stringArr.lastObject;
        NSMutableAttributedString *attributedString = weakSelf.attributedStringArr.lastObject;
        [attributedString addAttribute: NSBackgroundColorAttributeName
                                 value:value
                                 range:NSMakeRange(0, string.length)];
        return weakSelf;
    };
}

- (LSAttributedMaker *(^)(NSInteger value))strikethroughStyle {
    __weak typeof (self) weakSelf = self;
    return ^(NSInteger value ) {
        NSString *string = weakSelf.stringArr.lastObject;
        NSMutableAttributedString *attributedString = weakSelf.attributedStringArr.lastObject;
        [attributedString addAttribute: NSStrikethroughStyleAttributeName
                                 value:@(value)
                                 range:NSMakeRange(0, string.length)];
        return weakSelf;
    };
}

- (LSAttributedMaker *(^)(NSInteger value))baselineOffset {
    __weak typeof (self) weakSelf = self;
    return ^(NSInteger value ) {
        NSString *string = weakSelf.stringArr.lastObject;
        NSMutableAttributedString *attributedString = weakSelf.attributedStringArr.lastObject;
        [attributedString addAttribute: NSBaselineOffsetAttributeName
                                 value:@(value)
                                 range:NSMakeRange(0, string.length)];
        return weakSelf;
    };
}

- (LSAttributedMaker *(^)(UIColor *value))strikethroughColor {
    __weak typeof (self) weakSelf = self;
    return ^(UIColor *value ) {
        NSString *string = weakSelf.stringArr.lastObject;
        NSMutableAttributedString *attributedString = weakSelf.attributedStringArr.lastObject;
        [attributedString addAttribute: NSStrikethroughColorAttributeName
                                 value:value
                                 range:NSMakeRange(0, string.length)];
        return weakSelf;
    };
}

- (LSAttributedMaker *(^)(NSInteger value))underlineStyle {
    __weak typeof (self) weakSelf = self;
    return ^(NSInteger value ) {
        NSString *string = weakSelf.stringArr.lastObject;
        NSMutableAttributedString *attributedString = weakSelf.attributedStringArr.lastObject;
        [attributedString addAttribute: NSUnderlineStyleAttributeName
                                 value:@(value)
                                 range:NSMakeRange(0, string.length)];
        return weakSelf;
    };
}

- (LSAttributedMaker *(^)(UIColor *value))underlineColor {
    __weak typeof (self) weakSelf = self;
    return ^(UIColor *value) {
        NSString *string = weakSelf.stringArr.lastObject;
        NSMutableAttributedString *attributedString = weakSelf.attributedStringArr.lastObject;
        [attributedString addAttribute: NSUnderlineColorAttributeName
                                 value:value
                                 range:NSMakeRange(0, string.length)];
        return weakSelf;
    };
}

- (LSAttributedMaker *(^)(UIColor *value))strokeColor {
    __weak typeof (self) weakSelf = self;
    return ^(UIColor *value) {
        NSString *string = weakSelf.stringArr.lastObject;
        NSMutableAttributedString *attributedString = weakSelf.attributedStringArr.lastObject;
        [attributedString addAttribute: NSStrokeColorAttributeName
                                 value:value
                                 range:NSMakeRange(0, string.length)];
        return weakSelf;
    };
}

- (LSAttributedMaker *(^)(float value))strokeWidth {
    __weak typeof (self) weakSelf = self;
    return ^(float value) {
        NSString *string = weakSelf.stringArr.lastObject;
        NSMutableAttributedString *attributedString = weakSelf.attributedStringArr.lastObject;
        [attributedString addAttribute: NSStrokeWidthAttributeName
                                 value:@(value)
                                 range:NSMakeRange(0, string.length)];
        return weakSelf;
    };
}

- (LSAttributedMaker *(^)(NSShadow *value))shadow {
    __weak typeof (self) weakSelf = self;
    return ^(NSShadow *value) {
        NSString *string = weakSelf.stringArr.lastObject;
        NSMutableAttributedString *attributedString = weakSelf.attributedStringArr.lastObject;
        [attributedString addAttribute: NSShadowAttributeName
                                 value:value
                                 range:NSMakeRange(0, string.length)];
        return weakSelf;
    };
}

- (LSAttributedMaker *(^)(float value))obliqueness {
    __weak typeof (self) weakSelf = self;
    return ^(float value) {
        NSString *string = weakSelf.stringArr.lastObject;
        NSMutableAttributedString *attributedString = weakSelf.attributedStringArr.lastObject;
        [attributedString addAttribute: NSObliquenessAttributeName
                                 value:@(value)
                                 range:NSMakeRange(0, string.length)];
        return weakSelf;
    };
}

- (LSAttributedMaker *(^)(NSString *value))link {
    __weak typeof (self) weakSelf = self;
    return ^(NSString *value) {
        NSString *string = weakSelf.stringArr.lastObject;
        NSMutableAttributedString *attributedString = weakSelf.attributedStringArr.lastObject;
        [attributedString addAttribute: NSLinkAttributeName
                                 value:[NSURL URLWithString:value]
                                 range:NSMakeRange(0, string.length)];
        return weakSelf;
    };
}

- (LSAttributedMaker *(^)(UIImage *image,CGRect bounds,NSInteger index))insertImage {
    __weak typeof (self) weakSelf = self;
    return ^(UIImage *image,CGRect bounds,NSInteger index) {
        NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
        textAttachment.image = image;  //设置图片源
        textAttachment.bounds = bounds;          //设置图片位置和大小
        NSAttributedString *coreText2 = [NSAttributedString attributedStringWithAttachment: textAttachment];
 
        NSMutableAttributedString *attributedString = weakSelf.attributedStringArr.lastObject;
        [attributedString insertAttributedString:coreText2 atIndex:index];
        return weakSelf;
    };
}

- (LSAttributedMaker *(^)(float value))kern {
    __weak typeof (self) weakSelf = self;
    return ^(float value) {
        NSString *string = weakSelf.stringArr.lastObject;
        NSMutableAttributedString *attributedString = weakSelf.attributedStringArr.lastObject;
        [attributedString addAttribute: NSKernAttributeName
                                 value:@(value)
                                 range:NSMakeRange(0, string.length)];
        return weakSelf;
    };
}

- (LSAttributedMaker *(^)(float value))lineSpacing {
    __weak typeof (self) weakSelf = self;
    return ^(float value) {
        NSString *string = weakSelf.stringArr.lastObject;
        NSMutableAttributedString *attributedString = weakSelf.attributedStringArr.lastObject;
        NSMutableParagraphStyle *style = [NSMutableParagraphStyle new];
        style.lineSpacing = value;
        weakSelf.pLineSpacing = value;
        if (weakSelf.pLineBreakMode) {
            style.lineBreakMode = weakSelf.pLineBreakMode;
        }
        if (weakSelf.pAlignment) {
            style.alignment = weakSelf.pAlignment;
        }
        [attributedString addAttribute: NSParagraphStyleAttributeName
                                 value:style
                                 range:NSMakeRange(0, string.length)];
        return weakSelf;
    };
}

- (LSAttributedMaker *(^)(NSTextAlignment value))textAlignment {
    __weak typeof (self) weakSelf = self;
    return ^(NSTextAlignment value) {
        NSString *string = weakSelf.stringArr.lastObject;
        NSMutableAttributedString *attributedString = weakSelf.attributedStringArr.lastObject;
        NSMutableParagraphStyle *style = [NSMutableParagraphStyle new];
        style.alignment = value;
        weakSelf.pAlignment = value;
        if (weakSelf.pLineSpacing) {
            style.lineSpacing = weakSelf.pLineSpacing;
        }
        if (weakSelf.pLineBreakMode) {
            style.lineBreakMode = weakSelf.pLineBreakMode;
        }
        [attributedString addAttribute: NSParagraphStyleAttributeName
                                 value:style
                                 range:NSMakeRange(0, string.length)];
        return weakSelf;
    };
}

- (LSAttributedMaker *(^)(NSLineBreakMode value))lineBreakMode {
    __weak typeof (self) weakSelf = self;
    return ^(NSLineBreakMode value) {
        NSString *string = weakSelf.stringArr.lastObject;
        NSMutableAttributedString *attributedString = weakSelf.attributedStringArr.lastObject;
        NSMutableParagraphStyle *style = [NSMutableParagraphStyle new];
        style.lineBreakMode = value;
        weakSelf.pLineBreakMode = value;
        if (weakSelf.pLineSpacing) {
            style.lineSpacing = weakSelf.pLineSpacing;
        }
        if (weakSelf.pAlignment) {
            style.alignment = weakSelf.pAlignment;
        }
        [attributedString addAttribute: NSParagraphStyleAttributeName
                                 value:style
                                 range:NSMakeRange(0, string.length)];
        return weakSelf;
    };
}

- (LSAttributedMaker *(^)(NSString *string))append {
    __weak typeof (self) weakSelf = self;
    return ^(NSString *string) {
        [weakSelf.stringArr addObject:string];
        [weakSelf.attributedStringArr addObject:[[NSMutableAttributedString alloc] initWithString:string]];
        return weakSelf;
    };
}

- (LSAttributedMaker *)merge {
    __block  NSString *string = @"";
    [self.stringArr enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        string = [string stringByAppendingString:obj];
    }];
    [self.stringArr removeAllObjects];
    [self.stringArr addObject:string];
    
    NSMutableAttributedString *attributedString = \
    [[NSMutableAttributedString alloc] init];
    [self.attributedStringArr enumerateObjectsUsingBlock:^(NSMutableAttributedString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [attributedString appendAttributedString:obj];
    }];
    [self.attributedStringArr removeAllObjects];
    [self.attributedStringArr addObject:attributedString];
    return self;
}

@end
