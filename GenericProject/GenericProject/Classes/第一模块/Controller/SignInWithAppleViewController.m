//
//  SignInWithAppleViewController.m
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/12/11.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import "SignInWithAppleViewController.h"
#import <AuthenticationServices/AuthenticationServices.h>

@interface SignInWithAppleViewController ()<ASAuthorizationControllerDelegate,ASAuthorizationControllerPresentationContextProviding>

@end

@implementation SignInWithAppleViewController

//添加苹果第三方登录，证书使用会报错
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (@available(iOS 13.0, *)) {
        ASAuthorizationAppleIDButton *appleIDButton = [ASAuthorizationAppleIDButton buttonWithType:ASAuthorizationAppleIDButtonTypeSignIn style:ASAuthorizationAppleIDButtonStyleWhiteOutline];
        appleIDButton.frame = CGRectMake(50, NAVIGATION_BAR_HEIGHT + 100, 200, 50);
        [appleIDButton addTarget:self action:@selector(userAppIDLogin:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:appleIDButton];
    } else {
        // Fallback on earlier versions
    }
}

#pragma mark - 处理授权
- (void)userAppIDLogin:(ASAuthorizationAppleIDButton *)button  API_AVAILABLE(ios(13.0)){
    if (@available(iOS 13.0, *)) {
         // 基于用户的Apple ID授权用户，生成用户授权请求的一种机制
        ASAuthorizationAppleIDProvider *appleIdProvider = [[ASAuthorizationAppleIDProvider alloc] init];
        // 创建新的AppleID 授权请求
        ASAuthorizationAppleIDRequest *request = appleIdProvider.createRequest;
         // 在用户授权期间请求的联系信息
        request.requestedScopes = @[ASAuthorizationScopeEmail,ASAuthorizationScopeFullName];
        // 由ASAuthorizationAppleIDProvider创建的授权请求 管理授权请求的控制器
        ASAuthorizationController *controller = [[ASAuthorizationController alloc] initWithAuthorizationRequests:@[request]];
         // 设置授权控制器通知授权请求的成功与失败的代理
        controller.delegate = self;
        // 设置提供 展示上下文的代理，在这个上下文中 系统可以展示授权界面给用户
        controller.presentationContextProvider = self;
         // 在控制器初始化期间启动授权流
        [controller performRequests];
    } else {
        NSLog(@"system is lower");
    }
}

#pragma mark - 授权成功的回调
- (void)authorizationController:(ASAuthorizationController *)controller didCompleteWithAuthorization:(ASAuthorization *)authorization  API_AVAILABLE(ios(13.0)) {
    if ([authorization.credential isKindOfClass:[ASAuthorizationAppleIDCredential class]]) {
        // 用户登录使用ASAuthorizationAppleIDCredential
        ASAuthorizationAppleIDCredential *credential = authorization.credential;
        //将返回得到的user 存储起来
        NSString *user = credential.user;
        //用于后台像苹果服务器验证身份信息
        NSData *identityToken = credential.identityToken;
        NSLog(@"fullName -     %@",credential.fullName);
        //授权成功后，你可以拿到苹果返回的全部数据，根据需要和后台交互。
        NSLog(@"user   -   %@  %@",user,identityToken);
        //保存apple返回的唯一标识符
        SaveUserDefault(user, @"userIdentifier");
    } else if ([authorization.credential isKindOfClass:[ASPasswordCredential class]]) {
        // 用户登录使用现有的密码凭证
        ASPasswordCredential *psdCredential = authorization.credential;
        // 密码凭证对象的用户标识 用户的唯一标识
        NSString *user = psdCredential.user;
        NSString *psd = psdCredential.password;
        NSLog(@"psduser -  %@   %@",psd,user);
    } else {
       NSLog(@"授权信息不符");
    }
}

#pragma mark - 授权回调失败
- (void)authorizationController:(ASAuthorizationController *)controller didCompleteWithError:(NSError *)error  API_AVAILABLE(ios(13.0)){
    
     NSLog(@"错误信息：%@", error);
     NSString *errorMsg;
    switch (error.code) {
        case ASAuthorizationErrorCanceled:
            errorMsg = @"用户取消了授权请求";
            NSLog(@"errorMsg -   %@",errorMsg);
            break;
            
        case ASAuthorizationErrorFailed:
            errorMsg = @"授权请求失败";
            NSLog(@"errorMsg -   %@",errorMsg);
            break;
            
        case ASAuthorizationErrorInvalidResponse:
            errorMsg = @"授权请求响应无效";
            NSLog(@"errorMsg -   %@",errorMsg);
            break;
            
        case ASAuthorizationErrorNotHandled:
            errorMsg = @"未能处理授权请求";
            NSLog(@"errorMsg -   %@",errorMsg);
            break;
            
        case ASAuthorizationErrorUnknown:
            errorMsg = @"授权请求失败未知原因";
            NSLog(@"errorMsg -   %@",errorMsg);
            break;
                        
        default:
            break;
    }
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
