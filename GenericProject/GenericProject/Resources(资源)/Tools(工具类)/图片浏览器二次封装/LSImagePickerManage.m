//
//  LSImagePickerManage.m
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/11/25.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import "LSImagePickerManage.h"
#import <CoreServices/UTCoreTypes.h>

@interface LSImagePickerManage()<UIActionSheetDelegate>
{
    NSMutableArray *_selectedPhotos;//图片数组
    NSMutableArray *_selectedAssets;//图片原图
    BOOL _isSelectOriginalPhoto;//是否选择原图
}

@property (nonatomic, strong) NSMutableArray *imagesURL;
@property (nonatomic, assign) NSInteger maxCount;
@property (nonatomic, weak) UIViewController *superViewController;
@property (nonatomic,assign)LSManageSelectTakeType selectType;//类型

@property (nonatomic, assign) CGFloat compressionQuality;
@property (strong, nonatomic) CLLocation *location;
@property (nonatomic, strong) UIImagePickerController *imgPickerVC;
@end

@implementation LSImagePickerManage

/**打开手机图片库
 
 @param maxCount 最大张数
 @param superController superController
 @param selectType selectType
 */
- (void)showImagePickerControllerWithMaxCount:(NSInteger )maxCount WithViewController:(UIViewController *)superController withSelectTakeType:(LSManageSelectTakeType )selectType withAssetsArr:(NSMutableArray *)CusSelectedAssets andPhotosArr:(NSMutableArray *)CusSelectedPhotos {
    self.maxCount = maxCount;
    self.superViewController = superController;
    self.selectType = selectType;
    _selectedPhotos = [NSMutableArray array];
    _selectedAssets = [NSMutableArray array];
    if (CusSelectedAssets.count>0) {
        _selectedAssets = CusSelectedAssets;
    }
    if (CusSelectedPhotos.count>0) {
        _selectedPhotos = CusSelectedPhotos;
    }
    
    
    if (selectType==LSManageSelectTakePhotoType||selectType==LSManageSelectTakeShootingVideoType) {
        //拍照 视频或图片
        [self takePhoto];
    }else if (selectType == LSManageSelectTakeVideoType || selectType ==LSManageSelectTakeImagePickerType){
        //选择手机图片或视频
        [self pushTZImagePickerController];
    }else{
        UIActionSheet_UIAlertController *a = [[UIActionSheet_UIAlertController alloc] initWithFrame:self.superViewController.view.bounds titleArr:@[@"从相册选择", @"拍照"]];
        a.Click = ^(NSInteger clickIndex) {
            switch (clickIndex) {
                case 0:
                    NSLog(@"从相册选择");
                    [self pushTZImagePickerController];
                    break;
                case 1:
                    NSLog(@"拍照");
                    [self takePhoto];
                    break;
                default:
                    break;
            }
            [a hiddenSheet];
        };
        [self.superViewController.view addSubview:a];
    }
}

/**
 选取手机图片
 */
- (void)pushTZImagePickerController {
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:self.maxCount delegate:self];
    
#pragma mark - 五类个性化设置，这些参数都可以不传，此时会走默认设置
    //imagePickerVc.isSelectOriginalPhoto = _isSelectOriginalPhoto;
    
    imagePickerVc.selectedAssets = _selectedAssets; // 目前已经选中的图片数组
