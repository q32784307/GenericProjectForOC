//
//  LSTreeBaseView.h
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/12/6.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSTreeParam.h"
#import "LSTreeViewParam.h"

NS_ASSUME_NONNULL_BEGIN

@interface LSTreeBaseView : UIView

@property(nonatomic,strong)LSTreeViewParam *param;
//转换为树形
@property(nonatomic,strong)LSTreeParam *tree;
//主视图 readonly外部不可调用
@property(nonatomic,strong,readonly)UITableView *table;
//已展开的树形数组
@property(nonatomic,strong,readonly)NSMutableArray *data;
//全部字典
@property(nonatomic,strong,readonly)NSMutableDictionary *dic;
//数据为空的占位显示图
@property(nonatomic,strong,readonly)UIView *emptyView;

/*
*字典转模型
*/
- (LSTreeParam *)dictionaryToParam:(NSDictionary *)dic;

/*
 *寻找所有子节点
 */
- (NSMutableArray *)getSonData:(LSTreeParam *)node type:(TreeDataType)type;

/*
*寻找所有父节点
*/
- (NSArray *)searchAllParentNode:(LSTreeParam *)param;


/*
 *处理空视图
 */
- (void)setUpEmptyView:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
