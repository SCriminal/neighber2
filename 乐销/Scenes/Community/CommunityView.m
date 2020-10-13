//
//  CommunityView.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/7.
//Copyright © 2020 ping. All rights reserved.
//

#import "CommunityView.h"
//request
#import "RequestApi+Neighbor.h"
#import "ModuleCollectionView.h"

@interface CommunityNavView ()
@end

@implementation CommunityNavView
#pragma mark 懒加载
- (UILabel *)name{
    if (_name == nil) {
        _name = [UILabel new];
        _name.textColor = [UIColor blackColor];
        _name.font =  [UIFont systemFontOfSize:F(20) weight:UIFontWeightRegular];
    }
    return _name;
}
- (UILabel *)selectCommunity{
    if (_selectCommunity == nil) {
        _selectCommunity = [UILabel new];
        _selectCommunity.textColor = COLOR_333;
        _selectCommunity.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
    }
    return _selectCommunity;
}
- (UIImageView *)arrowLocal{
    if (_arrowLocal == nil) {
        _arrowLocal = [UIImageView new];
        _arrowLocal.image = [UIImage imageNamed:@"community_local"];
        _arrowLocal.widthHeight = XY(W(25),W(25));
    }
    return _arrowLocal;
}
- (UIImageView *)arrowDown{
    if (_arrowDown == nil) {
        _arrowDown = [UIImageView new];
        _arrowDown.image = [UIImage imageNamed:@"arrow_down"];
        _arrowDown.widthHeight = XY(W(25),W(25));
    }
    return _arrowDown;
}
- (UIImageView *)arrow{
    if (_arrow == nil) {
        _arrow = [UIImageView new];
        _arrow.image = [UIImage imageNamed:@"arrow_down"];
        _arrow.highlightedImage = [UIImage imageNamed:@"arrow_up"];
        _arrow.widthHeight = XY(W(25),W(25));
    }
    return _arrow;
}
#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(resetViewWithModel) name:NOTICE_COMMUNITY_REFERSH object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(requestArchive) name:NOTICE_ARCHIVE_CREATE object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(requestArchive) name:NOTICE_SELFMODEL_CHANGE object:nil];
        self.width = SCREEN_WIDTH;
        [self addSubView];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.name];
    [self addSubview:self.selectCommunity];
    [self addSubview:self.arrowLocal];
    [self addSubview:self.arrowDown];
    [self addSubview:self.arrow];

    //初始化页面
    [self resetViewWithModel];
}

