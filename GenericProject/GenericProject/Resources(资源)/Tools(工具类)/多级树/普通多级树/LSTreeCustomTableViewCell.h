//
//  LSTreeCustomTableViewCell.h
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/12/6.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSTreeParam.h"
#import "LSTreeViewParam.h"

NS_ASSUME_NONNULL_BEGIN

@protocol LSTreeCustomDelagete <NSObject>

/*
 *勾选了节点
  @param checkStrictly 是否关联父子节点
 */
- (void)selectNode:(LSTreeParam *)param checkStrictly:(BOOL)checkStrictly;


/*
 *节点上其他UI的交互
 */
- (void)userWithNode:(LSTreeParam *)param param:(id)data cell:(UITableViewCell *)cell;

@end

@interface LSTreeCustomTableViewCell : UITableViewCell

@property(nonatomic,strong)UIButton *icon;
@property(nonatomic,strong)UILabel *la;
@property(nonatomic,strong)UIButton *check;
@property(nonatomic,strong)LSTreeViewParam *parentModel;
@property(nonatomic,strong)LSTreeParam *model;
@property(nonatomic,weak)id<LSTreeCustomDelagete> delagete;
- (void)UI;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier parentModel:(LSTreeViewParam *)parentModel;

@end

NS_ASSUME_NONNULL_END
