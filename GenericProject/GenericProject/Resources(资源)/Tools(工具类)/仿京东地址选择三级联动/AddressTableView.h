//
//  AddressTableView.h
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/7/10.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^Block)(NSInteger row);

@interface AddressTableView : UIView<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,copy)NSString *indexRow;

/**
 初始化
 
 @param frame frame
 @param params 数据
 @return self
 */
- (instancetype)initWithFrame:(CGRect)frame withParmas:(id)params;

@property(nonatomic,copy)NSArray *datas;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,copy)Block block;

@end

NS_ASSUME_NONNULL_END
