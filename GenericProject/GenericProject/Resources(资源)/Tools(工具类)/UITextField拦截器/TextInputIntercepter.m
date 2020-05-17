//
//  TextInputIntercepter.m
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2018/8/1.
//  Copyright © 2018年 漠然丶情到深处. All rights reserved.
//

#import "TextInputIntercepter.h"
#import "NSString+TextInputStringType.h"

@interface UITextField (TextInputIntercepter)

@property(nonatomic,strong)TextInputIntercepter *yb_textInputIntercepter;

@end

@implementation UITextField (TextInputIntercepter)

- (void)setYb_textInputIntercepter:(TextInputIntercepter *)yb_textInputIntercepter {
    objc_setAssociatedObject(self, @selector(yb_textInputIntercepter), yb_textInputIntercepter, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (TextInputIntercepter *)yb_textInputIntercepter {
    return objc_getAssociatedObject(self, @selector(yb_textInputIntercepter));
}

@end



@interface UITextView (TextInputIntercepter)

@property(nonatomic,strong)TextInputIntercepter *yb_textInputIntercepter;

@end

@implementation UITextView (TextInputIntercepter)

- (void)setYb_textInputIntercepter:(TextInputIntercepter *)yb_textInputIntercepter {
    objc_setAssociatedObject(self, @selector(yb_textInputIntercepter), yb_textInputIntercepter, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (TextInputIntercepter *)yb_textInputIntercepter {
    return objc_getAssociatedObject(self, @selector(yb_textInputIntercepter));
}

@end


@interface TextInputIntercepter()<UITextViewDelegate, UITextFieldDelegate>

@property(nonatomic,strong)NSString *previousText;

@end

@implementation TextInputIntercepter

#pragma mark -------------------------- Life  Circle
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _emojiAdmitted = NO;
        _maxCharacterNum = UINT_MAX;
        _doubleBytePerChineseCharacter = NO;
        _intercepterNumberType = TextInputIntercepterNumberTypeNone;
    }
    return self;
}

#pragma mark -------------------------- Public  Methods
- (void)textInputView:(UIView *)textInputView {
    [TextInputIntercepter textInputView:textInputView setInputIntercepter:self];
}

+ (TextInputIntercepter *)textInputView:(UIView *)textInputView beyoudLimitBlock:(TextInputIntercepterBlock)beyoudLimitBlock {
    TextInputIntercepter *tmpInputIntercepter = [[TextInputIntercepter alloc] init];
    tmpInputIntercepter.beyoudLimitBlock = [beyoudLimitBlock copy];
    [self textInputView:textInputView setInputIntercepter:tmpInputIntercepter];
    return tmpInputIntercepter;
    
}

+ (void)textInputView:(UIView *)textInputView setInputIntercepter:(TextInputIntercepter *)intercepter {
    
    if ([textInputView isKindOfClass:[UITextField class]]) {
        UITextField *textField = (UITextField *)textInputView;
        
        textField.yb_textInputIntercepter = intercepter;
        [[NSNotificationCenter defaultCenter] addObserver:intercepter
                                                 selector:@selector(textInputDidChangeWithNotification:)
                                                     name:UITextFieldTextDidChangeNotification
                                                   object:textInputView];
        
    } else if ([textInputView isKindOfClass:[UITextView class]]) {
        UITextView *textView = (UITextView *)textInputView;
        textView.yb_textInputIntercepter = intercepter;
        [[NSNotificationCenter defaultCenter] addObserver:intercepter
                                                 selector:@selector(textInputDidChangeWithNotification:)
                                                     name:UITextViewTextDidChangeNotification
                                                   object:textInputView];
    }
}

#pragma mark -------------------------- Noti  Methods
- (void)textInputDidChangeWithNotification:(NSNotification *)noti {
    if (![((UIView *)noti.object) isFirstResponder]) {
        return;
    }
    
    BOOL textFieldTextDidChange = [noti.name isEqualToString:UITextFieldTextDidChangeNotification] &&
    [noti.object isKindOfClass:[UITextField class]];
    BOOL textViewTextDidChange = [noti.name isEqualToString:UITextViewTextDidChangeNotification] &&
    [noti.object isKindOfClass:[UITextView class]];
    if (!textFieldTextDidChange && !textViewTextDidChange) {
        return;
    }
    
    if ([noti.name isEqualToString:UITextFieldTextDidChangeNotification]) {
        [self textFieldTextDidChangeWithNotification:noti];
    } else if ([noti.name isEqualToString:UITextViewTextDidChangeNotification]) {
        [self textViewTextDidChangeWithNotification:noti];
    }
}

#pragma mark -------------------------- Private  Methods
- (void)textFieldTextDidChangeWithNotification:(NSNotification *)noti {
    
    UITextField *textField = (UITextField *)noti.object;
    NSString *inputText = textField.text;
    NSString *primaryLanguage = [textField.textInputMode primaryLanguage];
    //获取高亮部分
    UITextRange *selectedRange = [textField markedTextRange];
    UITextPosition *textPosition = [textField positionFromPosition:selectedRange.start
                                                            offset:0];
    
    inputText = [self handleWithInputText:inputText];
    
    NSString *finalText = [self finalTextAfterProcessingWithInput:inputText
                                                  maxCharacterNum:self.maxCharacterNum
                                                  primaryLanguage:primaryLanguage
                                                     textPosition:textPosition
                                  isDoubleBytePerChineseCharacter:self.isDoubleBytePerChineseCharacter];
    if (finalText.length > 0) {
        textField.text = finalText;
    }
    else if(self.intercepterNumberType == TextInputIntercepterNumberTypeNumberOnly ||
            self.intercepterNumberType == TextInputIntercepterNumberTypeDecimal ||
            self.isEmojiAdmitted == NO){
        textField.text = inputText;
    }
    _previousText = textField.text;
}

- (void)textViewTextDidChangeWithNotification:(NSNotification *)noti {
    
    UITextView *textView = (UITextView *)noti.object;
    NSString *inputText = textView.text;
    NSString *primaryLanguage = [textView.textInputMode primaryLanguage];
    //获取高亮部分
    UITextRange *selectedRange = [textView markedTextRange];
    UITextPosition *textPosition = [textView positionFromPosition:selectedRange.start
                                                           offset:0];
    
    inputText = [self handleWithInputText:inputText];
    
    NSString *finalText = [self finalTextAfterProcessingWithInput:inputText
                                                  maxCharacterNum:self.maxCharacterNum
                                                  primaryLanguage:primaryLanguage
                                                     textPosition:textPosition
                                  isDoubleBytePerChineseCharacter:self.isDoubleBytePerChineseCharacter];
    
    if (finalText.length > 0) {
        textView.text = finalText;
    }
    else if(self.intercepterNumberType == TextInputIntercepterNumberTypeNumberOnly ||
            self.intercepterNumberType == TextInputIntercepterNumberTypeDecimal ||
            self.isEmojiAdmitted == NO){
        textView.text = inputText;
    }
    
    _previousText = textView.text;
}

// 核心代码
// 对简体 中文 输入
- (NSString *)finalTextAfterProcessingWithInput:(NSString *)inputText
                                maxCharacterNum:(NSUInteger)maxCharacterNum
                                primaryLanguage:(NSString *)primaryLanguage
                                   textPosition:(UITextPosition *)textPosition
                isDoubleBytePerChineseCharacter:(BOOL)isDoubleBytePerChineseCharacter {
    
    
    
    NSString *finalText = nil;
    if ([primaryLanguage isEqualToString:@"zh-Hans"] ||
        [primaryLanguage isEqualToString:@"zh-Hant"]) { // 简繁体中文输入
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!textPosition) {
            finalText = [self processingTextWithInput:inputText
                                      maxCharacterNum:maxCharacterNum
                      isDoubleBytePerChineseCharacter:isDoubleBytePerChineseCharacter];
        }
        
    } else { // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
        finalText = [self processingTextWithInput:inputText
                                  maxCharacterNum:maxCharacterNum
                  isDoubleBytePerChineseCharacter:isDoubleBytePerChineseCharacter];
    }
    
    return finalText;
}

- (NSString *)processingTextWithInput:(NSString *)inputText
                      maxCharacterNum:(NSUInteger)maxCharacterNum
      isDoubleBytePerChineseCharacter:(BOOL)isDoubleBytePerChineseCharacter {
    
    NSString *processingText = nil;
    
    if (isDoubleBytePerChineseCharacter) { //如果一个汉字是双字节
        processingText = [self doubleBytePerChineseCharacterSubString:inputText
                                                      maxCharacterNum:maxCharacterNum];
    } else {
        if (inputText.length > maxCharacterNum) {
            NSRange rangeIndex = [inputText rangeOfComposedCharacterSequenceAtIndex:maxCharacterNum];
            if (rangeIndex.length == 1) {
                processingText = [inputText substringToIndex:maxCharacterNum];
            } else {
                NSRange rangeRange = [inputText rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, maxCharacterNum)];
                processingText = [inputText substringWithRange:rangeRange];
            }
            if (self.beyoudLimitBlock) {
                self.beyoudLimitBlock(self, processingText);
            }
        }
    }
    return processingText;
}

