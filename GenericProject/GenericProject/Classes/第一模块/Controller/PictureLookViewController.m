//
//  PictureLookViewController.m
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/11/25.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import "PictureLookViewController.h"
#import "LSGridViewFlowLayout.h"
#import "LSImagePickerManage.h"
#import "LSImagePickerCollectionViewCell.h"

@interface PictureLookViewController ()<UICollectionViewDataSource, UICollectionViewDelegate,LSImagePickerManageDelegate>

@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)LSGridViewFlowLayout *layout;
@property(nonatomic,strong)LSImagePickerManage *helper;

@property(nonatomic,strong)NSMutableArray *imageViewSelectPhotoArray;
@property(nonatomic,strong)NSMutableArray *imageViewSelectAssetsArray;

@end

@implementation PictureLookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.imageViewSelectPhotoArray = [NSMutableArray array];
    self.imageViewSelectAssetsArray = [NSMutableArray array];
    
    self.layout = [[LSGridViewFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 100, self.view.width, self.view.height - 300) collectionViewLayout:self.layout];
    CGFloat rgb = 244 / 255.0;
    self.collectionView.alwaysBounceVertical = YES;
    self.collectionView.backgroundColor = [UIColor colorWithRed:rgb green:rgb blue:rgb alpha:1.0];
    self.collectionView.contentInset = UIEdgeInsetsMake(4, 4, 4, 4);
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerClass:[LSImagePickerCollectionViewCell class] forCellWithReuseIdentifier:@"LSImagePickerCollectionViewCell"];
    [self.view addSubview:self.collectionView];
}

#pragma mark -- UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imageViewSelectPhotoArray.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LSImagePickerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LSImagePickerCollectionViewCell" forIndexPath:indexPath];
    cell.videoImageView.hidden = YES;
    cell.gifLable.hidden = YES;
    if (indexPath.row == self.imageViewSelectPhotoArray.count) {
        cell.imageView.image = [UIImage imageNamed:@"AlbumAddBtn.png"];
        cell.deleteBtn.hidden = YES;
    }else{
        cell.imageView.image = self.imageViewSelectPhotoArray[indexPath.row];
        cell.asset = self.imageViewSelectAssetsArray[indexPath.row];
        cell.deleteBtn.hidden = NO;
    }
    cell.deleteBtn.tag = indexPath.row;
    [cell.deleteBtn addTarget:self action:@selector(deleteBtnClik:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item == self.imageViewSelectPhotoArray.count) {
        [self.helper showImagePickerControllerWithMaxCount:9 WithViewController:self withSelectTakeType:LSManageSelectTakePhotoAndImagePickerType withAssetsArr:self.imageViewSelectAssetsArray andPhotosArr:self.imageViewSelectPhotoArray];
    }else{
        PHAsset *asset = self.imageViewSelectAssetsArray[indexPath.item];
        BOOL isVideo = NO;
        isVideo = asset.mediaType == PHAssetMediaTypeVideo;
        if ([[asset valueForKey:@"filename"] containsString:@"GIF"]) {
            TZGifPhotoPreviewController *vc = [[TZGifPhotoPreviewController alloc] init];
            TZAssetModel *model = [TZAssetModel modelWithAsset:asset type:TZAssetModelMediaTypePhotoGif timeLength:@""];
            vc.model = model;
            vc.modalPresentationStyle = UIModalPresentationFullScreen;
            [self presentViewController:vc animated:YES completion:nil];
        } else if (isVideo) { // perview video / 预览视频
            TZVideoPlayerController *vc = [[TZVideoPlayerController alloc] init];
            TZAssetModel *model = [TZAssetModel modelWithAsset:asset type:TZAssetModelMediaTypeVideo timeLength:@""];
            vc.model = model;
            vc.modalPresentationStyle = UIModalPresentationFullScreen;
            [self presentViewController:vc animated:YES completion:nil];
        } else { // preview photos / 预览照片
            TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithSelectedAssets:self.imageViewSelectAssetsArray selectedPhotos:self.imageViewSelectPhotoArray index:indexPath.item];
            imagePickerVc.modalPresentationStyle = UIModalPresentationFullScreen;
            [self presentViewController:imagePickerVc animated:YES completion:nil];
        }
    }
}

#pragma mark -- 内部方法

/**
 删除

 @param sender sender
 */
- (void)deleteBtnClik:(UIButton *)sender {
    if ([self collectionView:self.collectionView numberOfItemsInSection:0] <= self.imageViewSelectPhotoArray.count) {
        [self.imageViewSelectPhotoArray removeObjectAtIndex:sender.tag];
        [self.imageViewSelectAssetsArray removeObjectAtIndex:sender.tag];
        [self.collectionView reloadData];
        return;
    }
    
    [self.imageViewSelectPhotoArray removeObjectAtIndex:sender.tag];
    [self.imageViewSelectAssetsArray removeObjectAtIndex:sender.tag];
    [_collectionView performBatchUpdates:^{
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:sender.tag inSection:0];
        [self->_collectionView deleteItemsAtIndexPaths:@[indexPath]];
    } completion:^(BOOL finished) {
        [self->_collectionView reloadData];
    }];
}

#pragma mark -- 懒加载

#pragma mark ==========选择图片数组回调==========
- (void)selectTZImagePickerSelectedPhotos:(NSMutableArray *)selectedPhotos withSelectedAssets:(NSMutableArray *)selectAssets andIsOriginalPoto:(BOOL)isSelectOriginalPhoto andBlockData:(NSData *)data outPutPath:(NSString *)outPutPath withSelectTakeType:(LSManageSelectTakeType )selectType{
    //发布你的东西
    self.imageViewSelectPhotoArray = selectedPhotos;
    self.imageViewSelectAssetsArray = selectAssets;
    
    [self.collectionView reloadData];
}

- (LSImagePickerManage *)helper {
    if (!_helper) {
        _helper = [[LSImagePickerManage alloc] init];
        _helper.delegate = self;
    }
    return _helper;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
