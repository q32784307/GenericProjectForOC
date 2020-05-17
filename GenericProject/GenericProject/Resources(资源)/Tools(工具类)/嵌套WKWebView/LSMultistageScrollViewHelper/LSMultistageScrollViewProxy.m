//
//  LSMultistageScrollViewProxy.m
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/11/26.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import "LSMultistageScrollViewProxy.h"

@implementation LSMultistageScrollViewProxy

- (void)configWithScrollView:(UIScrollView *)scrollView {
    self.scrollViewDelegate = scrollView.delegate;
    scrollView.delegate = self;
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    BOOL res = [self.scrollViewDelegate respondsToSelector:aSelector] ||[self.helperTarget respondsToSelector:aSelector];
    return res ;
}


//下面三个方法，转发给helper，如果原有target也实现了，顺手转发一下
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([self.scrollViewDelegate respondsToSelector:@selector(scrollViewDidScroll:)]) {
        [self.scrollViewDelegate scrollViewDidScroll:scrollView];
    }
    if ([self.helperTarget respondsToSelector:@selector(scrollViewDidScroll:)]) {
        [self.helperTarget scrollViewDidScroll:scrollView];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView*)scrollView willDecelerate:(BOOL)decelerate {
    if ([self.scrollViewDelegate respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)]) {
        [self.scrollViewDelegate scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    }
    if ([self.helperTarget respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)]) {
        [self.helperTarget scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView*)scrollView {
    if ([self.scrollViewDelegate respondsToSelector:@selector(scrollViewDidEndDecelerating:)]) {
        [self.scrollViewDelegate scrollViewDidEndDecelerating:scrollView];
    }
    if ([self.helperTarget respondsToSelector:@selector(scrollViewDidEndDecelerating:)]) {
        [self.helperTarget scrollViewDidEndDecelerating:scrollView];
    }
}

//对于本类未实现的方法，转发给原有代理
- (id)forwardingTargetForSelector:(SEL)aSelector {
    return self.scrollViewDelegate;
}

@end
