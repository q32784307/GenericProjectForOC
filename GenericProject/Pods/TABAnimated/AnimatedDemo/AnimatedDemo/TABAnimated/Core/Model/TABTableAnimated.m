//
//  TABTableAnimated.m
//  AnimatedDemo
//
//  Created by tigerAndBull on 2019/4/27.
//  Copyright © 2019 tigerAndBull. All rights reserved.
//

#import "TABTableAnimated.h"

#import "TABManagerMethod.h"
#import "TableDeDaSelfModel.h"
#import "TABAnimated.h"
#import "TABAnimatedCacheManager.h"
#import "TABAnimatedDocumentMethod.h"

#import <objc/runtime.h>

@interface TABTableAnimated()

@property (nonatomic, strong, readwrite) NSMutableArray <Class> *headerClassArray;
@property (nonatomic, strong, readwrite) NSMutableArray <NSNumber *> *headerHeightArray;
@property (nonatomic, strong, readwrite) NSMutableArray <NSNumber *> *headerSectionArray;

@property (nonatomic, strong, readwrite) NSMutableArray <Class> *footerClassArray;
@property (nonatomic, strong, readwrite) NSMutableArray <NSNumber *> *footerHeightArray;
@property (nonatomic, strong, readwrite) NSMutableArray <NSNumber *> *footerSectionArray;

@property (nonatomic, assign, readwrite) BOOL isExhangeDelegateIMP;
@property (nonatomic, assign, readwrite) BOOL isExhangeDataSourceIMP;

@property (nonatomic, assign, readwrite) TABAnimatedRunMode runMode;

@end

@implementation TABTableAnimated

+ (instancetype)animatedWithCellClass:(Class)cellClass
                           cellHeight:(CGFloat)cellHeight {
    TABTableAnimated *obj = [[TABTableAnimated alloc] init];
    obj.cellClassArray = @[cellClass];
    obj.cellHeight = cellHeight;
    obj.animatedCount = ceilf([UIScreen mainScreen].bounds.size.height/cellHeight*1.0);
    return obj;
}

+ (instancetype)animatedWithCellClass:(Class)cellClass
                           cellHeight:(CGFloat)cellHeight
                        animatedCount:(NSInteger)animatedCount {
    TABTableAnimated *obj = [self animatedWithCellClass:cellClass cellHeight:cellHeight];
    obj.animatedCount = animatedCount;
    return obj;
}

+ (instancetype)animatedWithCellClass:(Class)cellClass
                           cellHeight:(CGFloat)cellHeight
                            toSection:(NSInteger)section {
    TABTableAnimated *obj = [self animatedWithCellClass:cellClass cellHeight:cellHeight];
    obj.animatedCountArray = @[@(ceilf([UIScreen mainScreen].bounds.size.height/cellHeight*1.0))];
    obj.animatedIndexArray = @[@(section)];
    return obj;
}

+ (instancetype)animatedWithCellClass:(Class)cellClass
                           cellHeight:(CGFloat)cellHeight
                        animatedCount:(NSInteger)animatedCount
                            toSection:(NSInteger)section {
    TABTableAnimated *obj = [self animatedWithCellClass:cellClass cellHeight:cellHeight];
    obj.animatedCountArray = @[@(animatedCount)];
    obj.animatedIndexArray = @[@(section)];
    return obj;
}

+ (instancetype)animatedWithCellClassArray:(NSArray<Class> *)cellClassArray
                           cellHeightArray:(NSArray<NSNumber *> *)cellHeightArray
                        animatedCountArray:(NSArray<NSNumber *> *)animatedCountArray {
    TABTableAnimated *obj = [[TABTableAnimated alloc] init];
    obj.animatedCountArray = animatedCountArray;
    obj.cellHeightArray = cellHeightArray;
    obj.cellClassArray = cellClassArray;
    return obj;
}

+ (instancetype)animatedWithCellClassArray:(NSArray <Class> *)cellClassArray
                           cellHeightArray:(NSArray <NSNumber *> *)cellHeightArray
                        animatedCountArray:(NSArray <NSNumber *> *)animatedCountArray
                      animatedSectionArray:(NSArray <NSNumber *> *)animatedSectionArray {
    TABTableAnimated *obj = [self animatedWithCellClassArray:cellClassArray
                                             cellHeightArray:cellHeightArray
                                          animatedCountArray:animatedCountArray];
    obj.animatedIndexArray = animatedSectionArray;
    return obj;
}

#pragma mark -

