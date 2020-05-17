//
//  AlertController.m
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2018/6/25.
//  Copyright © 2018年 漠然丶情到深处. All rights reserved.
//

#import "AlertController.h"

//toast默认展示时间
static NSTimeInterval const AlertShowDurationDefault = 1.0f;

#pragma mark - I.AlertActionModel
@interface AlertActionModel : NSObject

@property (nonatomic, copy) NSString * title;
@property (nonatomic, assign) UIAlertActionStyle style;
@end
@implementation AlertActionModel

- (instancetype)init {
    if (self = [super init]) {
        self.title = @"";
        self.style = UIAlertActionStyleDefault;
    }
    return self;
}

@end



#pragma mark - II.AlertController
/**
 AlertActions配置
 
 @param actionBlock AlertActionBlock
 */
typedef void (^AlertActionsConfig)(AlertActionBlock actionBlock);

@interface AlertController ()

//AlertActionModel数组
@property (nonatomic, strong) NSMutableArray <AlertActionModel *>* alertActionArray;
//是否操作动画
@property (nonatomic, assign) BOOL setAlertAnimated;
//action配置
- (AlertActionsConfig)alertActionsConfig;

@end

@implementation AlertController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    if (self.alertDidDismiss) {
        self.alertDidDismiss();
    }
}

- (void)dealloc
{
    //    NSLog(@"test-dealloc");
}

#pragma mark - Private
//action-title数组
- (NSMutableArray<AlertActionModel *> *)alertActionArray {
    if (_alertActionArray == nil) {
        _alertActionArray = [NSMutableArray array];
    }
    return _alertActionArray;
}

//action配置
- (AlertActionsConfig)alertActionsConfig {
    return ^(AlertActionBlock actionBlock) {
        if (self.alertActionArray.count > 0)
        {
            //创建action
            __weak typeof(self)weakSelf = self;
            [self.alertActionArray enumerateObjectsUsingBlock:^(AlertActionModel *actionModel, NSUInteger idx, BOOL * _Nonnull stop) {
                UIAlertAction *alertAction = [UIAlertAction actionWithTitle:actionModel.title style:actionModel.style handler:^(UIAlertAction * _Nonnull action) {
                    __strong typeof(weakSelf)strongSelf = weakSelf;
                    if (actionBlock) {
                        actionBlock(idx, action, strongSelf);
                    }
                }];
                //可利用这个改变字体颜色，但是不推荐！！！
                //                [alertAction setValue:[UIColor grayColor] forKey:@"titleTextColor"];
                //action作为self元素，其block实现如果引用本类指针，会造成循环引用
                [self addAction:alertAction];
            }];
        }
        else
        {
            NSTimeInterval duration = self.toastStyleDuration > 0 ? self.toastStyleDuration : AlertShowDurationDefault;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self dismissViewControllerAnimated:!(self.setAlertAnimated) completion:NULL];
            });
        }
    };
}

#pragma mark - Public

- (instancetype)initAlertControllerWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(UIAlertControllerStyle)preferredStyle {
    if (!(title.length > 0) && (message.length > 0) && (preferredStyle == UIAlertControllerStyleAlert)) {
        title = @"";
    }
    self = [[self class] alertControllerWithTitle:title message:message preferredStyle:preferredStyle];
    if (!self) return nil;
    
    self.setAlertAnimated = NO;
    self.toastStyleDuration = AlertShowDurationDefault;
    
    return self;
}

- (void)alertAnimateDisabled {
    self.setAlertAnimated = YES;
}

- (AlertActionTitle)addActionDefaultTitle {
    //该block返回值不是本类属性，只是局部变量，不会造成循环引用
    return ^(NSString *title) {
        AlertActionModel *actionModel = [[AlertActionModel alloc] init];
        actionModel.title = title;
        actionModel.style = UIAlertActionStyleDefault;
        [self.alertActionArray addObject:actionModel];
        return self;
    };
}

- (AlertActionTitle)addActionCancelTitle {
    return ^(NSString *title) {
        AlertActionModel *actionModel = [[AlertActionModel alloc] init];
        actionModel.title = title;
        actionModel.style = UIAlertActionStyleCancel;
        [self.alertActionArray addObject:actionModel];
        return self;
    };
}

- (AlertActionTitle)addActionDestructiveTitle {
    return ^(NSString *title) {
        AlertActionModel *actionModel = [[AlertActionModel alloc] init];
        actionModel.title = title;
        actionModel.style = UIAlertActionStyleDestructive;
        [self.alertActionArray addObject:actionModel];
        return self;
    };
}

@end



#pragma mark - III.UIViewController扩展
@implementation UIViewController (AlertController)

- (void)showAlertWithPreferredStyle:(UIAlertControllerStyle)preferredStyle title:(NSString *)title message:(NSString *)message appearanceProcess:(AlertAppearanceProcess)appearanceProcess actionsBlock:(AlertActionBlock)actionBlock {
    if (appearanceProcess) {
        AlertController *alertMaker = [[AlertController alloc] initAlertControllerWithTitle:title message:message preferredStyle:preferredStyle];
        //防止nil
        if (!alertMaker) {
            return ;
        }
        //加工链
        appearanceProcess(alertMaker);
        //配置响应
        alertMaker.alertActionsConfig(actionBlock);
        if (alertMaker.alertDidShown) {
            [self presentViewController:alertMaker animated:!(alertMaker.setAlertAnimated) completion:^{
                alertMaker.alertDidShown();
            }];
        }else{
            [self presentViewController:alertMaker animated:!(alertMaker.setAlertAnimated) completion:NULL];
        }
    }
}

- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message appearanceProcess:(AlertAppearanceProcess)appearanceProcess actionsBlock:(AlertActionBlock)actionBlock {
    [self showAlertWithPreferredStyle:UIAlertControllerStyleAlert title:title message:message appearanceProcess:appearanceProcess actionsBlock:actionBlock];
}

- (void)showActionSheetWithTitle:(NSString *)title message:(NSString *)message appearanceProcess:(AlertAppearanceProcess)appearanceProcess actionsBlock:(AlertActionBlock)actionBlock {
    [self showAlertWithPreferredStyle:UIAlertControllerStyleActionSheet title:title message:message appearanceProcess:appearanceProcess actionsBlock:actionBlock];
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
