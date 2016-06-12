//
//  JMImagePickerTools.h
//  JMImagePicker
//
//  Created by 张杰 on 16/6/8.
//  Copyright © 2016年 张杰. All rights reserved.
//
#import <Photos/Photos.h>
#import "JMImageModel.h"
#import <Foundation/Foundation.h>

@interface JMImagePickerTools : NSObject


//从相册中获取所有照片
+ (NSArray<PHAsset *> *) getImagesFromPhone;

//相册的使用权限
+ (BOOL)judgeIsHavePhotoAblumAuthority;

//相机的使用权限
+ (BOOL)judgeIsHaveCameraAuthority;

//toast 信息
+ (void)toastWithInfo:(NSString *)info;

@end
