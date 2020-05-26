//
//  UIView+TABControlModel.m
//  AnimatedDemo
//
//  Created by tigerAndBull on 2020/3/27.
//  Copyright © 2020 tigerAndBull. All rights reserved.
//

#import "UIView+TABControlModel.h"
#import <objc/runtime.h>

@implementation UIView (TABControlModel)

- (TABViewAnimated *)tabAnimated {
    return objc_getAssociatedObject(self, @selector(tabAnimated));
}

- (void)setTabAnimated:(TABViewAnimated *)tabAnimated {
    objc_setAssociatedObject(self, @selector(tabAnimated),tabAnimated, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

#import "TABTableAnimated.h"

@implementation UITableView (TABControlModel)

- (TABTableAnimated *)tabAnimated {
    return objc_getAssociatedObject(self, @selector(tabAnimated));
}

- (void)setTabAnimated:(TABTableAnimated *)tabAnimated {
    objc_setAssociatedObject(self, @selector(tabAnimated),tabAnimated, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

#import "TABCollectionAnimated.h"

@implementation UICollectionView (TABControlModel)

- (TABCollectionAnimated *)tabAnimated {
    return objc_getAssociatedObject(self, @selector(tabAnimated));
}

- (void)setTabAnimated:(TABCollectionAnimated *)tabAnimated {
    objc_setAssociatedObject(self, @selector(tabAnimated),tabAnimated, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
