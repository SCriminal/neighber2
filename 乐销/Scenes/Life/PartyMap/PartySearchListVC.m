//
//  PartySearchListVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/6/30.
//Copyright © 2020 ping. All rights reserved.
//

#import "PartySearchListVC.h"
#import "PartyMapView.h"
//request
#import "RequestApi+Neighbor.h"
#import "BaseVC+Location.h"

@interface PartySearchListVC ()
@property (nonatomic, strong) PartyMapSearchView *searchView;
@property (nonatomic, strong) NSString *name;

@end

@implementation PartySearchListVC
#pragma mark noresult view
@synthesize noResultView = _noResultView;
- (BOOL)isShowNoResult{
    return true;
}
- (NoResultView *)noResultView{
    if (!_noResultView) {
        _noResultView = [NoResultView new];
        [_noResultView resetWithImageName:@"empty_address" title:@"暂无地址信息"];
    }
    return _noResultView;
}
- (PartyMapSearchView *)searchView{
    if (!_searchView) {
        _searchView = [PartyMapSearchView new];
        WEAKSELF
        _searchView.blockSearch = ^(NSString *str) {
            weakSelf.name = str;
            [weakSelf refreshHeaderAll];
        };
    }
    return _searchView;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshHeaderAll) name:NOTICE_LOCATION_CHANGE object:nil];
    //添加导航栏
    [self addNav];
    //table
    [self.tableView registerClass:[PartySearchListCell class] forCellReuseIdentifier:@"PartySearchListCell"];
    //request
    [self requestList];
    [self addRefresh];
}

#pragma mark 添加导航栏
- (void)addNav{
    [self.view addSubview:self.searchView];
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
    PartySearchListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"PartySearchListCell"];
    [cell resetCellWithModel:self.aryDatas[indexPath.row]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [PartySearchListCell fetchHeight:self.aryDatas[indexPath.row]];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PartySearchListCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    if (self.blockSelected) {
        self.blockSelected(cell.model);
    }
    [GB_Nav popViewControllerAnimated:true];
}
#pragma mark request
- (void)requestList{
    ModelAddress * model = [GlobalMethod readModelForKey:LOCAL_LOCATION  modelName:@"ModelAddress" exchange:false];
//    model.lat = 39;
//    model.lng = 116;
    if (model.lat) {
        [RequestApi requestPartyListWithLat:model.lat lng:model.lng radius:0 name:self.name page:self.pageNum count:50 delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
     
            self.pageNum ++;
            NSMutableArray  * aryRequest = [GlobalMethod exchangeDic:[response arrayValueForKey:@"list"] toAryWithModelName:@"ModelParty"];
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
    }else{
        [self addLocalAuthorityListen];
    }
}

@end