+ (instancetype)animatedInRowModeWithCellClassArray:(NSArray <Class> *)cellClassArray
                                    cellHeightArray:(NSArray <NSNumber *> *)cellHeightArray {
    TABTableAnimated *obj = [[TABTableAnimated alloc] init];
    obj.cellHeightArray = cellHeightArray;
    obj.cellClassArray = cellClassArray;
    obj.runMode = TABAnimatedRunByRow;
    return obj;
}

+ (instancetype)animatedInRowModeWithCellClassArray:(NSArray <Class> *)cellClassArray
                                    cellHeightArray:(NSArray <NSNumber *> *)cellHeightArray
                                           rowArray:(NSArray <NSNumber *> *)rowArray {
    TABTableAnimated *obj = [TABTableAnimated animatedInRowModeWithCellClassArray:cellClassArray
                                                                  cellHeightArray:cellHeightArray];
    obj.animatedIndexArray = rowArray;
    return obj;
}

+ (instancetype)animatedInRowModeWithCellClass:(Class)cellClass
                                    cellHeight:(CGFloat)cellHeight
                                         toRow:(NSInteger)row {
    TABTableAnimated *obj = [self animatedWithCellClass:cellClass
                                             cellHeight:cellHeight];
    obj.runMode = TABAnimatedRunByRow;
    obj.animatedCountArray = @[@(1)];
    obj.animatedIndexArray = @[@(row)];
    return obj;
}

#pragma mark - 自适应高度

+ (instancetype)animatedWithCellClass:(Class)cellClass {
    TABTableAnimated *obj = [[TABTableAnimated alloc] init];
    obj.cellClassArray = @[cellClass];
    obj.cellHeight = 44.;
    return obj;
}

- (instancetype)init {
    if (self = [super init]) {
        _runAnimationIndexArray = @[].mutableCopy;
        _animatedSectionCount = 0;
        _animatedCount = 1;
        
        _headerClassArray = @[].mutableCopy;
        _headerHeightArray = @[].mutableCopy;
        _headerSectionArray = @[].mutableCopy;
        
        _footerClassArray = @[].mutableCopy;
        _footerHeightArray = @[].mutableCopy;
        _footerSectionArray = @[].mutableCopy;
    }
    return self;
}

#pragma mark - Public Method

- (void)addHeaderViewClass:(__nonnull Class)headerViewClass
                viewHeight:(CGFloat)viewHeight
                 toSection:(NSInteger)section {
    BOOL isAdd = false;
    for (int i = 0; i < _headerSectionArray.count; i++) {
        NSInteger oldSection = [_headerSectionArray[i] integerValue];
        if (oldSection == section) {
            isAdd = YES;
            [_headerClassArray replaceObjectAtIndex:i withObject:headerViewClass];
            [_headerHeightArray replaceObjectAtIndex:i withObject:@(viewHeight)];
            [_headerSectionArray replaceObjectAtIndex:i withObject:@(section)];
        }
    }
    
    if (!isAdd) {
        [_headerClassArray addObject:headerViewClass];
        [_headerHeightArray addObject:@(viewHeight)];
        [_headerSectionArray addObject:@(section)];
    }
}

- (void)addHeaderViewClass:(__nonnull Class)headerViewClass
                viewHeight:(CGFloat)viewHeight {
    [_headerClassArray addObject:headerViewClass];
    [_headerHeightArray addObject:@(viewHeight)];
}

- (void)addFooterViewClass:(__nonnull Class)footerViewClass
                viewHeight:(CGFloat)viewHeight
                 toSection:(NSInteger)section {
    BOOL isAdd = false;
    for (int i = 0; i < _footerSectionArray.count; i++) {
        NSInteger oldSection = [_footerSectionArray[i] integerValue];
        if (oldSection == section) {
            isAdd = YES;
            [_footerClassArray replaceObjectAtIndex:i withObject:footerViewClass];
            [_footerHeightArray replaceObjectAtIndex:i withObject:@(viewHeight)];
            [_footerSectionArray replaceObjectAtIndex:i withObject:@(section)];
        }
    }
    
    if (!isAdd) {
        [_footerClassArray addObject:footerViewClass];
        [_footerHeightArray addObject:@(viewHeight)];
        [_footerSectionArray addObject:@(section)];
    }
}

- (void)addFooterViewClass:(__nonnull Class)footerViewClass
                viewHeight:(CGFloat)viewHeight {
    [_footerClassArray addObject:footerViewClass];
    [_footerHeightArray addObject:@(viewHeight)];
}

#pragma mark -

- (void)setCellHeight:(CGFloat)cellHeight {
    _cellHeight = cellHeight;
    _cellHeightArray = @[[NSNumber numberWithFloat:cellHeight]];
}

- (BOOL)currentIndexIsAnimatingWithIndex:(NSInteger)index {
    for (NSNumber *num in self.runAnimationIndexArray) {
        if ([num integerValue] == index) {
            return YES;
        }
    }
    return NO;
}

