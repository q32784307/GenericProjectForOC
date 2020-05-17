//
//  LSPasswordDotView.m
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/10/18.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import "LSPasswordDotView.h"
#import "LSPasswordViewProtocol.h"

#import "LSPSWLineDotNormalView.h"
#import "LSPSWLineDotEncryptionView.h"
#import "LSPSWRectDotNormalView.h"
#import "LSPSWRectDotEncryptionView.h"

@interface LSPasswordDotView ()

@property (nonatomic, strong) LSPasswordDotView *currentDotView;

@end

@implementation LSPasswordDotView

+ (instancetype)createDotViewWithType:(LSPasswordType)type
                                frame:(CGRect)frame {
    LSPasswordDotView *dotView = [[LSPasswordDotView alloc] initWithFrame:frame type:type];
    return dotView;
}

- (id)initWithFrame:(CGRect)frame type:(LSPasswordType)type {
    LSPasswordDotView *currentDotView = nil;
    switch (type) {
        case LSPasswordBottomLineNormal: {
            currentDotView = [[LSPSWLineDotNormalView alloc] initWithFrame:frame];
        }
            break;
        case LSPasswordBottomLineEncrytion: {
            currentDotView = [[LSPSWLineDotEncryptionView alloc] initWithFrame:frame];
        }
            break;
        case LSPasswordRectangleNormal: {
            currentDotView = [[LSPSWRectDotNormalView alloc] initWithFrame:frame];
        }
            break;
        case LSPasswordRectangleEncryption: {
            currentDotView = [[LSPSWRectDotEncryptionView alloc] initWithFrame:frame];
        }
            break;
            
        default: {
            currentDotView = [[LSPSWLineDotNormalView alloc] initWithFrame:frame];
        }
            break;
    }
    [self setCurrentDotView:currentDotView];
    return currentDotView;
}

- (void)ls_addConstraints {
    self.dotViewRaduis = 6.f;
    self.kLineLeftGap = 8.f;
    self.kLineTopGap = 0.f;
    
    self.titleLab = CreateCenterAlignmentLabel(BFont(25), LSColorWithHex(0x333333));
    self.titleLab.userInteractionEnabled = true;
    [self addSubview:self.titleLab];
    
    self.dotView = [[LSMaskView alloc] init];
    self.dotView.backgroundColor = LSColorWithHex(0x333333);
    self.dotView.layer.cornerRadius = self.dotViewRaduis;
    self.dotView.clipsToBounds = true;
    [self addSubview:self.dotView];
    
    self.bottomLineView = [UIView new];
    [self.bottomLineView setBackgroundColor:kNormarLineColor];
    [self addSubview:self.bottomLineView];
    
    self.verticalLineView = [UIView new];
    [self.verticalLineView setBackgroundColor:LSBorderLayerCorlor];
    [self addSubview:self.verticalLineView];
}


/**
 设置 bottomLine 是否高亮
 
 @param isHightlight YES/NO
 */
- (void)setDotBottomLineHightlight:(BOOL)isHightlight {
    [self.bottomLineView setBackgroundColor:isHightlight ?
                                     kHightlightLineColor : kNormarLineColor ];
}

/**
 设置Title
 
 @param aTitle title
 */
- (void)setDotTitle:(NSString *)aTitle {
    [self.titleLab setText:aTitle];
}


/**
 设置实心圆点是否显示
 
 @param isHide  yes/no
 */
- (void)setDotPointHide:(BOOL)isHide {
    [self.dotView setHidden:isHide];
}


- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *pointView = [super hitTest:point withEvent:event];
    if ([pointView isKindOfClass:self.class]) {
        return nil;
    }
    return pointView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
