//
//  HouseKeepingVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/8/14.
//Copyright © 2020 ping. All rights reserved.
//

#import "HouseKeepingVC.h"
#import "HouseKeepingView.h"
#import "ModuleCollectionView.h"
#import "LifeView.h"
#import "AutoScView.h"
#import "WebVC.h"
#import "SliderView.h"
#import "HouseKeepingView.h"
//request
#import "RequestApi+Neighbor.h"
#import "RequestApi+Hailuo.h"
#import "HailuoAuntResumeVC.h"
#import "HailuoCompanyVC.h"

@interface HouseKeepingVC ()<SliderViewDelegate>
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) HouseKeepingTopView *topNavView;
@property (nonatomic, strong) ModuleCollectionView *collectionView;
@property (nonatomic, strong) LifeFoldView *arrowView;
@property (nonatomic, strong) NSMutableArray *aryModels;
@property (nonatomic, strong) AutoScView *autoSCView;
@property (nonatomic, strong) NSArray *aryADs;
@property (strong, nonatomic) SliderView *sliderView;
@property (nonatomic, assign) int index;
@property (nonatomic, strong) NSMutableArray *aryAunts;
@property (nonatomic, strong) NSMutableArray *aryOrganization;
@property (nonatomic, strong) UIView *homeAlert;

@end

@implementation HouseKeepingVC
- (SliderView *)sliderView{
    if (_sliderView == nil) {
        _sliderView = ^(){
            SliderView * sliderView = [SliderView new];
            sliderView.frame = CGRectMake(0, 0, SCREEN_WIDTH, W(50));
            sliderView.isHasSlider = true;
            sliderView.viewSlidColor = COLOR_ORANGE;
            sliderView.viewSlidWidth = W(45);
            sliderView.isScroll = false;
            sliderView.isLineVerticalHide = true;
            sliderView.delegate = self;
            sliderView.line.hidden = true;
            [sliderView resetWithAry:@[^(){
                ModelBtn * model = [ModelBtn new];
                model.title = @"推荐阿姨";
                return model;
            }(),^(){
                ModelBtn * model = [ModelBtn new];
                model.title = @"推荐机构";
                return model;
            }()]];
            return sliderView;
        }();
    }
    return _sliderView;
}
- (AutoScView *)autoSCView{
    if (!_autoSCView) {
        _autoSCView = [[AutoScView alloc]initWithFrame:CGRectMake(W(15), W(17), SCREEN_WIDTH - W(30), W(125)) image:@[@"temp_life3"]];
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
        [_arrowView resetTitle:@"展开"];
        WEAKSELF
        _arrowView.blockClick = ^{
            weakSelf.arrowView.iconFold.highlighted = !weakSelf.arrowView.iconFold.highlighted;
            if (weakSelf.aryModels.count <= 10) {
                return;
            }
            if (!weakSelf.arrowView.iconFold.highlighted ) {
                 [weakSelf.collectionView resetWithAry:[weakSelf.aryModels subarrayWithRange:NSMakeRange(0, 10)].mutableCopy];
            }else{
                [weakSelf.collectionView resetWithAry:weakSelf.aryModels];
            }
            [weakSelf reconfigView];

        };
    }
    return _arrowView;
}
- (UIView *)headerView{
    if (!_headerView) {
        _headerView = [UIView new];
        _headerView.backgroundColor = [UIColor whiteColor];
        _headerView.width = SCREEN_WIDTH;
    }
    return _headerView;
}
- (HouseKeepingTopView *)topNavView{
    if (!_topNavView) {
        _topNavView = [HouseKeepingTopView new];
        WEAKSELF
        _topNavView.blockBack = ^{
            [weakSelf.view removeFromSuperview];
        };
    }
    return _topNavView;
}
- (ModuleCollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = [[ModuleCollectionView alloc]initWithNum:5];
    }
    return _collectionView;
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
        [l fitTitle:@"潍社区家政服务由“家里服务云平台”提供" variable:0];
        l.centerXTop = XY(SCREEN_WIDTH/2.0, 0);
        [_homeAlert addSubview:l];
        _homeAlert.height = l.bottom;
    }
    return _homeAlert;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];

    //table
    [self.tableView registerClass:[HouseKeepingAuntCell class] forCellReuseIdentifier:@"HouseKeepingAuntCell"];
    [self.tableView registerClass:[HouseKeepingOrganizeCell class] forCellReuseIdentifier:@"HouseKeepingOrganizeCell"];

    self.tableView.height = SCREEN_HEIGHT- TABBAR_HEIGHT;
    self.tableView.top = 0;
    [self addRefreshHeader];
    //request
    [self reconfigView];
    [self requestADs];
    [self requestList];
}

