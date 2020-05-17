//
//  AuthID.h
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/4/16.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import <LocalAuthentication/LocalAuthentication.h>

/**
 *  TouchID/FaceID 状态
 */
typedef NS_ENUM(NSUInteger, AuthIDState){
    
    /**
     *  当前设备不支持TouchID/FaceID
     */
    AuthIDStateNotSupport = 0,
    /**
     *  TouchID/FaceID 验证成功
     */
    AuthIDStateSuccess = 1,
    
    /**
     *  TouchID/FaceID 验证失败
     */
    AuthIDStateFail = 2,
    /**
     *  TouchID/FaceID 被用户手动取消
     */
    AuthIDStateUserCancel = 3,
    /**
     *  用户不使用TouchID/FaceID,选择手动输入密码
     */
    AuthIDStateInputPassword = 4,
    /**
     *  TouchID/FaceID 被系统取消 (如遇到来电,锁屏,按了Home键等)
     */
    AuthIDStateSystemCancel = 5,
    /**
     *  TouchID/FaceID 无法启动,因为用户没有设置密码
     */
    AuthIDStatePasswordNotSet = 6,
    /**
     *  TouchID/FaceID 无法启动,因为用户没有设置TouchID/FaceID
     */
    AuthIDStateTouchIDNotSet = 7,
    /**
     *  TouchID/FaceID 无效
     */
    AuthIDStateTouchIDNotAvailable = 8,
    /**
     *  TouchID/FaceID 被锁定(连续多次验证TouchID/FaceID失败,系统需要用户手动输入密码)
     */
    AuthIDStateTouchIDLockout = 9,
    /**
     *  当前软件被挂起并取消了授权 (如App进入了后台等)
     */
    AuthIDStateAppCancel = 10,
    /**
     *  当前软件被挂起并取消了授权 (LAContext对象无效)
     */
    AuthIDStateInvalidContext = 11,
    /**
     *  系统版本不支持TouchID/FaceID (必须高于iOS 8.0才能使用)
     */
    AuthIDStateVersionNotSupport = 12
};


@interface AuthID : LAContext

typedef void (^AuthIDStateBlock)(AuthIDState state, NSError *error);

/**
 * 启动TouchID/FaceID进行验证
 * @param describe TouchID/FaceID显示的描述
 * @param block 回调状态的block
 */
- (void)showAuthIDWithDescribe:(NSString *)describe block:(AuthIDStateBlock)block;

@end
