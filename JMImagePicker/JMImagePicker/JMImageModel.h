//
//  JMImageModel.h
//  JMImagePicker
//
//  Created by 张杰 on 16/6/8.
//  Copyright © 2016年 张杰. All rights reserved.
//
@class PHAsset;
#import <Foundation/Foundation.h>

@interface JMImageModel : NSObject
@property(nonatomic,strong) PHAsset *asset;
@property(nonatomic,assign) BOOL isSelected;

@end
