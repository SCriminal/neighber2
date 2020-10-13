//
//  SelectCommunityCityVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/23.
//Copyright © 2020 ping. All rights reserved.
//

#import "SelectCommunityCityVC.h"
#import "SelectCommunityCityView.h"
//select district vc
#import "SelectCommunityDistrictVC.h"
//request
#import "RequestApi+Neighbor.h"

@interface SelectCommunityCityVC ()
@property (nonatomic, strong) UIImageView *BG;
@property (nonatomic, strong) UIView *viewHeader;
@property (nonatomic, strong) ModelCommunityCity *defaultCity;


@end

@implementation SelectCommunityCityVC
- (UIView *)viewHeader{
    if (!_viewHeader) {
        _viewHeader = [UIView new];
        UILabel * label = [UILabel new];
        label.backgroundColor = [UIColor colorWithHexString:@"#FCFCFC"];
        label.fontNum = F(14);
        label.textColor = COLOR_333;
        ModelAddress * model = [GlobalMethod readModelForKey:LOCAL_LOCATION modelName:@"ModelAddress" exchange:false];
        [label fitTitle:UnPackStr(model.city) variable:0];
        label.widthHeight = XY(label.width + W(50), W(37));
        label.textAlignment = NSTextAlignmentCenter;
        label.leftTop = XY(W(20), W(20));
        [label addRoundCorner:UIRectCornerAllCorners radius:5 lineWidth:1 lineColor:[UIColor colorWithHexString:@"#EFF2F1"]];

        [_viewHeader addSubview:label];
        _viewHeader.widthHeight = XY(SCREEN_WIDTH, [_viewHeader addLineFrame:CGRectMake(0, label.bottom +W(20), SCREEN_WIDTH, W(10)) color:COLOR_GRAY]);
        [_viewHeader addTarget:self action:@selector(cityClick)];
    }
    return _viewHeader;
}
- (UIImageView *)BG{
    if (!_BG) {
        _BG = [UIImageView new];
        _BG.image = [UIImage imageNamed:@"select_community_BG"];
        _BG.contentMode = UIViewContentModeScaleAspectFill;
        _BG.clipsToBounds = true;
        _BG.widthHeight = XY(SCREEN_WIDTH, SCREEN_HEIGHT);
    }
    return _BG;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.view insertSubview:self.BG belowSubview:self.tableView];
//    self.tableView.backgroundColor = [UIColor clearColor];

    //添加导航栏
    [self addNav];
    //table
    [self.tableView registerClass:[SelectCommunityCityCell class] forCellReuseIdentifier:@"SelectCommunityCityCell"];
    [self.sectionIndexView resetWithAry:self.aryDatas tableView:self.tableView viewShow:self.view rightCenterY:XY(SCREEN_WIDTH, self.tableView.centerY)];
    WEAKSELF
    self.tableView.blockReloadData = ^(void){
        [weakSelf.sectionIndexView resetWithAry:weakSelf.aryDatas tableView:weakSelf.tableView viewShow:weakSelf.view rightCenterY:XY(SCREEN_WIDTH-W(10), weakSelf.tableView.centerY)];
    };
    //request
    [self requestList];
    [self addRefreshHeader];
}

#pragma mark 添加导航栏
- (void)addNav{
    BaseNavView * nav = [BaseNavView initNavBackTitle:@"选择城市" rightView:nil];
    nav.backgroundColor = [UIColor clearColor];
    [self.view addSubview:nav];
}

#pragma mark UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.aryDatas.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    ModelAryIndex * model = self.aryDatas[section];
    return model.aryMu.count;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    ModelAryIndex * model = self.aryDatas[section];
    return model.strFirst;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    ModelAryIndex * model = self.aryDatas[section];
    return [GlobalMethod resetTitle:model.strFirst];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return [GlobalMethod fetchTitleHeight:self.aryDatas[section]];
}
//cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SelectCommunityCityCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SelectCommunityCityCell"];
    ModelAryIndex * model = self.aryDatas[indexPath.section];

    [cell resetCellWithModel:model.aryMu[indexPath.row]];
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ModelAryIndex * model = self.aryDatas[indexPath.section];
    return [SelectCommunityCityCell fetchHeight:model.aryMu[indexPath.row]];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ModelAryIndex * model = self.aryDatas[indexPath.section];
    ModelCommunityCity * modelCity = model.aryMu[indexPath.row];
    [self jumpToDefaultCity:modelCity];
}
- (void)cityClick{
    if (self.defaultCity) {
        [self jumpToDefaultCity:self.defaultCity];
    }
}
- (void)jumpToDefaultCity:(ModelCommunityCity *)modelCity{
    SelectCommunityDistrictVC * vc = [SelectCommunityDistrictVC new];
    vc.blockSelectCommunity = self.blockSelectCommunity;
    vc.model = modelCity;
    [GB_Nav pushViewController:vc animated:true];
}

#pragma mark request
- (void)requestList{
    [RequestApi requestCommunityCityListWithName:nil cityId:0 countyId:0 page:self.pageNum count:50000 delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.pageNum ++;
        NSMutableArray  * aryResponse = [GlobalMethod exchangeDic:[response arrayValueForKey:@"list"] toAryWithModelName:@"ModelCommunityCity"];
        self.aryDatas = [GlobalMethod exchangeAryToSectionWithAlpha:aryResponse keyPath:@"initial"];

        //judge address
        ModelAddress * modelAddress = [GlobalMethod readModelForKey:LOCAL_LOCATION modelName:@"ModelAddress" exchange:false];
        if (isStr(modelAddress.city)) {
           ModelCommunityCity * modelCity = [aryResponse fetchSameModelKeyPath:@"areaName" value:modelAddress.city];
            if (modelCity.iDProperty) {
                self.tableView.tableHeaderView = self.viewHeader;
                self.defaultCity = modelCity;
            }
        }
        [self.tableView reloadData];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}

@end