//    imagePickerVc.allowTakePicture = NO; // 在内部显示拍照按钮
    if (self.selectType==LSManageSelectTakeVideoType) {
        //视频
        imagePickerVc.allowTakeVideo = YES;   // 在内部显示拍视频按钮
    }else{
        imagePickerVc.allowTakeVideo = NO;   // 在内部不显示拍视频按钮
    }
    if (self.selectType == LSManageSelectTakeImagePickerType) {
        imagePickerVc.allowTakePicture = YES;  // 在内部显示拍照按钮
    }else{
        imagePickerVc.allowTakePicture = NO;  // 在内部不显示拍照按钮
    }
    imagePickerVc.videoMaximumDuration = 15; // 视频最大拍摄时间
    [imagePickerVc setUiImagePickerControllerSettingBlock:^(UIImagePickerController *imagePickerController) {
        imagePickerController.videoQuality = UIImagePickerControllerQualityTypeHigh;
    }];
    

    imagePickerVc.iconThemeColor = [UIColor colorWithRed:31 / 255.0 green:185 / 255.0 blue:34 / 255.0 alpha:1.0];
    imagePickerVc.showPhotoCannotSelectLayer = YES;
    imagePickerVc.cannotSelectLayerColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
    [imagePickerVc setPhotoPickerPageUIConfigBlock:^(UICollectionView *collectionView, UIView *bottomToolBar, UIButton *previewButton, UIButton *originalPhotoButton, UILabel *originalPhotoLabel, UIButton *doneButton, UIImageView *numberImageView, UILabel *numberLabel, UIView *divideLine) {
        [doneButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }];

    
    // 3. Set allow picking video & photo & originalPhoto or not
    // 3. 设置是否可以选择视频/图片/原图
    if (self.selectType==LSManageSelectTakeImagePickerType) {
        //选择图片
        //是否可以选择视频
        imagePickerVc.allowPickingVideo = NO;
        //允许选择图片
        imagePickerVc.allowPickingImage = YES;
        //允许选择原图
        imagePickerVc.allowPickingOriginalPhoto = YES;
    }else if(self.selectType == LSManageSelectTakeVideoType){
        //是否可以选择视频
        imagePickerVc.allowPickingVideo = YES;
        //允许选择图片
        imagePickerVc.allowPickingImage = NO;
        //允许选择原图
        imagePickerVc.allowPickingOriginalPhoto = NO;
    }
    
    
    
    //允许选择gif
    imagePickerVc.allowPickingGif = NO;
    // 是否可以多选视频
    imagePickerVc.allowPickingMultipleVideo = NO; // 是否可以多选视频
    
    // 4. 照片排列按修改时间升序
    imagePickerVc.sortAscendingByModificationDate = NO;
    

    imagePickerVc.statusBarStyle = UIStatusBarStyleLightContent;
    
    // 设置是否显示图片序号
    imagePickerVc.showSelectedIndex = YES;

    // 你可以通过block或者代理，来得到用户选择的照片.
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        
    }];
    imagePickerVc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self.superViewController presentViewController:imagePickerVc animated:YES completion:nil];
}

/**
 拍照
 */
- (void)takePhoto{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) {
        // 无相机权限 做一个友好的提示
        [self.superViewController showAlertWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" appearanceProcess:^(AlertController * _Nonnull alertMaker) {
            alertMaker.
            addActionCancelTitle(@"取消").
            addActionDestructiveTitle(@"设置");
        } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, AlertController * _Nonnull alertSelf) {
            if (buttonIndex == 0) {
                NSLog(@"cancel");
            }else if (buttonIndex == 1) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
            }
            
        }];
    } else if (authStatus == AVAuthorizationStatusNotDetermined) {
        // fix issue 466, 防止用户首次拍照拒绝授权时相机页黑屏
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if (granted) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self takePhoto];
                });
            }
        }];
        // 拍照之前还需要检查相册权限
    } else if ([PHPhotoLibrary authorizationStatus] == 2) { // 已被拒绝，没有相册权限，将无法保存拍的照片
        [self.superViewController showAlertWithTitle:@"无法访问相册" message:@"请在iPhone的""设置-隐私-相册""中允许访问相册" appearanceProcess:^(AlertController * _Nonnull alertMaker) {
            alertMaker.
            addActionCancelTitle(@"取消").
            addActionDestructiveTitle(@"设置");
        } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, AlertController * _Nonnull alertSelf) {
            if (buttonIndex == 0) {
                NSLog(@"cancel");
            }else if (buttonIndex == 1) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
            }
            
        }];
    } else if ([PHPhotoLibrary authorizationStatus] == 0) { // 未请求过相册权限
        [[TZImageManager manager] requestAuthorizationWithCompletion:^{
            [self takePhoto];
        }];
    } else {
        //拍照或者拍视频
        [self pushvideoAndImagePickerController];
        
    }
}

