//
//  WhistleWatiListVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/17.
//Copyright © 2020 ping. All rights reserved.
//

#import "SecurityWatiListVC.h"
//cell
#import "SecurityListCell.h"
//request
#import "RequestApi+Neighbor.h"
#import "SecurityDetailVC.h"

@interface SecurityWatiListVC ()

@end

@implementation SecurityWatiListVC
#pragma mark noresult view
@synthesize noResultView = _noResultView;
- (BOOL)isShowNoResult{
    return true;
}
- (NoResultView *)noResultView{
    if (!_noResultView) {
        _noResultView = [NoResultView new];
        [_noResultView resetWithImageName:@"empty_default" title:@"暂无待处理信息"];
    }
    return _noResultView;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    //table
    [self.tableView registerClass:[SecurityListCell class] forCellReuseIdentifier:@"SecurityListCell"];
    //request
    [self requestList];
    [self addRefreshHeader];
    [self addRefreshFooter];
}

#pragma mark 添加导航栏
- (void)addNav{
    [self.view addSubview:[BaseNavView initNavBackTitle:@"待处理" rightView:nil]];
}

#pragma mark UITableViewDelegate
//row num
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.aryDatas.count;
}

//cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SecurityListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SecurityListCell"];
    [cell resetCellWithModel:self.aryDatas[indexPath.row]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [SecurityListCell fetchHeight:self.aryDatas[indexPath.row]];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SecurityDetailVC * vc = [SecurityDetailVC new];
    vc.modelList = self.aryDatas[indexPath.row];
    WEAKSELF
    vc.blockBack = ^(UIViewController *item) {
        if (item.requestState ) {
            [weakSelf refreshHeaderAll];
        }
    };
    [GB_Nav pushViewController:vc animated:true];
}
#pragma mark request
- (void)requestList{
    [RequestApi requestCommunityServiceListWithType:self.serviceType count:50 page:self.pageNum status:@"1" delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.pageNum ++;
               NSMutableArray  * aryRequest = [GlobalMethod exchangeDic:[response arrayValueForKey:@"list"] toAryWithModelName:@"ModelCommunityServiceList"];
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
