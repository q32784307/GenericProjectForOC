//
//  LSTreeTableViewCell.h
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/12/5.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LSTreeItem;
NS_ASSUME_NONNULL_BEGIN

@interface LSTreeTableViewCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView andTreeItem:(LSTreeItem *)item;
- (void)updateItem;

@property(nonatomic,copy)void (^checkButtonClickBlock)(LSTreeItem *item);
@property(nonatomic,assign)BOOL isShowArrow;
@property(nonatomic,assign)BOOL isShowCheck;
@property(nonatomic,assign)BOOL isShowLevelColor;

@end

NS_ASSUME_NONNULL_END
