//
//  LSKeyboardHelperView.h
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/10/18.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import "LSBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface LSKeyboardHelperView : LSBaseView

+ (instancetype)createHelerViewWithFrame:(CGRect)frame keyboardDismiss:(void(^)(void))dismiss;

@end

NS_ASSUME_NONNULL_END
