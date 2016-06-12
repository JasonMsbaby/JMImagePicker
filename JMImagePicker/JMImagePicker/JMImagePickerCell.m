//
//  JMImagePickerCell.m
//  JMImagePicker
//  collectionview item
//  Created by 张杰 on 16/6/8.
//  Copyright © 2016年 张杰. All rights reserved.
//

#import "JMImagePickerCell.h"

@interface JMImagePickerCell ()
@property(nonatomic,strong) UIImageView *image;
@property(nonatomic,strong) UIImageView *selectImage;
@end


@implementation JMImagePickerCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadImage];
        [self loadSelectImage];
    }
    return self;
}
//初始化item图片
- (void)loadImage{
    self.image = [[UIImageView alloc] initWithFrame:self.bounds];
    CGRect frame = self.bounds;
    frame.origin.x += 1;
    frame.origin.y += 1;
    frame.size.width -= 2;
    frame.size.height -= 2;
    self.image.frame = frame;
    [self.contentView addSubview:self.image];
}
//初始化item图片上面的选中非选中图片
- (void)loadSelectImage{
    self.selectImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width - 20 - 2, self.bounds.size.width - 20 - 2, 20, 20)];
    [self.image addSubview:self.selectImage];
}

//设置数据源
- (void)setModel:(JMImageModel *)model{
    if (_model != model) {
        _model = nil;
        _model = model;
        [self settingImage];
    }
}
//设置图片
- (void)settingImage{
    [[PHImageManager defaultManager] requestImageForAsset:self.model.asset targetSize:self.bounds.size contentMode:(PHImageContentModeDefault) options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        self.image.image = result;
    }];
    [self selectImageSelected:self.model.isSelected];
}


//控制选中非选中的状态
- (void)selectImageSelected:(BOOL)selected{
    self.selectImage.layer.borderColor = self.selectedButtonColor.CGColor;
    self.selectImage.layer.borderWidth = 1;
    self.selectImage.layer.cornerRadius = 10;
    self.selectImage.clipsToBounds = YES;
    if (selected) {
        self.selectImage.backgroundColor = self.selectedButtonColor;
    }else{
        self.selectImage.backgroundColor = [UIColor clearColor];
    }
}




@end
