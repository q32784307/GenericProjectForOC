//
//  TABCollectionAnimated.h
//  AnimatedDemo
//
//  github: https://github.com/tigerAndBull/TABAnimated
//  jianshu: https://www.jianshu.com/p/6a0ca4995dff
//
//  Created by tigerAndBull on 2019/4/27.
//  Copyright © 2019 tigerAndBull. All rights reserved.
//

#import "TABViewAnimated.h"

NS_ASSUME_NONNULL_BEGIN

@interface TABCollectionAnimated : TABViewAnimated

#pragma mark - readwrite

/**
 cell样式 == 1时，UICollectionView的cellSize。
 */
@property (nonatomic, assign) CGSize cellSize;

/**
 cell样式 > 1时，UICollectionView的cellSize集合。
 */
@property (nonatomic, copy) NSArray <NSValue *> *cellSizeArray;

/**
 特殊情况下才需要使用，
 仅用于动态section，即section的数量是根据获取到的数据而变化的。
 */
@property (nonatomic, assign) NSInteger animatedSectionCount;

/**
 设置单section动画时row数量，默认填充屏幕为准
 **/
@property (nonatomic, assign) NSInteger animatedCount;

#pragma mark - readonly, 不建议重写的属性

/**
 你不需要手动赋值，但是你需要知道当前视图的结构，
 从而选择初始化方法和启动方法。
 */
@property (nonatomic, assign, readonly) TABAnimatedRunMode runMode;

/**
 指定某些section / row加载动画集合
 不设置默认为工程中所有的section。
 */
@property (nonatomic, copy) NSArray <NSNumber *> *animatedIndexArray;

/**
 当前正在动画中的分区
 */
@property (nonatomic, strong) NSMutableArray <NSNumber *> *runAnimationIndexArray;

/**
 是否已经交换了delegate的IMP地址
 */
@property (nonatomic, assign, readonly) BOOL isExhangeDelegateIMP;

/**
 是否已经交换了dataSource的IMP地址
 */
@property (nonatomic, assign, readonly) BOOL isExhangeDataSourceIMP;

/**
 存储头视图相关，在完全理解原理的情况下，可以采用直接赋值
 否则建议使用`addHeaderViewClass:viewSize:toSection`
 */
@property (nonatomic, strong, readonly) NSMutableArray <Class> *headerClassArray;
@property (nonatomic, strong, readonly) NSMutableArray <NSValue *> *headerSizeArray;
@property (nonatomic, strong, readonly) NSMutableArray <NSNumber *> *headerSectionArray;

/**
 存储尾视图相关，在完全理解原理的情况下，可以采用直接赋值
 否则建议使用`addFooterViewClass:viewSize:toSection`
 */
@property (nonatomic, strong, readonly) NSMutableArray <Class> *footerClassArray;
@property (nonatomic, strong, readonly) NSMutableArray <NSValue *> *footerSizeArray;
@property (nonatomic, strong, readonly) NSMutableArray <NSNumber *> *footerSectionArray;

#pragma mark -

/**
 单section表格组件初始化方式，row值以填充contentSize的数量为标准
 
 @param cellClass cell，以填充contentSize的数量为标准
 @param cellSize  cell的高度
 @return 目标对象
 */
+ (instancetype)animatedWithCellClass:(Class)cellClass
                             cellSize:(CGSize)cellSize;

/**
 单section表格组件初始化方式，row值以填充contentSize的数量为标准
 
 @param cellClass 模版cell
 @param animatedCount 动画时row值
 @return 目标对象
 */
+ (instancetype)animatedWithCellClass:(Class)cellClass
                             cellSize:(CGSize)cellSize
                        animatedCount:(NSInteger)animatedCount;

#pragma mark - 以下均为以section为单位的初始化方法

/**
 如果原UICollectionView是多个section，但是只想指定一个section启动动画，使用该初始化方法
 动画数量以填充contentSize的数量为标准
 
 @param cellClass 注册的cell类型
 @param cellSize 动画时cell的size
 @param section 被指定的section
 @return 目标对象
 */
+ (instancetype)animatedWithCellClass:(Class)cellClass
                             cellSize:(CGSize)cellSize
                            toSection:(NSInteger)section;

/**
 如果原UICollectionView是多个section，但是只想指定一个section启动动画，使用该初始化方法
 
 @param cellClass 注册的cell类型
 @param cellSize 动画时cell的size
 @param animatedCount 指定section的动画数量
 @param section 被指定的section
 @return 目标对象
 */
+ (instancetype)animatedWithCellClass:(Class)cellClass
                             cellSize:(CGSize)cellSize
                        animatedCount:(NSInteger)animatedCount
                            toSection:(NSInteger)section;

/**
 视图结构要求：section和cell样式一一对应
 
 @param cellClassArray 模版cell数组
 @param animatedCountArray 动画时row值的集合
 @return 目标对象
 */
