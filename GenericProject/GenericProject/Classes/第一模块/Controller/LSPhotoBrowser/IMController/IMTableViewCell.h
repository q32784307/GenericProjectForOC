//
//  IMTableViewCell.h
//  GenericProject
//
//  Created by 社科赛斯 on 2019/12/17.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IMModel;

NS_ASSUME_NONNULL_BEGIN

@protocol IMTableViewCellDelegate <NSObject>

- (void)reloadCellWithModel:(IMModel *)immModel;

- (void)imImageViewDidClick:(IMModel *)imModel;

@end

@interface IMTableViewCell : UITableViewCell

+ (instancetype)imTableViewCellWithTableView:(UITableView *)tableView;

@property (nonatomic,weak  ) UIImageView *picImgView;

@property (nonatomic,strong) IMModel *imModel;

@property (nonatomic,weak  ) id<IMTableViewCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
