//
//  LSProgressHUD.h
//  GenericProject
//
//  Created by 社科赛斯 on 2019/12/17.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSProgressHUD : UIView

/**
 * load main color
 */
@property(nonatomic,strong)UIColor *HUDColor;

/**
 * color of sector , Default is White
 */
@property(nonatomic,strong)UIColor *sectorColor;

/**
 * color of section's layer, Default is white
 */
@property(nonatomic,strong)UIColor *sectorBoldColor;

/**
 * progress, range is from 0 to 1
 */
@property(nonatomic,assign)CGFloat progress;

@end

NS_ASSUME_NONNULL_END
