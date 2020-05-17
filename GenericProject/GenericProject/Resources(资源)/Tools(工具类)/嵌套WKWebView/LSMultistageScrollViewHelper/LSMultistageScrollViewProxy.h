//
//  LSMultistageScrollViewProxy.h
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/11/26.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSMultistageScrollViewProxy : NSProxy<UIScrollViewDelegate>

@property(nonatomic,weak)id scrollViewDelegate;
@property(nonatomic,weak)id helperTarget;

- (void)configWithScrollView:(UIScrollView *)scrollView;

@end

NS_ASSUME_NONNULL_END
