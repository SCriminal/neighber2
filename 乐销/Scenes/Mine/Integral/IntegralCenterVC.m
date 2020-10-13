//
//  IntegralCenterVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/10.
//Copyright © 2020 ping. All rights reserved.
//

#import "IntegralCenterVC.h"
//cell
#import "IntegralRecordCell.h"
//view
//section title
#import "SectionTitleView.h"
#import "IntegralCenterView.h"
//request
#import "RequestApi+Neighbor.h"
@interface IntegralCenterVC ()
@property (nonatomic, strong) UIView *tableHeaderView;
@property (nonatomic, strong) IntegralCenterView *scoreView;
@property (nonatomic, strong) SectionTitleView *infoTitleView;

@end

@implementation IntegralCenterVC
#pragma mark noresult view
@synthesize noResultView = _noResultView;
- (BOOL)isShowNoResult{
    return true;
}
- (NoResultView *)noResultView{
    if (!_noResultView) {
        _noResultView = [NoResultView new];
        [_noResultView resetWithImageName:@"empty_default" title:@"暂无积分"];
    }
    return _noResultView;
}
#pragma mark lazy init
- (IntegralCenterView *)scoreView{
    if (!_scoreView) {
        _scoreView = [IntegralCenterView new];
        _scoreView.btnRecord.hidden = true;
    }
    return _scoreView;
}
- (UIView *)tableHeaderView{
    if (!_tableHeaderView) {
        _tableHeaderView = [UIView new];
        _tableHeaderView.width = SCREEN_WIDTH;
        _tableHeaderView.backgroundColor = [UIColor clearColor];
    }
    return _tableHeaderView;
}
- (SectionTitleView *)infoTitleView{
    if (!_infoTitleView) {
        _infoTitleView = [SectionTitleView new];
        _infoTitleView.title.text = @"积分账单";
        _infoTitleView.more.hidden = true;
        _infoTitleView.arrowRight.hidden = true;
    }
    return _infoTitleView;
}
#pragma mark view dited load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    [self reconfigView];
    //table
    [self.tableView registerClass:[IntegralRecordCell class] forCellReuseIdentifier:@"IntegralRecordCell"];
    //request
    [self requestTotal];
    [self requestList];
}
- (void)reconfigView{
    [self.tableHeaderView removeAllSubViews];
    
    self.scoreView.top = W(10);
    [self.tableHeaderView addSubview:self.scoreView];

    
    self.infoTitleView.top = W(30)+self.scoreView.bottom;
    [self.tableHeaderView addSubview:self.infoTitleView];
    
    self.tableHeaderView.height = self.infoTitleView.bottom+W(7);
    self.tableView.tableHeaderView = self.tableHeaderView;
}
#pragma mark 添加导航栏
- (void)addNav{
    [self.view addSubview:[BaseNavView initNavBackTitle:@"积分中心" rightView:nil]];
}

#pragma mark UITableViewDelegate
//row num
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.aryDatas.count;
}

//cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    IntegralRecordCell * cell = [tableView dequeueReusableCellWithIdentifier:@"IntegralRecordCell"];
    [cell resetCellWithModel:self.aryDatas[indexPath.row]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [IntegralRecordCell fetchHeight:self.aryDatas[indexPath.row]];
}


#pragma mark request
- (void)requestTotal{
    [RequestApi requestIntegralTotalDelegate:nil success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        [self.scoreView resetViewWithModel:[response intValueForKey:@"score"]];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
- (void)requestList{
    [RequestApi requestIntegralRecordDelegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.aryDatas = [GlobalMethod exchangeDic:[response arrayValueForKey:@"list"] toAryWithModelName:@"ModelIntegralRecord"];
        [self.tableView reloadData];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
    
}
@end
