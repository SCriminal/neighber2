//
//  CommunityVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/7.
//Copyright © 2020 ping. All rights reserved.
//

#import "CommunityVC.h"
//view
#import "CommunityView.h"
//auto sc view
#import "AutoScView.h"
//collection view
#import "CommunityCollectionView.h"
//section title
#import "SectionTitleView.h"
//request
#import "RequestApi+Neighbor.h"
//detail
#import "JournalismDetailVC.h"
#import "WhistleTabVC.h"
//web
#import "WebVC.h"
#import "WebInterActionVC.h"
//请求单例
#import "RequestInstance.h"
//switch community
#import "SwitchArchiveView.h"
#import "AutoNewsView.h"
//
#import "JournalismListVC.h"

@interface CommunityVC ()
@property (nonatomic, strong) CommunityNavView *navView;
@property (nonatomic, strong) AutoScView *autoSCView;
@property (nonatomic, strong) CommunityCollectionView *collection;
@property (nonatomic, strong) SectionTitleView *infoTitleView;
@property (nonatomic, strong) UIView *tableHeaderView;
@property (nonatomic, strong) CommunitySubCollectionView *subCollectionView;
@property (nonatomic, strong) NSArray *aryADs;
@property (nonatomic, strong) NSArray *aryNews;
@property (nonatomic, strong) NSArray *aryCommunitysWithArchive;
@property (nonatomic, strong) AutoNewsView *autoNewsView;
@end

@implementation CommunityVC
#pragma mark noresult view
@synthesize noResultView = _noResultView;
- (BOOL)isShowNoResult{
    return true;
}
- (NoResultView *)noResultView{
    if (!_noResultView) {
        _noResultView = [NoResultView new];
        [_noResultView resetWithImageName:@"empty_default" title:@"暂无内容"];
    }
    return _noResultView;
}
- (HouseKeepingVC *)houseKeepingVC{
    if (!_houseKeepingVC) {
        _houseKeepingVC = [HouseKeepingVC new];
    }
    return _houseKeepingVC;
}

- (AutoNewsView *)autoNewsView{
    if (!_autoNewsView) {
        _autoNewsView = [AutoNewsView new];
        [_autoNewsView timerStart];
        _autoNewsView.blockClick = ^(int index) {
            JournalismListVC * vc = [JournalismListVC new];
            vc.type = ENUM_NEWS_LIST_NOTICE;
            [GB_Nav pushViewController:vc animated:true];
            //            if (weakSelf.aryNews.count > index) {
            //                [weakSelf jumpToNewsDetail:[weakSelf.aryNews objectAtIndex:index]];
            //            }
        };
    }
    return _autoNewsView;
}
#pragma mark lazy init
- (CommunitySubCollectionView *)subCollectionView{
    if (!_subCollectionView) {
        _subCollectionView = [[CommunitySubCollectionView alloc]initWithNum:5];
        
    }
    return _subCollectionView;
}
- (CommunityNavView *)navView{
    if (!_navView) {
        _navView = [CommunityNavView new];
        _navView.top = STATUSBAR_HEIGHT;
        _navView.blockChangeDistrictClick = ^{
            [GB_Nav pushVCName:@"SelectCommunityVC" animated:true];
        };
        WEAKSELF
        _navView.blockSwitchDistrictClick = ^{
            [GlobalMethod judgeLoginState:^{
                [weakSelf requestArchive];
            }];
        };
    }
    return _navView;
}
- (AutoScView *)autoSCView{
    if (!_autoSCView) {
        _autoSCView = [[AutoScView alloc]initWithFrame:CGRectMake(W(15), W(17), SCREEN_WIDTH - W(30), W(125)) image:@[@"temp_community1"]];
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
- (CommunityCollectionView *)collection{
    if (!_collection) {
        _collection = [CommunityCollectionView new];
    }
    return _collection;
}
- (SectionTitleView *)infoTitleView{
    if (!_infoTitleView) {
        _infoTitleView = [SectionTitleView new];
        _infoTitleView.blockClick = ^{
            [GB_Nav pushVCName:@"JournalismListVC" animated:true];
        };
    }
    return _infoTitleView;
}
- (UIView *)tableHeaderView{
    if (!_tableHeaderView) {
        _tableHeaderView = [UIView new];
        _tableHeaderView.width = SCREEN_WIDTH;
        _tableHeaderView.backgroundColor = [UIColor clearColor];
    }
    return _tableHeaderView;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    [self reconfigView];
    [self addRefreshHeader];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(communityRefresh) name:NOTICE_COMMUNITY_REFERSH object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(communityRefresh) name:NOTICE_SELFMODEL_CHANGE object:nil];
    [self addChildViewController:self.houseKeepingVC];
    //table
    self.tableView.top = self.navView.bottom;
    self.tableView.height = SCREEN_HEIGHT - self.navView.bottom - TABBAR_HEIGHT;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, W(13.5), 0);
    [self.tableView registerClass:[CommunityInfoCell class] forCellReuseIdentifier:@"CommunityInfoCell"];
    //request
    [self communityRefresh];
}