// 调用相机
- (void)pushvideoAndImagePickerController {
    // 提前定位
    __weak typeof(self) weakSelf = self;
    [[TZLocationManager manager] startLocationWithSuccessBlock:^(NSArray<CLLocation *> *locations) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.location = [locations firstObject];
    } failureBlock:^(NSError *error) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.location = nil;
    }];
    
    
    UIImagePickerController *imagePickerVc = [[UIImagePickerController alloc] init];
    imagePickerVc.delegate = self;
    self.imgPickerVC = imagePickerVc;
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        imagePickerVc.sourceType = sourceType;
        NSMutableArray *mediaTypes = [NSMutableArray array];
        if (self.selectType==LSManageSelectTakeShootingVideoType) {//拍视频
            [mediaTypes addObject:(NSString *)kUTTypeMovie];
            imagePickerVc.videoMaximumDuration = 15; // 视频最大拍摄时间
        }
        if (self.selectType==LSManageSelectTakePhotoType) {//拍图片
            [mediaTypes addObject:(NSString *)kUTTypeImage];
            imagePickerVc.allowsEditing = YES;
            if ([[[UIDevice
                   currentDevice] systemVersion] floatValue] >= 8.0) {
                imagePickerVc.modalPresentationStyle=UIModalPresentationOverCurrentContext;
            }
        }
        if (mediaTypes.count) {
            imagePickerVc.mediaTypes = mediaTypes;
        }
        [self.superViewController presentViewController:imagePickerVc animated:YES completion:nil];
    } else {
        NSLog(@"模拟器中无法打开照相机,请在真机中使用");
    }
}

#pragma mark -- UIImagePickerControllerDelegate
//选择图片回调
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"如果这里有回调，请告诉我一下");
    if ([picker.mediaTypes containsObject:(NSString *)kUTTypeImage]){
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        // save photo and get asset / 保存图片，获取到asset
        [[TZImageManager manager] savePhotoWithImage:image location:self.location completion:^(PHAsset *asset, NSError *error){
            if (error) {
                NSLog(@"图片保存失败 %@",error);
            } else {
                TZAssetModel *assetModel = [[TZImageManager manager] createModelWithAsset:asset];
//                if (self.imagePickerVc.allowCrop == YES) { // 允许裁剪,去裁剪
//                    TZImagePickerController *imagePicker = [[TZImagePickerController alloc] initCropTypeWithAsset:assetModel.asset photo:image completion:^(UIImage *cropImage, id asset) {
//                        [self refreshCollectionViewWithAddedAsset:asset image:cropImage];
//                    }];
//                    imagePicker.allowPickingImage = NO;
//                    imagePicker.needCircleCrop = NO;
//                    imagePicker.circleCropRadius = 100;
//                    [self.superViewController presentViewController:imagePicker animated:YES completion:nil];
//                } else {
                    [self refreshCollectionViewWithAddedAsset:assetModel.asset image:image];
//                }
            }
        }];
        
    }else if([picker.mediaTypes containsObject:(NSString *)kUTTypeMovie]){
        //视频
        NSURL *videoUrl = [info objectForKey:UIImagePickerControllerMediaURL];
        if (videoUrl) {
            [[TZImageManager manager] saveVideoWithUrl:videoUrl location:self.location completion:^(PHAsset *asset, NSError *error) {
                if (!error) {
                    TZAssetModel *assetModel = [[TZImageManager manager] createModelWithAsset:asset];
                    [[TZImageManager manager] getPhotoWithAsset:assetModel.asset completion:^(UIImage *photo, NSDictionary *info, BOOL isDegraded) {
                        if (!isDegraded && photo) {
                            [self refreshCollectionViewWithAddedAsset:assetModel.asset image:photo];
                        }
                    }];
                }
            }];
        }
    }
}

