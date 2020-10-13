//
//  FindJobListVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/8/31.
//Copyright © 2020 ping. All rights reserved.
//

#import "FindJobListVC.h"
#import "FindJobListView.h"
#import "SearchShopView.h"
//request
#import "RequestApi+FindJob.h"
#import "FindJobDetailVC.h"
#import "RentListFilterListView.h"

@interface FindJobListVC ()
@property (nonatomic, strong) SearchShopNavView *searchView;
@property (nonatomic, strong) FindJobFilterView *filterView;
@property (nonatomic, strong) RentListFilterListView *filterDistrictList;
@property (nonatomic, strong) RentListFilterListView *filterWageList;
@property (nonatomic, strong) RentListFilterListView *filterExperienceList;
@property (nonatomic, strong) ModelBaseData *modelDistrict;
@property (nonatomic, strong) ModelBaseData *modelWage;
@property (nonatomic, strong) ModelBaseData *modelExperience;
@property (nonatomic, strong) FindJobFilterAllView *filterAllView;
@property (nonatomic, assign) int modelWorkProperty;
@property (nonatomic, assign) int modelEducation;
@property (nonatomic, assign) int modelWelfare;
@property (nonatomic, assign) int modelRefreshDate;

@end

@implementation FindJobListVC
- (FindJobFilterAllView *)filterAllView{
    if (!_filterAllView) {
        _filterAllView = [FindJobFilterAllView new];
        _filterAllView.viewTopHeight = self.filterView.bottom;
        [_filterAllView configView];
        WEAKSELF
        _filterAllView.blockSelected = ^(int modelWorkProperty, int modelEducation, int modelWelfare, int modelRefreshDate) {
            weakSelf.modelWorkProperty = modelWorkProperty;
            weakSelf.modelEducation = modelEducation;
            weakSelf.modelWelfare = modelWelfare;
            weakSelf.modelRefreshDate = modelRefreshDate;
            [weakSelf refreshHeaderAll];
        };
    }
    return _filterAllView;
}
- (ModelBaseData *)modelWage{
    if (!_modelWage) {
        _modelWage =  ^(){
            ModelBaseData * model = [ModelBaseData new];
            return model;
        }();
    }
    return _modelWage;
}
- (ModelBaseData *)modelDistrict{
    if (!_modelDistrict) {
        _modelDistrict =  ^(){
            ModelBaseData * model = [ModelBaseData new];
            return model;
        }();
    }
    return _modelDistrict;
}
- (ModelBaseData *)modelExperience{
    if (!_modelExperience) {
        _modelExperience =  ^(){
            ModelBaseData * model = [ModelBaseData new];
            return model;
        }();
    }
    return _modelExperience;
}
- (SearchShopNavView *)searchView{
    if (!_searchView) {
        _searchView = [SearchShopNavView new];
        _searchView.top = NAVIGATIONBAR_HEIGHT;
        _searchView.tfSearch.placeholder = @"请输入职位名称";
        WEAKSELF
        _searchView.blockSearch = ^(NSString *str) {
            [weakSelf refreshHeaderAll];
        };
    }
    return _searchView;
}
- (FindJobFilterView *)filterView{
    if (!_filterView) {
        _filterView = [FindJobFilterView new];
        WEAKSELF
        _filterView.blockIndexClick = ^(int index) {
            if (index == 0) {//地区
                if (weakSelf.modelDistrict.aryDatas.count) {
                    [weakSelf.view addSubview:weakSelf.filterDistrictList];
                }else{
                    [RequestApi requestFJDistrictDataListDelegate:weakSelf success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
                        
                        NSMutableArray * ary = [GlobalMethod exchangeDic:[response arrayValueForKey:@"list"] toAryWithModelName:@"ModelFJData"];
                        [ary insertObject:^(){
                            ModelFJData * item = [ModelFJData new];
                            item.categoryname = @"全部";
                            return item;
                        }() atIndex:0];
                        weakSelf.modelDistrict.aryDatas = ary;
                        NSMutableArray * aryStr = [NSMutableArray new];
                        for (ModelFJData * modelData in ary) {
                            [aryStr addObject:UnPackStr(modelData.categoryname)];
                        }
                        [weakSelf.filterDistrictList resetViewWithArys:aryStr top:weakSelf.filterView.bottom];
                        [weakSelf.view addSubview:weakSelf.filterDistrictList];
                        
                    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
                        
                    }];
                }
            }else if (index == 1) {//工资
                if (weakSelf.modelWage.aryDatas.count) {
                    [weakSelf.view addSubview:weakSelf.filterWageList];
                }else{
                    [RequestApi requestFJWageDataListDelegate:weakSelf success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
                        
                        NSMutableArray * ary = [GlobalMethod exchangeDic:[response arrayValueForKey:@"list"] toAryWithModelName:@"ModelFJData"];
                        [ary insertObject:^(){
                            ModelFJData * item = [ModelFJData new];
                            item.categoryname = @"全部";
                            return item;
                        }() atIndex:0];
                        weakSelf.modelWage.aryDatas = ary;
                        NSMutableArray * aryStr = [NSMutableArray new];
                        for (ModelFJData * modelData in ary) {
                            [aryStr addObject:UnPackStr(modelData.categoryname)];
                        }
                        [weakSelf.filterWageList resetViewWithArys:aryStr top:weakSelf.filterView.bottom];
                        [weakSelf.view addSubview:weakSelf.filterWageList];
                        
                    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
                        
                    }];
                }
            }else if (index == 2) {//经验
                if (weakSelf.modelExperience.aryDatas.count) {
                    [weakSelf.view addSubview:weakSelf.filterExperienceList];
                }else{
                    [RequestApi requestFJExperienceDataListDelegate:weakSelf success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
                        
                        NSMutableArray * ary = [GlobalMethod exchangeDic:[response arrayValueForKey:@"list"] toAryWithModelName:@"ModelFJData"];
                        [ary insertObject:^(){
                            ModelFJData * item = [ModelFJData new];
                            item.categoryname = @"全部";
                            return item;
                        }() atIndex:0];
                        weakSelf.modelExperience.aryDatas = ary;
                        NSMutableArray * aryStr = [NSMutableArray new];
                        for (ModelFJData * modelData in ary) {
                            [aryStr addObject:UnPackStr(modelData.categoryname)];
                        }
                        [weakSelf.filterExperienceList resetViewWithArys:aryStr top:weakSelf.filterView.bottom];
                        [weakSelf.view addSubview:weakSelf.filterExperienceList];
                        
                    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
                        
                    }];
                }
            }
        };
        _filterView.blockFilterClick = ^{
            [weakSelf.filterAllView show];
        };
        _filterView.top = self.searchView.bottom;
    }
    return _filterView;
}
- (RentListFilterListView *)filterDistrictList{
    if (!_filterDistrictList) {
        _filterDistrictList = [RentListFilterListView new];
        WEAKSELF
        _filterDistrictList.blockSelected = ^(int index) {
            if (weakSelf.modelDistrict.aryDatas.count > index) {
                ModelFJData * data = weakSelf.modelDistrict.aryDatas[index];
                weakSelf.modelDistrict.identifier = data.iDProperty;
                [weakSelf refreshHeaderAll];
            }
            
        };
    }
    return _filterDistrictList;
}
- (RentListFilterListView *)filterWageList{
    if (!_filterWageList) {
        _filterWageList = [RentListFilterListView new];
        WEAKSELF
        _filterWageList.blockSelected = ^(int index) {
            if (weakSelf.modelWage.aryDatas.count > index) {
                ModelFJData * data = weakSelf.modelWage.aryDatas[index];
                weakSelf.modelWage.identifier = data.iDProperty;
                [weakSelf refreshHeaderAll];
            }
        };
    }
    return _filterWageList;
}
- (RentListFilterListView *)filterExperienceList{
    if (!_filterExperienceList) {
        _filterExperienceList = [RentListFilterListView new];
        WEAKSELF
        _filterExperienceList.blockSelected = ^(int index) {
            if (weakSelf.modelExperience.aryDatas.count > index) {
                ModelFJData * data = weakSelf.modelExperience.aryDatas[index];
                weakSelf.modelExperience.identifier = data.iDProperty;
                [weakSelf refreshHeaderAll];
            }
        };
    }
    return _filterExperienceList;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    [self.view addSubview:self.searchView];
    [self.view addSubview:self.filterView];

    //添加导航栏
    self.tableView.top = self.filterView.bottom;
    self.tableView.height = SCREEN_HEIGHT-self.filterView.bottom;
    self.tableView.backgroundColor = COLOR_GRAY;
    //table
    [self.tableView registerClass:[FindJobListCell class] forCellReuseIdentifier:@"FindJobListCell"];
    //request
    [self requestList];
    [self addRefresh];
}

