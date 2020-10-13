//
//  FindJobMainVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/8/27.
//Copyright © 2020 ping. All rights reserved.
//

#import "FindJobMainVC.h"
#import "AutoScView.h"
//web
#import "WebVC.h"
//request
#import "RequestApi+Neighbor.h"
#import "ModuleCollectionView.h"
#import "FindJobMainView.h"
#import "FindJobNoticeListVC.h"
//section title
#import "SectionTitleView.h"
//request
#import "RequestApi+FindJob.h"
#import "FindJobListVC.h"
#import "FindJobDetailVC.h"
#import "BaseVC+Location.h"


@interface FindJobMainVC ()
@property (nonatomic, strong) AutoScView *autoSCView;
@property (nonatomic, strong) NSArray *aryADs;
@property (nonatomic, strong) UIView *tableHeaderView;
@property (nonatomic, strong) ModuleCollectionView *collection;
@property (nonatomic, strong) FindJobNewsView *autoNewsView;
@property (nonatomic, strong) SectionTitleView *infoTitleView;
@property (nonatomic, strong) UIView *homeAlert;

@end

@implementation FindJobMainVC
- (SectionTitleView *)infoTitleView{
    if (!_infoTitleView) {
        _infoTitleView = [SectionTitleView new];
        _infoTitleView.blockClick = ^{
            FindJobListVC * listVC = [FindJobListVC new];
            listVC.type = ENUM_FINDJOB_LIST_RECOMMEND;
            [GB_Nav pushViewController:listVC animated:true];
        };
        _infoTitleView.title.text = @"最新职位";
    }
    return _infoTitleView;
}
- (UIView *)homeAlert{
    if (!_homeAlert) {
        _homeAlert = [UIView new];
        _homeAlert.backgroundColor = [UIColor clearColor];
        _homeAlert.width = SCREEN_WIDTH;
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(11) weight:UIFontWeightRegular];
        l.textColor = COLOR_999;
        l.backgroundColor = [UIColor clearColor];
        [l fitTitle:@"潍社区工作数据由“潍坊人才网”提供" variable:0];
        l.centerXTop = XY(SCREEN_WIDTH/2.0, 0);
        [_homeAlert addSubview:l];
        _homeAlert.height = l.bottom;
    }
    return _homeAlert;
}
- (FindJobNewsView *)autoNewsView{
    if (!_autoNewsView) {
        _autoNewsView = [FindJobNewsView new];
        [_autoNewsView timerStart];
        _autoNewsView.blockClick = ^(int index) {
            FindJobNoticeListVC * vc = [FindJobNoticeListVC new];
            [GB_Nav pushViewController:vc animated:true];
        };
    }
    return _autoNewsView;
}

- (ModuleCollectionView *)collection{
    if (!_collection) {
        _collection = [[ModuleCollectionView alloc]initWithNum:5];
    }
    return _collection;
}

- (UIView *)tableHeaderView{
    if (!_tableHeaderView) {
        _tableHeaderView = [UIView new];
        _tableHeaderView.width = SCREEN_WIDTH;
        _tableHeaderView.backgroundColor = [UIColor clearColor];
    }
    return _tableHeaderView;
}
- (AutoScView *)autoSCView{
    if (!_autoSCView) {
        _autoSCView = [[AutoScView alloc]initWithFrame:CGRectMake(W(15), W(17), SCREEN_WIDTH - W(30), W(125)) image:@[@"temp_community3"]];
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
- (void)reconfigView{
    [self.tableHeaderView removeAllSubViews];
    //auto sc
    [self.tableHeaderView addSubview:self.autoSCView];
    
    CGFloat top = self.autoSCView.bottom;
    
    self.homeAlert.top = top + W(15);
    [self.tableHeaderView addSubview:self.homeAlert];
    top = self.homeAlert.bottom+ W(15);
    
    if (self.collection.aryModel.count) {
        self.collection.top = top ;
        [self.tableHeaderView addSubview:self.collection];
        top = self.collection.bottom;
    }
    
    self.autoNewsView.top = top;
    [self.tableHeaderView addSubview:self.autoNewsView];
    top = self.autoNewsView.bottom+W(15);
    
    self.infoTitleView.top = top;
    [self.tableHeaderView addSubview:self.infoTitleView];
    top = self.infoTitleView.bottom+W(3);
    
    
    self.tableHeaderView.height = top ;
    self.tableView.tableHeaderView = self.tableHeaderView;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    [self initLocation];

    //table
    [self.tableView registerClass:[FindJobNewsCell class] forCellReuseIdentifier:@"FindJobNewsCell"];
    //request
    [self addRefreshHeader];
    [self requestList];
    [self requestADs];
    [self requestNewsList];
    [self reconfigView];
    [self addRefresh];
}

#pragma mark 添加导航栏
- (void)addNav{
    [self.view addSubview:[BaseNavView initNavBackTitle:@"找工作" rightView:nil]];
}

#pragma mark UITableViewDelegate
//row num
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.aryDatas.count;
}
//cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FindJobNewsCell * cell = [tableView dequeueReusableCellWithIdentifier:@"FindJobNewsCell"];
    [cell resetCellWithModel:self.aryDatas[indexPath.row]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [FindJobNewsCell fetchHeight:self.aryDatas[indexPath.row]];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FindJobDetailVC * detailVC = [FindJobDetailVC new];
    detailVC.modelList = self.aryDatas[indexPath.row];
    [GB_Nav pushViewController:detailVC animated:true];
}
#pragma mark request
- (void)requestList{
    [RequestApi requestFJNewJobListDelegate:self type:@"recommend_jobs" page:self.pageNum  success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.pageNum ++;
        NSMutableArray  * aryRequest = [GlobalMethod exchangeDic:[response arrayValueForKey:@"list"] toAryWithModelName:@"ModelFJJobList"];
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
- (void)requestADs{
    [RequestApi requestADListWithGroupalias:@"wfrcsc" scopeId:[GlobalData sharedInstance].community.iDProperty delegate:nil success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        [self requestModule];
        NSArray * ary = [GlobalMethod exchangeDic:response toAryWithModelName:@"ModelAD"];
        self.aryADs = ary;
        NSArray * aryAds = [ary fetchValues:@"coverUrl"];
        [self.autoSCView resetWithImageAry:aryAds];
        
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
- (void)requestNewsList{
    [RequestApi requestFJMainNewsListDelegate:nil page:1 success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        NSArray * ary = [GlobalMethod exchangeDic:[response arrayValueForKey:@"list"] toAryWithModelName:@"ModelNews"];
        [self.autoNewsView resetWithAry:[ary fetchValues:@"title"]];
        [self reconfigView];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
    
}
- (void)requestModule{
    [RequestApi requestModuleWithLocationaliases:@"resident_wfrcsc" areaId:[GlobalData sharedInstance].community.iDProperty delegate:nil success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        NSMutableArray * aryResponse = [GlobalMethod exchangeDic:[response arrayValueForKey:@"resident_wfrcsc"] toAryWithModelName:@"ModelModule"];
        if (!isAry(aryResponse)) {
            return;
        }
        [self.collection resetWithAry:aryResponse];
        [self reconfigView];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
@end
