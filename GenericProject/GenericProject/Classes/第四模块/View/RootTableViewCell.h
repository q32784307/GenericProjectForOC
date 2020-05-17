//
//  RootTableViewCell.h
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2018/9/20.
//  Copyright © 2018年 漠然丶情到深处. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootModel;

@class RootTableViewCell;

@protocol RootTableViewCellDelegate <NSObject>

- (void)showCell:(RootTableViewCell*)cell;

@end

NS_ASSUME_NONNULL_BEGIN

@interface RootTableViewCell : UITableViewCell

@property (nonatomic,strong)RootModel * model;
@property (nonatomic,strong)NSString * upOrDown;

@property (nonatomic,strong) UILabel *label;
@property (nonatomic,strong) UIImageView *imageUpView;
@property (nonatomic,strong) UIImageView *imageSelectView;
@property (nonatomic, weak) id<RootTableViewCellDelegate> delegate;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
+ (instancetype)cellWithTableView:(UITableView *)tableView;

- (void)levelNameString:(NSString *)levelNameString levelString:(NSString *)levelString isSelect:(BOOL)isSelect;

@end

NS_ASSUME_NONNULL_END
