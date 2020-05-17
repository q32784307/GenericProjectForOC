//
//  LSModel.m
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/10/18.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import "LSModel.h"

@implementation LSModel

@end

@interface LSViewModel ()

@property (nonatomic, strong) NSMutableArray  <LSModel *> *rows;


@end

@implementation LSViewModel

- (id)init {
    if (self = [super init]) {
        [self configureDefaultData];
    }
    return self;
}

- (NSInteger)numberOfSections {
    return 1;
}

- (NSInteger)numberOfRowInSection:(NSInteger)setion {
    return self.rows.count;
}

- (LSModel *)rowModelOfIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row >= self.rows.count) {
        return nil;
    }
    return self.rows[indexPath.row];
}

- (void)configureDefaultData {
    for (int i = 0 ; i < 5; i++) {
        LSModel *model = [LSModel new];
        if (i == 0) {
            model.name = @"下划线高亮明文密码输入框样式";
            model.styleType = LSPasswordStyleBottomLineNormal;
        }else if (i == 1) {
            model.name = @"下划线安全密码输入框样式";
            model.styleType = LSPasswordStyleBottomLineEncrypt;
        }else if (i == 2) {
            model.name = @"矩形框明文密码输入框样式";
            model.styleType = LSPasswordStyleRectangleNormal;
        }else if (i == 3) {
            model.name = @"矩形框安全密码输入框样式";
            model.styleType = LSPasswordStyleRectangleEncrypt;
        }else if (i == 4) {
            model.name = @"密码密码框带完成动画";
            model.styleType = LSPasswordStyleWithAnimating;
        }
        [self.rows addObject:model];
    }
}

- (NSMutableArray *)rows{
    if(!_rows){
        _rows = [NSMutableArray new];
    }
    return _rows;
}

@end
