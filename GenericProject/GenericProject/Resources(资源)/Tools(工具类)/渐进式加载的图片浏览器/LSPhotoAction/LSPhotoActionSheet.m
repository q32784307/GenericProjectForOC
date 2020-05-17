//
//  LSPhotoActionSheet.m
//  GenericProject
//
//  Created by 社科赛斯 on 2019/12/17.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import "LSPhotoActionSheet.h"
#import "LSPhotoActionSheetView.h"

@interface LSPhotoActionSheet()<LSPhotoActionSheetViewDelegate>
{
    NSString *_cancelBtnTitle;
    NSString *_destructiveBtnTitle;
    NSArray *_otherBtnTitlesArr;
    
    UIView *_bgView;      // save subViews as a super View
    UIView *_coverView;   // background cover
    
    NSInteger _destructiveIndex;
}

@property(nonatomic,copy)ActionBlock ActionBlock;

@end

@implementation LSPhotoActionSheet

static id ActionSheet;
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if(!ActionSheet){
            ActionSheet = [super allocWithZone:zone];
        }
    });
    return ActionSheet;
}

#pragma mark - init subviews
- (void)setupSubViews {
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    
    [self setFrame:[[UIScreen mainScreen] bounds]];
    [self setBackgroundColor:[UIColor clearColor]];
    [self setHidden:YES];
    
    UIView *coverView = [[UIView alloc] initWithFrame:[self bounds]];
    _coverView = coverView;
    [coverView setBackgroundColor:[UIColor colorWithRed:30/255.f green:30/255.f blue:30/255.f alpha:1.f]];
    [coverView setAlpha:0.f];
    [coverView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coverViewDidClick)]];
    [self addSubview:coverView];
    
    UIView *bgView = [[UIView alloc] init];
    [bgView setBackgroundColor:[UIColor colorWithRed:220/255.f green:220/255.f blue:220/255.f alpha:1.f]];
    _bgView = bgView;
    [self addSubview:bgView];
    
    for (NSInteger i = 0; i < _otherBtnTitlesArr.count; i++) {
        LSPhotoActionSheetView *sheetView = [[LSPhotoActionSheetView alloc] init];
        [sheetView setTag:i];
        [sheetView setDelegate:self];
        
        CGFloat buttonY = 49 * i;
        [sheetView setFrame:(CGRect){{0,buttonY},{ScreenWidth,49}}];
        
        if (i == _destructiveIndex && _destructiveBtnTitle.length){
            [sheetView setIsDestructive:YES];
        }
        
        [sheetView setTitle:_otherBtnTitlesArr[i]];
        [_bgView addSubview:sheetView];
        
        CALayer *line = [CALayer layer];
        [line setBackgroundColor: [[UIColor colorWithRed:220/255.f green:220/255.f blue:220/255.f alpha:1.f] CGColor]];
        line.frame = CGRectMake(0, buttonY, ScreenWidth, 0.5);
        [_bgView.layer addSublayer:line];
    }

    CGFloat height = 49 * (_otherBtnTitlesArr.count + 1) + 5;
    LSPhotoActionSheetView *cancelView = [[LSPhotoActionSheetView alloc] init];
    [cancelView setDelegate:self];
    [cancelView setTag:_otherBtnTitlesArr.count];
    
    CGFloat buttonY = 49 * (_otherBtnTitlesArr.count) + 5;
    [cancelView setFrame:(CGRect){{0,buttonY},{ScreenWidth,49}}];
    
    [cancelView setTitle:_cancelBtnTitle?_cancelBtnTitle:@"取消"];
    [_bgView addSubview:cancelView];
    
    _bgView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, height);
}

- (void)actionSheetViewIBAction:(NSInteger)index {
    if(_ActionBlock){
        _ActionBlock(index);
    }
    [self dismiss];
}

- (void)coverViewDidClick {
    if(_ActionBlock){
        _ActionBlock(-1);
    }
    [self dismiss];
}

- (void)show {
    [_coverView setAlpha:0];
    [_bgView setTransform:CGAffineTransformIdentity];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    
    [self setHidden:NO];
    
    [UIView animateWithDuration:0.3 animations:^{
        [self->_coverView setAlpha:0.3];
        [self->_bgView setTransform:CGAffineTransformMakeTranslation(0, -self->_bgView.frame.size.height)];
    } completion:^(BOOL finished) {
        
    }];
}

- (void)dismiss {
    [UIView animateWithDuration:0.3 animations:^{
        [self->_coverView setAlpha:0];
        [self->_bgView setTransform:CGAffineTransformIdentity];
    } completion:^(BOOL finished) {
        [self setHidden:YES];
        [self removeFromSuperview];
    }];
}

/**
 alert
 
 @param cancelTitle title of cancel
 @param otherTitleArr other title array
 @param ActionBlock call back
 @return alert
 */
- (instancetype)initWithCancelTitle:(NSString *)cancelTitle
                      otherTitleArr:(NSArray  *)otherTitleArr
                        actionBlock:(ActionBlock)ActionBlock {
    return [self initWithCancelTitle:cancelTitle
                    destructiveTitle:nil
                       otherTitleArr:[otherTitleArr copy]
                         actionBlock:ActionBlock];
}

/**
 alert  + destruction
 
 @param cancelTitle title of cancel
 @param destructiveTitle destructive title
 @param otherTitleArr other title array
 @param ActionBlock call back
 @return alert
 */
- (instancetype)initWithCancelTitle:(NSString *)cancelTitle
                   destructiveTitle:(NSString *)destructiveTitle
                      otherTitleArr:(NSArray  *)otherTitleArr
                        actionBlock:(ActionBlock)ActionBlock {
    return [self initWithCancelTitle:cancelTitle
                    destructiveTitle:destructiveTitle
                    destructiveIndex:0
                       otherTitleArr:[otherTitleArr copy]
                         actionBlock:ActionBlock];
}

/**
 alert + destructive + index of destructive
 
 @param cancelTitle title of cancel
 @param destructiveTitle destructive title
 @param destructiveIndex destructive index
 @param otherTitleArr other title array
 @param ActionBlock call back
 @return alert
 */
- (instancetype)initWithCancelTitle:(NSString *)cancelTitle
                   destructiveTitle:(NSString *)destructiveTitle
                   destructiveIndex:(NSInteger )destructiveIndex
                      otherTitleArr:(NSArray  *)otherTitleArr
                        actionBlock:(ActionBlock)ActionBlock {
    
    if(self = [super init]){
        _cancelBtnTitle = cancelTitle;
        _destructiveBtnTitle = destructiveTitle;
        
        NSMutableArray *titleArr = [NSMutableArray arrayWithArray:otherTitleArr];
        
        if(destructiveTitle.length){
            _destructiveIndex = destructiveIndex;
            [titleArr insertObject:destructiveTitle atIndex:destructiveIndex];
        }
        
        _otherBtnTitlesArr = [NSArray arrayWithArray:titleArr];
        _ActionBlock = ActionBlock;
        
        [self setupSubViews];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
