//
//  JMImagePickerController.h
//  JMImagePicker
//
//  Created by 张杰 on 16/6/8.
//  Copyright © 2016年 张杰. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,JMImagerPickerMediaType){
    JMImagerPickerMediaTypePhotos,//图片选择
    JMImagerPickerMediaTypeCaramers,//照相+图片选择
    JMImagerPickerMediaTypeVideo//视频选择
};

@class JMImageModel;

@protocol JMImagePickerDelegate <NSObject>

- (void)JMImagePickerDidFinishWithImages:(NSArray<JMImageModel *> *)images;

@end


@interface JMImagePickerController : UIViewController


@property(nonatomic,assign) NSInteger selectedNumber;//选中的图片的个数 默认无限制
@property(nonatomic,strong) UIColor *topViewBackgroundColor;//顶部导航栏的颜色 默认白色
@property(nonatomic,strong) UIColor *topViewTintColor;//顶部导航栏的前景色 默认黑色
@property(nonatomic,strong) UIColor *collectionBackgroundColor;//图片选择列表的背景颜色 默认白色
@property(nonatomic,strong) UIColor *selectedButtonColor;//选择按钮的颜色 默认天蓝色
@property(nonatomic,strong) NSString *titleText;//标题文本
@property(nonatomic,assign) JMImagerPickerMediaType mediaType;//类型 默认选择图片


@property(nonatomic,assign) id<JMImagePickerDelegate> delegate;



@end
