//
//  RentInfoListVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/21.
//Copyright © 2020 ping. All rights reserved.
//

#import "RentInfoListVC.h"
#import "RentInfoListCell.h"
//request
#import "RequestApi+Neighbor.h"
#import "RentDetailVC.h"
//filter view
#import "RentListFilterListView.h"
@interface RentInfoListVC ()
@property (nonatomic, strong) RentListFilterListView *filterLayoutList;
@property (nonatomic, strong) RentListFilterListView *filterDirectionList;
@property (nonatomic, strong) RentListFilterListView *filterRentModeList;
@property (nonatomic, strong) RentListFilterListView *filterSoldPriceList;
@property (nonatomic, strong) RentListFilterListView *filterRentPriceList;

@end

@implementation RentInfoListVC
#pragma mark noresult view
@synthesize noResultView = _noResultView;
- (BOOL)isShowNoResult{
    return true;
}
- (NoResultView *)noResultView{
    if (!_noResultView) {
        _noResultView = [NoResultView new];
        [_noResultView resetWithImageName:@"empty_rent" title:@"暂无房屋信息"];
    }
    return _noResultView;
}
- (RentListFilterView *)filterView{
    if (!_filterView) {
        _filterView = [RentListFilterView new];
        _filterView.top = NAVIGATIONBAR_HEIGHT;
        WEAKSELF
        _filterView.blockClick = ^(int index) {
            switch (index) {
                case 0:
                    [weakSelf.view addSubview:weakSelf.filterLayoutList];
                    break;
                case 1:
                    [weakSelf.view addSubview:weakSelf.filterDirectionList];
                    break;
                case 2:
                {
                    if (weakSelf.filterView.modelFilter.houseMode==0) {
                        [GlobalMethod showAlert:@"请先选择租赁方式"];
                        [weakSelf.view addSubview:weakSelf.filterRentModeList];
                    }else{
                        if (weakSelf.filterView.modelFilter.houseMode == 3) {//sold
                            [weakSelf.view addSubview:weakSelf.filterSoldPriceList];
                        }else{
                            [weakSelf.view addSubview:weakSelf.filterRentPriceList];

                        }
                    }
                }
                    break;
                case 3:
                    [weakSelf.view addSubview:weakSelf.filterRentModeList];
                    break;
                default:
                    break;
            }
        };
//        _filterView.height = 0;
    }
    return _filterView;
}

- (RentListFilterListView *)filterLayoutList{
    if (!_filterLayoutList) {
        _filterLayoutList = [RentListFilterListView new];
        [_filterLayoutList resetViewWithArys:@[@"全部",@"1室",@"2室",@"3室",@"4室",@"5室"] top:self.filterView.bottom];
        WEAKSELF
        _filterLayoutList.blockSelected = ^(int index) {
            weakSelf.filterView.modelFilter.layoutBedroom = index;
            [weakSelf.filterView reconfigView];
            [weakSelf refreshHeaderAll];
        };
    }
    return _filterLayoutList;
}
- (RentListFilterListView *)filterDirectionList{
    if (!_filterDirectionList) {
        _filterDirectionList = [RentListFilterListView new];
        //1东 2南 3西 4北 5东南 6西南 7西北  8东北
        [_filterDirectionList resetViewWithArys:@[@"全部",@"朝东",@"朝南",@"朝西",@"朝北",@"朝东南",@"朝西南",@"朝西北",@"朝东北"] top:self.filterView.bottom];
        WEAKSELF
        _filterDirectionList.blockSelected = ^(int index) {
            weakSelf.filterView.modelFilter.direction = index;
            [weakSelf.filterView reconfigView];
            [weakSelf refreshHeaderAll];
        };
    }
    return _filterDirectionList;
}
- (RentListFilterListView *)filterRentModeList{
    if (!_filterRentModeList) {
        _filterRentModeList = [RentListFilterListView new];
        [_filterRentModeList resetViewWithArys:@[@"全部",@"整租",@"合租",@"出售"] top:self.filterView.bottom];
        WEAKSELF
        _filterRentModeList.blockSelected = ^(int index) {
            weakSelf.filterView.modelFilter.houseMode = index;
            weakSelf.filterView.modelFilter.filterSoldPriceIndex = 0;
            weakSelf.filterView.modelFilter.filterRentPriceIndex = 0;
            [weakSelf.filterView reconfigView];
            [weakSelf refreshHeaderAll];
        };
    }
    return _filterRentModeList;
}
- (RentListFilterListView *)filterSoldPriceList{
    if (!_filterSoldPriceList) {
        _filterSoldPriceList = [RentListFilterListView new];
        [_filterSoldPriceList resetViewWithArys:@[@"不限",@"20万元以下",@"20-40万",@"40-60万",@"60-80万",@"80-150万",@"150-300万",@"300万以上"] top:self.filterView.bottom];
        WEAKSELF
        _filterSoldPriceList.blockSelected = ^(int index) {
            weakSelf.filterView.modelFilter.filterSoldPriceIndex = index;
            [weakSelf refreshHeaderAll];
        };
    }
    return _filterSoldPriceList;
}
- (RentListFilterListView *)filterRentPriceList{
    if (!_filterRentPriceList) {
        _filterRentPriceList = [RentListFilterListView new];
        [_filterRentPriceList resetViewWithArys:@[@"不限",@"500元以下",@"500元-1000元",@"1000元-3000元",@"3000元-5000元",@"5000元以上"] top:self.filterView.bottom];
        WEAKSELF
        _filterRentPriceList.blockSelected = ^(int index) {
            weakSelf.filterView.modelFilter.filterRentPriceIndex = index;
            [weakSelf refreshHeaderAll];
        };
    }
    return _filterRentPriceList;
}

