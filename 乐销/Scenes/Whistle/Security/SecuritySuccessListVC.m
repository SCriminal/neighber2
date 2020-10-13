//
//  WhistleSuccessListVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/17.
//Copyright © 2020 ping. All rights reserved.
//

#import "SecuritySuccessListVC.h"
//request
#import "RequestApi+Neighbor.h"
@interface SecuritySuccessListVC ()

@end

@implementation SecuritySuccessListVC
@synthesize noResultView = _noResultView;
- (BOOL)isShowNoResult{
    return true;
}
- (NoResultView *)noResultView{
    if (!_noResultView) {
        _noResultView = [NoResultView new];
        [_noResultView resetWithImageName:@"empty_default" title:@"暂无已完结信息"];
    }
    return _noResultView;
}

#pragma mark 添加导航栏
- (void)addNav{
    [self.view addSubview:[BaseNavView initNavBackTitle:@"已完结" rightView:nil]];
}


#pragma mark request
- (void)requestList{
    [RequestApi requestCommunityServiceListWithType:self.serviceType count:50 page:self.pageNum status:@"9,10" delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
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
