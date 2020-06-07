//
//  TABComponentManager.m
//  AnimatedDemo
//
//  Created by tigerAndBull on 2019/7/16.
//  Copyright © 2019 tigerAndBull. All rights reserved.
//

#import "TABComponentManager.h"
#import "TABAnimatedProduction.h"

@interface TABComponentManager()

@property (nonatomic, strong) NSMutableArray <TABBaseComponent *> *components;

@end

@implementation TABComponentManager

#pragma mark - Public

+ (instancetype)managerWithLayers:(NSArray<TABComponentLayer *> *)layers {
    TABComponentManager *manager = [[TABComponentManager alloc] initWithLayers:layers];
    return manager;
}

- (instancetype)initWithLayers:(NSArray<TABComponentLayer *> *)layers {
    if (self = [super init]) {
        _components = @[].mutableCopy;
        for (NSInteger i = 0; i < layers.count; i++) {
            TABComponentLayer *layer = layers[i];
            TABBaseComponent *component = [TABBaseComponent componentWithLayer:layer];
            [_components addObject:component];
        }
    }
    return self;
}

- (TABBaseComponentBlock _Nullable)animation {
    return ^TABBaseComponent *(NSInteger index) {
        if (index >= self.components.count) {
            NSAssert(NO, @"Array bound, please check it carefully.");
        }
        return self.components[index];
    };
}

- (TABBaseComponentArrayBlock _Nullable)animations {
    return ^NSArray <TABBaseComponent *> *(NSInteger location, NSInteger length) {
        
        if (location + length > self.components.count) {
            NSAssert(NO, @"Array bound, please check it carefully.");
        }
        
        NSMutableArray <TABBaseComponent *> *tempArray = @[].mutableCopy;
        if (length == 0 && location == 0) {
            tempArray = self.components.mutableCopy;
        }else {
            for (NSInteger i = location; i < location+length; i++) {
                TABBaseComponent *layer = self.components[i];
                [tempArray addObject:layer];
            }
        }
        return tempArray.copy;
    };
}

- (TABBaseComponentArrayWithIndexsBlock)animationsWithIndexs {

    return ^NSArray <TABBaseComponent *> *(NSInteger index,...) {
        
        NSMutableArray <TABBaseComponent *> *resultArray = @[].mutableCopy;
        if (index >= self.components.count) {
            NSAssert(NO, @"Array bound, please check it carefully.");
        }else if(index < 0) {
            NSAssert(NO, @"Input data contains a number < 0, please check it carefully.");
        }else {
            [resultArray addObject:self.components[index]];
        }
        
        va_list args;
        NSInteger arg;
        va_start(args, index);

        while ((arg = va_arg(args, NSInteger))) {
            if(arg >= 0) {
                if (arg > 1000) break;
                if (arg >= self.components.count) {
                    NSAssert(NO, @"Array bound, please check it carefully.");
                }else if(arg < 0) {
                    NSAssert(NO, @"Input data contains a number < 0, please check it carefully.");
                }else {
                    [resultArray addObject:self.components[arg]];
                }
            }
        }
        
        va_end(args);
        return resultArray.copy;
    };
}

@end