#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    //table
    [self.view addSubview:self.filterView];
    self.tableView.top = self.filterView.bottom;
    [self.tableView registerClass:[RentInfoListCell class] forCellReuseIdentifier:@"RentInfoListCell"];
    [self addRefreshHeader];
    [self addRefreshFooter];
    //request
    [self requestList];
}

#pragma mark 添加导航栏
- (void)addNav{
    [self.view addSubview:[BaseNavView initNavBackTitle:@"房屋租售" rightView:nil]];
}

#pragma mark UITableViewDelegate
//row num
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.aryDatas.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
//cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RentInfoListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"RentInfoListCell"];
    [cell resetCellWithModel:self.aryDatas[indexPath.row]];
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [RentInfoListCell fetchHeight:self.aryDatas[indexPath.row]];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    RentDetailVC * vc = [RentDetailVC new];
    vc.modelList = self.aryDatas[indexPath.row];
    [GB_Nav pushViewController:vc animated:true];
}
#pragma mark request
- (void)requestList{
    ModelRentInfo *modelFilter = self.filterView.modelFilter;
    CGFloat priceMin = 0;
    CGFloat priceMax = 0;
    if (modelFilter.houseMode == 3) {//出售
        switch (modelFilter.filterSoldPriceIndex) {
            case 1:
                {
                    priceMin = 0;
                    priceMax = 200000*100.0;
                }
                break;
            case 2:
            {
                priceMin = 200000*100.0;
                priceMax = 400000*100.0;
            }
                break;
            case 3:
            {
                priceMin = 400000*100.0;
                priceMax = 600000*100.0;
            }
                break;
            case 4:
            {
                priceMin = 600000*100.0;
                priceMax = 800000*100.0;
            }
                break;
            case 5:
            {
                priceMin = 800000*100.0;
                priceMax = 1500000*100.0;
            }
                break;
            case 6:
            {
                priceMin = 1500000*100.0;
                priceMax = 3000000*100.0;
            }
                break;
            case 7:
            {
                priceMin = 3000000*100.0;
                priceMax = 0;
            }
                break;
            default:
                break;
        }
    }else if(modelFilter.houseMode != 0){
        switch (modelFilter.filterRentPriceIndex) {
            case 1:
            {
                priceMin = 0;
                priceMax = 500*100.0;
            }
                break;
            case 2:
            {
                priceMin = 500*100.0;
                priceMax = 1000*100.0;
            }
                break;
            case 3:
            {
                priceMin = 1000*100.0;
                priceMax = 3000*100.0;
            }
                break;
            case 4:
            {
                priceMin = 3000*100.0;
                priceMax = 5000*100.0;
            }
                break;
            case 5:
            {
                priceMin = 5000*100.0;
                priceMax = 0;
            }
                break;
         
            default:
                break;
        }
    }
    [RequestApi requestRentListWithLayoutbedroom:modelFilter.layoutBedroom areaId:[GlobalData sharedInstance].community.iDProperty layoutParlor:0 layoutToilet:0 direction:modelFilter.direction houseMode:modelFilter.houseMode minPrice:priceMin maxPrice:priceMax page:self.pageNum count:50 scope:4 delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.pageNum ++;
        NSMutableArray  * aryRequest = [GlobalMethod exchangeDic:[response arrayValueForKey:@"list"] toAryWithModelName:@"ModelRentInfo"];
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
