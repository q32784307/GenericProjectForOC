//
//  LSAvatarBrowser.h
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/12/6.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSAvatarBrowser : NSObject

/**
 *    @brief    浏览头像
 *
 *    @param     avatarImageView     头像所在的imageView
 */
+ (void)showImage:(UIImageView *)avatarImageView;

@end

NS_ASSUME_NONNULL_END