- (NSInteger)headerNeedAnimationOnSection:(NSInteger)section {
    
    if (self.headerSectionArray.count == 0) {
        return TABViewAnimatedErrorCode;
    }
    
    for (NSInteger i = 0; i < self.headerSectionArray.count; i++) {
        NSNumber *num = self.headerSectionArray[i];
        if ([num integerValue] == section) {
            return i;
        }
    }
    
    return TABViewAnimatedErrorCode;
}

- (NSInteger)footerNeedAnimationOnSection:(NSInteger)section {
    
    if (self.footerSectionArray.count == 0) {
        return TABViewAnimatedErrorCode;
    }
    
    for (NSInteger i = 0; i < self.footerSectionArray.count; i++) {
        NSNumber *num = self.footerSectionArray[i];
        if ([num integerValue] == section) {
            return i;
        }
    }
    
    return TABViewAnimatedErrorCode;
}

- (void)exchangeTableViewDelegate:(UITableView *)target {
    if (!_isExhangeDelegateIMP) {
        _isExhangeDelegateIMP = YES;
        id <UITableViewDelegate> delegate = target.delegate;
        
        if ([target isEqual:delegate]) {
            
            TableDeDaSelfModel *model = [[TABAnimated sharedAnimated] getTableDeDaModelAboutDeDaSelfWithClassName:NSStringFromClass(delegate.class)];
            if (!model.isExhangeDelegate) {
                [self exchangeDelegateMethods:delegate
                                       target:target
                                        model:model];
                model.isExhangeDelegate = YES;
            }
            
        }else {
            [self exchangeDelegateMethods:delegate
                                   target:target
                                    model:nil];
        }
    }
}

- (void)exchangeTableViewDataSource:(UITableView *)target {
    if (!_isExhangeDataSourceIMP) {
        
        _isExhangeDataSourceIMP = YES;
        
        id <UITableViewDataSource> dataSource = target.dataSource;
        
        if ([target isEqual:dataSource]) {
            TableDeDaSelfModel *model = [[TABAnimated sharedAnimated] getTableDeDaModelAboutDeDaSelfWithClassName:NSStringFromClass(dataSource.class)];
            if (!model.isExhangeDataSource) {
                [self exchangeDataSourceMethods:dataSource
                                         target:target
                                          model:model];
                model.isExhangeDataSource = YES;
            }
        }else {
            [self exchangeDataSourceMethods:dataSource
                                     target:target
                                      model:nil];
        }
    }
}

#pragma mark - Private Methods

