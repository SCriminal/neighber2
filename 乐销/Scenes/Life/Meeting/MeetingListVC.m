//
//  MeetingListVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/21.
//Copyright © 2020 ping. All rights reserved.
//

#import "MeetingListVC.h"
#import "MeetingListCell.h"
#import "LifeTopBGView.h"
//request
#import "RequestApi+Neighbor.h"
//detail
#import "QuestionnaireDetailVC.h"

@interface MeetingListVC ()
@property (nonatomic, strong) LifeTopBGView *topView;

@end

@implementation MeetingListVC
#pragma mark noresult view
@synthesize noResultView = _noResultView;
- (BOOL)isShowNoResult{
    return true;
}
- (NoResultView *)noResultView{
    if (!_noResultView) {
        _noResultView = [NoResultView new];
        [_noResultView resetWithImageName:@"empty_default" title:@"暂无信息"];
    }
    return _noResultView;
}
- (LifeTopBGView *)topView{
    if (!_topView) {
        _topView = [LifeTopBGView new];
        _topView.BG.image = [UIImage imageNamed:@"meeting_topBG"];
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
    [self.tableView registerClass:[MeetingListCell class] forCellReuseIdentifier:@"MeetingListCell"];
    //request
    [self requestList];
    [self addRefreshFooter];
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
    MeetingListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MeetingListCell"];
    [cell resetCellWithModel:self.aryDatas[indexPath.row]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [MeetingListCell fetchHeight:self.aryDatas[indexPath.row]];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    QuestionnaireDetailVC * detailVC = [QuestionnaireDetailVC new];
    detailVC.modelList = self.aryDatas[indexPath.row];
    [GB_Nav pushViewController:detailVC animated:true];
}
#pragma mark request
- (void)requestList{
    [RequestApi requestQuestionairListWithAreaid:[GlobalData sharedInstance].community.iDProperty page:self.pageNum count:50 delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.pageNum ++;
        NSMutableArray  * aryRequest = [GlobalMethod exchangeDic:[response arrayValueForKey:@"list"] toAryWithModelName:@"ModelQuestionariList"];
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
@end
