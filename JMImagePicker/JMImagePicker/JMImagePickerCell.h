//
//  JMImagePickerCell.h
//  JMImagePicker
//
//  Created by 张杰 on 16/6/8.
//  Copyright © 2016年 张杰. All rights reserved.
//
#import "JMImageModel.h"
#import <Photos/Photos.h>
#import <UIKit/UIKit.h>



@interface JMImagePickerCell : UICollectionViewCell
@property(nonatomic,strong) JMImageModel *model;
@property(nonatomic,strong) UIColor *selectedButtonColor;

@end
