//
//  ShoppingVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/7.
//Copyright © 2020 ping. All rights reserved.
//

#import "ShoppingVC.h"
//view
#import "ShoppingView.h"
//section title
#import "SectionTitleView.h"
//collection view
#import "ModuleCollectionView.h"
//request
#import "RequestApi+Neighbor.h"
//auto sc view
#import "AutoScView.h"
//shop detail
#import "ShopDetailVC.h"
#import "WebVC.h"

@interface ShoppingVC ()
@property (nonatomic, strong) AutoScView *autoSCView;
@property (nonatomic, strong) ShoppingShopView *shopView;
@property (nonatomic, strong) UIView *tableHeaderView;
@property (nonatomic, strong) SectionTitleView *infoTitleView;
@property (nonatomic, strong) ModuleCollectionView *collection;
@property (nonatomic, strong) NSArray *aryADs;

@end

@implementation ShoppingVC
- (AutoScView *)autoSCView{
    if (!_autoSCView) {
        _autoSCView = [[AutoScView alloc]initWithFrame:CGRectMake(W(15), W(17), SCREEN_WIDTH - W(30), W(125)) image:@[@"tmp_shop1"]];
        _autoSCView.pageCurrentColor = [UIColor whiteColor];
        _autoSCView.pageDefaultColor = [UIColor colorWithHexString:@"ffffff" alpha:0.5];
        [_autoSCView addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:5 lineWidth:0 lineColor:[UIColor clearColor]];
        _autoSCView.isClickValid = true;
         WEAKSELF
               _autoSCView.blockClick = ^(int index) {
                   if (weakSelf.aryADs.count > index) {
                       ModelAD * model = [weakSelf.aryADs objectAtIndex:index];
                       if (isStr(model.bodyUrl) && model.displayMode != 7) {
                           WebVC * vc = [WebVC new];
                           vc.navTitle = @"详情";
                           vc.url = model.bodyUrl;
                           [GB_Nav pushViewController:vc animated:true];
                       }
                      
                   }
               };
        [_autoSCView timerStart];
    }
    return _autoSCView;
}
- (ModuleCollectionView *)collection{
    if (!_collection) {
        _collection = [ModuleCollectionView new];
    }
    return _collection;
}
- (ShoppingShopView *)shopView{
    if (!_shopView) {
        _shopView = [ShoppingShopView new];
    }
    return _shopView;
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
        _infoTitleView.title.text = @"推荐商家";
        _infoTitleView.more.hidden = true;
        _infoTitleView.arrowRight.hidden = true;
    }
    return _infoTitleView;
}

#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    [self reconfigView];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(communityRefresh) name:NOTICE_COMMUNITY_REFERSH object:nil];

    //table
    self.tableView.height = SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT - TABBAR_HEIGHT;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, W(13.5), 0);
    [self.tableView registerClass:[ShoppingShopCell class] forCellReuseIdentifier:@"ShoppingShopCell"];
    //request
    [self communityRefresh];
    [self addRefreshHeader];
    [self addRefreshFooter];
}
- (void)reconfigView{
    [self.tableHeaderView removeAllSubViews];
    [self.tableHeaderView addSubview:self.autoSCView];
//    [self.tableHeaderView addSubview:self.shopView];
    CGFloat top = self.autoSCView.bottom+W(30);
    if (self.collection.aryModel.count) {
            self.collection.top = top;
        [self.tableHeaderView addSubview:self.collection];
        top = self.collection.bottom+W(10);
    }
    self.infoTitleView.top = top;
    [self.tableHeaderView addSubview:self.infoTitleView];

    self.tableHeaderView.height = self.infoTitleView.bottom+W(7);
    self.tableView.tableHeaderView = self.tableHeaderView;
}
#pragma mark 添加导航栏
- (void)addNav{
    [self.view addSubview:[BaseNavView initNavTitle:@"便民采购" leftView:nil rightView:nil]];
}

#pragma mark UITableViewDelegate
//row num
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.aryDatas.count;
}

//cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ShoppingShopCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ShoppingShopCell"];
    [cell resetCellWithModel:self.aryDatas[indexPath.row]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [ShoppingShopCell fetchHeight:self.aryDatas[indexPath.row]];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ShopDetailVC * vc = [ShopDetailVC new];
    vc.modelShop = self.aryDatas[indexPath.row];
    [GB_Nav pushViewController:vc animated:true];
    
}

#pragma mark request
- (void)communityRefresh{
    [self refreshHeaderAll];
    [self requestADList];
    [self requestModule];
}
- (void)requestList{
    ModelAddress * modelAddress = [GlobalMethod readModelForKey:LOCAL_LOCATION  modelName:@"ModelAddress" exchange:false];
    [RequestApi requestShopListWithScopeid:[GlobalData sharedInstance].community.iDProperty storeName:@""  sortDistance:1 sortScore:0 sortAmount:0 sortAll:0 lng:modelAddress.lng lat:modelAddress.lat page:self.pageNum count:50 delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.pageNum ++;
        NSMutableArray  * aryRequest = [GlobalMethod exchangeDic:[response arrayValueForKey:@"list"] toAryWithModelName:@"ModelShopList"];
        
        if (self.isRemoveAll) {
            [self.aryDatas removeAllObjects];
        }
        if (!isAry(aryRequest)) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        [self.aryDatas addObjectsFromArray:aryRequest];
        [self.tableView reloadData];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
    
}
- (void)requestADList{
    [RequestApi requestADListWithGroupalias:@"buy_1" scopeId:[GlobalData sharedInstance].community.iDProperty delegate:nil success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        NSArray * ary = [GlobalMethod exchangeDic:response toAryWithModelName:@"ModelAD"];
        self.aryADs = ary;
        NSArray * aryAds = [ary fetchValues:@"coverUrl"];
        [self.autoSCView resetWithImageAry:aryAds];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
- (void)requestModule{
    [RequestApi requestModuleWithLocationaliases:@"resident_buy" areaId:[GlobalData sharedInstance].community.iDProperty delegate:nil success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        NSMutableArray * aryResponse = [GlobalMethod exchangeDic:[response arrayValueForKey:@"resident_buy"] toAryWithModelName:@"ModelModule"];
        if (!isAry(aryResponse)) {
            return;
        }
        [self.collection resetWithAry:aryResponse];
        [self reconfigView];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
@end
