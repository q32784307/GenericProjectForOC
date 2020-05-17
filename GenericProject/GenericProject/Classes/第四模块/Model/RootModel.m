//
//  RootModel.m
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2018/9/20.
//  Copyright © 2018年 漠然丶情到深处. All rights reserved.
//

#import "RootModel.h"

@implementation RootModel

+ (instancetype)modelWithDic:(NSDictionary *)dic {
    
    RootModel *foldCellModel = [RootModel new];
    foldCellModel.levelName = dic[@"levelName"];
    foldCellModel.upRegionId = dic[@"upRegionId"];
    foldCellModel.busiAreaId = dic[@"busiAreaId"];
    
    if ([dic[@"regionTypeCode"] isEqualToString:@"1100"]) {
        foldCellModel.level = @"0";
    }else if ([dic[@"regionTypeCode"] isEqualToString:@"1300"]){
        foldCellModel.level = @"1";
    }else if ([dic[@"regionTypeCode"] isEqualToString:@"1400"]){
        foldCellModel.level = @"2";
    }
    
    foldCellModel.belowCount = 0;
    
    foldCellModel.submodels = [NSMutableArray new];
    NSArray *shiArr = dic[@"shiBusiAreaList"];
    NSArray *xianArr = dic[@"xianBusiAreaList"];
    
    NSArray *submodels = [[NSArray alloc] init];
    if (shiArr.count > 0) {
        submodels = dic[@"shiBusiAreaList"];
    }
    if (xianArr.count > 0) {
        submodels = dic[@"xianBusiAreaList"];
    }
    for (int i = 0; i < submodels.count; i++) {
        RootModel *submodel = [RootModel modelWithDic:(NSDictionary *)submodels[i]];
        submodel.supermodel = foldCellModel;
        [foldCellModel.submodels addObject:submodel];
    }
    
    return foldCellModel;
}

- (NSArray *)open {
    NSArray *submodels = self.submodels;
    self.submodels = nil;
    self.belowCount = submodels.count;
    return submodels;
}

- (void)closeWithSubmodels:(NSArray *)submodels {
    self.submodels = [NSMutableArray arrayWithArray:submodels];
    self.belowCount = 0;
}

- (void)setBelowCount:(NSUInteger)belowCount {
    self.supermodel.belowCount += (belowCount - _belowCount);
    _belowCount = belowCount;
}

@end
