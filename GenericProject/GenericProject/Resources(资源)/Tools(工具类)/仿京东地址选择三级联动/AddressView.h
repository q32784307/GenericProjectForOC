//
//  AddressView.h
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/7/10.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressTableView.h"
#import "AddressModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^returnBlock)(NSDictionary *addressDic);

@interface AddressView : UIView<UIScrollViewDelegate>

@property(nonatomic,copy)returnBlock block;
@property(nonatomic,strong)UIView *fatherView;
@property(nonatomic,copy)NSArray *datasArr, *datasArr1, *datasArr2;

/**
 弹出选择地址view
 
 @param supView 父view
 */
- (void)showView:(UIView *_Nonnull)supView;

@property(nonatomic,strong)UIView *myView;


/**
 请选择label
 */
@property(nonatomic,strong)UILabel *selectLabel;


/**
 红色的线
 */
@property(nonatomic,strong)UIView *redLineView;


@property(nonatomic,strong)UIScrollView *scrollView;

@property(nonatomic,strong)AddressTableView *__nullable tableView1;
@property(nonatomic,strong)AddressTableView *__nullable tableView2;
@property(nonatomic,strong)AddressTableView *__nullable tableView3;

/**
 记录点击的第一个的Model
 */
@property(nonatomic,strong)AddressModel *oneModel;

/**
 记录点击的第二个的Model
 */
@property(nonatomic,strong)AddressModel *twoModel;



/**
 省份label
 */
@property(nonatomic,strong)UILabel *stateLabel;

/**
 市label
 */
@property(nonatomic,strong)UILabel *__nullable cityLabel;

@end

NS_ASSUME_NONNULL_END