- (NSString *)doubleBytePerChineseCharacterSubString:(NSString*)string
                                     maxCharacterNum:(NSUInteger)maxCharacterNum {
    // 允许 表情
    if (self.emojiAdmitted) {
        // 调用 UTF8 编码处理 一个字符一个字节 一个汉字3个字节 一个表情4个字节
        NSUInteger textBytesLength = [string lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
        if (textBytesLength > maxCharacterNum) {
            NSRange range;
            NSUInteger byteLength = 0;
            NSString *text = string;
            for(int i=0; i < string.length && byteLength <= maxCharacterNum; i += range.length) {
                range = [string rangeOfComposedCharacterSequenceAtIndex:i];
                byteLength += strlen([[text substringWithRange:range] UTF8String]);
                if (byteLength > maxCharacterNum) {
                    NSString* newText = [text substringWithRange:NSMakeRange(0, range.location)];
                    string = newText;
                }
            }
            return string;
        }
    }
    // 不允许 输入 表情
    else {
        // 一个字符一个字节 一个汉字2个字节
        NSStringEncoding encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
        NSData *data = [string dataUsingEncoding:encoding];
        NSInteger length = [data length];
        if (length > maxCharacterNum) {
            NSData *subdata = [data subdataWithRange:NSMakeRange(0, maxCharacterNum)];
            NSString *content = [[NSString alloc] initWithData:subdata encoding:encoding];//注意：当截取CharacterCount长度字符时把中文字符截断返回的content会是nil
            if (!content || content.length == 0) {
                subdata = [data subdataWithRange:NSMakeRange(0, maxCharacterNum - 1)];
                content =  [[NSString alloc] initWithData:subdata encoding:encoding];
            }
            if (self.beyoudLimitBlock) {
                self.beyoudLimitBlock(self, content);
            }
            return content;
        }
    }
    
    return nil;
}

// 处理 输入 字符串
- (NSString *)handleWithInputText:(NSString *)inputText {
    if (_previousText.length >= inputText.length) {
        return inputText;
    }
    
    NSString *tmpReplacementString = [inputText substringWithRange:NSMakeRange(_previousText.length, (inputText.length - _previousText.length))];
    // 只允许 输入 数字
    if (self.intercepterNumberType == TextInputIntercepterNumberTypeNumberOnly) {
        if ([tmpReplacementString isCertainStringType:TextInputStringTypeNumber] == NO) {
            inputText = _previousText;
        }
    }
    // 输入 小数
    else if(self.intercepterNumberType == TextInputIntercepterNumberTypeDecimal){
        NSRange tmpRange = NSMakeRange(_previousText.length, 0);
        BOOL isCorrect = [self inputText:_previousText shouldChangeCharactersInRange:tmpRange replacementString:tmpReplacementString];
        if (isCorrect == YES) {
            if (inputText.length == self.maxCharacterNum && [tmpReplacementString isEqualToString:@"."]) {
                inputText = _previousText;
            }
        }
        else {
            inputText = _previousText;
        }
    }
    // 不允许 输入 表情
    else if (!self.isEmojiAdmitted && [tmpReplacementString isSpecialLetter]) {
        inputText =  _previousText;
    }
    
    return inputText;
}

- (BOOL)inputText:(NSString *)inputText shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    //    限制只能输入数字
    BOOL isHaveDian = YES;
    if ([string isEqualToString:@" "]) {
        return NO;
    }
    
    if ([inputText rangeOfString:@"."].location == NSNotFound) {
        isHaveDian = NO;
    }
    if ([string length] > 0) {
        
        unichar single = [string characterAtIndex:0];//当前输入的字符
        if ((single >= '0' && single <= '9') || single == '.') {//数据格式正确
            if(inputText.length == 0){
                if(single == '.') {
                    [inputText stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                }
            }
            //输入的字符是否是小数点
            if (single == '.') {
                if(!isHaveDian)//text中还没有小数点
                {
                    isHaveDian = YES;
                    return YES;
                    
                }else{
                    [inputText stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                }
            }else{
                if (isHaveDian) {//存在小数点
                    
                    //判断小数点的位数
                    NSRange ran = [inputText rangeOfString:@"."];
                    if (range.location - ran.location <= _decimalPlaces) {
                        return YES;
                    }else{
                        return NO;
                    }
                }else{
                    return YES;
                }
            }
        }else{//输入的数据格式不正确
            [inputText stringByReplacingCharactersInRange:range withString:@""];
            return NO;
        }
    }
    return YES;
}

#pragma mark -------------------------- Setter / Getter
- (void)setIntercepterNumberType:(TextInputIntercepterNumberType)intercepterNumberType {
    _intercepterNumberType = intercepterNumberType;
    // 小数
    if (_intercepterNumberType == TextInputIntercepterNumberTypeDecimal && (_decimalPlaces == 0)) {
        _decimalPlaces = 2;
    }
    
    if (_intercepterNumberType != TextInputIntercepterNumberTypeNone) {
        _doubleBytePerChineseCharacter = NO;
    }
}
@end

