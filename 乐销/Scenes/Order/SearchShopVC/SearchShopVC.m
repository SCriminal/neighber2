//
//  SearchShopVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/9.
//Copyright © 2020 ping. All rights reserved.
//

#import "SearchShopVC.h"
//view
#import "SearchShopView.h"
//cell
#import "ShoppingView.h"
//request
#import "RequestApi+Neighbor.h"
//shop detail
#import "ShopDetailVC.h"
#import "TrolleyBtn.h"

@interface SearchShopVC ()
@property (nonatomic, strong) SearchShopNavView *searchView;
@property (nonatomic, strong) SearchShopCategoryView *categoryView;
@property (nonatomic, strong) TrolleyBtn *btnTrolley;
@property (nonatomic, assign) int indexSort;
@end

@implementation SearchShopVC
#pragma mark noresult view
@synthesize noResultView = _noResultView;
- (BOOL)isShowNoResult{
    return true;
}
- (NoResultView *)noResultView{
    if (!_noResultView) {
        _noResultView = [NoResultView new];
        [_noResultView resetWithImageName:@"empty_address" title:@"暂无商铺"];
    }
    return _noResultView;
}
- (TrolleyBtn *)btnTrolley{
    if (!_btnTrolley) {
        _btnTrolley = [TrolleyBtn new];
        _btnTrolley.rightBottom = XY(SCREEN_WIDTH - W(5.5), SCREEN_HEIGHT - iphoneXBottomInterval - W(8));
    }
    return _btnTrolley;
}

- (SearchShopNavView *)searchView{
    if (!_searchView) {
        _searchView = [SearchShopNavView new];
        _searchView.top = NAVIGATIONBAR_HEIGHT;
        WEAKSELF
        _searchView.blockSearch = ^(NSString *str) {
            [weakSelf refreshHeaderAll];
        };
    }
    return _searchView;
}
- (SearchShopCategoryView *)categoryView{
    if (!_categoryView) {
        _categoryView = [SearchShopCategoryView new];
        WEAKSELF
        _categoryView.blockSelect = ^(int index) {
            weakSelf.indexSort = index;
            [weakSelf refreshHeaderAll];
        };
    }
    return _categoryView;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNav];
    [self.view addSubview:self.searchView];
    //table
    self.tableView.top = self.searchView.bottom;
    self.tableView.height = SCREEN_HEIGHT - self.searchView.bottom;
    self.tableView.tableHeaderView = self.categoryView;
    [self.tableView registerClass:[ShoppingShopCell class] forCellReuseIdentifier:@"ShoppingShopCell"];
    [self.view addSubview:self.btnTrolley];
    //request
    [self requestList];
}

#pragma mark add nav
- (void)addNav{
    [self.view addSubview:[BaseNavView initNavBackTitle:@"商家列表" rightView:nil]];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
    [self.btnTrolley reconfig];
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
- (void)requestList{
 ModelAddress * modelAddress = [GlobalMethod readModelForKey:LOCAL_LOCATION  modelName:@"ModelAddress" exchange:false];
    [RequestApi requestShopListWithScopeid:[GlobalData sharedInstance].community.iDProperty storeName:self.searchView.tfSearch.text  sortDistance:self.indexSort ==2?1:0 sortScore:self.indexSort ==3?2:0 sortAmount:self.indexSort ==1?2:0 sortAll:self.indexSort ==0?2:0 lng:modelAddress.lng lat:modelAddress.lat page:self.pageNum count:50 delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
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
@end
