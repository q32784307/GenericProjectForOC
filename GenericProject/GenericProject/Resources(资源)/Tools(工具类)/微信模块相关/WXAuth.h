//
//  WXAuth.h
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/7/25.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define  WXAUTH [WXAuth sharedInstance]

@interface WXAuth : NSObject

@property(nonatomic,strong)void (^onRespBlock)(NSString *code);
@property(nonatomic,strong)void (^onPaySuccessBlock)(void);
@property(nonatomic,strong)void (^onPayFailBlock)(int codeType);

//全局管理对象
+ (WXAuth *)sharedInstance;

- (BOOL)handleOpenURL:(NSURL *)url;

- (void)sendWXAuthReq;

@end

NS_ASSUME_NONNULL_END
