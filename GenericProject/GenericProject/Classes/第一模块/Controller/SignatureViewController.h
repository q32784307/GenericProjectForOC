//
//  SignatureViewController.h
//  GenericProject
//
//  Created by 社科赛斯 on 2020/5/29.
//  Copyright © 2020 漠然丶情到深处. All rights reserved.
//

#import "LSBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SignatureViewController : LSBaseViewController

@property(nonatomic,copy)void(^signResult)(UIImage *signImage);

@end

NS_ASSUME_NONNULL_END
