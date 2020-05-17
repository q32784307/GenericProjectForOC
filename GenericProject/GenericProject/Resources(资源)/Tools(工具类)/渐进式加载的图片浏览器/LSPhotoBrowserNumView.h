//
//  LSPhotoBrowserNumView.h
//  GenericProject
//
//  Created by 社科赛斯 on 2019/12/17.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSPhotoBrowserNumView : UILabel

- (void)setCurrentNum:(NSInteger)currentNum totalNum:(NSInteger)totalNum;

@property(nonatomic,assign)NSInteger currentNum;
@property(nonatomic,assign)NSInteger totalNum;

@end

NS_ASSUME_NONNULL_END
