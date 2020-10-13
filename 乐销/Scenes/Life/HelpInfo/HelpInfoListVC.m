//
//  HelpInfoListVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/21.
//Copyright © 2020 ping. All rights reserved.
//

#import "HelpInfoListVC.h"
#import "HelpInfoListCell.h"
#import "LifeTopBGView.h"
#import "HelpInfoDetailVC.h"
//request
#import "RequestApi+Neighbor.h"
@interface HelpInfoListVC ()
@property (nonatomic, strong) LifeTopBGView *topView;

@end

@implementation HelpInfoListVC
#pragma mark noresult view
@synthesize noResultView = _noResultView;
- (BOOL)isShowNoResult{
    return true;
}
- (NoResultView *)noResultView{
    if (!_noResultView) {
        _noResultView = [NoResultView new];
        [_noResultView resetWithImageName:@"empty_default" title:@"暂无求助信息"];
    }
    return _noResultView;
}
- (LifeTopBGView *)topView{
    if (!_topView) {
        _topView = [LifeTopBGView new];
        _topView.BG.image = [UIImage imageNamed:@"help_topBG"];
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
    [self.tableView registerClass:[HelpInfoListCell class] forCellReuseIdentifier:@"HelpInfoListCell"];
    //request
    [self requestList];
//    [self addRefreshFooter];
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
    HelpInfoListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HelpInfoListCell"];
    [cell resetCellWithModel:self.aryDatas[indexPath.row]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [HelpInfoListCell fetchHeight:self.aryDatas[indexPath.row]];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HelpInfoDetailVC * vc = [HelpInfoDetailVC new];
    vc.modelList = self.aryDatas[indexPath.row];
    [GB_Nav pushViewController:vc animated:true];
}

#pragma mark request
- (void)requestList{
    [RequestApi requestHelpListWithAreaId:[GlobalData sharedInstance].community.iDProperty delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {

        NSMutableArray  * aryRequest = [GlobalMethod exchangeDic:[response arrayValueForKey:@"list"] toAryWithModelName:@"ModelHelpList"];
        
        [self.aryDatas removeAllObjects];
        [self.aryDatas addObjectsFromArray:aryRequest];
        [self.tableView reloadData];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];


    
}
@end
