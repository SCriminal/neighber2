//
//  ManualSelectCommunityVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/23.
//Copyright © 2020 ping. All rights reserved.
//

#import "ManualSelectCommunityVC.h"
#import "SelectCommunityView.h"
//request
#import "RequestApi+Neighbor.h"
//view
#import "SearchShopView.h"

@interface ManualSelectCommunityVC ()
@property (nonatomic, strong) ManualSelectCommunityTopView *topView;
@property (nonatomic, strong) SearchShopNavView *searchView;

@end

@implementation ManualSelectCommunityVC
- (SearchShopNavView *)searchView{
    if (!_searchView) {
        _searchView = [SearchShopNavView new];
        _searchView.top = NAVIGATIONBAR_HEIGHT;
        _searchView.tfSearch.placeholder = @"请输入小区名称";
        WEAKSELF
        _searchView.blockSearch = ^(NSString *str) {
            [weakSelf refreshHeaderAll];
        };
    }
    return _searchView;
}

- (ManualSelectCommunityTopView *)topView{
    if (!_topView) {
        _topView = [ManualSelectCommunityTopView new];
        [_topView.district fitTitle:[NSString stringWithFormat:@"直接进入%@",UnPackStr(self.model.areaName)] variable:SCREEN_WIDTH - W(60)];
        WEAKSELF
        _topView.blockClick = ^{
            ModelCommunity * model = [ModelCommunity new];
            model.iDProperty = weakSelf.model.iDProperty;
            model.name = weakSelf.model.areaName;
            [weakSelf selctCommunity:model];
        };
    };
    _topView.top = self.searchView.bottom;
    return _topView;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.searchView];
    [self.view addSubview:self.topView];
    //添加导航栏
    self.tableView.top = self.topView.bottom;
    self.tableView.height = SCREEN_HEIGHT-self.topView.bottom;
    self.tableBackgroundView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.topView];
    //table
    [self.tableView registerClass:[SelectCommunityCell class] forCellReuseIdentifier:@"SelectCommunityCell"];
    //request
    [self addRefreshHeader];
    [self addNav];
    [self refreshHeaderAll];
}
- (void)addNav{
    BaseNavView * nav = [BaseNavView initNavBackTitle:@"选择小区" rightView:nil];
    nav.backgroundColor = [UIColor clearColor];
    [self.view addSubview:nav];
    
}
#pragma mark UITableViewDelegate
//row num
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.aryDatas.count;
}

//cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SelectCommunityCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SelectCommunityCell"];
    [cell resetCellWithModel:self.aryDatas[indexPath.row]];
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [SelectCommunityCell fetchHeight:self.aryDatas[indexPath.row]];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self selctCommunity:self.aryDatas[indexPath.row]];
}
- (void)selctCommunity:(ModelCommunity *)model{
    if (self.blockSelectCommunity) {
        self.blockSelectCommunity(model);
        return;
    }
    [GlobalData sharedInstance].community = model;
    [GB_Nav popToRootViewControllerAnimated:true];
}

#pragma mark request
- (void)requestList{
    [RequestApi requestCommunityCityListWithName:self.searchView.tfSearch.text cityId:0 countyId:self.model.iDProperty page:self.pageNum count:50 delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.pageNum ++;
        NSMutableArray  * aryRequest = [GlobalMethod exchangeDic:[response arrayValueForKey:@"list"] toAryWithModelName:@"ModelCommunityCity"];
        if (self.isRemoveAll) {
            [self.aryDatas removeAllObjects];
        }
        if (!isAry(aryRequest)) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        
        for (ModelCommunityCity * modelCity in aryRequest) {
            ModelCommunity * modelCommunity = [ModelCommunity new];
            modelCommunity.iDProperty = modelCity.iDProperty;
            modelCommunity.name = modelCity.areaName;
            [self.aryDatas addObject:modelCommunity];
        }
        
        [self.tableView reloadData];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
    
    
    
}

@end
