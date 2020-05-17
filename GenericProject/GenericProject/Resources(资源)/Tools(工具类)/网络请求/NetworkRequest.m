//
//  NetworkRequest.m
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2018/5/17.
//  Copyright © 2018年 漠然丶情到深处. All rights reserved.
//

#import "NetworkRequest.h"
#import "Reachability.h"

@interface NetworkRequest ()

@property(nonatomic)AFHTTPSessionManager *sessionManager;

@end

@implementation NetworkRequest

+ (instancetype)sharedInstance {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        NSLog(@"指针变量p的自身在内存地址=%p", &instance);
    });
    return instance;
}

#pragma mark - 网络检测
- (BOOL)isNetWorkConnectionAvailable {
    BOOL isExistenceNetwork = YES;
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    switch ([reach currentReachabilityStatus]) {
        case NotReachable:
            isExistenceNetwork = NO;
            break;
        case ReachableViaWiFi:
            isExistenceNetwork = YES;
            break;
        case ReachableViaWWAN:
            isExistenceNetwork = YES;
            break;
    }
    return isExistenceNetwork;
}

#pragma mark - 配置请求底层参数
- (AFHTTPSessionManager *)sessionManager {
    if (!_sessionManager) {
        NSURL *baseUrl = [NSURL URLWithString:RequestUrl];
        _sessionManager = [[AFHTTPSessionManager manager] initWithBaseURL:baseUrl];
        _sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
        _sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        _sessionManager.requestSerializer.timeoutInterval = 20.f;
        [_sessionManager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        [_sessionManager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        [_sessionManager.responseSerializer setAcceptableContentTypes: [NSSet setWithObjects:@"application/json",@"text/json", @"text/javascript",@"text/html",@"text/css",@"text/plain", nil]];
        NSString *userAgent = [NSString stringWithFormat:@"iOS/%@/%@ (%@; iOS %@; Scale/%0.2f)", [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleExecutableKey],[[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"] ?: [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleVersionKey], [[UIDevice currentDevice] model], [[UIDevice currentDevice] systemVersion], [[UIScreen mainScreen] scale]];
        [_sessionManager.requestSerializer setValue:userAgent forHTTPHeaderField:@"User-Agent"];
    }
    return _sessionManager;
}

/**
 *  @brief                                         网络请求 Get
 *  @param url                                     传入的url(NSString)
 *  @param header                                  请求头参数(id)
 *  @param successblock                            请求获取数据成功
 *  @param failureBlock                            请求获取数据失败
 */
- (void)getRequestWithHTTPUrl:(NSString *)url parmater:(id)parmater headerRequest:(id)header isOpenHUD:(BOOL)isOpenHUD isCloseHUD:(BOOL)isCloseHUD SuccessBlock:(void (^)(id responseDict))successblock FailureBlock:(void (^)(NSError *error))failureBlock {
    
    if (self.isNetWorkConnectionAvailable) {
//        [self.sessionManager.requestSerializer setValue:header forHTTPHeaderField:@"Authorization"];
        if (isOpenHUD == YES) {
            [SVProgressHUD showWithStatus:@"加载中..."];
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
            [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
            [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        }
        NSLog(@"请求地址---%@%@",RequestUrl,url);
        [self.sessionManager GET:url parameters:nil headers:@{header:@"Authorization"} progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:responseDict options:NSJSONWritingPrettyPrinted error:nil];
            NSString *Json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            successblock(responseDict);
            if (isCloseHUD == YES) {
                [SVProgressHUD dismiss];
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            }
            NSLog(@"网络请求返回数据---%@",Json);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            failureBlock(error);
            if (isCloseHUD == YES) {
                [SVProgressHUD dismiss];
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            }
            NSHTTPURLResponse *resoinse = (NSHTTPURLResponse *)task.response;
            NSString *codeStr = [NSString stringWithFormat:@"%ld - %@",(long)resoinse.statusCode,[error.userInfo objectForKey:@"NSLocalizedDescription"]];
            [[UIViewController ViewController] showAlertWithTitle:EmptyTitle message:codeStr appearanceProcess:^(AlertController * _Nonnull alertMaker) {
                alertMaker.toastStyleDuration = 2;
            } actionsBlock:NULL];
        }];
    }else{
        [[UIViewController ViewController] showAlertWithTitle:EmptyTitle message:MessageTiele appearanceProcess:^(AlertController * _Nonnull alertMaker) {
            alertMaker.toastStyleDuration = 2;
        } actionsBlock:NULL];
    }
}

/**
 *  @brief                                         网络请求 Put
 *  @param url                                     传入的url(NSString)
 *  @param parmater                                传入的参数(id)
 *  @param header                                  请求头参数(id)
 *  @param successblock                            请求获取数据成功
 *  @param failureBlock                            请求获取数据失败
 */
- (void)putRequestWithHTTPUrl:(NSString *)url parmater:(id)parmater headerRequest:(id)header isOpenHUD:(BOOL)isOpenHUD isCloseHUD:(BOOL)isCloseHUD SuccessBlock:(void (^)(id responseDict))successblock FailureBlock:(void (^)(NSError *error))failureBlock {
    
    if (self.isNetWorkConnectionAvailable) {
        [self.sessionManager.requestSerializer setValue:header forHTTPHeaderField:@"Authorization"];
        if (isOpenHUD == YES) {
            [SVProgressHUD showWithStatus:@"加载中..."];
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
            [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
            [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        }
        NSLog(@"请求地址+传参---%@%@\n%@",RequestUrl,url,parmater);
        [self.sessionManager PUT:url parameters:parmater headers:@{header:@"Authorization"} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:responseDict options:NSJSONWritingPrettyPrinted error:nil];
            NSString *Json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            successblock(responseDict);
            if (isCloseHUD == YES) {
                [SVProgressHUD dismiss];
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            }
            NSLog(@"网络请求返回数据---%@",Json);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            failureBlock(error);
            if (isCloseHUD == YES) {
                [SVProgressHUD dismiss];
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            }
            NSHTTPURLResponse *resoinse = (NSHTTPURLResponse *)task.response;
            NSString *codeStr = [NSString stringWithFormat:@"%ld - %@",(long)resoinse.statusCode,[error.userInfo objectForKey:@"NSLocalizedDescription"]];
            [[UIViewController ViewController] showAlertWithTitle:EmptyTitle message:codeStr appearanceProcess:^(AlertController * _Nonnull alertMaker) {
                alertMaker.toastStyleDuration = 2;
            } actionsBlock:NULL];
        }];
    }else{
        [[UIViewController ViewController] showAlertWithTitle:EmptyTitle message:MessageTiele appearanceProcess:^(AlertController * _Nonnull alertMaker) {
            alertMaker.toastStyleDuration = 2;
        } actionsBlock:NULL];
    }
}

/**
 *  @brief                                         网络请求 Post
 *  @param url                                     传入的url(NSString)
 *  @param parmater                                传入的参数(id)
 *  @param header                                  请求头参数(id)
 *  @param successblock                            请求获取数据成功
 *  @param failureBlock                            请求数据获取失败
 */
- (void)postRequestWithHTTPUrl:(NSString *)url parmater:(id)parmater headerRequest:(id)header isOpenHUD:(BOOL)isOpenHUD isCloseHUD:(BOOL)isCloseHUD SuccessBlock:(void (^)(id responseDict))successblock FailureBlock:(void (^)(NSError *error))failureBlock {
    
    if (self.isNetWorkConnectionAvailable) {
        [self.sessionManager.requestSerializer setValue:header forHTTPHeaderField:@"Authorization"];
        if (isOpenHUD == YES) {
            [SVProgressHUD showWithStatus:@"加载中..."];
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
            [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
            [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        }
        NSLog(@"请求地址+传参---%@%@\n%@",RequestUrl,url,parmater);
        [self.sessionManager POST:url parameters:parmater headers:@{header:@"Authorization"} progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:responseDict options:NSJSONWritingPrettyPrinted error:nil];
            NSString *Json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            successblock(responseDict);
            if (isCloseHUD == YES) {
                [SVProgressHUD dismiss];
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            }
            NSLog(@"网络请求返回数据---%@",Json);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            failureBlock(error);
            if (isCloseHUD == YES) {
                [SVProgressHUD dismiss];
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            }
            NSHTTPURLResponse *resoinse = (NSHTTPURLResponse *)task.response;
            NSString *codeStr = [NSString stringWithFormat:@"%ld - %@",(long)resoinse.statusCode,[error.userInfo objectForKey:@"NSLocalizedDescription"]];
            [[UIViewController ViewController] showAlertWithTitle:EmptyTitle message:codeStr appearanceProcess:^(AlertController * _Nonnull alertMaker) {
                alertMaker.toastStyleDuration = 2;
            } actionsBlock:NULL];
        }];
    }else{
        [[UIViewController ViewController] showAlertWithTitle:EmptyTitle message:MessageTiele appearanceProcess:^(AlertController * _Nonnull alertMaker) {
            alertMaker.toastStyleDuration = 2;
        } actionsBlock:NULL];
    }
}

/**
 *  @brief                                         网络请求 Post (单图片上传)
 *  @param url                                     传入的url(NSString)
 *  @param parmater                                传入的参数(id)
 *  @param header                                  请求头参数(id)
 *  @param fileData                                传入图片的数据流(NSData)
 *  @param fileName                                传入图片的名字(NSString  与后台一致)
 *  @param successblock                            请求获取数据成功
 *  @param failureBlock                            请求数据获取失败
 */
- (void)postRequestWithHTTPImageUploadRequestWithUrl:(NSString *)url parmater:(id)parmater headerRequest:(id)header isOpenHUD:(BOOL)isOpenHUD isCloseHUD:(BOOL)isCloseHUD fileData:(NSData *)fileData fileName:(NSString *)fileName SuccessBlock:(void (^)(id responseDict))successblock FailureBlock:(void (^)(NSError *error))failureBlock {
    
    if (self.isNetWorkConnectionAvailable) {
        [self.sessionManager.requestSerializer setValue:header forHTTPHeaderField:@"Authorization"];
        if (isOpenHUD == YES) {
            [SVProgressHUD showWithStatus:@"加载中..."];
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
            [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
            [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        }
        NSLog(@"请求地址+传参---%@%@\n%@",RequestUrl,url,parmater);
        [self.sessionManager POST:url parameters:parmater headers:@{header:@"Authorization"} constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            [formData appendPartWithFileData:fileData name:fileName fileName:@"picture.png" mimeType:@"image/png"];
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:responseDict options:NSJSONWritingPrettyPrinted error:nil];
            NSString *Json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            successblock(responseDict);
            if (isCloseHUD == YES) {
                [SVProgressHUD dismiss];
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            }
            NSLog(@"网络请求返回数据---%@",Json);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            failureBlock(error);
            if (isCloseHUD == YES) {
                [SVProgressHUD dismiss];
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            }
            NSHTTPURLResponse *resoinse = (NSHTTPURLResponse *)task.response;
            NSString *codeStr = [NSString stringWithFormat:@"%ld - %@",(long)resoinse.statusCode,[error.userInfo objectForKey:@"NSLocalizedDescription"]];
            [[UIViewController ViewController] showAlertWithTitle:EmptyTitle message:codeStr appearanceProcess:^(AlertController * _Nonnull alertMaker) {
                alertMaker.toastStyleDuration = 2;
            } actionsBlock:NULL];
        }];
    }else{
        [[UIViewController ViewController] showAlertWithTitle:EmptyTitle message:MessageTiele appearanceProcess:^(AlertController * _Nonnull alertMaker) {
            alertMaker.toastStyleDuration = 2;
        } actionsBlock:NULL];
    }
}

/**
 *  @brief                                         网络请求 Delete
 *  @param url                                     传入的url(NSString)
 *  @param parmater                                传入的参数(id)
 *  @param header                                  请求头参数(id)
 *  @param successblock                            请求获取数据成功
 *  @param failureBlock                            请求数据获取失败
 */
- (void)deleteRequestWithHTTPUrl:(NSString *)url parmater:(id)parmater headerRequest:(id)header isOpenHUD:(BOOL)isOpenHUD isCloseHUD:(BOOL)isCloseHUD SuccessBlock:(void (^)(id responseDict))successblock FailureBlock:(void (^)(NSError *error))failureBlock {
    
    if (self.isNetWorkConnectionAvailable) {
        [self.sessionManager.requestSerializer setValue:header forHTTPHeaderField:@"Authorization"];
        if (isOpenHUD == YES) {
            [SVProgressHUD showWithStatus:@"加载中..."];
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
            [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
            [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        }
        NSLog(@"请求地址+传参---%@%@\n%@",RequestUrl,url,parmater);
        [self.sessionManager DELETE:url parameters:parmater headers:@{header:@"Authorization"} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:responseDict options:NSJSONWritingPrettyPrinted error:nil];
            NSString *Json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            successblock(responseDict);
            if (isCloseHUD == YES) {
                [SVProgressHUD dismiss];
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            }
            NSLog(@"网络请求返回数据---%@",Json);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            failureBlock(error);
            if (isCloseHUD == YES) {
                [SVProgressHUD dismiss];
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            }
            NSHTTPURLResponse *resoinse = (NSHTTPURLResponse *)task.response;
            NSString *codeStr = [NSString stringWithFormat:@"%ld - %@",(long)resoinse.statusCode,[error.userInfo objectForKey:@"NSLocalizedDescription"]];
            [[UIViewController ViewController] showAlertWithTitle:EmptyTitle message:codeStr appearanceProcess:^(AlertController * _Nonnull alertMaker) {
                alertMaker.toastStyleDuration = 2;
            } actionsBlock:NULL];
        }];
    }else{
        [[UIViewController ViewController] showAlertWithTitle:EmptyTitle message:MessageTiele appearanceProcess:^(AlertController * _Nonnull alertMaker) {
            alertMaker.toastStyleDuration = 2;
        } actionsBlock:NULL];
    }
}

/**
 *  @brief                                         网络请求 Post (Json参数上传)
 *  @param url                                     传入的url(NSString)
 *  @param parmater                                传入的参数(id,必须是json格式)
 *  @param header                                  请求头参数(id)
 *  @param successblock                            请求获取数据成功
 *  @param failureBlock                            请求数据获取失败
 */
- (void)postRequestJsonWithUrl:(NSString *)url parmater:(id)parmater headerRequest:(id)header isOpenHUD:(BOOL)isOpenHUD isCloseHUD:(BOOL)isCloseHUD SuccessBlock:(void (^)(id responseDict))successblock FailureBlock:(void (^)(NSError *error))failureBlock {
    
    if (self.isNetWorkConnectionAvailable) {
        [self.sessionManager.requestSerializer setValue:header forHTTPHeaderField:@"Authorization"];
        if (isOpenHUD == YES) {
            [SVProgressHUD showWithStatus:@"加载中..."];
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
            [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
            [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        }
        NSLog(@"请求地址+传参---%@%@\n%@",RequestUrl,url,parmater);
        NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:url parameters:nil error:nil];
        [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        NSData *body = [parmater dataUsingEncoding:NSUTF8StringEncoding];
        [request setHTTPBody:body];
        [self.sessionManager dataTaskWithRequest:request uploadProgress:^(NSProgress * _Nonnull uploadProgress) {
            
        } downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
            
        } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
            if (!error) {
                NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
                successblock(responseDict);
                if (isCloseHUD == YES) {
                    [SVProgressHUD dismiss];
                    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                }
                NSLog(@"网络请求返回数据---%@",responseDict);
            }else{
                failureBlock(error);
                if (isCloseHUD == YES) {
                    [SVProgressHUD dismiss];
                    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                }
            }
        }];
    }else{
        [[UIViewController ViewController] showAlertWithTitle:EmptyTitle message:MessageTiele appearanceProcess:^(AlertController * _Nonnull alertMaker) {
            alertMaker.toastStyleDuration = 2;
        } actionsBlock:NULL];
    }
}

@end
