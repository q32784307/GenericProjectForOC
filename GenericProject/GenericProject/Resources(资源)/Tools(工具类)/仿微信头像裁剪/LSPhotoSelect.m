//
//  LSPhotoSelect.m
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/12/10.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import "LSPhotoSelect.h"
#import "LSImageEditViewController.h"

@interface LSPhotoSelect ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,LSDPhotoEditVCDelegate>

@property(nonatomic,strong)NSMutableArray *imageArray;
@property(nonatomic,weak)id <LSDPhotoSelectDelegate> delegate;
@property(nonatomic,weak)UIViewController *viewController;
@property(nonatomic,assign)UIStatusBarStyle previousStatusBarStyle;
@property(nonatomic,strong)UIImagePickerController *pickerController;

@end

@implementation LSPhotoSelect

- (id)initWithController:(UIViewController *)viewController delegate:(id<LSDPhotoSelectDelegate>)delegate {
    self = [super init];
    if (self) {
        self.viewController = viewController;
        self.delegate = delegate;
        self.imageArray = [NSMutableArray array];
    }
    return self;
}

- (void)startPhotoSelect:(LSEPhotoSelectType)type {
    switch (type) {
        case LSEPhotoSelectTakePhoto:
            [self showTakePhotoView];
            break;
        case LSEPhotoSelectFromLibrary:
            [self showPhotoSelectView];
            break;
            
        default:
            break;
    }
}

- (NSArray *)selectedImageArray {
    return self.imageArray;
}

#pragma mark - Private Methods
- (void)showTakePhotoView {
    self.previousStatusBarStyle = [[UIApplication sharedApplication] statusBarStyle];
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    self.pickerController = picker;
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self.viewController presentViewController:picker animated:YES completion:^{
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    }];
}

- (void)showPhotoSelectView {
    self.previousStatusBarStyle = [[UIApplication sharedApplication] statusBarStyle];
    
    if (!self.isMultiPickImage) {
        // 如果不是多选, 则使用系统的控件来进行选择
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        self.pickerController = picker;
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.modalPresentationStyle = UIModalPresentationFullScreen;
        [self.viewController presentViewController:picker animated:YES completion:^{
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
        }];
    }else{
        // 多选(暂未实现)
    }
}

- (void)selectedFinished:(NSArray *)imageArray {
    //先清空之前保存的照片列表
    [self.imageArray removeAllObjects];
    
    [self.imageArray addObjectsFromArray:imageArray];
    if ([self.delegate respondsToSelector:@selector(lsdOptionalPhotoSelect:didFinishedWithImageArray:)]) {
        [self.delegate lsdOptionalPhotoSelect:self didFinishedWithImageArray:self.imageArray];
    }
    [self.pickerController dismissViewControllerAnimated:YES completion:nil];
}

- (void)selectedCancelled {
    if ([self.delegate respondsToSelector:@selector(lsdOptionalPhotoSelectDidCancelled:)]) {
        [self.delegate lsdOptionalPhotoSelectDidCancelled:self];
    }
}

#pragma mark - Delegate
#pragma mark UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *selectedImage = nil;
    if (info[UIImagePickerControllerEditedImage]) {
        selectedImage = info[UIImagePickerControllerEditedImage];
    }else if(info[UIImagePickerControllerOriginalImage]){
        selectedImage = info[UIImagePickerControllerOriginalImage];
    }
    
    [UIApplication sharedApplication].statusBarStyle = self.previousStatusBarStyle;
    
    if (self.isAllowEdit) {
        LSImageEditViewController *vc = [[LSImageEditViewController alloc] initWithImage:selectedImage delegate:self];
        picker.view.backgroundColor = [UIColor whiteColor];
        [picker pushViewController:vc animated:YES];
    } else {
        [self selectedFinished:@[selectedImage]];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [UIApplication sharedApplication].statusBarStyle = self.previousStatusBarStyle;
    __weak LSPhotoSelect *weakSelf = self;
    [picker dismissViewControllerAnimated:YES completion:^{
        [weakSelf selectedCancelled];
    }];
}

#pragma mark LSDPhotoEditVCDelegate
- (void)lsdOptionalPhotoEditVC:(LSImageEditViewController *)controller didFinishCroppingImage:(UIImage *)croppedImage {
    if (croppedImage) {
        [self selectedFinished:@[croppedImage]];
    } else {
        [controller dismissViewControllerAnimated:YES completion:^{
        }];
    }
}

@end