- (void)exchangeDelegateMethods:(id<UITableViewDelegate>)delegate
                         target:(id)target
                          model:(TableDeDaSelfModel *)model {
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    SEL oldClickDelegate = @selector(tableView:didSelectRowAtIndexPath:);
    SEL newClickDelegate;
    if (model) {
        newClickDelegate = @selector(tab_deda_tableView:didSelectRowAtIndexPath:);
    }else {
        newClickDelegate = @selector(tab_tableView:didSelectRowAtIndexPath:);
    }
    [self exchangeDelegateOldSel:oldClickDelegate
                      withNewSel:newClickDelegate
                      withTarget:target
                    withDelegate:delegate
                           model:model];
    
    SEL oldHeightDelegate = @selector(tableView:heightForRowAtIndexPath:);
    SEL newHeightDelegate;
    if (model) {
        newHeightDelegate = @selector(tab_deda_tableView:heightForRowAtIndexPath:);
    }else {
        newHeightDelegate = @selector(tab_tableView:heightForRowAtIndexPath:);
    }
    
    SEL estimatedHeightDelegateSel = @selector(tableView:estimatedHeightForRowAtIndexPath:);
    
    if ([delegate respondsToSelector:estimatedHeightDelegateSel] &&
        ![delegate respondsToSelector:oldHeightDelegate]) {
        EstimatedTableViewDelegate *edelegate = EstimatedTableViewDelegate.new;
        Method method = class_getInstanceMethod([edelegate class], oldHeightDelegate);
        BOOL isVictory = class_addMethod([delegate class], oldHeightDelegate, class_getMethodImplementation([edelegate class], oldHeightDelegate), method_getTypeEncoding(method));
        if (isVictory) {
            [self exchangeDelegateOldSel:oldHeightDelegate
                              withNewSel:newHeightDelegate
                              withTarget:target
                            withDelegate:delegate
                                   model:model];
        }
        ((UITableView *)target).delegate = delegate;
    }else {
        [self exchangeDelegateOldSel:oldHeightDelegate
                          withNewSel:newHeightDelegate
                          withTarget:target
                        withDelegate:delegate
                               model:model];
    }
    
    SEL oldHeadViewDelegate = @selector(tableView:viewForHeaderInSection:);
    SEL newHeadViewDelegate;
    if (model) {
        newHeadViewDelegate= @selector(tab_deda_tableView:viewForHeaderInSection:);
    }else {
        newHeadViewDelegate= @selector(tab_tableView:viewForHeaderInSection:);
    }
    [self exchangeDelegateOldSel:oldHeadViewDelegate
                      withNewSel:newHeadViewDelegate
                      withTarget:target
                    withDelegate:delegate
                           model:model];
    
    SEL oldFooterViewDelegate = @selector(tableView:viewForFooterInSection:);
    SEL newFooterViewDelegate;
    if (model) {
        newFooterViewDelegate = @selector(tab_deda_tableView:viewForFooterInSection:);
    }else {
        newFooterViewDelegate = @selector(tab_tableView:viewForFooterInSection:);
    }
    [self exchangeDelegateOldSel:oldFooterViewDelegate
                      withNewSel:newFooterViewDelegate
                      withTarget:target
                    withDelegate:delegate
                           model:model];
    
    SEL oldHeadHeightDelegate = @selector(tableView:heightForHeaderInSection:);
    SEL newHeadHeightDelegate;
    if (model) {
        newHeadHeightDelegate = @selector(tab_deda_tableView:heightForHeaderInSection:);
    }else {
        newHeadHeightDelegate = @selector(tab_tableView:heightForHeaderInSection:);
    }
    [self exchangeDelegateOldSel:oldHeadHeightDelegate
                      withNewSel:newHeadHeightDelegate
                      withTarget:target
                    withDelegate:delegate
                           model:model];
    
    SEL oldFooterHeightDelegate = @selector(tableView:heightForFooterInSection:);
    SEL newFooterHeightDelegate;
    if (model) {
        newFooterHeightDelegate = @selector(tab_deda_tableView:heightForFooterInSection:);
    }else {
        newFooterHeightDelegate = @selector(tab_tableView:heightForFooterInSection:);
    }
    [self exchangeDelegateOldSel:oldFooterHeightDelegate
                      withNewSel:newFooterHeightDelegate
                      withTarget:target
                    withDelegate:delegate
                           model:model];
#pragma clang diagnostic pop
}

- (void)exchangeDataSourceMethods:(id<UITableViewDataSource>)dataSource
                           target:(id)target
                            model:(TableDeDaSelfModel *)model {
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    
    SEL oldSectionSelector = @selector(numberOfSectionsInTableView:);
    SEL newSectionSelector;
    if (model) {
        newSectionSelector = @selector(tab_deda_numberOfSectionsInTableView:);
    }else {
        newSectionSelector = @selector(tab_numberOfSectionsInTableView:);
    }
    
    SEL oldSelector = @selector(tableView:numberOfRowsInSection:);
    SEL newSelector;
    if (model) {
        newSelector = @selector(tab_deda_tableView:numberOfRowsInSection:);
    }else {
        newSelector = @selector(tab_tableView:numberOfRowsInSection:);
    }
    
    SEL oldCell = @selector(tableView:cellForRowAtIndexPath:);
    SEL newCell;
    if (model) {
        newCell = @selector(tab_deda_tableView:cellForRowAtIndexPath:);
    }else {
        newCell = @selector(tab_tableView:cellForRowAtIndexPath:);
    }
    
    SEL old = @selector(tableView:willDisplayCell:forRowAtIndexPath:);
    SEL new;
    if (model) {
        new = @selector(tab_deda_tableView:willDisplayCell:forRowAtIndexPath:);
    }else {
        new = @selector(tab_tableView:willDisplayCell:forRowAtIndexPath:);
    }
#pragma clang diagnostic pop
    
    [self exchangeDelegateOldSel:oldSectionSelector
                      withNewSel:newSectionSelector
                      withTarget:target
                    withDelegate:dataSource
                           model:model];
    
    [self exchangeDelegateOldSel:oldSelector
                      withNewSel:newSelector
                      withTarget:target
                    withDelegate:dataSource
                           model:model];
    
    [self exchangeDelegateOldSel:old
                      withNewSel:new
                      withTarget:target
                    withDelegate:dataSource
                           model:model];
    
    [self exchangeDelegateOldSel:oldCell
                      withNewSel:newCell
                      withTarget:target
                    withDelegate:dataSource
                           model:model];
}

/**
 exchange method
 
 @param oldSelector old method's sel
 @param newSelector new method's sel
 @param delegate return nil
 */
