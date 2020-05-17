//
//  LSPhotoDownloadMgr.m
//  GenericProject
//
//  Created by 社科赛斯 on 2019/12/17.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import "LSPhotoDownloadMgr.h"

@interface LSPhotoDownloadMgr()
{
    NSURLSessionDownloadTask *_downloadTask;
}

@property(nonatomic,copy)PhotoDownLoadBlock downloadBlock;
@property(nonatomic,strong)LSPhotoItems *item;

@end

@implementation LSPhotoDownloadMgr

- (void)downloadVideoWithItems:(LSPhotoItems *)item downloadBlock:(PhotoDownLoadBlock)downloadBlock {
    _item = item;
    _downloadBlock = downloadBlock;
    
    if (item.isVideo == true) {
        NSURL *url = [NSURL URLWithString:item.url];
        if ([url.scheme containsString:@"http"]) {
            [self startDownLoadWithURL:url.absoluteString];
        }else {
            [self saveLocationVideo:url.path];
        }
    }else {
        _downloadBlock(LSPhotoDownloadStateUnknow,0.0);
    }
}

- (void)startDownLoadWithURL:(NSString *)videoURL {
    if (_item.downloadState == LSPhotoDownloadStateDownloading) {
        _item.downloadState = LSPhotoDownloadStateDownloading;
        return;
    }
    
    _item.downloadState = LSPhotoDownloadStateDownloading;
    _item.downloadProgress = 0.0;
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    _downloadTask = [session downloadTaskWithURL:[NSURL URLWithString:_item.url]];
    [_downloadTask resume];
}

#pragma mark - NSURLSession Delegate --> NSURLSessionTaskDelegate
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    CGFloat progress = totalBytesWritten / totalBytesExpectedToWrite;
    if (progress < 0) progress = 0;
    if (progress > 1) progress = 1;
    _item.downloadProgress = progress;
    _item.downloadState = LSPhotoDownloadStateDownloading;
    if (_downloadBlock) {
        _downloadBlock(_item.downloadState,_item.downloadProgress);
    }
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(nullable NSError *)error {
    _item.downloadState = LSPhotoDownloadStateSuccess;
    _item.downloadProgress = 1.0;
    if (error) {
        _item.downloadState = LSPhotoDownloadStateFailure;
        _item.downloadProgress = 0.0;
    }
    
    if (_downloadBlock) {
        _downloadBlock(_item.downloadState,_item.downloadProgress);
    }
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location {
    NSString *cache = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *file = [cache stringByAppendingPathComponent:downloadTask.response.suggestedFilename];
    [[NSFileManager defaultManager] moveItemAtURL:location toURL:[NSURL fileURLWithPath:file] error:nil];
    if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(file)) {
        UISaveVideoAtPathToSavedPhotosAlbum(file, self, @selector(video:didFinishSavingWithError:contextInfo:), nil);
    } else {
        _item.downloadState = LSPhotoDownloadStateUnknow;
        if (_downloadBlock) {
            _downloadBlock(_item.downloadState,0.0);
        }
    }
}

- (void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (error) {
        _item.downloadState = LSPhotoDownloadStateFailure;
        if (_downloadBlock) {
            _downloadBlock(_item.downloadState,0.0);
        }
    } else {
        _item.downloadState = LSPhotoDownloadStateSuccess;
        if (_downloadBlock) {
            _downloadBlock(_item.downloadState,1.0);
        }
    }
}

#pragma mark - location video is going to save
- (void)saveLocationVideo:(NSString *)path {
    if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(path)) {
        UISaveVideoAtPathToSavedPhotosAlbum(path, self, @selector(video:didFinishSavingWithError:contextInfo:), nil);
    } else {
        _item.downloadState = LSPhotoDownloadStateUnknow;
        if (_downloadBlock) {
            _downloadBlock(_item.downloadState,0.0);
        }
    }
}


@end
