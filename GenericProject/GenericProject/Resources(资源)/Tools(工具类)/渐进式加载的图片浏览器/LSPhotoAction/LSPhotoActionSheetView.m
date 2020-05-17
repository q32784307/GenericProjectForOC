//
//  LSPhotoActionSheetView.m
//  GenericProject
//
//  Created by 社科赛斯 on 2019/12/17.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import "LSPhotoActionSheetView.h"

@implementation LSPhotoActionSheetView

- (instancetype)init {
    if (self = [super init]) {
        self.isDestructive = NO;
        [self setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self setBackgroundColor:[UIColor colorWithRed:209 / 255.f green:211 / 255.f blue:218 / 255.f alpha:1.f]];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self setBackgroundColor:[UIColor whiteColor]];
    [self setAlpha:1.f];
    
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint point = [touch locationInView:[touch view]];
    
    CGFloat x = point.x;
    CGFloat y = point.y;
    
    if(x < self.frame.size.width && x > 0 && y >0 && y < self.frame.size.height){
        if([_delegate respondsToSelector:@selector(actionSheetViewIBAction:)]){
            [_delegate actionSheetViewIBAction:self.tag];
        }
    }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self setBackgroundColor:[UIColor whiteColor]];
    [self setAlpha:1.f];
}

- (void)setTitle:(NSString *)title {
    _title = title;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:18];
    dict[NSForegroundColorAttributeName] = _isDestructive?[UIColor redColor]:[UIColor blackColor];
    NSMutableParagraphStyle *paragrap = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    paragrap.alignment = NSTextAlignmentCenter;
    dict[NSParagraphStyleAttributeName] = paragrap;
    [_title drawInRect:(CGRect){{0,self.bounds.size.height * 0.25},self.bounds.size} withAttributes:dict];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
