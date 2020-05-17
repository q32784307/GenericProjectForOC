//
//  LSTreeBaseView.m
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/12/6.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import "LSTreeBaseView.h"

@interface LSTreeBaseView()

//主视图 readwrite本类调用
@property(nonatomic,strong,readwrite)UITableView *table;
//已展开的树形数组
@property(nonatomic,strong,readwrite)NSMutableArray *data;
//全部字典
@property(nonatomic,strong,readwrite)NSMutableDictionary *dic;
//数据为空的占位显示图
@property(nonatomic,strong,readwrite)UIView *emptyView;

@end

@implementation LSTreeBaseView

/*
 *处理空视图
 */
- (void)setUpEmptyView:(NSDictionary *)dic{
    UIImageView *image = (UIImageView*)[self.emptyView viewWithTag:999];
    UILabel *la = (UILabel*)[self.emptyView viewWithTag:998];
    la.center = self.emptyView.center;
    image.frame = CGRectMake(image.frame.origin.x, CGRectGetMinY(la.frame)-image.frame.size.height, image.frame.size.width, image.frame.size.height);
    image.center = CGPointMake(self.emptyView.center.x, image.center.y);
    if (dic[@"image"]) {
        image.image = [UIImage imageNamed:dic[@"image"]];
    }
    if (dic[@"name"]) {
        la.text = dic[@"name"];
    }
}

- (LSTreeParam *)dictionaryToParam:(NSDictionary *)dic{
    LSTreeParam *param = TreeParam();
    if (dic[@"name"]) {
        param.nameSet(dic[@"name"]);
    }
    if (dic[@"currentId"]) {
        param.currentIdSet(dic[@"currentId"]);
    }
    if (dic[@"parentId"]) {
        param.parentIdSet(dic[@"parentId"]);
    }
    if (dic[@"isExpand"]) {
        param.isExpandSet([dic[@"isExpand"] boolValue]);
    }
    if (dic[@"canSelect"]) {
        param.canSelectSet([dic[@"canSelect"] boolValue]);
    }
    if (dic[@"data"]) {
        param.dataSet(dic[@"data"]);
    }
    if (dic[@"dtos"]) {
        param.children = [NSMutableArray arrayWithArray:dic[@"dtos"]];
     }
    if (param.currentId) {
        [self.dic setObject:param forKey:param.currentId];
        if (!param.parentId) {
            [self.tree.children addObject:param];
        }
    }
    return param;
}

/*
*寻找所有子节点
*/
- (NSMutableArray *)getSonData:(LSTreeParam *)node type:(TreeDataType)type{
    NSMutableArray *sonData = [NSMutableArray new];
    if (!node) return sonData;
    NSMutableArray *stack = [NSMutableArray new];
    [stack addObject:node];
    LSTreeParam *tmpNode = [LSTreeParam new];
    while (stack.count) {
           tmpNode = stack.lastObject;
           LSTreeParam *parentNode = self.dic[tmpNode.parentId];
           [stack removeLastObject];
           
           if (!tmpNode.depath&&tmpNode!=node) {
               tmpNode.depath = parentNode.depath+1;
           }
           if (type == TreeDataAllWithSelf) {
               if (parentNode.isExpand) {
                   [sonData addObject:tmpNode];
               }else{
                   if (parentNode.isExpand&&[sonData indexOfObject:parentNode]!=NSNotFound) {
                       [sonData addObject:tmpNode];
                   }
               }
           }else if (type == TreeDataAll) {
               if (tmpNode!=node) {
                   tmpNode.isExpand = YES;
                   [sonData addObject:tmpNode];
               }
           }else if (type == TreeDataSelectAll) {
               if (tmpNode!=node) {
                   tmpNode.isSelected = node.isSelected;
                   if (!node.isSelected) {
                       tmpNode.halfSelect = NO;
                   }
               }
           }else if (type == TreeDataExpandOrNotParent) {
               if (tmpNode!=node) {
                   if (!tmpNode.parentId) {
                       [sonData addObject:tmpNode];
                   }else if (([sonData indexOfObject:parentNode]!=NSNotFound)&&parentNode.isExpand){
                       [sonData addObject:tmpNode];
                   }
               }
           }else if(type == TreeDataDelete || type == TreeDataInsert){
               if (tmpNode!=node) {
                   if (tmpNode.parentId == node.currentId) {
                       if (type == TreeDataInsert?(parentNode.isExpand):(!parentNode.isExpand)) {
                           [sonData addObject:tmpNode];
                       }
                   }else{
                       if (parentNode.isExpand&&[sonData indexOfObject:parentNode]!=NSNotFound) {
                           [sonData addObject:tmpNode];
                       }
                   }
               }
           }else{
               if (tmpNode!=node) {
                   [sonData addObject:tmpNode];
               }
           }
           
           for (NSInteger i = tmpNode.children.count - 1; i >= 0; i--) {
             @autoreleasepool {
               LSTreeParam *son = tmpNode.children[i];
               [stack addObject:son];
              }
           }
       }
       return sonData;
}


//寻找该节点的所有父节点
- (NSArray*)searchAllParentNode:(LSTreeParam *)param{
    NSMutableArray *arr = [NSMutableArray new];
    NSMutableArray *loop= [NSMutableArray new];
    if (param.parentId) {
        [loop addObject:self.dic[param.parentId]];
    }
    while (loop.count) {
        LSTreeParam *tmp = loop.lastObject;
        if (param.isSelected) {
           tmp.halfSelect = NO;
           tmp.isSelected = YES;
           for (LSTreeParam *son in tmp.children) {
                if (!son.isSelected) {
                    tmp.halfSelect = YES;
                    tmp.isSelected = NO;
                    break;
                }
           }
        }else{
            tmp.halfSelect = NO;
            tmp.isSelected = NO;
            for (LSTreeParam *son in tmp.children) {
                if (son!=tmp&&son.isSelected) {
                    tmp.halfSelect = YES;
                    break;
                }
            }
        }
        [loop removeLastObject];
        [arr addObject:tmp];
        if (tmp.parentId) {
            [loop addObject:self.dic[tmp.parentId]];
        }
    }
    return arr;
}

- (UIView *)emptyView{
    if (!_emptyView) {
        _emptyView = [UIView new];
        _emptyView.frame = self.bounds;
        UIImageView *image = [UIImageView new];
        image.contentMode = UIViewContentModeScaleAspectFit;
        image.tag = 999;
        image.frame = CGRectMake(0, 0, _emptyView.bounds.size.width<200?_emptyView.bounds.size.width*0.8:200, _emptyView.bounds.size.height<200?_emptyView.bounds.size.height*0.8:200);
        [_emptyView addSubview:image];
        UILabel *la = [UILabel new];
        la.tag = 998;
        la.textAlignment = NSTextAlignmentCenter;
        la.frame = CGRectMake(0, 0, _emptyView.bounds.size.width, 40);
        [_emptyView addSubview:la];
    }
    return _emptyView;
}

- (UITableView *)table{
    if (!_table) {
        _table = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStyleGrouped];
        _table.estimatedRowHeight = 0.01;
        _table.estimatedSectionFooterHeight = 0.01;
        _table.estimatedSectionHeaderHeight = 0.01;
        if (@available(iOS 11.0, *)) {
              _table.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _table;
}

- (NSMutableArray *)data{
    if (!_data) {
        _data = [NSMutableArray new];
    }
    return _data;
}

- (NSMutableDictionary *)dic{
    if (!_dic) {
        _dic = [NSMutableDictionary new];
    }
    return _dic;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
