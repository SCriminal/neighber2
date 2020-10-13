//
//  FindJobNetListVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/9/11.
//Copyright © 2020 ping. All rights reserved.
//

#import "FindJobNetListVC.h"
//request
#import "RequestApi+FindJob.h"
#import "FindJobNetDetailVC.h"

@interface FindJobNetListVC ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *myCollectionView;
@property (nonatomic, assign) CGFloat cellHeight;

@end

@implementation FindJobNetListVC

- (CGFloat)cellHeight{
    if (_cellHeight == 0) {
        _cellHeight = [FindJobNetCollectionCell fetchHeight:[ModelFJNet new]];
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
        [_myCollectionView registerClass:[FindJobNetCollectionCell class] forCellWithReuseIdentifier:@"FindJobNetCollectionCell"];
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
    return self.aryDatas.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.获得cell
    FindJobNetCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FindJobNetCollectionCell" forIndexPath:indexPath];
    [cell resetCellWithModel:self.aryDatas[indexPath.row]];
    return cell;
}

#pragma mark - 代理方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ModelFJNet * model = self.aryDatas[indexPath.row];
    FindJobNetDetailVC * vc = [FindJobNetDetailVC new];
    vc.identity = model.iDProperty.doubleValue;
    [GB_Nav pushViewController:vc animated:true];

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

#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];

    [self.tableView removeFromSuperview];
    [self.view addSubview:self.myCollectionView];
    self.myCollectionView.widthHeight = XY(SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT);
    self.myCollectionView.top = NAVIGATIONBAR_HEIGHT;
    WEAKSELF
    self.myCollectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.pageNum = 1;
        weakSelf.isRemoveAll = true;
        [weakSelf requestList];
       //Call this Block When enter the refresh status automatically
    }];

    // The pull to refresh
    self.myCollectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.isRemoveAll = false;
        [weakSelf requestList];
       //Call this Block When enter the refresh status automatically
    }];
    //添加导航栏
    [self addNav];
    //request
    [self requestList];
}
- (void)endRefreshing{
    self.myCollectionView.mj_header.userInteractionEnabled = true;
    self.myCollectionView.mj_footer.userInteractionEnabled = true;
    [self.myCollectionView.mj_header endRefreshing];
    [self.myCollectionView.mj_footer endRefreshing];
}
#pragma mark 添加导航栏
- (void)addNav{
    BaseNavView * nav = [BaseNavView initNavBackTitle:@"网络招聘会" rightView:nil];
    [self.view addSubview:nav];
}

#pragma mark request
- (void)requestList{
    
    [RequestApi requestFJNetJobListDelegate:self page:self.pageNum success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.pageNum ++;
        NSMutableArray  * aryRequest = [GlobalMethod exchangeDic:[response arrayValueForKey:@"list"] toAryWithModelName:@"ModelFJNet"];
        if (self.isRemoveAll) {
            [self.aryDatas removeAllObjects];
        }
        [self.aryDatas addObjectsFromArray:aryRequest];
        if (self.aryDatas.count >= [response doubleValueForKey:@"total"] ) {
            [self.myCollectionView.mj_footer endRefreshingWithNoMoreData];
        }
        [self.myCollectionView reloadData];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];

}


@end


@implementation FindJobNetCollectionCell
#pragma mark 懒加载#pragma mark 懒加载
- (ShadowView *)viewBG{
    if (_viewBG == nil) {
        _viewBG = [ShadowView new];
    }
    return _viewBG;
}
- (UIView *)viewFather{
    if (_viewFather == nil) {
        _viewFather = [UIView new];
        _viewFather.backgroundColor = [UIColor clearColor];
        
    }
    return _viewFather;
}
- (UIImageView *)productImage{
    if (_productImage == nil) {
        _productImage = [UIImageView new];
        _productImage.widthHeight = XY(W(160),W(135));
        _productImage.contentMode = UIViewContentModeScaleAspectFill;
        _productImage.clipsToBounds = true;
    }
    return _productImage;
}
- (UILabel *)name{
    if (_name == nil) {
        _name = [UILabel new];
        _name.textColor = COLOR_333;
        _name.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _name.numberOfLines = 2;
        _name.lineSpace = W(4);
    }
    return _name;
}
- (UILabel *)time{
    if (_time == nil) {
        _time = [UILabel new];
        _time.textColor = COLOR_999;
        _time.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        _time.numberOfLines = 1;
        _time.lineSpace = 0;
    }
    return _time;
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.viewBG];
        [self addSubview:self.viewFather];
        [self.viewFather addSubview:self.productImage];
        [self.viewFather addSubview:self.name];
        [self.viewFather addSubview:self.time];
        
    }
    return self;
}

#pragma mark 刷新cell



#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelFJNet *)model{
    self.model = model;
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
      
    [self.productImage sd_setImageWithURL:[NSURL URLWithString:model.smallImg] placeholderImage:[UIImage imageNamed:IMAGE_BIG_DEFAULT]];
    [self.name fitTitle:UnPackStr(model.title) variable:self.productImage.width - W(20)];
    self.name.leftTop = XY(W(10),self.productImage.bottom+W(15));
    [self.time fitTitle:[GlobalMethod exchangeTimeWithStamp:model.addtime.longLongValue andFormatter:TIME_DAY_SHOW] variable:self.productImage.width - W(20)];
    self.time.rightTop = XY(self.productImage.right - W(10),self.productImage.bottom+W(58));
    
    
    self.viewFather.widthHeight = XY(self.productImage.width, W(220));
    self.viewFather.leftTop = XY(W(7.5),W(10));
    [self.viewFather   addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:self.viewBG.cornerRadius lineWidth:0 lineColor:[UIColor clearColor]];

    [self.viewBG resetViewWith:self.viewFather.frame];
    
    //设置size
    self.size = CGSizeMake(self.productImage.width+W(15), self.viewFather.bottom + W(5));
    
    
}
@end
