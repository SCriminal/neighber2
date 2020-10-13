//
//  ModuleCollectionView.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/7.
//Copyright © 2020 ping. All rights reserved.
//

#import "ModuleCollectionView.h"

@interface ModuleCollectionView ()

@end

@implementation ModuleCollectionView
@synthesize aryModel = _aryModel;

#pragma mark 懒加载

- (NSMutableArray *)aryModel{
    if (!_aryModel) {
//        _aryModel = [GlobalMethod readAry:[NSString stringWithFormat:@"%@%@",LOCAL_MODULE,[self fetchParentID]] modelName:@"ModelCropListItem"];
        _aryModel = [NSMutableArray array];
    }
    return _aryModel;
}
- (CGFloat)cellHeight{
    if (_cellHeight == 0) {
        _cellHeight = [ModuleCollectionCell fetchHeight:[ModelModule new]];
    }
    return _cellHeight;
}

#pragma mark-----  设置collectionview
- (UICollectionView *)myCollectionView {
    if (!_myCollectionView) {
        // 1.流水布局
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        
        layout.minimumInteritemSpacing = 1;
        layout.minimumLineSpacing = 1;
        layout.sectionInset = UIEdgeInsetsMake(1, W(4), 0, W(4));
        layout.itemSize = CGSizeMake((SCREEN_WIDTH-W(8)) / self.numPerLine - 1 , self.cellHeight);
        
        //设定滚动方向，有UICollectionViewScrollDirectionVertical和UICollectionViewScrollDirectionHorizontal两个值。
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        // 6.创建UICollectionView
        _myCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT- NAVIGATIONBAR_HEIGHT) collectionViewLayout:layout];
        // 7.设置collectionView的背景色
        _myCollectionView.backgroundColor = [UIColor whiteColor];
        // 8.设置代理
        _myCollectionView.collectionViewLayout = layout;
        _myCollectionView.delegate = self;
        _myCollectionView.dataSource = self;
        _myCollectionView.scrollEnabled = YES;
        _myCollectionView.showsVerticalScrollIndicator = false;
        // 9.注册cell(告诉collectionView将来创建怎样的cell)
        [_myCollectionView registerClass:[ModuleCollectionCell class] forCellWithReuseIdentifier:@"ModuleCollectionCell"];
        [_myCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"foot"];
        [_myCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"head"];
        
        
    }
    return _myCollectionView;
}



#pragma mark - UICollectionView数据源方法

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.aryModel.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    // 1.获得cell
    ModuleCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ModuleCollectionCell" forIndexPath:indexPath];
    [cell resetCellWithModel:self.aryModel[indexPath.row]];
    return cell;
}

#pragma mark - 代理方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [ModelModule jumpWithModule:self.aryModel[indexPath.row]];
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(SCREEN_WIDTH, CGFLOAT_MIN);
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(SCREEN_WIDTH, CGFLOAT_MIN);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView * view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"head" forIndexPath:indexPath];
        return view;
    }
    UICollectionReusableView * view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"foot" forIndexPath:indexPath];
    [view  addLineFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1) color:COLOR_BACKGROUND];
    return view;
}

- (instancetype)initWithNum:(NSInteger)num{
    self = [super init];
       if (self) {
           self.numPerLine = num;
           [self config];
       }
       return self;
}
- (instancetype)init{
    self = [super init];
    if (self) {
        self.numPerLine = 4;
        [self config];
    }
    return self;
}
- (void)config{
    [self addSubview:self.myCollectionView];
    self.backgroundColor = [UIColor whiteColor];

}
#pragma mark reset view
- (void)resetWithAry:(NSMutableArray *)ary{
    self.aryModel = ary;
    int numLine = (int)(ary.count/self.numPerLine+(ary.count%self.numPerLine==0?0:1));
    self.width = SCREEN_WIDTH;
    self.height = (self.cellHeight+1)*numLine;
    
    self.myCollectionView.height = self.height;
    self.myCollectionView.width = SCREEN_WIDTH ;
    [self.myCollectionView reloadData];
}
@end



@implementation ModuleCollectionCell
#pragma mark 懒加载

- (UIImageView *)iconImg{
    if (_iconImg == nil) {
        _iconImg = [UIImageView new];
        _iconImg.widthHeight = XY(W(50),W(50));
    }
    return _iconImg;
}

- (UILabel *)nameLabel{
    if (_nameLabel == nil) {
        _nameLabel = [UILabel new];
        _nameLabel.fontNum = F(12);
        _nameLabel.textColor = [UIColor colorWithHexString:@"717273"];
    }
    return _nameLabel;
}
#pragma mark 初始化

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.iconImg];
        [self.contentView addSubview:self.nameLabel];
    }
    return self;
}


#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelModule *)model{
    self.model = model;
    //刷新view
    self.iconImg.centerXTop = XY(self.contentView.width / 2,W(0));
    
    //设置图片
    UIImage * image = [UIImage imageNamed:model.iconUrl];
    [self.iconImg sd_setImageWithURL:[NSURL URLWithString:model.iconUrl] placeholderImage:image?image:[UIImage imageNamed:@"default_module"]];
    
    [self.nameLabel  fitTitle:model.moduleName  variable:0];
    self.nameLabel.centerXTop = XY(self.iconImg.centerX,W(3) + self.iconImg.bottom);
    
    self.height = self.nameLabel.bottom + W(25);
    
    
}


@end
