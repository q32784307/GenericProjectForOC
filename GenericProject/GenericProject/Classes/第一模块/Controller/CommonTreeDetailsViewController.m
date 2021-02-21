//
//  CommonTreeDetailsViewController.m
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/12/6.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import "CommonTreeDetailsViewController.h"
#import "CommonTreeDetailsTableViewCell.h"
#import "LSTreeView.h"

@interface CommonTreeDetailsViewController ()

@property(nonatomic,strong)LSTreeView *treeView;

@end

@implementation CommonTreeDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSDictionary *dic = @{
        @(1):@"firstDemo",
        @(2):@"secondDemo",
        @(3):@"thirdDemo",
        @(4):@"fourDemo",
        @(5):@"fiveDemo",
        @(6):@"sixDemo",
        @(7):@"sevenDemo",
    };
    if (self.type) {
        [self performSelector:NSSelectorFromString(dic[@(self.type)]) withObject:nil afterDelay:0.01];
    }
}

//全部属性
- (void)all{
        LSTreeViewParam *param =
        TreeViewParam()
        .lsDataSet([self randomArr:20 level:3])
    //    .wDataSet([self jsonData])
        //数据为空时的占位图
        .lsEmptyDataSet(@{@"name":@"暂无数据",@"image":@"default_maintenance"})
        //frame
        .lsFrameSet(CGRectMake(0, NAVIGATION_BAR_HEIGHT, self.view.bounds.size.width, self.view.bounds.size.height-NAVIGATION_BAR_HEIGHT))
        //缩进距离
        .lsIndentSet(2)
        //手风琴效果 同级只展开一级
        .lsAccordionSet(NO)
        //可勾选
        .lsShowCheckboxSet(YES)
        //隐藏展开图标
        .lsHideExpanIconSet(NO)
        //节点字体font
        .lsNodeTextFontSet(15.0f)
        //节点字体颜色
        .lsNodeTextColorSet([UIColor blackColor])
        //节点字体高亮颜色
        .lsHighlightCurrentSet(ColorFromRGB(0x1d76db))
        //默认勾选
        .lsDefaultExpandedKeysSet(@[@"1_2_1",@"2"])
        //父节点和子节点 勾选关联
        .lsCheckStrictlySet(YES)
        //默认展开全部
        .lsDefaultExpandAllSet(YES)
        //拖拽
        .lsDraggableSet(NO)
        //节点点击事件
        .lsEventNodeClickSet(^(id node) {
            NSLog(@"%@被点击",node);
        })
        //节点勾选状态切换事件
        .lsEventCheckChangeSet(^(id node, BOOL isSelect) {
            NSLog(@"节点切换 %@ , %d",node,isSelect);
        })
        //自定义节点内容
        .lsEventTreeCellSet(^UITableViewCell *(id model, NSIndexPath *path,UITableView *table,id param) {
            CommonTreeDetailsTableViewCell *cell = [table dequeueReusableCellWithIdentifier:@"CommonTreeDetailsTableViewCell"];
            if (!cell) {
                cell = [[CommonTreeDetailsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CommonTreeDetailsTableViewCell" parentModel:param];
            }
            cell.model = model;
            return cell;
        })
        //自定义节点高度
        .lsEventCellHeightSet(^CGFloat(id model, NSIndexPath *path, UITableView *table) {
            return 50;
        })
        //自定义节点用户交互
        .lsEventCellUserEnabledSet(^(id model, NSIndexPath *path, UITableView *table,id userInfo) {

        })
        //节点拖拽完成
        .lsEventNodeDraggableSet(^(NSIndexPath *sourceIndexPath, NSIndexPath *destinationIndexPath, UITableView *table) {
            
        });
        self.treeView = [[LSTreeView alloc]initWithParam:param];
        [self.view addSubview:self.treeView];
}


//正常多叉树显示
- (void)firstDemo{
    LSTreeViewParam *param =TreeViewParam()
    .lsFrameSet(CGRectMake(0, NAVIGATION_BAR_HEIGHT, self.view.bounds.size.width, self.view.bounds.size.height-NAVIGATION_BAR_HEIGHT))
    .lsDataSet([self readLocalFileWithName:@"datanew"]);
    self.treeView = [[LSTreeView alloc]initWithParam:param];
    [self.view addSubview:self.treeView];
}

//可选中树形+选中高亮显示
- (void)secondDemo{
    LSTreeViewParam *param =TreeViewParam()
    .lsDataSet([self randomArr:10 level:5])
    .lsFrameSet(CGRectMake(0, NAVIGATION_BAR_HEIGHT, self.view.bounds.size.width, self.view.bounds.size.height-NAVIGATION_BAR_HEIGHT))
    //节点字体高亮颜色
    .lsHighlightCurrentSet(ColorFromRGB(0x1d76db))
    //可勾选
    .lsShowCheckboxSet(YES);
    self.treeView = [[LSTreeView alloc]initWithParam:param];
    [self.view addSubview:self.treeView];
}

//自定义节点内容+增删节点
- (void)thirdDemo{
    LSWeakSelf(self);
    LSTreeViewParam *param =TreeViewParam()
    .lsFrameSet(CGRectMake(0, NAVIGATION_BAR_HEIGHT, self.view.bounds.size.width, self.view.bounds.size.height-NAVIGATION_BAR_HEIGHT))
    .lsDataSet([self randomArr:10 level:5])
    //自定义节点内容
    .lsEventTreeCellSet(^UITableViewCell *(id model, NSIndexPath *path,UITableView *table,id param) {
        CommonTreeDetailsTableViewCell *cell = [table dequeueReusableCellWithIdentifier:@"CommonTreeDetailsTableViewCell"];
        if (!cell) {
            cell = [[CommonTreeDetailsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CommonTreeDetailsTableViewCell" parentModel:param];
        }
        cell.model = model;
        return cell;
    })
    //自定义节点用户交互
    .lsEventCellUserEnabledSet(^(id model, NSIndexPath *path, UITableView *table,id userInfo) {
        [weakself dealModel:model path:path userInfo:userInfo];
    });
    self.treeView = [[LSTreeView alloc]initWithParam:param];
    [self.view addSubview:self.treeView];
}

//手风琴效果+指定层级可勾选(这里选取3层 指定第三层可选)
- (void)fourDemo{
    NSArray *data = @[
        TreeParam().currentIdSet(@"1").nameSet(@"第1_0级").canSelectSet(NO),
        TreeParam().currentIdSet(@"2").nameSet(@"第1_1级").canSelectSet(NO),
        TreeParam().currentIdSet(@"3").nameSet(@"第1_2级").canSelectSet(NO),
        TreeParam().currentIdSet(@"11").nameSet(@"第2_11级").parentIdSet(@"1").canSelectSet(NO),
        TreeParam().currentIdSet(@"22").nameSet(@"第2_22级").parentIdSet(@"2").canSelectSet(NO),
        TreeParam().currentIdSet(@"33").nameSet(@"第2_22级").parentIdSet(@"3").canSelectSet(NO),
        //第三层可选
        TreeParam().currentIdSet(@"111").nameSet(@"第3_111级").parentIdSet(@"11"),
        TreeParam().currentIdSet(@"222").nameSet(@"第3_222级").parentIdSet(@"22"),
        TreeParam().currentIdSet(@"333").nameSet(@"第3_333级").parentIdSet(@"33"),
    ];
    LSTreeViewParam *param =TreeViewParam()
    .lsFrameSet(CGRectMake(0, NAVIGATION_BAR_HEIGHT, self.view.bounds.size.width, self.view.bounds.size.height-NAVIGATION_BAR_HEIGHT))
    .lsDataSet(data)
    //可勾选
    .lsShowCheckboxSet(YES)
    //手风琴效果
    .lsAccordionSet(YES);
    self.treeView = [[LSTreeView alloc]initWithParam:param];
    [self.view addSubview:self.treeView];
}

//勾选不关联父节点和子节点+默认选中+默认全部展开
- (void)fiveDemo{
    LSTreeViewParam *param =TreeViewParam()
    .lsDataSet(([self randomArr:10 level:5]))
    .lsFrameSet(CGRectMake(0, NAVIGATION_BAR_HEIGHT, self.view.bounds.size.width, self.view.bounds.size.height-NAVIGATION_BAR_HEIGHT))
    //默认全部展开
    .lsDefaultExpandAllSet(YES)
    //不关联父节点和子节点
    .lsCheckStrictlySet(NO)
    //可勾选
    .lsShowCheckboxSet(YES)
    //默认选中
    .lsDefaultExpandedKeysSet(@[@"5",@"8"]);
    self.treeView = [[LSTreeView alloc]initWithParam:param];
    [self.view addSubview:self.treeView];
}

//开启拖拽
- (void)sixDemo{
    LSTreeViewParam *param =TreeViewParam()
    .lsFrameSet(CGRectMake(0, NAVIGATION_BAR_HEIGHT, self.view.bounds.size.width, self.view.bounds.size.height-NAVIGATION_BAR_HEIGHT))
    .lsDefaultExpandAllSet(YES)
    .lsDataSet([self randomArr:10 level:5]);
    
    self.treeView = [[LSTreeView alloc]initWithParam:param];
    [self.view addSubview:self.treeView];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitleColor:ColorFromRGB(0xF4606C) forState:UIControlStateNormal];
    [btn setTitle:@"开启拖拽" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(onBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.navView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navView).with.offset(STATUS_BAR_HEIGHT + 2);
        make.right.equalTo(self.navView.mas_right).with.offset(LSSYRealValue(-20 / 2));
        make.height.mas_equalTo(40);
    }];
}

//传字典数据
- (void)sevenDemo{
    LSTreeViewParam *param =TreeViewParam()
    .lsFrameSet(CGRectMake(0, NAVIGATION_BAR_HEIGHT, self.view.bounds.size.width, self.view.bounds.size.height-NAVIGATION_BAR_HEIGHT))
    .lsShowCheckboxSet(YES)
    .lsDataSet([self jsonData]);
    self.treeView = [[LSTreeView alloc]initWithParam:param];
    [self.view addSubview:self.treeView];
}

//增删数据
- (void)dealModel:(id)model path:(NSIndexPath*)path userInfo:(id)userInfo{
    if ([userInfo isEqualToString:@"add"]) {
         LSTreeParam *param = model;
        LSWeakSelf(self);
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"请输入节点" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"追加子节点" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            UITextField *idText = alertController.textFields[0];
            UITextField *nameText = alertController.textFields[1];
            LSTreeParam *node =  TreeParam().currentIdSet(idText.text).nameSet(nameText.text).parentIdSet(param.currentId);
            [weakself.treeView append:param.currentId node:node];
        }]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"追加节点" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            UITextField *idText = alertController.textFields[0];
            UITextField *nameText = alertController.textFields[1];
            LSTreeParam *node =  TreeParam().currentIdSet(idText.text).nameSet(nameText.text).parentIdSet(param.parentId);
            [weakself.treeView insertAfter:param.currentId node:node];
        }]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        
        [alertController addTextFieldWithConfigurationHandler:^(UITextField*_Nonnull textField) {
            textField.placeholder=@"请输入节点唯一currentId";
        }];
                   
        [alertController addTextFieldWithConfigurationHandler:^(UITextField*_Nonnull textField) {
            textField.placeholder=@"请输入节点name";
        }];
        [self presentViewController:alertController animated:YES completion:nil];
    }else if ([userInfo isEqualToString:@"delete"]){
        LSTreeParam *param = model;
        [self.treeView remove:param.currentId];
    }
}

