//
//  OrderListVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/10.
//Copyright © 2020 ping. All rights reserved.
//

#import "OrderListVC.h"
//cell
#import "OrderListCell.h"
//request
#import "RequestApi+Neighbor.h"
#import "OrderDetailVC.h"
@interface OrderListVC ()

@end

@implementation OrderListVC
#pragma mark noresult view
@synthesize noResultView = _noResultView;
- (BOOL)isShowNoResult{
    return true;
}
- (NoResultView *)noResultView{
    if (!_noResultView) {
        _noResultView = [NoResultView new];
        [_noResultView resetWithImageName:@"empty_waybill_default" title:@"暂无订单"];
    }
    return _noResultView;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //table
    [self.tableView registerClass:[OrderListCell class] forCellReuseIdentifier:@"OrderListCell"];
    [self.tableView registerClass:[OrderListMultiImageCell class] forCellReuseIdentifier:@"OrderListMultiImageCell"];
    self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshHeaderAll) name:NOTICE_ORDER_REFERSH object:nil];
    self.tableView.backgroundColor = [UIColor clearColor];
    [self addRefreshHeader];
    [self addRefreshFooter];
    //request
    [self requestList];

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
    ModelOrderDetail * model = self.aryDatas[indexPath.row];
    if (model.skus.count>1) {
         OrderListMultiImageCell * cell = [tableView dequeueReusableCellWithIdentifier:@"OrderListMultiImageCell"];
           [cell resetCellWithModel:model];
           return cell;
    }
    OrderListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"OrderListCell"];
    [cell resetCellWithModel:model];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ModelOrderDetail * model = self.aryDatas[indexPath.row];
    if (model.skus.count>1) {
        return [OrderListMultiImageCell fetchHeight:model];
    }
    return [OrderListCell fetchHeight:model];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderDetailVC * detailVC = [OrderDetailVC new];
    ModelOrderDetail * model = self.aryDatas[indexPath.row];
    detailVC.orderNumber = model.number;
    [GB_Nav pushViewController:detailVC animated:true];
}
#pragma mark request
- (void)requestList{
    //1已下单 5已付款 7已发货 10已完成 99已关闭
    [RequestApi requestOrderListWithStatuses:@"1,5,7,10,99" page:self.pageNum count:50 delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.pageNum ++;
        NSMutableArray  * aryRequest = [GlobalMethod exchangeDic:[response arrayValueForKey:@"list"] toAryWithModelName:@"ModelOrderDetail"];
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
