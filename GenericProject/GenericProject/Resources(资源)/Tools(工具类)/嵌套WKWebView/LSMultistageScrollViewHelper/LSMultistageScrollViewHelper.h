//
//  LSMultistageScrollViewHelper.h
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/11/26.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
   对联动事件进行处理
*/
@interface LSMultistageScrollViewHelper : NSObject

@property(nonatomic,readonly)UIScrollView *baseScrollView;
@property(nonatomic,readonly)UIScrollView *subScrollView;

/**
 绑定需要联动的两个scrollView
 一定要在他们开始滚动之前，否者我也不知道有啥bug。——。——

 @param baseScrollView 下方scrollView
 @param subScrollView 上方scrollView
 @return helper需要被持有，不然就释放了
 */
- (instancetype)initWithBaseScrollView:(UIScrollView *)baseScrollView subScrollView:(UIScrollView *)subScrollView;

@end

NS_ASSUME_NONNULL_END