//随机多少级 每级多少条数据
- (NSArray*)randomArr:(int)num level:(int)level{
    NSMutableArray *arr = [NSMutableArray new];
    NSArray *firstId = @[@"0",@"1",@"2"];
    //第一级
    for (int i = 0; i<firstId.count; i++) {
        NSString *str = [NSString stringWithFormat:@"第1_%d级",i];
        [arr addObject:TreeParam().currentIdSet(firstId[i]).nameSet(str)];
    }
    NSInteger index = 1;
    NSInteger fitstIndex = firstId.count;
    NSInteger endIndex = num+3;
    NSArray *tempArr = [NSArray new];
    while (index<level) {
        NSArray *dataArr = [NSArray arrayWithArray:tempArr.count?tempArr:firstId];
        index+=1;
         NSMutableArray *secondId = [NSMutableArray new];
          for (NSInteger i = fitstIndex; i<endIndex; i++) {
               int y =(arc4random() % (dataArr.count));
               NSString *str = [NSString stringWithFormat:@"第%ld_%ld级",index,i];
               NSString *currentID = [NSString stringWithFormat:@"%ld",i];
               [secondId addObject:currentID];
               LSTreeParam *param = TreeParam().currentIdSet(currentID).parentIdSet(dataArr[y]).nameSet(str);
               [arr addObject:param];
        }
        fitstIndex = num*index;
        endIndex = num*(index+1);
        tempArr = secondId;
    }
    return [NSArray arrayWithArray:arr];
}