#pragma mark 刷新view
- (void)resetViewWithModel{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    self.arrowLocal.leftTop = XY(W(15),W(11));

    [self.name fitTitle:isStr([GlobalData sharedInstance].community.name)?[GlobalData sharedInstance].community.name:@"暂无小区" variable:0];
    self.name.leftCenterY = XY(self.arrowLocal.right+ W(5),self.arrowLocal.centerY);
    self.arrow.leftCenterY = XY(self.name.right , self.name.centerY);
    
    self.arrowDown.rightCenterY = XY(SCREEN_WIDTH - W(15),self.name.centerY);

    [self.selectCommunity fitTitle:@"切换小区" variable:0];
    self.selectCommunity.rightCenterY = XY(self.arrowDown.left - W(2),self.arrowDown.centerY);
    
    
    //设置总高度
    self.height = self.name.bottom + W(11);
    
    [self addControlFrame:CGRectMake(self.selectCommunity.left - W(15), 0, SCREEN_WIDTH - (self.selectCommunity.left - W(15)), self.height) belowView:self.selectCommunity target:self action:@selector(selectCommunityClick)];

    [self addControlFrame:CGRectInset(self.name.frame, -W(30), -W(20)) belowView:self.selectCommunity target:self action:@selector(switchCommunityClick)];

    [self requestArchive];
}
- (void)requestArchive{
    if (![GlobalMethod isLoginSuccess]) {
        self.arrow.hidden = true;
        return;
    }
    [RequestApi requestCommunityListWithArchiveDelegate:nil success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        NSArray * ary = [GlobalMethod exchangeDic:response toAryWithModelName:@"ModelCommunity"];
        self.arrow.hidden = ary.count == 0;
        
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
#pragma mark click
- (void)selectCommunityClick{
    if (self.blockChangeDistrictClick ) {
        self.blockChangeDistrictClick();
    }
}
- (void)switchCommunityClick{
    if (self.blockSwitchDistrictClick ) {
        self.blockSwitchDistrictClick();
    }
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end


@implementation CommunitySubCollectionView
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
        
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        layout.sectionInset = UIEdgeInsetsMake(0, W(0), 0, W(0));
        layout.itemSize = CGSizeMake((SCREEN_WIDTH-W(20)) / self.numPerLine, self.cellHeight);
        
        //设定滚动方向，有UICollectionViewScrollDirectionVertical和UICollectionViewScrollDirectionHorizontal两个值。
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        // 6.创建UICollectionView
        _myCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(W(10), 0, SCREEN_WIDTH-W(20), self.cellHeight) collectionViewLayout:layout];
//        _myCollectionView.contentInset = UIEdgeInsetsMake(0, W(4), 0, W(4));
        // 7.设置collectionView的背景色
        _myCollectionView.backgroundColor = [UIColor whiteColor];
        // 8.设置代理
        _myCollectionView.collectionViewLayout = layout;
        _myCollectionView.delegate = self;
        _myCollectionView.dataSource = self;
        _myCollectionView.scrollEnabled = YES;
        _myCollectionView.pagingEnabled = YES;
        _myCollectionView.showsVerticalScrollIndicator = false;
        _myCollectionView.showsHorizontalScrollIndicator = false;
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
//    int numLine = (int)(ary.count/self.numPerLine+(ary.count%self.numPerLine==0?0:1));
    self.width = SCREEN_WIDTH;
    self.height = (self.cellHeight+1)*1;
    [self.myCollectionView reloadData];
}
@end




@implementation CommunityInfoCell
#pragma mark 懒加载
- (UILabel *)title{
    if (_title == nil) {
        _title = [UILabel new];
        _title.textColor = COLOR_333;
        _title.font =  [UIFont systemFontOfSize:F(17) weight:UIFontWeightMedium];
        _title.numberOfLines = 3;
        _title.lineSpace = W(5);
    }
    return _title;
}
- (UILabel *)time{
    if (_time == nil) {
        _time = [UILabel new];
        _time.textColor = COLOR_999;
        _time.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
    }
    return _time;
}
- (UIImageView *)icon{
    if (_icon == nil) {
        _icon = [UIImageView new];
        _icon.widthHeight = XY(W(120),W(92));
        [_icon addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:5 lineWidth:0 lineColor:[UIColor clearColor]];
    }
    return _icon;
}

#pragma mark 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.title];
        [self.contentView addSubview:self.time];
        [self.contentView addSubview:self.icon];
        
    }
    return self;
}
#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelNews *)model{
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
      self.icon.hidden = false;
          [self.icon sd_setImageWithURL:[NSURL URLWithString:model.coverUrl] placeholderImage:[UIImage imageNamed:@"newsDefault"]];
          self.icon.rightTop = XY(SCREEN_WIDTH -  W(20),W(18));
          
          [self.title fitTitle:model.title variable:W(187)];
          self.title.leftTop = XY(W(20),self.icon.top);
          [self.time fitTitle:[GlobalMethod exchangeTimeWithStamp:model.publishTime andFormatter:TIME_MIN_SHOW] variable:self.icon.left - W(30)];
          self.time.leftBottom = XY(W(20),self.icon.bottom);
          
          //设置总高度
          self.height = self.icon.bottom + W(18);
          [self.contentView addLineFrame:CGRectMake(W(20), self.height -1 , SCREEN_WIDTH - W(40), 1)];
}

@end
