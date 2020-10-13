//
//  HospitalListVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/21.
//Copyright © 2020 ping. All rights reserved.
//

#import "HospitalListVC.h"
#import "HospitalListCell.h"
#import "LifeTopBGView.h"
//request
#import "RequestApi+Neighbor.h"
@interface HospitalListVC ()
@property (nonatomic, strong) LifeTopBGView *topView;

@end

@implementation HospitalListVC
#pragma mark noresult view
@synthesize noResultView = _noResultView;
- (BOOL)isShowNoResult{
    return true;
}
- (NoResultView *)noResultView{
    if (!_noResultView) {
        _noResultView = [NoResultView new];
        [_noResultView resetWithImageName:@"empty_default" title:@"暂无医院"];
    }
    return _noResultView;
}
- (LifeTopBGView *)topView{
    if (!_topView) {
        _topView = [LifeTopBGView new];
    }
    return _topView;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    self.tableView.tableHeaderView = self.topView;
    self.tableView.height = SCREEN_HEIGHT;
    self.tableView.top = 0;
    //table
    [self.tableView registerClass:[HospitalListCell class] forCellReuseIdentifier:@"HospitalListCell"];
    //request
    [self requestList];
    [self addRefreshFooter];
    [self addRefreshHeader];
}

#pragma mark 添加导航栏
- (void)addNav{
//    [self.view addSubview:[BaseNavView initNavBackTitle:<#导航栏标题#> rightView:nil]];
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
    HospitalListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HospitalListCell"];
    [cell resetCellWithModel:self.aryDatas[indexPath.row]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [HospitalListCell fetchHeight:self.aryDatas[indexPath.row]];
}

#pragma mark request
- (void)requestList{
    [RequestApi requestHospitalListWithAreaId:[GlobalData sharedInstance].community.iDProperty name:nil page:self.pageNum count:50 delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.pageNum ++;
        NSMutableArray  * aryRequest = [GlobalMethod exchangeDic:[response arrayValueForKey:@"list"] toAryWithModelName:@"ModelHospital"];
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