//拖拽
- (void)onBtnAction:(UIButton*)sender{
    sender.selected = ![sender isSelected];
    if (sender.isSelected) {
        [sender setTitle:@"关闭拖拽" forState:UIControlStateNormal];
    }else{
        [sender setTitle:@"开启拖拽" forState:UIControlStateNormal];
    }
    self.treeView.param.lsDraggableSet(sender.isSelected);
    [self.treeView updateEditing];
}

//json数据
- (NSArray*)jsonData{
    return @[
        @{
            @"name":@"1级",
            @"currentId":@"1",
            @"children":@[
                    @{
                        @"name":@"1_2_1级",
                        @"currentId":@"1_2_1",
                        @"parentId":@"1",
                        @"children":@[
                                           @{
                                               @"name":@"1_3_1级",
                                               @"currentId":@"1_3_1",
                                               @"parentId":@"1_2_1",
                                           },
                                           @{
                                               @"name":@"1_3_2级",
                                               @"currentId":@"1_3_2",
                                               @"parentId":@"1_2_1",
                                           },
                                          @{
                                               @"name":@"1_3_3级",
                                               @"currentId":@"1_3_3",
                                               @"parentId":@"1_2_1",
                                           },
                                   ]
                    },
                    @{
                        @"name":@"1_2_2级",
                        @"currentId":@"1_2_2",
                        @"parentId":@"1",
                    },
                   @{
                        @"name":@"1_2_3级",
                        @"currentId":@"1_2_3",
                        @"parentId":@"1",
                    },
            ]
        },
        @{
            @"name":@"2级",
            @"currentId":@"2",
            @"children":@[
                    @{
                        @"name":@"2_2_1级",
                        @"currentId":@"2_2_1",
                        @"parentId":@"2",
                    },
                    @{
                        @"name":@"2_2_2级",
                        @"currentId":@"2_2_2",
                        @"parentId":@"2",
                    },
                   @{
                        @"name":@"2_2_3级",
                        @"currentId":@"2_2_3",
                        @"parentId":@"2",
                    },
            ]
        },
        @{
            @"name":@"3级",
            @"currentId":@"3",
            @"children":@[
                    @{
                        @"name":@"3_2_1级",
                        @"currentId":@"3_2_1",
                        @"parentId":@"3",
                    },
                    @{
                        @"name":@"3_2_2级",
                        @"currentId":@"3_2_2",
                        @"parentId":@"3",
                    },
                   @{
                        @"name":@"3_2_3级",
                        @"currentId":@"3_2_3",
                        @"parentId":@"3",
                    },
            ]
        }
    ];
}

// 读取本地JSON文件
- (NSArray *)readLocalFileWithName:(NSString *)name {
    // 获取文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"json"];
    // 将文件数据化
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    // 对数据进行JSON格式化并返回字典形式
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
