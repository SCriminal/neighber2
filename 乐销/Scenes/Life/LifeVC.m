//
//  LifeVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/7.
//Copyright © 2020 ping. All rights reserved.
//

#import "LifeVC.h"
//auto sc view
#import "AutoScView.h"
//collection view
#import "ModuleCollectionView.h"
#import "WebVC.h"
//request
#import "RequestApi+Neighbor.h"
//SecurityTabVC
#import "SecurityTabVC.h"
#import "SearchShopView.h"
#import "LifeView.h"
#import "RequestInstance.h"
#import "CommunityView.h"
@interface LifeVC ()
@property (nonatomic, strong) AutoScView *autoSCView;
@property (nonatomic, strong) NSMutableArray *arySections;
@property (nonatomic, strong) NSMutableArray *aryCollections;
@property (nonatomic, strong) UIView *tableHeaderView;
@property (nonatomic, strong) NSArray *aryADs;
@property (nonatomic, strong) SearchShopNavView *searchView;
@property (nonatomic, strong) LifeFoldView *arrowView;
@property (nonatomic, strong) CommunitySubCollectionView *subCollectionView;
@property (nonatomic, strong) UIView *subCollectionTitle;

@end

@implementation LifeVC


#pragma mark lazy init
- (UIView *)subCollectionTitle{
    if (!_subCollectionTitle) {
        _subCollectionTitle = [UIView new];
        _subCollectionTitle.backgroundColor = [UIColor clearColor];
               _subCollectionTitle.width = SCREEN_WIDTH;
               UILabel * label = [UILabel new];
               label.textColor = COLOR_333;
               label.font = [UIFont systemFontOfSize:F(17) weight:UIFontWeightMedium];
               [label fitTitle:@"常用应用" variable:0];
               label.left = W(25);
               _subCollectionTitle.height = label.height;
               [_subCollectionTitle addSubview:label];
    }
    return _subCollectionTitle;
}
- (CommunitySubCollectionView *)subCollectionView{
    if (!_subCollectionView) {
        _subCollectionView = [[CommunitySubCollectionView alloc]initWithNum:5];
        
    }
    return _subCollectionView;
}
- (NSMutableArray *)arySections{
    if (!_arySections) {
        _arySections = [NSMutableArray new];
    }
    return _arySections;
}
- (NSMutableArray *)aryCollections{
    if (!_aryCollections) {
        _aryCollections = [NSMutableArray new];
    }
    return _aryCollections;
}
- (SearchShopNavView *)searchView{
    if (!_searchView) {
        _searchView = [SearchShopNavView new];
        _searchView.tfSearch.placeholder = @"搜索您感兴趣的应用";
        for (UIView * subView in _searchView.subviews) {
            subView.userInteractionEnabled = false;
        }
        [_searchView addTarget:self action:@selector(searchClick)];
    }
    return _searchView;
}
- (AutoScView *)autoSCView{
    if (!_autoSCView) {
        _autoSCView = [[AutoScView alloc]initWithFrame:CGRectMake(W(15), W(17), SCREEN_WIDTH - W(30), W(125)) image:@[@"temp_life1"]];
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
- (LifeFoldView *)arrowView{
    if (!_arrowView) {
        _arrowView = [LifeFoldView new];
        WEAKSELF
        _arrowView.blockClick = ^{
            weakSelf.arrowView.iconFold.highlighted = !weakSelf.arrowView.iconFold.highlighted;
            [weakSelf reconfigView];
        };
    }
    return _arrowView;
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
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(configView) name:NOTICE_COMMUNITY_REFERSH object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(configView) name:NOTICE_SELFMODEL_CHANGE object:nil];

    //table
    self.tableView.top = NAVIGATIONBAR_HEIGHT;
    self.tableView.height = SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT - TABBAR_HEIGHT;
    //request
    [self configView];
}
- (void)configView{
    NSArray * aryTitles = nil;
//    if ([GlobalMethod isLoginSuccess]) {
//        aryTitles = @[@"我的应用",@"党建先锋",@"政务服务",@"社区服务",@"物业服务",@"公共服务",@"医疗养老",@"家政服务",@"安全服务"];
//    }else{
//        aryTitles = @[@"党建先锋",@"政务服务",@"社区服务",@"物业服务",@"公共服务",@"医疗养老",@"家政服务",@"安全服务"];
//    }
   aryTitles = @[@"我的应用",@"党建先锋",@"政务服务",@"社区服务",@"物业服务",@"公共服务",@"医疗养老",@"家政服务",@"安全服务"];

    [self.arySections removeAllObjects];
    [self.aryCollections removeAllObjects];
    
    for (NSString * title in aryTitles) {
        UIView * _section0 = [UIView new];
        _section0.width = SCREEN_WIDTH;
        UILabel * label = [UILabel new];
        label.textColor = COLOR_333;
        label.font = [UIFont systemFontOfSize:F(17) weight:UIFontWeightMedium];
        [label fitTitle:title variable:0];
        label.left = W(25);
        _section0.height = label.height;
        [_section0 addSubview:label];
        [self.arySections addObject:_section0];
        
        ModuleCollectionView * view = [[ModuleCollectionView alloc]initWithNum:5];
        view.isMyself = [title isEqualToString:@"我的应用"];
        [self.aryCollections addObject:view];
    }
    [self reconfigView];
    [self refreshHeaderAll];
}
- (void)reconfigView{
    [self.tableHeaderView removeAllSubViews];
    //auto sc
    [self.tableHeaderView addSubview:self.autoSCView];
    CGFloat top = self.autoSCView.bottom + W(25);
    
        self.searchView.centerXTop = XY(SCREEN_WIDTH/2.0, self.autoSCView.bottom + W(15));
        [self.tableHeaderView addSubview:self.searchView];
        top = self.searchView.bottom + W(25);
    
    for (int i = 0; i<self.aryCollections.count; i++) {
        ModuleCollectionView * collection = self.aryCollections[i];
        UIView * section = self.arySections[i];
        if (collection.aryModel.count) {
            section.top = top;
            [self.tableHeaderView addSubview:section];
            
            collection.top = section.bottom+W(20);
            [self.tableHeaderView addSubview:collection];
            top = collection.bottom + W(25);
            
            if (collection.isMyself) {
                if ([GlobalMethod isLoginSuccess]) {
                    self.subCollectionTitle.top = top-W(5);
                    [self.tableHeaderView addSubview:self.subCollectionTitle];
                    top = self.subCollectionTitle.bottom+W(20);

                    self.subCollectionView.top = top;
                    [self.tableHeaderView addSubview:self.subCollectionView];
                    top = self.subCollectionView.bottom + W(25);
                }
                
                self.arrowView.top = top - W(20);
                [self.tableHeaderView addSubview:self.arrowView];
                top = self.arrowView.bottom;
                
                
                if (self.arrowView.iconFold.isHighlighted) {
                    break;
                }
            }
        }
        
       
    }
    self.tableHeaderView.height = top - W(11.5);
    self.tableView.tableHeaderView = self.tableHeaderView;
}
#pragma mark 添加导航栏
- (void)addNav{
    [self.view addSubview:[BaseNavView initNavTitle:@"便民生活" leftView:nil rightView:nil]];
}


#pragma mark request
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    static int num = 0;
    if (num == 0) {
        num = 1;
    }else{
        [self requestExtendToken];
    }
}
- (void)requestExtendToken{
    static int requestSuccess = 0;
    if (requestSuccess) {
        return;
    }
    if (![GlobalMethod isLoginSuccess]) {
        requestSuccess = 1;
        return;
    }
    if ([RequestInstance sharedInstance].tasks.count == 0) {
        requestSuccess = 1;
        [RequestApi requestExtendTokenSuccess:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
            NSString * token = [response stringValueForKey:@"token"];
            if (isStr(token)) {
                [GlobalData sharedInstance].GB_Key = token;
            }
        } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
            
        }];
    }
}
- (void)requestList{
    [RequestApi requestADListWithGroupalias:@"live_1" scopeId:[GlobalData sharedInstance].community.iDProperty delegate:nil success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        [self requestModule];
        NSArray * ary = [GlobalMethod exchangeDic:response toAryWithModelName:@"ModelAD"];
        self.aryADs = ary;
        NSArray * aryAds = [ary fetchValues:@"coverUrl"];
        [self.autoSCView resetWithImageAry:aryAds];

    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
- (void)requestSelfModule{
    if ([GlobalMethod isLoginSuccess]) {
        [RequestApi requestPersonalModuleWithDelegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
            [self requestSubModule];
               NSMutableArray * aryResponse = [GlobalMethod exchangeDic:[response arrayValueForKey:@"list"] toAryWithModelName:@"ModelModule"];
               [aryResponse addObject:^(){
                   ModelModule * model = [ModelModule new];
                   model.moduleName = @"添加";
                   model.iconUrl = @"addModule";
                   model.goMode = 3;
                   model.isLogin = true;
                   model.ios = @"ManualModuleVC";
                   return model;
               }()];
               ModuleCollectionView * collectionView = self.aryCollections[0];
               if (collectionView.isMyself) {
                           [collectionView resetWithAry:aryResponse];
                   [self reconfigView];
               }
           } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {

           }];
        
    }else {
        ModuleCollectionView * collectionView = self.aryCollections[0];
        if (collectionView.isMyself) {
            [collectionView resetWithAry:@[^(){
                ModelModule * model = [ModelModule new];
                model.moduleName = @"添加";
                model.iconUrl = @"addModule";
                model.goMode = 3;
                model.isLogin = true;
                model.ios = @"ManualModuleVC";
                return model;
            }()].mutableCopy];
            [self reconfigView];
        }

    }
   
   
}
- (void)requestModule{
    int next = 0;
    ModuleCollectionView * collectionView = self.aryCollections[0];
    if (collectionView.isMyself) {
        next = 1;
    }
    NSArray * aryAlias = @[@"resident_party",@"resident_gov",@"resident_estate",@"resident_property",@"resident_public",@"resident_hospital",@"resident_housekeeping",@"resident_security"];
    [RequestApi requestModuleWithLocationaliases:[aryAlias componentsJoinedByString:@","] areaId:[GlobalData sharedInstance].community.iDProperty delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        [self requestSelfModule];
        for (int i = 0; i<aryAlias.count; i++) {
            NSString * strAlias = aryAlias[i];
            ModuleCollectionView * collectionView = self.aryCollections[i+next];
            NSMutableArray * aryResponse = [GlobalMethod exchangeDic:[response arrayValueForKey:strAlias] toAryWithModelName:@"ModelModule"];
            if (isAry(aryResponse)) {
                [collectionView resetWithAry:aryResponse];
            }
        }
        [self reconfigView];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
- (void)requestSubModule{
    [RequestApi requestModuleHotListWithAreaid:[GlobalData sharedInstance].community.iDProperty  page:1 count:10 delegate:nil success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        NSMutableArray * aryResponse = [GlobalMethod exchangeDic:[response arrayValueForKey:@"list"] toAryWithModelName:@"ModelModule"];
        if (isAry(aryResponse)) {
            [self.subCollectionView resetWithAry:aryResponse];
        }
        [self reconfigView];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
    
}

- (void)searchClick{
    [GB_Nav pushVCName:@"SearchModuleVC" animated:true];
}
@end
