//
//  LSPhotoBrowserImageView.m
//  GenericProject
//
//  Created by 社科赛斯 on 2019/12/17.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import "LSPhotoBrowserImageView.h"
#import "LSProgressHUD.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/SDImageCache.h>

@interface LSPhotoBrowserImageView ()<UIScrollViewDelegate>
{
    NSURL         *_url;
    UIImage       *_placeHolder;
}

@end

@implementation LSPhotoBrowserImageView

- (FLAnimatedImageView *)imageView {
    if (!_imageView) {
        _imageView = [[FLAnimatedImageView alloc] init];
        [_imageView setUserInteractionEnabled:true];
        [_imageView setFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        _imageView.layer.cornerRadius = 0.1;
        _imageView.clipsToBounds = true;
    }
    return _imageView;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        [_scrollView setFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        [_scrollView addSubview:self.imageView];
        [_scrollView setDelegate:self];
        [_scrollView setClipsToBounds:true];
    }
    return _scrollView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.scrollView];
        [self initDefaultData];
        if (@available(iOS 11.0, *)){
            _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return self;
}

- (void)initDefaultData {
    // 1.tap && doubleTap && longpress
    UITapGestureRecognizer *tap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(scrollViewDidTap)];
    
    UITapGestureRecognizer *doubleTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(scrollViewDidDoubleTap:)];
    
    UILongPressGestureRecognizer *longPress =
    [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                  action:@selector(longPressDidPress:)];
    
    // 2.set gesture require
    [tap setNumberOfTapsRequired:1];
    [tap setNumberOfTouchesRequired:1];
    [doubleTap setNumberOfTapsRequired:2];
    [doubleTap setNumberOfTouchesRequired:1];
    
    // 3.conflict resolution
    [tap requireGestureRecognizerToFail:doubleTap];
    
    // 4.add gesture
    [self addGestureRecognizer:tap];
    [self addGestureRecognizer:doubleTap];
    [self addGestureRecognizer:longPress];
}

#pragma mark - 单击
- (void)scrollViewDidTap {
    if(_singleTap){
        _singleTap();
    }
}

#pragma mark - 长按
- (void)longPressDidPress:(UILongPressGestureRecognizer *)longPress {
    if(longPress.state == UIGestureRecognizerStateBegan){
        if(_longPressTap){
            _longPressTap();
        }
    }
}

#pragma mark - 双击
- (void)scrollViewDidDoubleTap:(UITapGestureRecognizer *)doubleTap {
    // if image is download, if not ,just return;
    if(!_imageView.image) return;
    
    if(_scrollView.zoomScale <= 1){
        // 1.catch the postion of the gesture
        // 2.contentOffset.x of scrollView  + location x of gesture
        CGFloat x = [doubleTap locationInView:self].x + _scrollView.contentOffset.x;
        
        // 3.contentOffset.y + location y of gesture
        CGFloat y = [doubleTap locationInView:self].y + _scrollView.contentOffset.y;
        [_scrollView zoomToRect:(CGRect){{x,y},CGSizeZero} animated:true];
    }else{
        // set scrollView zoom to original
        [_scrollView setZoomScale:1.f animated:true];
    }
}

- (void)sd_ImageWithUrl:(NSURL *)url progressHUD:(LSProgressHUD *)progressHUD placeHolder:(UIImage *)placeHolder {
    [progressHUD setHidden:true];
    
    _url         = url;
    _placeHolder = placeHolder;
    
    if(!url){
        if([placeHolder images] != nil){
            FLAnimatedImage *animatedImg = [FLAnimatedImage animatedImageWithGIFData:UIImagePNGRepresentation(placeHolder)];
            _imageView.animatedImage = animatedImg;
        }else{
            [_imageView setImage:placeHolder];
        }
        [self layoutSubviews];
        return;
    }
    [progressHUD setHidden:false];
    __weak typeof(self) weakSelf = self;
    UIImage *image = [[SDImageCache sharedImageCache] imageFromCacheForKey:[url absoluteString]];
    if(image){
        [progressHUD setHidden:true];
    }
    
    // SDWebImage download image
    [_imageView sd_setImageWithURL:url placeholderImage:placeHolder options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        CGFloat progress = ((CGFloat)receivedSize / expectedSize);
        dispatch_async(dispatch_get_main_queue(), ^{
            if(progressHUD){
                progressHUD.progress = progress;
            }
        });
    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        [self->_scrollView setZoomScale:1.f animated:true];
        if(!error){
            [progressHUD setProgress:1.f];
            [weakSelf layoutSubviews];
        }else{
            [progressHUD setHidden:true];
        }
    }];
    
    [self layoutSubviews];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _scrollView.frame = CGRectMake(10, 0, self.width - 20, self.height);
    [self reloadFrames];
}

- (void)reloadFrames {
    CGRect frame = _scrollView.frame;
    if(_imageView.image){
        
        CGSize imageSize = _imageView.image.size;
        CGRect imageFrame = CGRectMake(0, 0, imageSize.width, imageSize.height);
        if (frame.size.width <= frame.size.height) { // if scrollView.width <= height
            // let width of the image set as width of scrollView, height become radio
            CGFloat ratio = frame.size.width / imageFrame.size.width;
            imageFrame.size.height = imageFrame.size.height * ratio;
            imageFrame.size.width = frame.size.width;
        }else{
            // let width of the image set as width of scrollView, height become radio
            CGFloat ratio = frame.size.height / imageFrame.size.height;
            imageFrame.size.width = imageFrame.size.width*ratio;
            imageFrame.size.height = frame.size.height;
        }
        
        [_imageView setFrame:(CGRect){CGPointZero,imageFrame.size}];
        
        // set scrollView contentsize
        _scrollView.contentSize = _imageView.frame.size;
        
        // set scrollView.contentsize as image.size , and get center of the image
        _imageView.center = [self centerOfScrollViewContent:_scrollView];
        // get the radio of scrollView.height and image.height
        CGFloat maxScale = frame.size.height / imageFrame.size.height;
        // get radio of the width
        CGFloat widthRadit = frame.size.width / imageFrame.size.width;
        
        // get the max radio
        maxScale = widthRadit > maxScale?widthRadit:maxScale;
        // if the max radio >= PhotoBrowerImageMaxScale, get max radio , else PhotoBrowerImageMaxScale
        maxScale = maxScale > 2.f?maxScale:2.f;
        
        // set max and min radio of scrollView
        _scrollView.minimumZoomScale = 1.f;
        _scrollView.maximumZoomScale = maxScale;
        
        // set scrollView zoom original
        _scrollView.zoomScale = 1.0f;
        
    }else{
        frame.origin = CGPointZero;
        _imageView.frame = frame;
        _scrollView.contentSize = _imageView.size;
    }
    _scrollView.contentOffset = CGPointZero;
}

- (CGPoint)centerOfScrollViewContent:(UIScrollView *)scrollView {
    // scrollView.bounds.size.width > scrollView.contentSize.width :that means scrollView.size > image.size
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?
    (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
    
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?
    (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
    
    CGPoint actualCenter = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,
                                       scrollView.contentSize.height * 0.5 + offsetY);
    return actualCenter;
}

#pragma mark UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    // zoom the subviews of the scrollView
    return self.imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    // reset the center of image when dragging everytime
    _imageView.center = [self centerOfScrollViewContent:scrollView];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
