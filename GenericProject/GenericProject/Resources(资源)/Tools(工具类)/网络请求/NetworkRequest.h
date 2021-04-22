//
//  NetworkRequest.h
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2018/5/17.
//  Copyright © 2018年 漠然丶情到深处. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkRequest : NSObject

+ (instancetype)sharedInstance;

#pragma mark - 网络检测
- (BOOL)isNetWorkConnectionAvailable;


/**
 *  @brief                                        网络请求 Get
 *  @param url                                    传入的url(NSString)
 *  @param header                                 请求头参数(id)
 *  @param successblock                           请求获取数据成功
 *  @param failureBlock                           请求获取数据失败
 */
- (void)getRequestWithHTTPUrl:(NSString *)url parmater:(id)parmater headerRequest:(id)header isOpenHUD:(BOOL)isOpenHUD isCloseHUD:(BOOL)isCloseHUD SuccessBlock:(void (^)(id responseDict))successblock FailureBlock:(void (^)(NSError *error))failureBlock;

/**
 *  @brief                                        网络请求 Put
 *  @param url                                    传入的url(NSString)
 *  @param parmater                               传入的参数(id)
 *  @param header                                 请求头参数(id)
 *  @param successblock                           请求获取数据成功
 *  @param failureBlock                           请求获取数据失败
 */
- (void)putRequestWithHTTPUrl:(NSString *)url parmater:(id)parmater headerRequest:(id)header isOpenHUD:(BOOL)isOpenHUD isCloseHUD:(BOOL)isCloseHUD SuccessBlock:(void (^)(id responseDict))successblock FailureBlock:(void (^)(NSError *error))failureBlock;

/**
 * @brief                                         网络请求 Post
 * @param url                                     传入的url(NSString)
 * @param parmater                                传入的参数(id)
 * @param header                                  请求头参数(id)
 * @param successblock                            请求获取数据成功
 * @param failureBlock                            请求获取数据失败
 */
- (void)postRequestWithHTTPUrl:(NSString *)url parmater:(id)parmater headerRequest:(id)header isOpenHUD:(BOOL)isOpenHUD isCloseHUD:(BOOL)isCloseHUD SuccessBlock:(void (^)(id responseDict))successblock FailureBlock:(void (^)(NSError *error))failureBlock;

/**
 *  @brief                                         网络请求 Post (单图片上传)
 *  @param url                                     传入的url(NSString)
 *  @param parmater                                传入的参数(id)
 *  @param header                                  请求头参数(id)
 *  @param fileData                                传入图片的数据流(NSData)
 *  @param fileName                                传入图片的名字(NSString  与后台一致)
 *  @param successblock                            请求获取数据成功
 *  @param failureBlock                            请求获取数据失败
 */
- (void)postRequestWithHTTPImageUploadRequestWithUrl:(NSString *)url parmater:(id)parmater headerRequest:(id)header isOpenHUD:(BOOL)isOpenHUD isCloseHUD:(BOOL)isCloseHUD fileData:(NSData *)fileData fileName:(NSString *)fileName SuccessBlock:(void (^)(id responseDict))successblock FailureBlock:(void (^)(NSError *error))failureBlock;

/**
 *  @brief                                         网络请求 Delete
 *  @param url                                     传入的url(NSString)
 *  @param parmater                                传入的参数(id)
 *  @param header                                  请求头参数(id)
 *  @param successblock                            请求获取数据成功
 *  @param failureBlock                            请求数据获取失败
 */
- (void)deleteRequestWithHTTPUrl:(NSString *)url parmater:(id)parmater headerRequest:(id)header isOpenHUD:(BOOL)isOpenHUD isCloseHUD:(BOOL)isCloseHUD SuccessBlock:(void (^)(id responseDict))successblock FailureBlock:(void (^)(NSError *error))failureBlock;

#pragma mark - Post Json参数上传
/**
 *  @brief                                         网络请求 Post (Json参数上传)
 *  @param url                                     传入的url(NSString)
 *  @param parmater                                传入的参数(id)
 *  @param header                                  请求头参数(id)
 *  @param successblock                            请求获取数据成功
 *  @param failureBlock                            请求数据获取失败
 */
- (void)postRequestJsonWithUrl:(NSString *)url parmater:(id)parmater headerRequest:(id)header isOpenHUD:(BOOL)isOpenHUD isCloseHUD:(BOOL)isCloseHUD SuccessBlock:(void (^)(id responseDict))successblock FailureBlock:(void (^)(NSError *error))failureBlock;

/**
 *  @brief                      断点续传(开始下载)
 */
- (void)downloadStartWithHTTPUrl:(NSString *)url headerRequest:(id)header fileName:(NSString *)fileName progress:(void (^)(CGFloat progressFloat))progress SuccessBlock:(void (^)(id responseDict, NSString *filePathSite))successblock FailureBlock:(void (^)(NSError *error))failureBlock;

/**
 *  @brief                      断点续传(继续下载)
 */
- (void)downloadStartWithHTTPUrl:(NSString *)url headerRequest:(id)header resumeData:(NSData *)resumeData fileName:(NSString *)fileName progress:(void (^)(CGFloat progressFloat))progress SuccessBlock:(void (^)(id responseDict, NSString *filePathSite))successblock FailureBlock:(void (^)(NSError *error))failureBlock;

/**
 *  开始下载
 */
- (void)operationResume;

/**
 *  暂停下载
 */
- (void)operationPauseSuspendedBlock:(void (^)(NSData *resumeData))suspendedBlock;

- (void)releaseZipFilesWithUnzipFileAtPath:(NSString *)zipPath Destination:(NSString *)unzipPath;

@end