- (void)exchangeDelegateOldSel:(SEL)oldSelector
                    withNewSel:(SEL)newSelector
                    withTarget:(id)target
                  withDelegate:(id)delegate
                         model:(TableDeDaSelfModel *)model {
    
    if (![delegate respondsToSelector:oldSelector]) {
        return;
    }
    
    Class targetClass;
    if (model) {
        targetClass = [model class];
    }else {
        targetClass = [self class];
    }
    
    Method newMethod = class_getInstanceMethod(targetClass, newSelector);
    if (newMethod == nil) {
        return;
    }
    
    Method oldMethod = class_getInstanceMethod([delegate class], oldSelector);
    
    BOOL isVictory = class_addMethod([delegate class], newSelector, class_getMethodImplementation([delegate class], oldSelector), method_getTypeEncoding(oldMethod));
    
    if (isVictory) {
        class_replaceMethod([delegate class], oldSelector, class_getMethodImplementation(targetClass, newSelector), method_getTypeEncoding(newMethod));
    }
}

#pragma mark - TABTableViewDataSource / Delegate

- (NSInteger)tab_numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (tableView.tabAnimated.state == TABViewAnimationStart) {
        
        if (tableView.tabAnimated.animatedSectionCount != 0) {
            return tableView.tabAnimated.animatedSectionCount;
        }

        NSInteger count = [self tab_numberOfSectionsInTableView:tableView];
        if (count == 0) {
            count = tableView.tabAnimated.cellClassArray.count;
        }

        if (count == 0) return 1;
        
        return count;
    }
    
    return [self tab_numberOfSectionsInTableView:tableView];
}

- (NSInteger)tab_tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView.tabAnimated.runMode == TABAnimatedRunByRow) {
        NSInteger count = [self tab_tableView:tableView numberOfRowsInSection:section];
        if (count == 0) {
            return tableView.tabAnimated.cellClassArray.count;
        }
        return count;
    }
    
    // If the animation running, return animatedCount.
    if ([tableView.tabAnimated currentIndexIsAnimatingWithIndex:section]) {
        
        // 开发者指定section/row
        if (tableView.tabAnimated.animatedIndexArray.count > 0) {
            
            // 没有获取到动画时row数量
            if (tableView.tabAnimated.animatedCountArray.count == 0) {
                return 0;
            }
            
            // 匹配当前section
            for (NSNumber *num in tableView.tabAnimated.animatedIndexArray) {
                if ([num integerValue] == section) {
                    NSInteger index = [tableView.tabAnimated.animatedIndexArray indexOfObject:num];
                    if (index > tableView.tabAnimated.animatedCountArray.count - 1) {
                        return [[tableView.tabAnimated.animatedCountArray lastObject] integerValue];
                    }else {
                        return [tableView.tabAnimated.animatedCountArray[index] integerValue];
                    }
                }
                
                // 没有匹配到指定的数量
                if ([num isEqual:[tableView.tabAnimated.animatedIndexArray lastObject]]) {
                    return 0;
                }
            }
        }
        
        if (tableView.tabAnimated.animatedCountArray.count > 0) {
            if (section > tableView.tabAnimated.animatedCountArray.count - 1) {
                return tableView.tabAnimated.animatedCount;
            }
            return [tableView.tabAnimated.animatedCountArray[section] integerValue];
        }
        return tableView.tabAnimated.animatedCount;
    }
    return [self tab_tableView:tableView numberOfRowsInSection:section];
}

- (CGFloat)tab_tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger index;
    switch (tableView.tabAnimated.runMode) {
        case TABAnimatedRunBySection: {
            index = indexPath.section;
        }
            break;
        case TABAnimatedRunByRow: {
            index = indexPath.row;
        }
            break;
    }
    
    if ([tableView.tabAnimated currentIndexIsAnimatingWithIndex:index]) {
        
        // 开发者指定section
        if (tableView.tabAnimated.animatedIndexArray.count > 0) {
            
            // 匹配当前section
            for (NSNumber *num in tableView.tabAnimated.animatedIndexArray) {
                if ([num integerValue] == index) {
                    NSInteger currentIndex = [tableView.tabAnimated.animatedIndexArray indexOfObject:num];
                    if (currentIndex > tableView.tabAnimated.cellHeightArray.count - 1) {
                        index = [tableView.tabAnimated.cellHeightArray count] - 1;
                    }else {
                        index = currentIndex;
                    }
                    break;
                }
                
                // 没有匹配到注册的cell
                if ([num isEqual:[tableView.tabAnimated.animatedIndexArray lastObject]]) {
                    return 1.;
                }
            }
        }else {
            if (index > (tableView.tabAnimated.cellClassArray.count - 1)) {
                index = tableView.tabAnimated.cellClassArray.count - 1;
                tabAnimatedLog(@"TABAnimated提醒 - section的数量和指定分区的数量不一致，超出的section，将使用最后一个分区cell加载");
            }
        }
        
        return [tableView.tabAnimated.cellHeightArray[index] floatValue];
    }
    return [self tab_tableView:tableView heightForRowAtIndexPath:indexPath];
}

