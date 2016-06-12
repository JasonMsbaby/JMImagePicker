//
//  JMImagePickerTools.m
//  JMImagePicker
//
//  Created by 张杰 on 16/6/8.
//  Copyright © 2016年 张杰. All rights reserved.
//
#import "Masonry/Masonry.h"
#import "JMImagePickerTools.h"


@implementation JMImagePickerTools

//从相册中获取所有照片
+ (NSArray<PHAsset *> *) getImagesFromPhone{
    if (![self judgeIsHavePhotoAblumAuthority]) {
        return nil;
    }
    NSMutableArray *dataArray = [NSMutableArray array];
    // 获取所有资源的集合，并按资源的创建时间排序
    PHFetchOptions *options = [[PHFetchOptions alloc] init];
    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
    PHFetchResult *assetsFetchResults = [PHAsset fetchAssetsWithOptions:options];
    // 这时 assetsFetchResults 中包含的，应该就是各个资源（PHAsset）
    NSLog(@"%ld",assetsFetchResults.count);
    for (NSInteger i = 0; i < assetsFetchResults.count; i++) {
        // 获取一个资源（PHAsset）
        PHAsset *asset = assetsFetchResults[i];
        [dataArray addObject:asset];
    }
    return dataArray;
}

//相册的使用权限
+ (BOOL)judgeIsHavePhotoAblumAuthority
{
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusRestricted ||
        status == PHAuthorizationStatusDenied) {
        return NO;
    }
    return YES;
}
//相机的使用权限
+ (BOOL)judgeIsHaveCameraAuthority
{
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (status == AVAuthorizationStatusRestricted ||
        status == AVAuthorizationStatusDenied) {
        return NO;
    }
    return YES;
}

+ (void)toastWithInfo:(NSString *)info{
    UILabel *lbl = [UILabel new];
    UIWindow *keywindow = [UIApplication sharedApplication].keyWindow;
    [keywindow addSubview:lbl];
    [lbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(keywindow).offset(-50);
        make.centerX.equalTo(keywindow);
        make.height.equalTo(@20);
    }];
    lbl.backgroundColor = [UIColor blackColor];
    lbl.textColor = [UIColor whiteColor];
    lbl.font = [UIFont systemFontOfSize:12];
    lbl.textAlignment = NSTextAlignmentCenter;
    lbl.layer.cornerRadius = 3;
    lbl.clipsToBounds = YES;
    lbl.text = [NSString stringWithFormat:@" %@   ",info];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [lbl removeFromSuperview];
    });
}
@end
