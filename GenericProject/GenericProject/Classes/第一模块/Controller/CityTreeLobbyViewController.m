//
//  CityTreeLobbyViewController.m
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/12/5.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import "CityTreeLobbyViewController.h"
#import "CityTreeViewController.h"

@interface CityTreeLobbyViewController ()<LSTreeTableViewControllerDelegate>

@property(nonatomic,strong)UISwitch *mySwitch1;
@property(nonatomic,strong)UISwitch *mySwitch2;
@property(nonatomic,strong)UISwitch *mySwitch3;
@property(nonatomic,strong)UISwitch *mySwitch4;
@property(nonatomic,strong)UISwitch *mySwitch5;
@property(nonatomic,strong)UISwitch *mySwitch6;
@property(nonatomic,strong)UISwitch *mySwitch7;
@property(nonatomic,strong)UISwitch *mySwitch8;
@property(nonatomic,strong)UISwitch *mySwitch9;
@property(nonatomic,strong)UISwitch *mySwitch10;
@property(nonatomic,strong)UILabel *bottomLabel;

@property(nonatomic,strong)NSArray <LSTreeItem *>*checkItems;  // 所选择的 items 传出来的数据

@end

@implementation CityTreeLobbyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigation];
    [self createSubViews];
}

- (void)setNavigation {
    self.navView.isShowRightButton = YES;
    self.navView.rightButtonTitle = @"进入下一级";
    
    LSWeakSelf(self);
    self.navView.RightActionBlock = ^{
        LSStrongSelf(self);
        // 这里的个性化设置也可以移到 CityTreeViewController 中的 viewDidLoad 执行
        CityTreeViewController *CityTreeVC = [[CityTreeViewController alloc] init];
        CityTreeVC.delegate                 = self;
        CityTreeVC.isShowExpandedAnimation  = self.mySwitch1.isOn;
        CityTreeVC.isShowArrowIfNoChildNode = self.mySwitch2.isOn;
        CityTreeVC.isShowArrow              = self.mySwitch3.isOn;
        CityTreeVC.isShowCheck              = self.mySwitch4.isOn;
        CityTreeVC.isSingleCheck            = self.mySwitch5.isOn;
        CityTreeVC.isCancelSingleCheck      = self.mySwitch6.isOn;
        CityTreeVC.isExpandCheckedNode      = self.mySwitch7.isOn;
        CityTreeVC.isShowLevelColor         = self.mySwitch8.isOn;
        CityTreeVC.isShowSearchBar          = self.mySwitch9.isOn;
        CityTreeVC.isSearchRealTime         = self.mySwitch10.isOn;
        CityTreeVC.checkItemIds             = [self getItemIds];
        [self.navigationController pushViewController:CityTreeVC animated:YES];
    };
}

