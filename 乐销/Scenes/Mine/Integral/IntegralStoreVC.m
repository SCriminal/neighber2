//
//  IntegralStoreVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/10.
//Copyright © 2020 ping. All rights reserved.
//

#import "IntegralStoreVC.h"
//cell
#import "IntegralCollectionCell.h"
//view
//section title
#import "SectionTitleView.h"
#import "IntegralCenterView.h"
//request
#import "RequestApi+Neighbor.h"
#import "IntegralProductDetailVC.h"

@interface IntegralStoreVC ()
@property (nonatomic, strong) UIView *tableHeaderView;
@property (nonatomic, strong) IntegralCenterView *scoreView;
@property (nonatomic, strong) SectionTitleView *infoTitleView;
@property (nonatomic, strong) UICollectionView *myCollectionView;
@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, strong) NSMutableArray *aryDatas;

@end

@implementation IntegralStoreVC
#pragma mark lazy init
- (IntegralCenterView *)scoreView{
    if (!_scoreView) {
        _scoreView = [IntegralCenterView new];
        _scoreView.blockBillClick = ^{
            [GB_Nav pushVCName:@"IntegralRecordVC" animated:true];
        };
    }
    return _scoreView;
}
- (UIView *)tableHeaderView{
    if (!_tableHeaderView) {
        _tableHeaderView = [UIView new];
        _tableHeaderView.width = SCREEN_WIDTH;
        _tableHeaderView.backgroundColor = [UIColor clearColor];
    }
    return _tableHeaderView;
}
- (SectionTitleView *)infoTitleView{
    if (!_infoTitleView) {
        _infoTitleView = [SectionTitleView new];
        _infoTitleView.title.text = @"猜你喜欢";
        _infoTitleView.more.hidden = true;
        _infoTitleView.arrowRight.hidden = true;
    }
    return _infoTitleView;
}
- (CGFloat)cellHeight{
    if (_cellHeight == 0) {
        
        _cellHeight = [IntegralCollectionCell fetchHeight:[ModelIntegralProduct new]];
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
        layout.sectionInset = UIEdgeInsetsMake(1, W(11), 0, W(11));
        layout.itemSize = CGSizeMake(W(160+15) , self.cellHeight);
        
        //设定滚动方向，有UICollectionViewScrollDirectionVertical和UICollectionViewScrollDirectionHorizontal两个值。
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        // 6.创建UICollectionView
        _myCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT- NAVIGATIONBAR_HEIGHT) collectionViewLayout:layout];
        // 7.设置collectionView的背景色
        _myCollectionView.backgroundColor = [UIColor whiteColor];
        // 8.设置代理
        _myCollectionView.collectionViewLayout = layout;
        _myCollectionView.delegate = self;
        _myCollectionView.dataSource = self;
        _myCollectionView.scrollEnabled = YES;
        _myCollectionView.showsVerticalScrollIndicator = false;
        // 9.注册cell(告诉collectionView将来创建怎样的cell)
        [_myCollectionView registerClass:[IntegralCollectionCell class] forCellWithReuseIdentifier:@"IntegralCollectionCell"];
        [_myCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"foot"];
        [_myCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"head"];
        
    }
    return _myCollectionView;
}

#pragma mark view dited load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    [self.view addSubview:self.myCollectionView];
    [self reconfigView];
    //request
    [self requestList];
    [self requestTotal];
}
- (void)reconfigView{
    [self.tableHeaderView removeAllSubViews];
    
    self.scoreView.top = W(10);
    [self.tableHeaderView addSubview:self.scoreView];
    
    
    self.infoTitleView.top = W(30)+self.scoreView.bottom;
    [self.tableHeaderView addSubview:self.infoTitleView];
    
    self.tableHeaderView.height = self.infoTitleView.bottom+W(13);
    [self.myCollectionView reloadData];
}
#pragma mark 添加导航栏
- (void)addNav{
    [self.view addSubview:[BaseNavView initNavBackTitle:@"积分商城" rightView:nil]];
}


#pragma mark - UICollectionView数据源方法

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.aryDatas.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    // 1.获得cell
    IntegralCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"IntegralCollectionCell" forIndexPath:indexPath];
    [cell resetCellWithModel:self.aryDatas[indexPath.row]];
    return cell;
}

#pragma mark - 代理方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ModelIntegralProduct * item = self.aryDatas[indexPath.row];
    IntegralProductDetailVC * detailVC = [IntegralProductDetailVC new];
    detailVC.integralProductID = item.iDProperty;
    [GB_Nav pushViewController:detailVC animated:true];
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(SCREEN_WIDTH, self.tableHeaderView.height);
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(SCREEN_WIDTH, CGFLOAT_MIN);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView * view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"head" forIndexPath:indexPath];
        [view addSubview:self.tableHeaderView];
        return view;
    }
    UICollectionReusableView * view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"foot" forIndexPath:indexPath];
    [view  addLineFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1) color:COLOR_BACKGROUND];
    return view;
}

#pragma mark request
- (void)requestList{

    [RequestApi requestIntegralStoreProductListWithScope:@"" delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        NSMutableArray  * aryRequest = [GlobalMethod exchangeDic:[response arrayValueForKey:@"list"] toAryWithModelName:@"ModelIntegralProduct"];
        self.aryDatas = aryRequest;
        [self.myCollectionView reloadData];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
- (void)requestTotal{
    [RequestApi requestIntegralTotalDelegate:nil success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        [self.scoreView resetViewWithModel:[response intValueForKey:@"score"]];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
@end
