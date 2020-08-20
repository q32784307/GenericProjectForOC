//
//  LSAttributedMaker.h
//  GenericProject
//
//  Created by 社科塞斯 on 2020/8/20.
//  Copyright © 2020 漠然丶情到深处. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSAttributedMaker : NSObject

@property(nonatomic,strong,readonly)NSMutableArray<NSString *> *stringArr;
@property(nonatomic,strong,readonly)NSMutableArray<NSMutableAttributedString *> *attributedStringArr;


///设置font
- (LSAttributedMaker *(^)(UIFont *value))font;
///设置斜体
- (LSAttributedMaker *(^)(float value))obliqueness;
///设置文字颜色
- (LSAttributedMaker *(^)(UIColor *value))foregroundColor;
///设置背景颜色
- (LSAttributedMaker *(^)(UIColor *value))backgroundColor;
///删除线高度
- (LSAttributedMaker *(^)(NSInteger value))strikethroughStyle;
///删除线颜色
- (LSAttributedMaker *(^)(UIColor *value))strikethroughColor;
///删除线基线偏移属性(有bug)
//- (AttributedMaker *(^)(NSInteger value))baselineOffset;
///下滑线粗度
- (LSAttributedMaker *(^)(NSInteger value))underlineStyle;
///下滑线颜色
- (LSAttributedMaker *(^)(UIColor *value))underlineColor;
///字体描边宽度
- (LSAttributedMaker *(^)(float value))strokeWidth;
///字体描边颜
- (LSAttributedMaker *(^)(UIColor *value))strokeColor;
///字体阴影
- (LSAttributedMaker *(^)(NSShadow *value))shadow;
///字间距
- (LSAttributedMaker *(^)(float value))kern;
///行间距
- (LSAttributedMaker *(^)(float value))lineSpacing;
///对齐方式
- (LSAttributedMaker *(^)(NSTextAlignment value))textAlignment;
///字符截断类型
- (LSAttributedMaker *(^)(NSLineBreakMode value))lineBreakMode;
///设置URL跳转 UITextView才有效，UILabel和UITextField里面无效
- (LSAttributedMaker *(^)(NSString *value))link;
///插入图片(图片，尺寸，位置)
- (LSAttributedMaker *(^)(UIImage *image,CGRect bounds,NSInteger index))insertImage;
///追加文字
- (LSAttributedMaker *(^)(NSString *string))append;
///合并（例如追加完文字以后，来个总设置）
- (LSAttributedMaker *)merge;

@end

NS_ASSUME_NONNULL_END
