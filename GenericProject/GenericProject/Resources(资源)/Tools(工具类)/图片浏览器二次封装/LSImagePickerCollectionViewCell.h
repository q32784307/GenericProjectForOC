//
//  LSImagePickerCollectionViewCell.h
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/11/25.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSImagePickerCollectionViewCell : UICollectionViewCell

@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UIImageView *videoImageView;
@property(nonatomic,strong)UIButton *deleteBtn;
@property(nonatomic,strong)UILabel *gifLable;
@property(nonatomic,assign)NSInteger row;
@property(nonatomic,strong)id asset;

- (UIView *)snapshotView;

@end

NS_ASSUME_NONNULL_END
