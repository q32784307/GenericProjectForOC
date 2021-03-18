//
//  JJCollectionViewRoundFlowLayout.h
//  FuLaDuo
//
//  Created by jiajie on 2019/9/17.
//  Copyright © 2019 谢家杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JJCollectionViewRoundConfigModel.h"
#import "JJCollectionViewFlowLayoutConfig.h"

NS_ASSUME_NONNULL_BEGIN

@protocol JJCollectionViewDelegateRoundFlowLayout <UICollectionViewDelegateFlowLayout>

@required


@optional

/// 设置底色参数
/// @param collectionView collectionView description
/// @param collectionViewLayout collectionViewLayout description
/// @param section section description
- (JJCollectionViewRoundConfigModel *)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout configModelForSectionAtIndex:(NSInteger)section;

/// 设置底色偏移点量（与collectionview的sectionInset用法相同，但是与sectionInset区分）
/// @param collectionView collectionView description
/// @param collectionViewLayout collectionViewLayout description
/// @param section section description
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout borderEdgeInsertsForSectionAtIndex:(NSInteger)section;

/// 设置是否计算headerview（根据section判断是否单独计算）
/// @param collectionView collectionView description
/// @param collectionViewLayout collectionViewLayout description
/// @param section section description
- (BOOL)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout isCalculateHeaderViewIndex:(NSInteger)section;

/// 设置是否计算footerview（根据section判断是否单独计算）
/// @param collectionView collectionView description
/// @param collectionViewLayout collectionViewLayout description
/// @param section section description
- (BOOL)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout isCalculateFooterViewIndex:(NSInteger)section;

/// 当Cell个数为0时，是否允许进行计算（根据section判断是否单独计算，Cell个数为0时，会检测计算Header或Footer）
/// @param collectionView collectionView description
/// @param collectionViewLayout collectionViewLayout description
/// @param section section description
- (BOOL)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout isCanCalculateWhenRowEmptyWithSection:(NSInteger)section;

/// 背景图点击事件
/// @param collectionView collectionView description
/// @param indexPath 点击背景图的indexPath
- (void)collectionView:(UICollectionView *)collectionView didSelectDecorationViewAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface JJCollectionViewRoundFlowLayout : UICollectionViewFlowLayout

/// 设置cell对齐方式，不设置为使用系统默认，支持Left
@property (assign, nonatomic) JJCollectionViewRoundFlowLayoutAlignmentType collectionCellAlignmentType;

/// 是否开始Round计算，（默认YES），当该位置为NO时，计算模块都不开启，包括设置的代理
@property (assign, nonatomic) BOOL isRoundEnabled;

/// 是否计算header（若实现collectionView: layout: isCalculateHeaderViewIndex:）该字段不起作用
@property (assign, nonatomic) BOOL isCalculateHeader;

/// 是否计算footer（若实现collectionView: layout: isCalculateFooterViewIndex:）该字段不起作用
@property (assign, nonatomic) BOOL isCalculateFooter;

/// 是否使用不规则Cell大小的计算方式(若Cell的大小是相同固定大小，则无需开启该方法)，默认NO
@property (assign, nonatomic) BOOL isCalculateTypeOpenIrregularitiesCell;

/// 当Cell个数为0时，是否允许进行计算（开启后，Cell个数为0时，会检测计算Header或Footer）
/// 注意！！！是否计算Header或Footer，会根据设置的isCalculateHeader、isCalculateFooter和对应代理方法进行判断！！！请注意！！！
///（若实现collectionView:layout:isCanCalculateWhenRowEmptyWithSection:）该字段不起作用
/// 注意！！！！！！ 在使用该功能的时候，请自行检测和处理sectionInset的偏移量，Cell无数据时，有header&footer，设置了的sectionInset还是生效的，底色在计算时候会进行sectionInset相关的偏移处理。
@property (assign, nonatomic) BOOL isCanCalculateWhenRowEmpty;

@end


NS_ASSUME_NONNULL_END
