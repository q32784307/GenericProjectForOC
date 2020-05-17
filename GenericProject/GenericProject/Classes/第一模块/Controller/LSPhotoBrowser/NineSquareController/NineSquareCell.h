//
//  NineSquareCell.h
//  GenericProject
//
//  Created by 社科赛斯 on 2019/12/17.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NineSquareModel;

NS_ASSUME_NONNULL_BEGIN

@interface NineSquareCell : UITableViewCell

+ (instancetype)nineSquareCellWithTableView:(UITableView *)tableView;

@property (nonatomic, assign) CGFloat cellHeight;

@property (nonatomic, strong) NineSquareModel *squareM;

@end

NS_ASSUME_NONNULL_END
