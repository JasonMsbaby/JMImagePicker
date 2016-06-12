//
//  JMImagePickerController.m
//  JMImagePicker
//
//  Created by 张杰 on 16/6/8.
//  Copyright © 2016年 张杰. All rights reserved.
//
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kTopHeight 64
#define kCellReuseID @"JMImagePickerCell"

#import <Photos/Photos.h>
#import "JMImageModel.h"
#import "JMImagePickerTools.h"
#import "JMImagePickerController.h"
#import "JMImagePickerCell.h"
#import "Masonry.h"



@interface JMImagePickerController () <UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,strong) UIView *topView;
@property(nonatomic,strong) UICollectionView *collectionView;
@property(nonatomic,strong) NSMutableArray<JMImageModel *>  *dataSources;
@property(nonatomic,strong) UIButton *rightButton;

@end

@implementation JMImagePickerController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTopVew];
    [self initDataSources];
    [self initCollectionView];
    
}
//初始化顶部的标题栏
- (void)initTopVew{
    self.topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kTopHeight)];
    [self.view addSubview:self.topView];
    self.topView.backgroundColor = self.topViewBackgroundColor;
    
    
    [self initTitleLabel];
    
    [self initLeftButton];
    
    [self initRightButton];
    
    
}
//标题
- (void)initTitleLabel{
    UILabel *titleLabel = [UILabel new];
    [self.topView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.topView);
        make.bottom.equalTo(self.topView).offset(-5);
    }];
    titleLabel.text = self.titleText;
}

- (void)initLeftButton{
    UIButton *leftButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [self.topView addSubview:leftButton];
    [leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topView).offset(5);
        make.bottom.equalTo(self.topView);
    }];
    [leftButton setTitle:@"←" forState:(UIControlStateNormal)];
    [leftButton setTintColor:self.topViewTintColor];
    [leftButton addTarget:self action:@selector(leftButtonClicked) forControlEvents:(UIControlEventTouchUpInside)];
}

- (void)leftButtonClicked{
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES
                                 completion:nil];
    }
}

- (void)initRightButton{
    self.rightButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [self.topView addSubview:self.rightButton];
    [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.topView).offset(0);
        make.right.equalTo(self.topView).offset(-5);
    }];
    [self.rightButton setTitle:@"完成(0)" forState:(UIControlStateNormal)];
    [self.rightButton setTintColor:self.topViewTintColor];
}

//初始化collectionView
- (void)initCollectionView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
    flowLayout.itemSize = CGSizeMake(kScreenWidth/3, kScreenWidth/3);
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.sectionInset = UIEdgeInsetsZero;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, kTopHeight, kScreenWidth, kScreenHeight - kTopHeight) collectionViewLayout:flowLayout];
    [self.view addSubview:self.collectionView];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = self.collectionBackgroundColor;
    [self.collectionView registerClass:[JMImagePickerCell class] forCellWithReuseIdentifier:kCellReuseID];
}
//初始化数据源
- (void)initDataSources{
    self.dataSources = [NSMutableArray array];
    for (PHAsset *asset in [JMImagePickerTools getImagesFromPhone]) {
        JMImageModel *model = [JMImageModel new];
        model.asset = asset;
        [self.dataSources addObject:model];
    }
}

#pragma mark - collectionView DataSources
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSources.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    JMImagePickerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellReuseID forIndexPath:indexPath];
    JMImageModel *model = self.dataSources[indexPath.item];
    if (self.selectedNumber == 1) {
        cell.selectedButtonColor = [UIColor clearColor];
    }else{
        cell.selectedButtonColor = self.selectedButtonColor;
    }
    cell.model = model;
    return cell;
}

#pragma mark - collectionView Delegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    JMImagePickerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellReuseID forIndexPath:indexPath];
    JMImageModel *model = self.dataSources[indexPath.item];
    BOOL selected = model.isSelected;
    selected = !selected;
    if ([self numberOfSelected] >= self.selectedNumber && selected == YES) {
        [JMImagePickerTools toastWithInfo:@"图片超过最大选择范围"];
        return ;
    }
    model.isSelected = selected;
    cell.model = model;
    [collectionView reloadItemsAtIndexPaths:@[indexPath]];
    [self.rightButton setTitle:[NSString stringWithFormat:@"完成(%ld)",[self numberOfSelected]] forState:(UIControlStateNormal)];
}


#pragma mark -helper
//计算当前选中的个数
- (NSInteger)numberOfSelected{
    int num = 0;
    for (JMImageModel *m in self.dataSources) {
        if (m.isSelected) {
            num ++;
        }
    }
    return num;
}


#pragma mark - getter

- (UIColor *)topViewBackgroundColor{
    if (_topViewBackgroundColor == nil) {
        _topViewBackgroundColor = [UIColor whiteColor];
    }
    return _topViewBackgroundColor;
}

- (UIColor *)topViewTintColor{
    if (_topViewTintColor == nil) {
        _topViewTintColor = [UIColor blackColor];
    }
    return _topViewTintColor;
}

- (UIColor *)collectionBackgroundColor{
    if (_collectionBackgroundColor == nil) {
        _collectionBackgroundColor = [UIColor whiteColor];
    }
    return _collectionBackgroundColor;
}

- (UIColor *)selectedButtonColor{
    if (_selectedButtonColor == nil) {
        _selectedButtonColor = [UIColor colorWithRed:0.000 green:0.502 blue:1.000 alpha:1.000];
    }
    return _selectedButtonColor;
}

- (NSString *)titleText{
    if (_titleText == nil) {
        _titleText = @"图片";
    }
    return _titleText;
}






@end
