//
//  OneViewController.m
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2018/5/29.
//  Copyright © 2018年 漠然丶情到深处. All rights reserved.
//

#import "OneViewController.h"
#import "PushViewController.h"
#import "VideoPlayViewController.h"
#import "AnimatedViewController.h"
#import "FaceViewController.h"
#import "VerifyCodeViewController.h"
#import "StickerKeyboardViewController.h"
#import "PictureLookViewController.h"
#import "CardTextFieldViewController.h"
#import "NestedHTMLViewController.h"
#import "BeautyCameraViewController.h"
#import "MerchantScanCodeViewController.h"
#import "SelectedDateViewController.h"
#import "CuttingHeadViewController.h"
#import "MultilevelTreeViewController.h"
#import "LmitationWXTakingPicturesViewController.h"
#import "SignInWithAppleViewController.h"
#import "PhotoAmplificationViewController.h"
#import "GraphicsProcessingViewController.h"
#import "TagViewDemoViewController.h"
#import "VerifyAlertViewController.h"
#import "PageViewController.h"
#import "LabelTagViewController.h"
#import "SignatureViewController.h"
#import "UserResizableViewController.h"
#import "RadioViewController.h"
#import "DownloadViewController.h"

@interface OneViewController ()

@property(nonatomic,copy)NSArray *titleArray;

@end

@implementation OneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigation];
    [self analysis];
    [self createSubViews];
    // 监听UITabBarItem被重复点击时的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarDidClick) name:@"0" object:nil];
    
//    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"城市数据" ofType:@"txt"];
//    NSData *data = [NSData dataWithContentsOfFile:filePath];
//    NSDictionary *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
//    NSLog(@"%@",array);
//    [UIDevice currentDevice].batteryMonitoringEnabled = YES;
    NSLog(@"%@",[EquipmentInformation getDeviceName]);
    NSLog(@"%@",[EquipmentInformation Operator]);
    NSLog(@"%@",systemName);
    NSLog(@"%@",iPhoneName);
    batteryMonitoring = YES;
    NSLog(@"%3.0f%%",batteryLevel);
    NSLog(@"%@",iOSVersion);
    NSLog(@"%@",iPhoneModel);
    NSLog(@"%@",uuid);
    NSLog(@"%@",appVerion);
    NSLog(@"%@",appName);
    NSLog(@"%@",buildVerion);
    
    [EquipmentInformation batteryState];
}

- (void)setNavigation {
    self.navView.isShowLeftButton = NO;
    self.navView.isShowRightButton = NO;
    self.navView.titleLabelText = @"列表";
//    self.navView.navBackgroundViewImage = @"1024-768";
}

- (void)analysis {
    self.titleArray = @[
                        @"闲杂",
                        @"视频播放器",
                        @"仿简书动画",
                        @"面容/指纹登录",
                        @"自定义验证码输入框",
                        @"自定义表情键盘",
                        @"蓝牙连接",
                        @"图片浏览器",
                        @"身份证键盘",
                        @"WEB嵌套",
                        @"美颜相机简单使用",
                        @"二维码扫描",
                        @"时间控件",
                        @"裁剪头像",
                        @"多级树效果",
                        @"仿微信拍照",
                        @"苹果第三方登录",
                        @"图片延迟加载",
                        @"圆角与阴影",
                        @"TagView演示",
                        @"滑块验证码",
                        @"分段选择控制器",
                        @"UILable添加点击事件",
                        @"手势签名",
                        @"仿猿题库拖拽",
                        @"仿Radio",
                        @"断点续传"
                        ];
}

- (void)createSubViews {
    self.mainTableView.frame = CGRectMake(0, NAVIGATION_BAR_HEIGHT, LSScreenWidth, LSScreenHeight - NAVIGATION_BAR_HEIGHT - TAB_BAR_HEIGHT);
    [self.view addSubview:self.mainTableView];
}