- (void)reconfigView{
    [self.tableHeaderView removeAllSubViews];
    //auto sc
    [self.tableHeaderView addSubview:self.autoSCView];
    
    CGFloat top = self.autoSCView.bottom+W(15);
    if (self.aryNews.count) {
        [self.tableHeaderView addSubview:self.autoNewsView];
        self.autoNewsView.top = top;
        top = self.autoNewsView.bottom + W(15);
    }
    
    if (self.collection.aryModel.count) {
        self.collection.top = top;
        [self.tableHeaderView addSubview:self.collection];
        top = self.collection.bottom+W(10);
    }
    
    if (self.subCollectionView.aryModel.count) {
        self.subCollectionView.top = top;
        [self.tableHeaderView addSubview:self.subCollectionView];
        top = self.subCollectionView.bottom;
    }
    
    self.infoTitleView.top = top+W(35);
    [self.tableHeaderView addSubview:self.infoTitleView];
    
    
    self.tableHeaderView.height = self.infoTitleView.bottom+W(13.5);
    self.tableView.tableHeaderView = self.tableHeaderView;
}
#pragma mark 添加导航栏
- (void)addNav{
    [self.view addSubview:self.navView];
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
    CommunityInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CommunityInfoCell"];
    [cell resetCellWithModel:self.aryDatas[indexPath.row]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [CommunityInfoCell fetchHeight:self.aryDatas[indexPath.row]];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self jumpToNewsDetail:self.aryDatas[indexPath.row]];
}
- (void)jumpToNewsDetail:(ModelNews *)news{
    JournalismDetailVC * vc = [JournalismDetailVC new];
    vc.model = news;
    [GB_Nav pushViewController:vc animated:true];
}
#pragma mark request
- (void)communityRefresh{
    [self requestModule];
    [self requestSubModule];
    [self refreshHeaderAll];
    [self requestADList];
    [self requestNewsList];
}
- (void)requestList{
    
    [RequestApi requestNewsListWithScopeid:[GlobalData sharedInstance].community.iDProperty page:self.pageNum count:50 categoryAlias:@"news" delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        NSMutableArray  * aryRequest = [GlobalMethod exchangeDic:[response arrayValueForKey:@"list"] toAryWithModelName:@"ModelNews"];
        for (ModelNews * item in aryRequest.copy) {
            if ([item.title containsString:@"疫情"]) {
                [aryRequest removeObject:item];
            }
        }
        [self.aryDatas removeAllObjects];
        for (int i = 0; i<MIN(aryRequest.count, 6); i++) {
            [self.aryDatas addObject:aryRequest[i]];
        }
        [self.tableView reloadData];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
- (void)requestADList{
    [RequestApi requestADListWithGroupalias:@"community_1" scopeId:[GlobalData sharedInstance].community.iDProperty delegate:nil success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        NSArray * ary = [GlobalMethod exchangeDic:response toAryWithModelName:@"ModelAD"];
        self.aryADs = ary;
        NSArray * aryAds = [ary fetchValues:@"coverUrl"];
        [self.autoSCView resetWithImageAry:aryAds];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
- (void)requestNewsList{
    [RequestApi requestNewsListWithScopeid:[GlobalData sharedInstance].community.iDProperty page:1 count:50 categoryAlias:@"notice" delegate:nil success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        NSMutableArray  * aryRequest = [GlobalMethod exchangeDic:[response arrayValueForKey:@"list"] toAryWithModelName:@"ModelNews"];
        for (ModelNews * item in aryRequest.copy) {
            if ([item.title containsString:@"疫情"]) {
                [aryRequest removeObject:item];
            }
        }
        self.aryNews = aryRequest;
        [self.autoNewsView resetWithAry:[self.aryNews fetchValues:@"title"]];
        
        [self reconfigView];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
- (void)requestSubModule{
    [RequestApi requestModuleHotListWithAreaid:[GlobalData sharedInstance].community.iDProperty  page:1 count:13 delegate:nil success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        NSMutableArray * aryResponse = [GlobalMethod exchangeDic:[response arrayValueForKey:@"list"] toAryWithModelName:@"ModelModule"];
        [aryResponse addObject:^(){
            ModelModule * model = [ModelModule new];
            model.moduleName = @"更多";
            model.iconUrl = @"community_more";
            model.ios = @"TabVC1";
            model.goMode = 3;
            return model;
        }()];
        if (isAry(aryResponse)) {
            [self.subCollectionView resetWithAry:aryResponse];
        }
        [self reconfigView];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
    
}

- (void)requestModule{
    [RequestApi requestModuleWithLocationaliases:@"resident_main" areaId:[GlobalData sharedInstance].community.iDProperty delegate:nil success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        NSMutableArray * aryResponse = [GlobalMethod exchangeDic:[response arrayValueForKey:@"resident_main"] toAryWithModelName:@"ModelModule"];
        if (!isAry(aryResponse)) {
            return;
        }
        [self.collection resetWithAry:aryResponse];
        [self reconfigView];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
- (void)requestArchive{
    [RequestApi requestCommunityListWithArchiveDelegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.aryCommunitysWithArchive = [GlobalMethod exchangeDic:response toAryWithModelName:@"ModelCommunity"];
        if (self.aryCommunitysWithArchive.count == 0) {
            return;
        }
        self.navView.arrow.highlighted = true;
        SwitchArchiveView * switchView = [SwitchArchiveView new];
        [switchView resetViewWithArys:[self.aryCommunitysWithArchive fetchValues:@"name"]];
        WEAKSELF
        switchView.blockSelected = ^(int index) {
            weakSelf.navView.arrow.highlighted = false;
            ModelCommunity * model = weakSelf.aryCommunitysWithArchive[index];
            [GlobalData sharedInstance].community = model;
        };
        switchView.blockCancel = ^{
            weakSelf.navView.arrow.highlighted = false;
        };
        [[UIApplication sharedApplication].keyWindow  addSubview:switchView];
        
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
    
}
- (void)requestSwtichArchive{
    
}
@end