- (void)createSubViews {
    UILabel *titleLabel1 = [[UILabel alloc]init];
    titleLabel1.text = @"是否显示展开/折叠动画";
    [self.view addSubview:titleLabel1];
    [titleLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(NAVIGATION_BAR_HEIGHT + LSSYRealValue(30 / 2));
        make.left.equalTo(self.view).with.offset(LSSYRealValue(30 / 2));
        make.height.mas_equalTo(LSSYRealValue(30 / 2));
    }];
    
    self.mySwitch1 = [[UISwitch alloc] init];
    self.mySwitch1.on = YES;
    self.mySwitch1.tag = 1;
    [self.mySwitch1 addTarget:self action:@selector(mySwitchAction:) forControlEvents:(UIControlEventValueChanged)];
    [self.view addSubview:self.mySwitch1];
    [self.mySwitch1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(NAVIGATION_BAR_HEIGHT + LSSYRealValue(30 / 2));
        make.right.equalTo(self.view.mas_right).with.offset(LSSYRealValue(-30 / 2));
        make.height.mas_equalTo(LSSYRealValue(30 / 2));
    }];
    
    UILabel *titleLabel2 = [[UILabel alloc]init];
    titleLabel2.text = @"是否没有子节点就不显示箭头";
    [self.view addSubview:titleLabel2];
    [titleLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel1.mas_bottom).with.offset(LSSYRealValue(50 / 2));
        make.left.equalTo(self.view).with.offset(LSSYRealValue(30 / 2));
        make.height.mas_equalTo(LSSYRealValue(30 / 2));
    }];
    
    self.mySwitch2 = [[UISwitch alloc] init];
    self.mySwitch2.on = NO;
    self.mySwitch2.tag = 2;
    [self.mySwitch2 addTarget:self action:@selector(mySwitchAction:) forControlEvents:(UIControlEventValueChanged)];
    [self.view addSubview:self.mySwitch2];
    [self.mySwitch2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mySwitch1.mas_bottom).with.offset(LSSYRealValue(50 / 2));
        make.right.equalTo(self.view.mas_right).with.offset(LSSYRealValue(-30 / 2));
        make.height.mas_equalTo(LSSYRealValue(30 / 2));
    }];
    
    UILabel *titleLabel3 = [[UILabel alloc]init];
    titleLabel3.text = @"是否显示箭头";
    [self.view addSubview:titleLabel3];
    [titleLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel2.mas_bottom).with.offset(LSSYRealValue(50 / 2));
        make.left.equalTo(self.view).with.offset(LSSYRealValue(30 / 2));
        make.height.mas_equalTo(LSSYRealValue(30 / 2));
    }];
    
    self.mySwitch3 = [[UISwitch alloc] init];
    self.mySwitch3.on = YES;
    self.mySwitch3.tag = 3;
    [self.mySwitch3 addTarget:self action:@selector(mySwitchAction:) forControlEvents:(UIControlEventValueChanged)];
    [self.view addSubview:self.mySwitch3];
    [self.mySwitch3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mySwitch2.mas_bottom).with.offset(LSSYRealValue(50 / 2));
        make.right.equalTo(self.view.mas_right).with.offset(LSSYRealValue(-30 / 2));
        make.height.mas_equalTo(LSSYRealValue(30 / 2));
    }];
    
    UILabel *titleLabel4 = [[UILabel alloc]init];
    titleLabel4.text = @"是否显示勾选框";
    [self.view addSubview:titleLabel4];
    [titleLabel4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel3.mas_bottom).with.offset(LSSYRealValue(50 / 2));
        make.left.equalTo(self.view).with.offset(LSSYRealValue(30 / 2));
        make.height.mas_equalTo(LSSYRealValue(30 / 2));
    }];
    
    self.mySwitch4 = [[UISwitch alloc] init];
    self.mySwitch4.on = YES;
    self.mySwitch4.tag = 4;
    [self.mySwitch4 addTarget:self action:@selector(mySwitchAction:) forControlEvents:(UIControlEventValueChanged)];
    [self.view addSubview:self.mySwitch4];
    [self.mySwitch4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mySwitch3.mas_bottom).with.offset(LSSYRealValue(50 / 2));
        make.right.equalTo(self.view.mas_right).with.offset(LSSYRealValue(-30 / 2));
        make.height.mas_equalTo(LSSYRealValue(30 / 2));
    }];
    
    UILabel *titleLabel5 = [[UILabel alloc]init];
    titleLabel5.text = @"是否单选";
    [self.view addSubview:titleLabel5];
    [titleLabel5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel4.mas_bottom).with.offset(LSSYRealValue(50 / 2));
        make.left.equalTo(self.view).with.offset(LSSYRealValue(30 / 2));
        make.height.mas_equalTo(LSSYRealValue(30 / 2));
    }];
    
    self.mySwitch5 = [[UISwitch alloc] init];
    self.mySwitch5.on = NO;
    self.mySwitch5.tag = 5;
    [self.mySwitch5 addTarget:self action:@selector(mySwitchAction:) forControlEvents:(UIControlEventValueChanged)];
    [self.view addSubview:self.mySwitch5];
    [self.mySwitch5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mySwitch4.mas_bottom).with.offset(LSSYRealValue(50 / 2));
        make.right.equalTo(self.view.mas_right).with.offset(LSSYRealValue(-30 / 2));
        make.height.mas_equalTo(LSSYRealValue(30 / 2));
    }];
    
    UILabel *titleLabel6 = [[UILabel alloc]init];
    titleLabel6.text = @"是否单选时再次点击可以取消选择";
    [self.view addSubview:titleLabel6];
    [titleLabel6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel5.mas_bottom).with.offset(LSSYRealValue(50 / 2));
        make.left.equalTo(self.view).with.offset(LSSYRealValue(30 / 2));
        make.height.mas_equalTo(LSSYRealValue(30 / 2));
    }];
    
    self.mySwitch6 = [[UISwitch alloc] init];
    self.mySwitch6.on = NO;
    self.mySwitch6.tag = 6;
    [self.mySwitch6 addTarget:self action:@selector(mySwitchAction:) forControlEvents:(UIControlEventValueChanged)];
    [self.view addSubview:self.mySwitch6];
    [self.mySwitch6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mySwitch5.mas_bottom).with.offset(LSSYRealValue(50 / 2));
        make.right.equalTo(self.view.mas_right).with.offset(LSSYRealValue(-30 / 2));
        make.height.mas_equalTo(LSSYRealValue(30 / 2));
    }];
    
    UILabel *titleLabel7 = [[UILabel alloc]init];
    titleLabel7.text = @"是否展开已选择的节点";
    [self.view addSubview:titleLabel7];
    [titleLabel7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel6.mas_bottom).with.offset(LSSYRealValue(50 / 2));
        make.left.equalTo(self.view).with.offset(LSSYRealValue(30 / 2));
        make.height.mas_equalTo(LSSYRealValue(30 / 2));
    }];
    
    self.mySwitch7 = [[UISwitch alloc] init];
    self.mySwitch7.on = YES;
    self.mySwitch7.tag = 7;
    [self.mySwitch7 addTarget:self action:@selector(mySwitchAction:) forControlEvents:(UIControlEventValueChanged)];
    [self.view addSubview:self.mySwitch7];
    [self.mySwitch7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mySwitch6.mas_bottom).with.offset(LSSYRealValue(50 / 2));
        make.right.equalTo(self.view.mas_right).with.offset(LSSYRealValue(-30 / 2));
        make.height.mas_equalTo(LSSYRealValue(30 / 2));
    }];
    
    UILabel *titleLabel8 = [[UILabel alloc]init];
    titleLabel8.text = @"是否显示层级颜色";
    [self.view addSubview:titleLabel8];
    [titleLabel8 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel7.mas_bottom).with.offset(LSSYRealValue(50 / 2));
        make.left.equalTo(self.view).with.offset(LSSYRealValue(30 / 2));
        make.height.mas_equalTo(LSSYRealValue(30 / 2));
    }];
    
    self.mySwitch8 = [[UISwitch alloc] init];
    self.mySwitch8.on = YES;
    self.mySwitch8.tag = 8;
    [self.mySwitch8 addTarget:self action:@selector(mySwitchAction:) forControlEvents:(UIControlEventValueChanged)];
    [self.view addSubview:self.mySwitch8];
    [self.mySwitch8 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mySwitch7.mas_bottom).with.offset(LSSYRealValue(50 / 2));
        make.right.equalTo(self.view.mas_right).with.offset(LSSYRealValue(-30 / 2));
        make.height.mas_equalTo(LSSYRealValue(30 / 2));
    }];
    
    UILabel *titleLabel9 = [[UILabel alloc]init];
    titleLabel9.text = @"是否显示搜索框";
    [self.view addSubview:titleLabel9];
    [titleLabel9 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel8.mas_bottom).with.offset(LSSYRealValue(50 / 2));
        make.left.equalTo(self.view).with.offset(LSSYRealValue(30 / 2));
        make.height.mas_equalTo(LSSYRealValue(30 / 2));
    }];
    
    self.mySwitch9 = [[UISwitch alloc] init];
    self.mySwitch9.on = YES;
    self.mySwitch9.tag = 9;
    [self.mySwitch9 addTarget:self action:@selector(mySwitchAction:) forControlEvents:(UIControlEventValueChanged)];
    [self.view addSubview:self.mySwitch9];
    [self.mySwitch9 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mySwitch8.mas_bottom).with.offset(LSSYRealValue(50 / 2));
        make.right.equalTo(self.view.mas_right).with.offset(LSSYRealValue(-30 / 2));
        make.height.mas_equalTo(LSSYRealValue(30 / 2));
    }];
    
    UILabel *titleLabel10 = [[UILabel alloc]init];
    titleLabel10.text = @"是否实时查询";
    [self.view addSubview:titleLabel10];
    [titleLabel10 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel9.mas_bottom).with.offset(LSSYRealValue(50 / 2));
        make.left.equalTo(self.view).with.offset(LSSYRealValue(30 / 2));
        make.height.mas_equalTo(LSSYRealValue(30 / 2));
    }];
    
    self.mySwitch10 = [[UISwitch alloc] init];
    self.mySwitch10.on = YES;
    self.mySwitch10.tag = 10;
    [self.mySwitch10 addTarget:self action:@selector(mySwitchAction:) forControlEvents:(UIControlEventValueChanged)];
    [self.view addSubview:self.mySwitch10];
    [self.mySwitch10 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mySwitch9.mas_bottom).with.offset(LSSYRealValue(50 / 2));
        make.right.equalTo(self.view.mas_right).with.offset(LSSYRealValue(-30 / 2));
        make.height.mas_equalTo(LSSYRealValue(30 / 2));
    }];
    
    self.bottomLabel = [[UILabel alloc] init];
    self.bottomLabel.text = @"已选择了 0 个 items";
    [self.view addSubview:self.bottomLabel];
    [self.bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-HOME_INDICATOR_HEIGHT + LSSYRealValue(-50 / 2));
        make.left.equalTo(self.view).with.offset(LSSYRealValue(30 / 2));
        make.right.equalTo(self.view.mas_right).with.offset(LSSYRealValue(-30 / 2));
        make.height.mas_equalTo(LSSYRealValue(30 / 2));
    }];
}

- (void)mySwitchAction:(UISwitch *)sender {
    
}

- (NSArray *)getItemIds {
    // demo 中的逻辑判断没有处理的那么严谨，多选切换成单选后，当前多选选择的数据全部清空
    if (self.mySwitch5.isOn && self.checkItems.count > 1) {
        self.checkItems = [NSArray array];
        self.bottomLabel.text = @"已选择了 0 个 items";
    }

    NSMutableArray *itemIds = [NSMutableArray array];
    for (LSTreeItem *item in self.checkItems) {
        [itemIds addObject:item.ID];
    }
    return itemIds.copy;
}


#pragma mark - MYTreeTableViewControllerDelegate

- (void)tableViewController:(LSTreeTableViewController *)tableViewController checkItems:(NSArray<LSTreeItem *> *)items {

    self.checkItems = items;
    self.bottomLabel.text = [NSString stringWithFormat:@"已选择了 %lu 个 items", (unsigned long)items.count];
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