- (UITableViewCell *)tab_tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger index;
    switch (tableView.tabAnimated.runMode) {
        case TABAnimatedRunBySection: {
            index = indexPath.section;
        }
            break;
        case TABAnimatedRunByRow: {
            index = indexPath.row;
        }
            break;
    }
    
    if ([tableView.tabAnimated currentIndexIsAnimatingWithIndex:index]) {
        
        // 开发者指定index
        if (tableView.tabAnimated.animatedIndexArray.count > 0) {
            
            if (tableView.tabAnimated.cellClassArray.count == 0) {
                return UITableViewCell.new;
            }
            
            // 匹配当前section
            for (NSNumber *num in tableView.tabAnimated.animatedIndexArray) {
                if ([num integerValue] == index) {
                    NSInteger currentIndex = [tableView.tabAnimated.animatedIndexArray indexOfObject:num];
                    if (currentIndex > tableView.tabAnimated.cellClassArray.count - 1) {
                        index = [tableView.tabAnimated.cellClassArray count] - 1;
                    }else {
                        index = currentIndex;
                    }
                    break;
                }
                
                if ([num isEqual:[tableView.tabAnimated.animatedIndexArray lastObject]]) {
                    return UITableViewCell.new;
                }
            }
        }else {
            if (index > (tableView.tabAnimated.cellClassArray.count - 1)) {
                index = tableView.tabAnimated.cellClassArray.count - 1;
                tabAnimatedLog(@"TABAnimated - section的数量和指定分区的数量不一致，超出的section，将使用最后一个分区cell加载");
            }
        }
        
        Class currentClass = tableView.tabAnimated.cellClassArray[index];
        NSString *className = NSStringFromClass(currentClass);
        if ([className containsString:@"."]) {
            NSRange range = [className rangeOfString:@"."];
            className = [className substringFromIndex:range.location+1];
        }
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"tab_%@",className] forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSString *fileName = [className stringByAppendingString:[NSString stringWithFormat:@"_%@",tableView.tabAnimated.targetControllerClassName]];
        
        if (nil == cell.tabComponentManager) {
            
            TABComponentManager *manager = [[TABAnimated sharedAnimated].cacheManager getComponentManagerWithFileName:fileName];

            if (manager && !manager.needChangeRowStatus) {
                
                manager.fileName = fileName;
                manager.isLoad = YES;
                manager.tabTargetClass = currentClass;
                manager.currentSection = indexPath.section;
                cell.tabComponentManager = manager;
                
                [manager reAddToView:cell
                           superView:tableView];
                
                [TABManagerMethod hiddenAllView:cell];
                [TABManagerMethod startAnimationToSubViews:cell
                                                  rootView:cell];
                [TABManagerMethod addExtraAnimationWithSuperView:tableView
                                                      targetView:cell
                                                         manager:cell.tabComponentManager];
            }else {
                
                [TABManagerMethod fullData:cell];
                
                cell.tabComponentManager = [TABComponentManager initWithView:cell
                                                                   superView:tableView tabAnimated:tableView.tabAnimated];
                cell.tabComponentManager.currentSection = indexPath.section;
                cell.tabComponentManager.fileName = fileName;
                cell.tabComponentManager.tabTargetClass = currentClass;
            
                __weak typeof(cell) weakCell = cell;
                dispatch_async(dispatch_get_main_queue(), ^{
                    TABTableAnimated *tabAnimated = (TABTableAnimated *)tableView.tabAnimated;
                    if (weakCell && tabAnimated && weakCell.tabComponentManager) {
                        [TABManagerMethod runAnimationWithSuperView:tableView
                                                         targetView:weakCell
                                                             isCell:YES
                                                            manager:weakCell.tabComponentManager];
                    }
                });
            }
        
        }else {
            if (cell.tabComponentManager.tabLayer.hidden) {
                cell.tabComponentManager.tabLayer.hidden = NO;
            }
        }
        cell.tabComponentManager.currentRow = indexPath.row;
        
        if (tableView.tabAnimated.oldEstimatedRowHeight > 0) {
            [TABManagerMethod fullData:cell];
            __weak typeof(cell) weakCell = cell;
            dispatch_async(dispatch_get_main_queue(), ^{
                weakCell.tabComponentManager.tabLayer.frame = weakCell.bounds;
                [TABManagerMethod resetData:weakCell];
            });
        }
        
        return cell;
    }
    return [self tab_tableView:tableView cellForRowAtIndexPath:indexPath];
}

