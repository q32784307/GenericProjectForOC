//
//  LSSuccessLoadingView.h
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/10/18.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import "LSBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface LSSuccessLoadingView : LSBaseView

@property (nonatomic,copy) void (^LSSuccessLoadEnd)(void);

- (void)beginAnimating;

- (void)stopAnimating;

@end

NS_ASSUME_NONNULL_END