+ (instancetype)animatedWithCellClassArray:(NSArray <Class> *)cellClassArray
                             cellSizeArray:(NSArray <NSValue *> *)cellSizeArray
                        animatedCountArray:(NSArray <NSNumber *> *)animatedCountArray;

/**
 视图结构要求：section和cell样式一一对应
 
 上一个初始化方式，section和数组元素依次对应，所有section都会有动画
 现在可以根据animatedSectionArray指定section，不指定的section没有动画。
 
 举个例子：
 比如 animatedSectionArray = @[@(3),@(4)];
 意思是 cellSizeArray,animatedCountArray,cellClassArray数组中的第一个元素，是 section == 3 的动画数据
 
 @param cellClassArray 模版cell数组
 @param cellSizeArray 模版cell对应size
 @param animatedCountArray 对应section动画数量
 @param animatedSectionArray animatedSectionArray
 @return 目标对象
 */
+ (instancetype)animatedWithCellClassArray:(NSArray <Class> *)cellClassArray
                             cellSizeArray:(NSArray <NSValue *> *)cellSizeArray
                        animatedCountArray:(NSArray <NSNumber *> *)animatedCountArray
                      animatedSectionArray:(NSArray <NSNumber *> *)animatedSectionArray;

#pragma mark - 以下均为以row为单位的初始化方法

/**
 视图结构要求：1个section对应多个cell，且只有1个section
 
 指定row配置动画
 animatedCount只能为1，无法设置animatedCount，只能为1
 
 @param cellClass 注册的cell类型
 @param cellSize 动画时cell size
 @param row 被指定的row
 @return object
 */
+ (instancetype)animatedInRowModeWithCellClass:(Class)cellClass
                                      cellSize:(CGSize)cellSize
                                         toRow:(NSInteger)row;

/**
 视图结构要求：1个section对应多个cell，且只有1个section
 
 该section中所有row均会配置动画
 animatedCount只能为1，无法设置animatedCount，只能为1
 
 @param cellClassArray 目标cell数组
 @param cellSizeArray 目标cell对应size集合
 @return object
 */
+ (instancetype)animatedInRowModeWithCellClassArray:(NSArray <Class> *)cellClassArray
                                      cellSizeArray:(NSArray <NSValue *> *)cellSizeArray;

/**
 视图结构要求：1个section对应多个cell，且只有1个section
 
 此初始化指定row，不指定的row会执行你的代理方法。
 
 举个例子：
 比如 animatedRowArray = @[@(3),@(4)];
 意思是 cellHeightArray，animatedCountArray，cellClassArray数组中的第一个元素，是 row == 3 的动画数据
 
 @param cellClassArray 目标cell数组
 @param cellSizeArray 目标cell对应size
 @param rowArray rowArray
 @return object
 */
+ (instancetype)animatedInRowModeWithCellClassArray:(NSArray <Class> *)cellClassArray
                                      cellSizeArray:(NSArray <NSValue *> *)cellSizeArray
                                           rowArray:(NSArray <NSNumber *> *)rowArray;

#pragma mark - Header / Footer

/**
 添加区头动画，指定section
 
 @param headerViewClass 区头类对象
 @param viewSize 区头size
 @param section 指定的section
 */
- (void)addHeaderViewClass:(_Nonnull Class)headerViewClass
                  viewSize:(CGSize)viewSize
                 toSection:(NSInteger)section;

/**
 添加区头动画
 不指定section，意味着所有section都会加入该区头动画，
 仅设置animatedSectionCount属性生效
 
 @param headerViewClass 区头类对象
 @param viewSize 区头size
 */
- (void)addHeaderViewClass:(_Nonnull Class)headerViewClass
                  viewSize:(CGSize)viewSize;

/**
 添加区尾动画，指定section
 
 @param footerViewClass 区尾类对象
 @param viewSize 区尾size
 @param section 指定的section
 */
- (void)addFooterViewClass:(_Nonnull Class)footerViewClass
                  viewSize:(CGSize)viewSize
                 toSection:(NSInteger)section;

/**
 添加区尾动画
 不指定section，意味着所有section都会加入该区尾动画，
 仅设置animatedSectionCount属性生效
 
 @param footerViewClass 区尾类对象
 @param viewSize 区尾size
 */
- (void)addFooterViewClass:(_Nonnull Class)footerViewClass
                  viewSize:(CGSize)viewSize;

#pragma mark -

- (NSInteger)headerFooterNeedAnimationOnSection:(NSInteger)section
                                           kind:(NSString *)kind;

- (void)exchangeCollectionViewDelegate:(UICollectionView *)target;

- (void)exchangeCollectionViewDataSource:(UICollectionView *)target;

@end

NS_ASSUME_NONNULL_END