- (void)refreshCollectionViewWithAddedAsset:(PHAsset *)asset image:(UIImage *)image {
    [_selectedAssets addObject:asset];
    [_selectedPhotos addObject:image];
    
    NSData *data = [[NSData alloc]init];
    if (_delegate&&[_delegate respondsToSelector:@selector(selectTZImagePickerSelectedPhotos:withSelectedAssets:andIsOriginalPoto: andBlockData: outPutPath: withSelectTakeType:)]) {
        [_delegate selectTZImagePickerSelectedPhotos:_selectedPhotos withSelectedAssets:_selectedAssets andIsOriginalPoto:NO andBlockData:data outPutPath:@"" withSelectTakeType:self.selectType];
    }
    
    if ([asset isKindOfClass:[PHAsset class]]) {
        PHAsset *phAsset = asset;
        NSLog(@"location:%@",phAsset.location);
        __weak typeof(self) weakSelf = self;
        [[TZImageManager manager] getVideoOutputPathWithAsset:asset presetName:AVAssetExportPreset640x480 success:^(NSString *outputPath) {
            NSData *data = [NSData dataWithContentsOfFile:outputPath];
            NSLog(@"视频导出到本地完成,沙盒路径为:%@",outputPath);
            // Export completed, send video here, send by outputPath or NSData
            // 导出完成，在这里写上传代码，通过路径或者通过NSData上传
            //拿到data 开始回调
            [weakSelf requestDataBlock:data andOutPutPath:outputPath];
        } failure:^(NSString *errorMessage, NSError *error) {
            NSLog(@"视频导出失败:%@,error:%@",errorMessage, error);
        }];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [self.superViewController dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - TZImagePickerControllerDelegate
/// User click cancel button
/// 用户点击了取消
- (void)tz_imagePickerControllerDidCancel:(TZImagePickerController *)picker {
    // NSLog(@"cancel");
}

// 这个照片选择器会自己dismiss，当选择器dismiss的时候，会执行下面的代理方法
// 你也可以设置autoDismiss属性为NO，选择器就不会自己dismis了
// 如果isSelectOriginalPhoto为YES，表明用户选择了原图
// 你可以通过一个asset获得原图，通过这个方法：[[TZImageManager manager] getOriginalPhotoWithAsset:completion:]
// photos数组里的UIImage对象，默认是828像素宽，你可以通过设置photoWidth属性的值来改变它
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {
    //返回图片处理
    _selectedPhotos = [NSMutableArray arrayWithArray:photos];
    _selectedAssets = [NSMutableArray arrayWithArray:assets];
    _isSelectOriginalPhoto = isSelectOriginalPhoto;
    NSData *data = [[NSData alloc]init];
    if (_delegate&&[_delegate respondsToSelector:@selector(selectTZImagePickerSelectedPhotos:withSelectedAssets:andIsOriginalPoto: andBlockData: outPutPath: withSelectTakeType:)]) {
        [_delegate selectTZImagePickerSelectedPhotos:_selectedPhotos withSelectedAssets:_selectedAssets andIsOriginalPoto:isSelectOriginalPhoto andBlockData:data outPutPath:@"" withSelectTakeType:self.selectType];
    }
}


// 如果用户选择了一个视频且allowPickingMultipleVideo是NO，下面的代理方法会被执行
// 如果allowPickingMultipleVideo是YES，将会调用imagePickerController:didFinishPickingPhotos:sourceAssets:isSelectOriginalPhoto:
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingVideo:(UIImage *)coverImage sourceAssets:(PHAsset *)asset {
    _selectedPhotos = [NSMutableArray arrayWithArray:@[coverImage]];
    _selectedAssets = [NSMutableArray arrayWithArray:@[asset]];

    NSLog(@"打印视频的宽:%zd",asset.pixelWidth);
    NSLog(@"打印视频的搞:%zd",asset.pixelHeight);
    //[self.superViewController showLoadingInWindowWithMessage:@"处理中..."];
    __weak typeof(self) weakSelf = self;
    [[TZImageManager manager] getVideoOutputPathWithAsset:asset presetName:AVAssetExportPreset640x480 success:^(NSString *outputPath) {
        NSData *data = [NSData dataWithContentsOfFile:outputPath];
        NSLog(@"视频导出到本地完成,沙盒路径为:%@",outputPath);
        // Export completed, send video here, send by outputPath or NSData
        // 导出完成，在这里写上传代码，通过路径或者通过NSData上传
        //拿到data 开始回调
        [weakSelf requestDataBlock:data andOutPutPath:outputPath];
    } failure:^(NSString *errorMessage, NSError *error) {
        NSLog(@"视频导出失败:%@,error:%@",errorMessage, error);
    }];
    
    
}
#pragma mark ==========回调了视频==========
- (void)requestDataBlock:(NSData *)data andOutPutPath:(NSString *)outPutPath {
    //[self.superViewController dissmissWindowHud];
    //返回图片处理
    if (_delegate && [_delegate respondsToSelector:@selector(selectTZImagePickerSelectedPhotos:withSelectedAssets:andIsOriginalPoto:andBlockData: outPutPath:withSelectTakeType:)]) {
        [_delegate selectTZImagePickerSelectedPhotos:_selectedPhotos withSelectedAssets:_selectedAssets andIsOriginalPoto:NO andBlockData:data outPutPath:outPutPath withSelectTakeType:self.selectType];
    }
}

#pragma mark -- 内部方法
- (NSString *)imageDataWriteToFile:(UIImage *)image {
    NSData *data;
    //获取图片路径
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePath =  [NSString stringWithFormat:@"%@%@",path,[NSString stringWithFormat:@"img_%d.jpg",arc4random()]];
    if (UIImagePNGRepresentation(image) == nil) {
        data = UIImageJPEGRepresentation(image, self.compressionQuality);
    }else{
        // 将PNG转JPG
        [UIImageJPEGRepresentation(image, self.compressionQuality) writeToFile:filePath atomically:YES];
        UIImage *jpgImage = [UIImage imageWithContentsOfFile:filePath];
        data = UIImageJPEGRepresentation(jpgImage, self.compressionQuality);
    }
    
    [data writeToFile:filePath atomically:YES];
    return filePath;
}

/**
 处理图片
 
 @param image image
 @return return 新图片
 */
- (UIImage *)imageProcessing:(UIImage *)image {
    UIImageOrientation imageOrientation = image.imageOrientation;
    if (imageOrientation != UIImageOrientationUp) {
        // 原始图片可以根据照相时的角度来显示，但UIImage无法判定，于是出现获取的图片会向左转９０度的现象。
        // 以下为调整图片角度的部分
        UIGraphicsBeginImageContext(image.size);
        [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        // 调整图片角度完毕
    }
    
    CGSize imagesize = image.size;
    //质量压缩系数
    self.compressionQuality = 1;
    
    //如果大于两倍屏宽 或者两倍屏高
    if (image.size.width > 640 || image.size.height > 568*2) {
        self.compressionQuality = 0.5;
        //宽大于高
        if (image.size.width > image.size.height) {
            imagesize.width = 320*2;
            imagesize.height = image.size.height*imagesize.width/image.size.width;
        }else{
            imagesize.height = 568*2;
            imagesize.width = image.size.width*imagesize.height/image.size.height;
        }
    }else{
        self.compressionQuality = 0.6;
    }
    
    // 对图片大小进行压缩
    UIImage *newImage = [self imageWithImage:image scaledToSize:imagesize];
    return newImage;
}

- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}

#pragma mark -- 懒加载
- (NSMutableArray *)imagesURL {
    if (!_imagesURL) {
        _imagesURL = [NSMutableArray array];
    }
    return _imagesURL;
}

@end
