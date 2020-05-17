//
//  LSBaseView.h
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/10/18.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSUIHeader.h"

NS_ASSUME_NONNULL_BEGIN

@interface LSBaseView : UIView

- (void)ls_addSubviews;

- (void)ls_addConstraints;

@end

NS_ASSUME_NONNULL_END
