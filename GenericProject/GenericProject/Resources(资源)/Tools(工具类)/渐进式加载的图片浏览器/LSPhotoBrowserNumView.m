//
//  LSPhotoBrowserNumView.m
//  GenericProject
//
//  Created by 社科赛斯 on 2019/12/17.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import "LSPhotoBrowserNumView.h"

@implementation LSPhotoBrowserNumView

- (instancetype)init {
    if (self = [super init]) {
        [self setFont:[UIFont boldSystemFontOfSize:20]];
        [self setTextColor:[UIColor whiteColor]];
        [self setTextAlignment:NSTextAlignmentCenter];
    }
    return self;
}

- (void)setCurrentNum:(NSInteger)currentNum totalNum:(NSInteger)totalNum {
    _currentNum = currentNum;
    _totalNum = totalNum;
    [self changeText];
}

- (void)changeText {
    self.text = [NSString stringWithFormat:@"%zd / %zd",_currentNum,_totalNum];
}

- (void)setCurrentNum:(NSInteger)currentNum {
    _currentNum = currentNum;
    [self changeText];
}

- (void)setTotalNum:(NSInteger)totalNum {
    _totalNum = totalNum;
    [self changeText];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