- (void)tab_tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger index;
    switch (tableView.tabAnimated.runMode) {
        case TABAnimatedRunBySection: {
            index = indexPath.section;
        }
            break;
        case TABAnimatedRunByRow: {
            index = indexPath.row;
        }
            break;
    }
    
    if ([tableView.tabAnimated currentIndexIsAnimatingWithIndex:index]) {
        return;
    }
    [self tab_tableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
}

- (void)tab_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger index;
    switch (tableView.tabAnimated.runMode) {
        case TABAnimatedRunBySection: {
            index = indexPath.section;
        }
            break;
        case TABAnimatedRunByRow: {
            index = indexPath.row;
        }
            break;
    }
    
    if ([tableView.tabAnimated currentIndexIsAnimatingWithIndex:index]) {
        return;
    }
    [self tab_tableView:tableView didSelectRowAtIndexPath:indexPath];
}

#pragma mark - About HeaderFooterView

- (CGFloat)tab_tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if ([tableView.tabAnimated currentIndexIsAnimatingWithIndex:section]) {
        NSInteger index = [tableView.tabAnimated headerNeedAnimationOnSection:section];
        if (index != TABViewAnimatedErrorCode) {
            NSNumber *value = nil;
            if (index > tableView.tabAnimated.headerHeightArray.count - 1) {
                value = tableView.tabAnimated.headerHeightArray.lastObject;
            }else {
                value = tableView.tabAnimated.headerHeightArray[index];
            }
            return [value floatValue];
        }
        return [self tab_tableView:tableView heightForHeaderInSection:section];
    }
    return [self tab_tableView:tableView heightForHeaderInSection:section];
}

- (CGFloat)tab_tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if ([tableView.tabAnimated currentIndexIsAnimatingWithIndex:section]) {
        NSInteger index = [tableView.tabAnimated footerNeedAnimationOnSection:section];
        if (index != TABViewAnimatedErrorCode) {
            NSNumber *value = nil;
            if (index > tableView.tabAnimated.footerHeightArray.count - 1) {
                value = tableView.tabAnimated.footerHeightArray.lastObject;
            }else {
                value = tableView.tabAnimated.footerHeightArray[index];
            }
            return [value floatValue];
        }
        return [self tab_tableView:tableView heightForFooterInSection:section];
    }
    return [self tab_tableView:tableView heightForFooterInSection:section];
}

- (nullable UIView *)tab_tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if ([tableView.tabAnimated currentIndexIsAnimatingWithIndex:section]) {
        NSInteger index = [tableView.tabAnimated headerNeedAnimationOnSection:section];
        if (index != TABViewAnimatedErrorCode) {
            
            Class class;
            if (index > tableView.tabAnimated.headerClassArray.count - 1) {
                class = tableView.tabAnimated.headerClassArray.lastObject;
            }else {
                class = tableView.tabAnimated.headerClassArray[index];
            }
            
            UIView *headerFooterView = class.new;
            headerFooterView.tabAnimated = TABViewAnimated.new;
            [headerFooterView tab_startAnimation];
            
            NSString *fileName = [NSStringFromClass(class) stringByAppendingString:[NSString stringWithFormat:@"_%@",tableView.tabAnimated.targetControllerClassName]];
            
            if (nil == headerFooterView.tabComponentManager) {
                
                TABComponentManager *manager = [[TABAnimated sharedAnimated].cacheManager getComponentManagerWithFileName:fileName];
                
                if (manager) {
                    manager.fileName = fileName;
                    manager.isLoad = YES;
                    manager.tabTargetClass = class;
                    manager.currentSection = section;
                    [manager reAddToView:headerFooterView
                               superView:tableView];
                    headerFooterView.tabComponentManager = manager;
                    [TABManagerMethod startAnimationToSubViews:headerFooterView
                                                      rootView:headerFooterView];
                    [TABManagerMethod addExtraAnimationWithSuperView:tableView
                                                          targetView:headerFooterView
                                                             manager:headerFooterView.tabComponentManager];
                }else {
                    [TABManagerMethod fullData:headerFooterView];
                    headerFooterView.tabComponentManager =
                    [TABComponentManager initWithView:headerFooterView
                                            superView:tableView
                                          tabAnimated:tableView.tabAnimated];
                    headerFooterView.tabComponentManager.currentSection = section;
                    headerFooterView.tabComponentManager.fileName = fileName;
                    headerFooterView.tabComponentManager.tabTargetClass = class;
                    
                    __weak typeof(headerFooterView) weakView = headerFooterView;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (weakView && weakView.tabComponentManager) {
                            
                            BOOL isCell = NO;
                            if ([weakView isKindOfClass:[UITableViewHeaderFooterView class]]) {
                                isCell = YES;
                            }
                            
                            [TABManagerMethod runAnimationWithSuperView:tableView
                                                             targetView:weakView
                                                                 isCell:isCell
                                                                manager:weakView.tabComponentManager];
                        }
                    });
                }
            }else {
                if (headerFooterView.tabComponentManager.tabLayer.hidden) {
                    headerFooterView.tabComponentManager.tabLayer.hidden = NO;
                }
            }
            
            if (tableView.tabAnimated.oldEstimatedRowHeight > 0) {
                [TABManagerMethod fullData:headerFooterView];
                __weak typeof(headerFooterView) weakView = headerFooterView;
                dispatch_async(dispatch_get_main_queue(), ^{
                    weakView.tabComponentManager.tabLayer.frame = weakView.bounds;
                    [TABManagerMethod resetData:weakView];
                });
            }

            return headerFooterView;
        }
        return [self tab_tableView:tableView viewForHeaderInSection:section];
    }
    return [self tab_tableView:tableView viewForHeaderInSection:section];
}

