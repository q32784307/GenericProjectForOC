//
//  UIView+Animated.h
//  AnimatedDemo
//
//  github: https://github.com/tigerAndBull/TABAnimated
//  jianshu: https://www.jianshu.com/p/6a0ca4995dff
//
//  集成问答文档：https://www.jianshu.com/p/34417897915a
//  历史更新文档：https://www.jianshu.com/p/e3e9ea295e8a
//  动画下标说明：https://www.jianshu.com/p/8c361ba5aa18
//  豆瓣效果说明：https://www.jianshu.com/p/1a92158ce83a
//  嵌套视图说明：https://www.jianshu.com/p/cf8e37195c11
//
//  Created by tigerAndBull on 2018/9/14.
//  Copyright © 2018年 tigerAndBull. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TABViewAnimated, TABBaseComponent, TABComponentManager;

typedef TABBaseComponent * _Nullable (^TABSearchLayerBlock)(NSInteger);
typedef NSArray <TABBaseComponent *> * _Nullable (^TABSearchLayerArrayBlock)(NSInteger location, NSInteger length);

@interface UIView (TABAnimated)

// 控制视图持有
@property (nonatomic, strong) TABViewAnimated * _Nullable tabAnimated;

// 骨架屏管理单元持有
@property (nonatomic, strong) TABComponentManager * _Nullable tabComponentManager;

- (TABSearchLayerBlock _Nullable)animation DEPRECATED_MSG_ATTRIBUTE("已废弃的使用逻辑，请使用TABComponentManager中的`animation:`");
- (TABSearchLayerArrayBlock _Nullable)animations DEPRECATED_MSG_ATTRIBUTE("已废弃的使用逻辑，请使用TABComponentManager中的`animations:`");

@end

@class TABTableAnimated;

@interface UITableView (TABAnimated)

// 控制视图持有的配置管理对象
@property (nonatomic, strong) TABTableAnimated * _Nullable tabAnimated;

@end

@class TABCollectionAnimated;

@interface UICollectionView (TABAnimated)

// 控制视图持有的配置管理对象
@property (nonatomic, strong) TABCollectionAnimated * _Nullable tabAnimated;

@end

