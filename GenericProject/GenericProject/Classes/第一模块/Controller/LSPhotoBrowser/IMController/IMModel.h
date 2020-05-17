//
//  IMModel.h
//  GenericProject
//
//  Created by 社科赛斯 on 2019/12/17.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface IMModel : NSObject

@property (nonatomic,copy  ) NSString *url;
@property (nonatomic,strong) UIImage *locImage;
@property (nonatomic,assign) BOOL isLeft;
@property (nonatomic,assign) BOOL isVideo;

// width / height
@property (nonatomic,assign) CGFloat rate;

@property (nonatomic,assign) CGFloat  cellHeight;

@end

NS_ASSUME_NONNULL_END