- (nullable UIView *)tab_tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if ([tableView.tabAnimated currentIndexIsAnimatingWithIndex:section]) {
        NSInteger index = [tableView.tabAnimated footerNeedAnimationOnSection:section];
        if (index != TABViewAnimatedErrorCode) {
            
            Class class;
            if (index > tableView.tabAnimated.footerClassArray.count - 1) {
                class = tableView.tabAnimated.footerClassArray.lastObject;
            }else {
                class = tableView.tabAnimated.footerClassArray[index];
            }
            
            UIView *headerFooterView = class.new;
            headerFooterView.tabAnimated = TABViewAnimated.new;
            [headerFooterView tab_startAnimation];
            
            NSString *fileName = [NSStringFromClass(class) stringByAppendingString:[NSString stringWithFormat:@"_%@",tableView.tabAnimated.targetControllerClassName]];
            
            if (nil == headerFooterView.tabComponentManager) {
                
                TABComponentManager *manager = [[TABAnimated sharedAnimated].cacheManager getComponentManagerWithFileName:fileName];
                
                if (manager) {
                    manager.fileName = fileName;
                    manager.isLoad = YES;
                    manager.tabTargetClass = class;
                    manager.currentSection = section;
                    [manager reAddToView:headerFooterView
                               superView:tableView];
                    headerFooterView.tabComponentManager = manager;
                    
                    [TABManagerMethod startAnimationToSubViews:headerFooterView
                                                      rootView:headerFooterView];
                    [TABManagerMethod addExtraAnimationWithSuperView:tableView
                                                          targetView:headerFooterView
                                                             manager:headerFooterView.tabComponentManager];
                    
                }else {
                    [TABManagerMethod fullData:headerFooterView];
                    headerFooterView.tabComponentManager = [TABComponentManager initWithView:headerFooterView superView:tableView tabAnimated:tableView.tabAnimated];
                    headerFooterView.tabComponentManager.currentSection = section;
                    headerFooterView.tabComponentManager.fileName = fileName;
                    
                    __weak typeof(headerFooterView) weakView = headerFooterView;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (weakView && weakView.tabComponentManager) {
                            
                            BOOL isCell = NO;
                            if ([weakView isKindOfClass:[UITableViewHeaderFooterView class]]) {
                                isCell = YES;
                            }
                            
                            [TABManagerMethod runAnimationWithSuperView:tableView
                                                             targetView:weakView
                                                                 isCell:isCell
                                                                manager:weakView.tabComponentManager];
                        }
                    });
                }
            }else {
                if (headerFooterView.tabComponentManager.tabLayer.hidden) {
                    headerFooterView.tabComponentManager.tabLayer.hidden = NO;
                }
            }
            
            headerFooterView.tabComponentManager.tabTargetClass = class;
            
            if (tableView.tabAnimated.oldEstimatedRowHeight > 0) {
                [TABManagerMethod fullData:headerFooterView];
                __weak typeof(headerFooterView) weakView = headerFooterView;
                dispatch_async(dispatch_get_main_queue(), ^{
                    weakView.tabComponentManager.tabLayer.frame = weakView.bounds;
                    [TABManagerMethod resetData:weakView];
                });
            }
            
            return headerFooterView;
        }
        return [self tab_tableView:tableView viewForFooterInSection:section];
    }
    return [self tab_tableView:tableView viewForFooterInSection:section];
}

@end

@implementation EstimatedTableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

@end
