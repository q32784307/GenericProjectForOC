//
//  LSGridViewFlowLayout.h
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/11/25.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSGridViewFlowLayout : UICollectionViewFlowLayout

@property(nonatomic,assign)BOOL panGestureRecognizerEnable;

@end

@protocol LSGridViewDataSource <UICollectionViewDataSource>

@optional

- (void)collectionView:(UICollectionView *)collectionView
       itemAtIndexPath:(NSIndexPath *)sourceIndexPath
   willMoveToIndexPath:(NSIndexPath *)destinationIndexPath;
- (void)collectionView:(UICollectionView *)collectionView
       itemAtIndexPath:(NSIndexPath *)sourceIndexPath
    didMoveToIndexPath:(NSIndexPath *)destinationIndexPath;

- (BOOL)collectionView:(UICollectionView *)collectionView
canMoveItemAtIndexPath:(NSIndexPath *)indexPath;
- (BOOL)collectionView:(UICollectionView *)collectionView
       itemAtIndexPath:(NSIndexPath *)sourceIndexPath
    canMoveToIndexPath:(NSIndexPath *)destinationIndexPath;

@end

@protocol LSGridViewDelegateFlowLayout <UICollectionViewDelegateFlowLayout>

@optional

- (void)collectionView:(UICollectionView *)collectionView
                layout:(UICollectionViewLayout *)collectionViewLayout
willBeginDraggingItemAtIndexPath:(NSIndexPath *)indexPath;
- (void)collectionView:(UICollectionView *)collectionView
                layout:(UICollectionViewLayout *)collectionViewLayout
didBeginDraggingItemAtIndexPath:(NSIndexPath *)indexPath;
- (void)collectionView:(UICollectionView *)collectionView
                layout:(UICollectionViewLayout *)collectionViewLayout
willEndDraggingItemAtIndexPath:(NSIndexPath *)indexPath;
- (void)collectionView:(UICollectionView *)collectionView
                layout:(UICollectionViewLayout *)collectionViewLayout
didEndDraggingItemAtIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
