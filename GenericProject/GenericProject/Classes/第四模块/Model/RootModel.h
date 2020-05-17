//
//  RootModel.h
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2018/9/20.
//  Copyright © 2018年 漠然丶情到深处. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RootModel : NSObject

@property(nonatomic,copy) NSString * _Nullable levelName;
@property(nonatomic,copy) NSString * _Nullable upRegionId;
@property(nonatomic,copy) NSString * _Nullable busiAreaId;
@property(nonatomic,copy) NSString * _Nullable level;
//...

@property(nonatomic,assign) NSUInteger belowCount;
@property(nullable,nonatomic) RootModel *supermodel;
@property(nonatomic,strong) NSMutableArray<__kindof RootModel *> * _Nullable submodels;

+ (instancetype _Nullable )modelWithDic:(NSDictionary *_Nullable)dic;
- (NSArray *_Nullable)open;
- (void)closeWithSubmodels:(NSArray *_Nullable)submodels;

@end

NS_ASSUME_NONNULL_END
