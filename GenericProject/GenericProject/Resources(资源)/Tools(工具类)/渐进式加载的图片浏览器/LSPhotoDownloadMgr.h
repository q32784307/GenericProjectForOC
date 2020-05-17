//
//  LSPhotoDownloadMgr.h
//  GenericProject
//
//  Created by 社科赛斯 on 2019/12/17.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LSPhotoBrowser.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^PhotoDownLoadBlock)(LSPhotoDownloadState downloadState ,float prgress);

@interface LSPhotoDownloadMgr : NSObject <NSURLSessionDelegate>

/**
 download video
 
 @param item current item
 @param downloadBlock block
 */
- (void)downloadVideoWithItems:(LSPhotoItems *)item downloadBlock:(PhotoDownLoadBlock)downloadBlock;

@end

NS_ASSUME_NONNULL_END
