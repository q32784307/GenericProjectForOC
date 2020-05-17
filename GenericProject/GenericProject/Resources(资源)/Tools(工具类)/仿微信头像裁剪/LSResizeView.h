//
//  LSResizeView.h
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/12/10.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class LSResizeView;

@protocol LSDResizeConrolViewDelegate <NSObject>

@optional

- (void)lsdOptionalResizeConrolViewDidBeginResizing:(LSResizeView *)resizeConrolView;
- (void)lsdOptionalResizeConrolViewDidResize:(LSResizeView *)resizeConrolView;
- (void)lsdOptionalResizeConrolViewDidEndResizing:(LSResizeView *)resizeConrolView;

@end

@interface LSResizeView : UIView

@property(nonatomic,weak)id<LSDResizeConrolViewDelegate> delegate;
@property(nonatomic,assign,readonly)CGPoint translation;

@end

NS_ASSUME_NONNULL_END
