//
//  LSPhotoActionSheetView.h
//  GenericProject
//
//  Created by 社科赛斯 on 2019/12/17.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol LSPhotoActionSheetViewDelegate <NSObject>

- (void)actionSheetViewIBAction:(NSInteger)index;

@end

@interface LSPhotoActionSheetView : UIView

@property(nonatomic,weak)id<LSPhotoActionSheetViewDelegate> delegate;

/*
 * title
 */
@property(nonatomic,copy)NSString *title;

/*
 * is destruct
 */
@property(nonatomic,assign)BOOL isDestructive;

@end

NS_ASSUME_NONNULL_END
