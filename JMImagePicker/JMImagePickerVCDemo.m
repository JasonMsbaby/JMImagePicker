//
//  JMImagePickerVCDemo.m
//  JMImagePicker
//
//  Created by 张杰 on 16/6/8.
//  Copyright © 2016年 张杰. All rights reserved.
//
#import "JMImagePicker.h"
#import "JMImagePickerVCDemo.h"

@interface JMImagePickerVCDemo ()
@property(nonatomic,strong) UIImageView *image;
@property(nonatomic,strong) UIButton *selectImageButton;

@end

@implementation JMImagePickerVCDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initImages];
    [self initButton];
}

- (void)initImages{
    self.image =  [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    [self.view addSubview:self.image];
    self.image.backgroundColor = [UIColor grayColor];
}

- (void)initButton{
    self.selectImageButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.selectImageButton.frame = CGRectMake(150, 320, 100, 30);
    [self.selectImageButton setTitle:@"选择图片" forState:(UIControlStateNormal)];
    [self.view addSubview:self.selectImageButton];
    [self.selectImageButton addTarget:self action:@selector(buttonClick) forControlEvents:(UIControlEventTouchUpInside)];
}

- (void)buttonClick{
    JMImagePickerController *pickerVC = [JMImagePickerController new];
    pickerVC.selectedNumber = 2;
//    pickerVC.selectedButtonColor = [UIColor grayColor];
    [self presentViewController:pickerVC animated:YES completion:nil];
}

@end
