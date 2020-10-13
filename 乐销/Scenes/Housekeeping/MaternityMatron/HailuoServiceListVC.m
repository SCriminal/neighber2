//
//  HailuoListVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/8/15.
//Copyright © 2020 ping. All rights reserved.
//

#import "HailuoServiceListVC.h"
#import "HouseKeepingView.h"
#import "HailuoServiceListView.h"
#import "HailuoFilterAlertView.h"
#import "RequestApi+Hailuo.h"
#import "HailuoAuntResumeVC.h"
@interface HailuoServiceListVC ()
@property (nonatomic, strong) HailuoFilterView *filterView;
@property (nonatomic, strong) HailuoLabelView *labelView;
@property (nonatomic, strong) HailuoFilterAlertView *alertView;
@property (nonatomic, assign) int indexSelected;
@property (nonatomic, strong) NSDate *dateSelected;
@property (nonatomic, assign) int ageStart;
@property (nonatomic, assign) int ageEnd;
@property (nonatomic, assign) long addressId;
@property (nonatomic, assign) int sonServeID;

@end

@implementation HailuoServiceListVC
- (HailuoFilterAlertView *)alertView{
    if (!_alertView) {
        _alertView = [HailuoFilterAlertView new];
        WEAKSELF
        _alertView.blockSearchClick = ^(long addressId, NSDate *date, int ageStart, int ageEnd) {
            weakSelf.addressId = addressId;
            weakSelf.dateSelected = date;
            weakSelf.ageStart = ageStart;
            weakSelf.ageEnd = ageEnd;
            [weakSelf refreshHeaderAll];
        };
    }
    return _alertView;
}
- (HailuoFilterView *)filterView{
    if (!_filterView) {
        _filterView = [HailuoFilterView new];
        WEAKSELF
        _filterView.blockIndexClick = ^(int index) {
            weakSelf.indexSelected = index;
            [weakSelf refreshHeaderAll];
        };
        _filterView.blockFilterClick = ^{
            [weakSelf.alertView show];
        };
    }
    return _filterView;
}
- (HailuoLabelView *)labelView{
    if (!_labelView) {
        _labelView = [HailuoLabelView new];
        WEAKSELF
        _labelView.blockIndexClick = ^(int index) {
            weakSelf.sonServeID = index;
            [weakSelf refreshHeaderAll];
        };
    }
    return _labelView;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    //table
    self.tableView.tableHeaderView = [UIView initWithViews:@[self.filterView,self.labelView]];
    [self.tableView registerClass:[HouseKeepingAuntCell class] forCellReuseIdentifier:@"HouseKeepingAuntCell"];
    //request
    [self requestList];
    [self addRefresh];
}

#pragma mark 添加导航栏
- (void)addNav{
    [self.view addSubview:[BaseNavView initNavBackTitle:UnPackStr(self.navTitle) rightView:nil]];
}

#pragma mark UITableViewDelegate
//row num
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.aryDatas.count;
}

//cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HouseKeepingAuntCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HouseKeepingAuntCell"];
    [cell resetCellWithModel:self.aryDatas[indexPath.row]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [HouseKeepingAuntCell fetchHeight:self.aryDatas[indexPath.row]];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HailuoAuntResumeVC * resumeVC = [HailuoAuntResumeVC new];
    ModelHailuoAunt *aunt = self.aryDatas[indexPath.row];
    resumeVC.auntID = aunt.auntId;
    resumeVC.auntName = aunt.name;
    resumeVC.estimatePrice = aunt.estimatePrice;
    resumeVC.orderCount = aunt.orderCount;
    [GB_Nav pushViewController:resumeVC animated:true];
}
#pragma mark request
- (void)requestList{
    [RequestApi requestHaiLuoServiceListServiceID:NSNumber.lon(self.type).stringValue max_age:self.ageEnd?NSNumber.lon(self.ageEnd).stringValue:@"" min_age:self.ageStart?NSNumber.lon(self.ageStart).stringValue:@"" serve_time:[GlobalMethod exchangeDate:self.dateSelected?self.dateSelected:[NSDate date] formatter:TIME_DAY_SHOW] order_status:self.indexSelected company_id:self.companyID page:self.pageNum son_serve_id:self.sonServeID delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        if (self.labelView.aryDatas.count == 0) {
            NSMutableArray  * aryRequest = [GlobalMethod exchangeDic:[response arrayValueForKey:@"serve"] toAryWithModelName:@"ModelIntegralProduct"];
            [self.labelView resetViewWithAry:aryRequest];
        }
        self.pageNum ++;
        NSMutableArray  * aryRequest = [GlobalMethod exchangeDic:[response arrayValueForKey:@"aunt"] toAryWithModelName:@"ModelHailuoAunt"];
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
