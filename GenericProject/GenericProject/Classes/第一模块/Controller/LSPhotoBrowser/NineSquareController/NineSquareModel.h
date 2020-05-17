//
//  NineSquareModel.h
//  GenericProject
//
//  Created by 社科赛斯 on 2019/12/17.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NineSquareUrlModel : NSObject

// 为 网络图片
@property (nonatomic, copy  ) NSString *url;

// 为 本地图片
@property (nonatomic, strong) UIImage *img;

@end

@interface NineSquareModel : NSObject

@property (nonatomic, copy  ) NSString *title;

// 存放 上面的那个model
@property (nonatomic, strong) NSMutableArray *urlArr;

@end

NS_ASSUME_NONNULL_END
