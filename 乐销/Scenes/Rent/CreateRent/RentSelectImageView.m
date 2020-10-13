//
//  RentSelectImageView.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/25.
//Copyright © 2020 ping. All rights reserved.
//

#import "RentSelectImageView.h"
#import "ImageDetailBigView.h"//detail
#import "BaseVC+BaseImageSelectVC.h"//select image category

@interface RentSelectImageView ()

@end

@implementation RentSelectImageView

#pragma mark 懒加载
- (NSMutableArray *)aryDatas {
    if (!_aryDatas) {
        _aryDatas = [NSMutableArray array];
    }
    return _aryDatas;
}
- (UICollectionView *)collectionView{
    if (_collectionView == nil) {
        // 1.流水布局
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        
        layout.minimumInteritemSpacing = 1;
        layout.minimumLineSpacing = W(8);
        layout.sectionInset = UIEdgeInsetsMake(1, 0, 0, 0);
        CGSize size = [self fetchCellSize];
        layout.itemSize = size;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        // 6.创建UICollectionView
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.height) collectionViewLayout:layout];
        // 7.设置collectionView的背景色
        _collectionView.backgroundColor = [UIColor whiteColor];
        // 8.设置代理
        _collectionView.collectionViewLayout = layout;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.scrollEnabled = YES;
        _collectionView.showsVerticalScrollIndicator = false;
        _collectionView.showsHorizontalScrollIndicator = false;
        _collectionView.clipsToBounds = true;
        [_collectionView registerClass:RentCollectionCell.class forCellWithReuseIdentifier:@"RentCollectionCell"];
        _collectionView.height = size.height;
    }
    return _collectionView;
}
- (UILabel *)title{
    if (_title == nil) {
        _title = [UILabel new];
        _title.textColor = COLOR_333;
        _title.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _title.numberOfLines = 0;
        _title.lineSpace = 0;
    }
    return _title;
}
- (UIView *)viewBG{
    if (_viewBG == nil) {
        _viewBG = [UIView new];
        _viewBG.backgroundColor = [UIColor whiteColor];
        _viewBG.width = W(345);
        _viewBG.centerX = SCREEN_WIDTH/2.0;
    }
    return _viewBG;
}

#pragma mark 初始化

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //default
        self.isEditing = true;
        self.backgroundColor = COLOR_GRAY;
        self.widthHeight = XY(SCREEN_WIDTH, 0);
        [self addSubview:self.viewBG];
        [self addSubview:self.title];
        [self addSubview:self.collectionView];
        [self reconfigView];
    }
    return  self;
}
- (void)reconfigView{
    [self.title fitTitle:@"房源图片" variable:0];
    self.title.leftTop = XY(W(35), W(13));
    
    self.collectionView.leftTop = XY(W(127), W(13));
    self.collectionView.width = SCREEN_WIDTH - W(127) - W(35);
    self.height = self.collectionView.bottom + self.collectionView.top;
    self.viewBG.height = self.height;
    [self addLineFrame:CGRectMake(W(35), self.height-1, SCREEN_WIDTH - W(70), 1)];
    
}
#pragma mark fetch cell size
- (CGSize)fetchCellSize{
    return [RentCollectionCell fetchHeight];
}



#pragma mark - UICollectionView数据源方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.isEditing? self.aryDatas.count + 1:self.aryDatas.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RentCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RentCollectionCell" forIndexPath:indexPath];
    if (self.isEditing && indexPath.row == 0) {
        [cell resetCellWithCamera];
        return cell;
    }
    [cell resetCellWithModel:self.aryDatas[self.isEditing?indexPath.row -1:indexPath.row]];
    return cell;
}
//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self fetchCellSize];
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.isEditing && indexPath.item == 0) {
        [self showSelectImage];
    } else {
        ImageDetailBigView * detailView = [ImageDetailBigView new];
        WEAKSELF
        detailView.blockRefresh = ^(void){
            [weakSelf.collectionView reloadData];
          
        };
        [detailView resetView:self.aryDatas isEdit:self.isEditing index: self.isEditing?indexPath.row-1:indexPath.row];
        RentCollectionCell * cell = (RentCollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
        [detailView showInView:GB_Nav.lastVC.view imageViewShow:cell.ivImage];
    }
}
- (void)showSelectImage{
    BaseVC * vc = (BaseVC *)[self fetchVC];
    if (self.aryDatas.count>=3) {
        [GlobalMethod showAlert:@"最多3张，请先删除再添加"];
        return;
    }
    [GB_Nav jumpToAry:@[[vc fetchImageVC:3-(int)self.aryDatas.count]]];
}

@end



@implementation RentCollectionCell
#pragma mark 懒加载
- (UIImageView *)ivImage{
    if (_ivImage == nil) {
        _ivImage = [UIImageView new];
        _ivImage.backgroundColor = [UIColor clearColor];
        _ivImage.image = nil;
        _ivImage.contentMode = UIViewContentModeScaleAspectFill;
        _ivImage.clipsToBounds = true;
        _ivImage.widthHeight = XY(W(64),W(64));
    }
    return _ivImage;
}
#pragma mark 获取高度
+ (CGSize)fetchHeight{
    static RentCollectionCell * cell;
    if (cell == nil) {
        cell = [self new];
    }
    return [cell resetCellWithModel:nil];
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.ivImage];
    }
    return self;
}

#pragma mark 刷新cell
- (CGSize)resetCellWithModel:(ModelImage *)model{
    //iv
    self.ivImage.centerXTop = XY(self.width/2.0,0);
    [self.ivImage sd_setImageWithModel:model placeholderImageName:IMAGE_BIG_DEFAULT];
    //label bottom
    //btn delete
    return CGSizeMake(self.ivImage.width, self.ivImage.height);
}
//照相机 cell
- (void)resetCellWithCamera{
    self.ivImage.image = [UIImage imageNamed:@"whistle_add"];
}


@end