#pragma mark -- tabbar2次点击事件
- (void)tabBarDidClick {
    // 如果本控制器的view显示在最前面，就下拉刷新
    if ([self isShowingOnKeyWindow]) {
        NSLog(@"点击了0");
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellId = @"TableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.textLabel.font = [UIFont systemFontOfSize:LSSYRealValue(30 / 2)];
    }
    
    cell.textLabel.text = _titleArray[indexPath.row];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        PushViewController *pushVC = [[PushViewController alloc]init];
        [self.navigationController pushViewController:pushVC animated:YES];
    }
    if (indexPath.row == 1) {
        VideoPlayViewController *VideoPlayVC = [[VideoPlayViewController alloc]init];
        [self.navigationController pushViewController:VideoPlayVC animated:YES];
    }
    if (indexPath.row == 2) {
        AnimatedViewController *AnimatedVC = [[AnimatedViewController alloc]init];
        [self.navigationController pushViewController:AnimatedVC animated:YES];
    }
    if (indexPath.row == 3) {
        FaceViewController *FaceVC = [[FaceViewController alloc]init];
        [self.navigationController pushViewController:FaceVC animated:YES];
    }
    if (indexPath.row == 4) {
        VerifyCodeViewController *VerifyCodeVC = [[VerifyCodeViewController alloc]init];
        [self.navigationController pushViewController:VerifyCodeVC animated:YES];
    }
    if (indexPath.row == 5) {
        StickerKeyboardViewController *StickerKeyboardVC = [[StickerKeyboardViewController alloc]init];
        [self.navigationController pushViewController:StickerKeyboardVC animated:YES];
    }
    if (indexPath.row == 7) {
        PictureLookViewController *PictureLookVC = [[PictureLookViewController alloc]init];
        [self.navigationController pushViewController:PictureLookVC animated:YES];
    }
    if (indexPath.row == 8) {
        CardTextFieldViewController *CardTextFieldVC = [[CardTextFieldViewController alloc]init];
        [self.navigationController pushViewController:CardTextFieldVC animated:YES];
    }
    if (indexPath.row == 9) {
        NestedHTMLViewController *NestedHTMLVC = [[NestedHTMLViewController alloc]init];
        [self.navigationController pushViewController:NestedHTMLVC animated:YES];
    }
    if (indexPath.row == 10) {
        BeautyCameraViewController *BeautyCameraVC = [[BeautyCameraViewController alloc]init];
        [self.navigationController pushViewController:BeautyCameraVC animated:YES];
    }
    if (indexPath.row == 11) {
        MerchantScanCodeViewController *MerchantScanCodeVC = [[MerchantScanCodeViewController alloc] init];
        [self.navigationController pushViewController:MerchantScanCodeVC animated:YES];
    }
    if (indexPath.row == 12) {
        SelectedDateViewController *SelectedDateVC = [[SelectedDateViewController alloc]init];
        [self.navigationController pushViewController:SelectedDateVC animated:YES];
    }
    if (indexPath.row == 13) {
        CuttingHeadViewController *CuttingHeadVC = [[CuttingHeadViewController alloc]init];
        [self.navigationController pushViewController:CuttingHeadVC animated:YES];
    }
    if (indexPath.row == 14) {
        MultilevelTreeViewController *MultilevelTreeVC = [[MultilevelTreeViewController alloc]init];
        [self.navigationController pushViewController:MultilevelTreeVC animated:YES];
    }
    if (indexPath.row == 15) {
        LmitationWXTakingPicturesViewController *LmitationWXTakingPicturesVC = [[LmitationWXTakingPicturesViewController alloc]init];
        [self.navigationController pushViewController:LmitationWXTakingPicturesVC animated:YES];
    }
    if (indexPath.row == 16) {
        SignInWithAppleViewController *SignInWithAppleVC = [[SignInWithAppleViewController alloc]init];
        [self.navigationController pushViewController:SignInWithAppleVC animated:YES];
    }
    if (indexPath.row == 17) {
        PhotoAmplificationViewController *PhotoAmplificationVC = [[PhotoAmplificationViewController alloc]init];
        PhotoAmplificationVC.index = 0;
        [self.navigationController pushViewController:PhotoAmplificationVC animated:YES];
    }
    if (indexPath.row == 18) {
        GraphicsProcessingViewController *GraphicsProcessingVC = [[GraphicsProcessingViewController alloc]init];
        [self.navigationController pushViewController:GraphicsProcessingVC animated:YES];
    }
    if (indexPath.row == 19) {
        TagViewDemoViewController *TagViewDemoVC = [[TagViewDemoViewController alloc]init];
        [self.navigationController pushViewController:TagViewDemoVC animated:YES];
    }
    if (indexPath.row == 20) {
        VerifyAlertViewController *VerifyAlertVC = [[VerifyAlertViewController alloc]init];
        [self.navigationController pushViewController:VerifyAlertVC animated:YES];
    }
    if (indexPath.row == 21) {
        PageViewController *PageVC = [[PageViewController alloc]init];
        [self.navigationController pushViewController:PageVC animated:YES];
    }
    if (indexPath.row == 22) {
        LabelTagViewController *LabelTagVC = [[LabelTagViewController alloc]init];
        [self.navigationController pushViewController:LabelTagVC animated:YES];
    }
    if (indexPath.row == 23) {
        SignatureViewController *SignatureVC = [[SignatureViewController alloc]init];
        [self.navigationController pushViewController:SignatureVC animated:YES];
        SignatureVC.signResult = ^(UIImage *signImage) {
//            self.signImageView.image = signImage;
        };
    }
    if (indexPath.row == 24) {
        UserResizableViewController *UserResizableVC = [[UserResizableViewController alloc]init];
        [self.navigationController pushViewController:UserResizableVC animated:YES];
    }
    if (indexPath.row == 25) {
        RadioViewController *RadioVC = [[RadioViewController alloc]init];
        [self.navigationController pushViewController:RadioVC animated:YES];
    }
    if (indexPath.row == 26) {
        DownloadViewController *DownloadVC = [[DownloadViewController alloc]init];
        [self.navigationController pushViewController:DownloadVC animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return LSSYRealValue(100 / 2);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 25;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