#pragma mark 添加导航栏
- (void)addNav{
    NSString * navTitle = nil;
    switch (self.type) {
        case ENUM_FINDJOB_LIST_RECOMMEND:
            navTitle = @"最新职位";
            break;
        case ENUM_FINDJOB_LIST_FIND:
            navTitle = @"找工作";
            break;
        case ENUM_FINDJOB_LIST_NEARBY:
            navTitle = @"附近工作";
            break;
        default:
            break;
    }
    [self.view addSubview:[BaseNavView initNavBackTitle:navTitle rightView:nil]];
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
    FindJobListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"FindJobListCell"];
    [cell resetCellWithModel:self.aryDatas[indexPath.row]];
    return cell;;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [FindJobListCell fetchHeight:self.aryDatas[indexPath.row]];
}
//table header
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return  nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
//table footer
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FindJobDetailVC * detailVC = [FindJobDetailVC new];
    detailVC.modelList = self.aryDatas[indexPath.row];
    [GB_Nav pushViewController:detailVC animated:true];
}
#pragma mark request
- (void)requestList{
    NSString * type = nil;
    switch (self.type) {
        case ENUM_FINDJOB_LIST_FIND:
            type = @"jobs_commpany";
            break;
        case ENUM_FINDJOB_LIST_NEARBY:
            type = @"nearby_jobs";
            break;
        case ENUM_FINDJOB_LIST_RECOMMEND:
            type = @"recommend_jobs";
            break;
        default:
            break;
    }
    [RequestApi requestFJJobListDelegate:self page:self.pageNum type:type citycategory:self.modelDistrict.identifier.doubleValue wage:self.modelWage.identifier.doubleValue experience:self.modelExperience.identifier.doubleValue nature:self.modelWorkProperty education:self.modelEducation jobtag:self.modelWelfare settr:self.modelRefreshDate
                                     key:self.searchView.tfSearch.text
success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.pageNum ++;
        NSMutableArray  * aryRequest = [GlobalMethod exchangeDic:[response arrayValueForKey:@"list"] toAryWithModelName:@"ModelFJJobList"];
        if (self.isRemoveAll) {
            [self.aryDatas removeAllObjects];
        }
        [self.aryDatas addObjectsFromArray:aryRequest];
        if (self.aryDatas.count >= [response doubleValueForKey:@"total"] ) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        [self.tableView reloadData];

    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
   
}
@end