- (void)reconfigView{
    self.tableView.tableHeaderView = nil;
    [self.headerView removeAllSubViews];
    
    CGFloat top = 0;
    [self.headerView addSubview:self.topNavView];
    top = self.topNavView.bottom;
    
    self.homeAlert.top = top + W(15);
    [self.headerView addSubview:self.homeAlert];
    top = self.homeAlert.bottom;
    
    
    self.collectionView.top = top + W(20);
    [self.headerView addSubview:self.collectionView];
    top = self.collectionView.bottom;
    
    self.arrowView.top = top - W(10);
       [self.headerView addSubview:self.arrowView];
       top = self.arrowView.bottom;

    self.autoSCView.top = top;
        [self.headerView addSubview:self.autoSCView];
        top = self.autoSCView.bottom;

    self.sliderView.top = top;
           [self.headerView addSubview:self.sliderView];
           top = self.sliderView.bottom;
    
    self.headerView.height = top;
    
    self.tableView.tableHeaderView = self.headerView;
    [self.tableView reloadData];
}
#pragma mark UITableViewDelegate
//row num
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.index == 0? self.aryAunts.count: self.aryOrganization.count;
}
//cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.index == 0) {
          HouseKeepingAuntCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HouseKeepingAuntCell"];
          [cell resetCellWithModel:self.aryAunts[indexPath.row]];
          return cell;
    }
  
    HouseKeepingOrganizeCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HouseKeepingOrganizeCell"];
    [cell resetCellWithModel:self.aryOrganization[indexPath.row]];
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.index == 0) {
        return [HouseKeepingAuntCell fetchHeight:self.aryAunts[indexPath.row]];
    }
    return [HouseKeepingOrganizeCell fetchHeight:self.aryOrganization[indexPath.row]];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.index == 0) {
        HailuoAuntResumeVC * resumeVC = [HailuoAuntResumeVC new];
        ModelHailuoAunt *aunt = self.aryAunts[indexPath.row];
        resumeVC.auntID = aunt.auntId;
        resumeVC.auntName = aunt.name;
        resumeVC.estimatePrice = aunt.estimatePrice;
        resumeVC.orderCount = aunt.orderCount;
        [GB_Nav pushViewController:resumeVC animated:true];
        return;
    }
    ModelHailuoCompany * model = self.aryOrganization[indexPath.row];
    HailuoCompanyVC * vc = [HailuoCompanyVC new];
    vc.companyID = model.companyId;
    [GB_Nav pushViewController:vc animated:true];
}
#pragma mark slid delegate
- (void)protocolSliderViewBtnSelect:(NSUInteger)tag btn:(CustomSliderControl *)control{
    self.index = (int)tag;
    [self refreshHeaderAll];
}

- (void)requestList{
    [RequestApi requestHaiLuoIndexDelegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        
        self.aryAunts = [GlobalMethod exchangeDic:[response arrayValueForKey:@"goods_aunt"] toAryWithModelName:@"ModelHailuoAunt"];
        self.aryOrganization = [GlobalMethod exchangeDic:[response arrayValueForKey:@"goods_company"] toAryWithModelName:@"ModelHailuoCompany"];
        [self.tableView reloadData];

    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
- (void)requestADs{
    [RequestApi requestADListWithGroupalias:@"housekeep_1" scopeId:[GlobalData sharedInstance].community.iDProperty delegate:nil success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        [self reqeustModel];
        NSArray * ary = [GlobalMethod exchangeDic:response toAryWithModelName:@"ModelAD"];
        self.aryADs = ary;
        NSArray * aryAds = [ary fetchValues:@"coverUrl"];
        [self.autoSCView resetWithImageAry:aryAds];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
- (void)reqeustModel{
    [RequestApi requestModuleWithLocationaliases:@"resident_housekeeping" areaId:[GlobalData sharedInstance].community.iDProperty delegate:nil success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        NSMutableArray * aryResponse = [GlobalMethod exchangeDic:[response arrayValueForKey:@"resident_housekeeping"] toAryWithModelName:@"ModelModule"];
        self.aryModels = aryResponse;
        if (isAry(aryResponse)) {
            [self.collectionView resetWithAry:[aryResponse subarrayWithRange:NSMakeRange(0, MIN(aryResponse.count, 10))].mutableCopy];
        }
        [self reconfigView];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
@end
