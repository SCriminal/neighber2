//
//  CommunityCollectionView.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/7.
//Copyright © 2020 ping. All rights reserved.
//

#import "CommunityCollectionView.h"
#import "SubModuleView.h"

@interface CommunityCollectionView ()

@end

@implementation CommunityCollectionView
@synthesize aryModel = _aryModel;


- (UIImageView *)shadow{
    if (!_shadow) {
        _shadow = [UIImageView new];
        _shadow.image = [UIImage imageNamed:@"community_shadow"];
        _shadow.backgroundColor = [UIColor clearColor];
        _shadow.widthHeight = XY(SCREEN_WIDTH, W(15));
    }
    return _shadow;
}
- (NSMutableArray *)aryModel{
    if (!_aryModel) {
        _aryModel = [NSMutableArray array];
    }
    return _aryModel;
}
- (CGFloat)cellHeight{
    if (_cellHeight == 0) {
        _cellHeight = [CommunityCollectionCell fetchHeight:[ModelModule new]];
    }
    return _cellHeight;
}
- (CustomPageControlView *)pageControl{
    if (!_pageControl) {
        _pageControl = [CustomPageControlView new];
    }
    return _pageControl;
}

#pragma mark-----  设置collectionview
- (UICollectionView *)myCollectionView {
    if (!_myCollectionView) {
        // 1.流水布局
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        
        layout.minimumInteritemSpacing = 1;
        layout.minimumLineSpacing = 1;
        layout.sectionInset = UIEdgeInsetsMake(1, W(4), 0, W(4));
        layout.itemSize = CGSizeMake((SCREEN_WIDTH-W(8)) / 4 - 1 , self.cellHeight);
        
        //设定滚动方向，有UICollectionViewScrollDirectionVertical和UICollectionViewScrollDirectionHorizontal两个值。
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        // 6.创建UICollectionView
        _myCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.cellHeight) collectionViewLayout:layout];
        // 7.设置collectionView的背景色
        _myCollectionView.backgroundColor = [UIColor whiteColor];
        // 8.设置代理
        _myCollectionView.collectionViewLayout = layout;
        _myCollectionView.delegate = self;
        _myCollectionView.dataSource = self;
        _myCollectionView.scrollEnabled = YES;
        _myCollectionView.showsVerticalScrollIndicator = false;
        _myCollectionView.showsHorizontalScrollIndicator = false;
        _myCollectionView.pagingEnabled = true;
        // 9.注册cell(告诉collectionView将来创建怎样的cell)
        [_myCollectionView registerClass:[CommunityCollectionCell class] forCellWithReuseIdentifier:@"CommunityCollectionCell"];
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
    CommunityCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CommunityCollectionCell" forIndexPath:indexPath];
    ModelModule * model = self.aryModel[indexPath.row];
    [cell resetCellWithModel:model];
    return cell;
}

#pragma mark - 代理方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ModelModule * model = self.aryModel[indexPath.row];
    [ModelModule jumpWithModule:model];
  
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(CGFLOAT_MIN, CGFLOAT_MIN);
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(CGFLOAT_MIN, CGFLOAT_MIN);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView * view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"head" forIndexPath:indexPath];
        return view;
    }
    UICollectionReusableView * view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"foot" forIndexPath:indexPath];
    return view;
}
#pragma mark scrollview delegat
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self fetchCurrentView];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (!decelerate) {
        [self fetchCurrentView];
    }
}
- (void)fetchCurrentView {
    // 获取已经滚动的比例
    double ratio = self.myCollectionView.contentOffset.x / SCREEN_WIDTH;
    int    page  = (int)(ratio + 0.5);
    // scrollview 到page页时 将toolbar调至对应按钮
    [self.pageControl setIndex:page];
}
- (instancetype)init{
    self = [super init];
    if (self) {
        self.width = SCREEN_WIDTH;
        [self addSubview:self.myCollectionView];
        [self addSubview:self.pageControl];
        [self addSubview:self.shadow];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

#pragma mark reset view
- (void)resetWithAry:(NSMutableArray *)ary{
    self.aryModel = ary;
    int numLine = (int)(ary.count/4+(ary.count%4==0?0:1));
    self.pageControl.hidden = numLine<=1;
    [self.pageControl resetViewWithNum:numLine];
    self.pageControl.centerXTop = XY(SCREEN_WIDTH/2.0, self.myCollectionView.bottom);
    
    self.height = (self.cellHeight+1)+(self.pageControl.hidden?0:self.pageControl.height);
    
    [self.myCollectionView reloadData];
}
@end



@implementation CommunityCollectionCell
#pragma mark 懒加载

- (UIImageView *)iconImg{
    if (_iconImg == nil) {
        _iconImg = [UIImageView new];
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
    self.iconImg.widthHeight = XY(W(74),W(74));
    self.iconImg.centerXTop = XY(self.contentView.width / 2,W(0));
    
    //设置图片
        [self.iconImg sd_setImageWithURL:[NSURL URLWithString:model.iconUrl] placeholderImage:[UIImage imageNamed:@"default_module"]];
    
    [self.nameLabel  fitTitle:model.moduleName  variable:0];
    self.nameLabel.centerXTop = XY(self.iconImg.centerX,W(70) + self.iconImg.top);
    
    self.height = self.nameLabel.bottom + W(15);
    
    
}


@end
