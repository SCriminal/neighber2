//
//  HailuoOrderListVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/8/19.
//Copyright © 2020 ping. All rights reserved.
//

#import "HailuoOrderListVC.h"
#import "HailuoOrderListCell.h"
//request
#import "RequestApi+Hailuo.h"
#import "HailuoDisappointmentView.h"
#import "HailuoOrderDetailVC.h"
@interface HailuoOrderListVC ()

@end

@implementation HailuoOrderListVC
#pragma mark noresult view
@synthesize noResultView = _noResultView;
- (BOOL)isShowNoResult{
    return true;
}
- (NoResultView *)noResultView{
    if (!_noResultView) {
        _noResultView = [NoResultView new];
        [_noResultView resetWithImageName:@"empty_default" title:@"暂无订单"];
    }
    return _noResultView;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //table
    
    [self.tableView registerClass:[HailuoOrderListCell class] forCellReuseIdentifier:@"HailuoOrderListCell"];
    self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
 
    self.tableView.backgroundColor = COLOR_GRAY;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, W(10), 0);
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
//cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WEAKSELF
    HailuoOrderListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HailuoOrderListCell"];
    cell.blockDismiss = ^(ModelHailuoOrder *item) {
        HailuoDisappointmentView * view = [HailuoDisappointmentView new];
        view.blockConfirmClick = ^(NSString *reason) {
            [weakSelf requestDismiss:reason model:item];
        };
        [GB_Nav.lastVC.view addSubview: view];
    };
    [cell resetCellWithModel: self.aryDatas[indexPath.row]];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [HailuoOrderListCell fetchHeight:self.aryDatas[indexPath.row]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ModelHailuoOrder * model = self.aryDatas[indexPath.row];
    HailuoOrderDetailVC * vc = [HailuoOrderDetailVC new];
    vc.orderID = model.iDProperty;
    [GB_Nav pushViewController:vc animated:true];
}

- (void)requestList{
    [RequestApi requestHaiLuoOrderListWithStatus:NSNumber.dou(self.type).stringValue page:strDotF(self.pageNum) delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.pageNum ++;
        NSMutableArray  * aryRequest = [GlobalMethod exchangeDic:response toAryWithModelName:@"ModelHailuoOrder"];
        if (self.isRemoveAll) {
            [self.aryDatas removeAllObjects];
        }
        if (!isAry(aryRequest)) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        [self.aryDatas addObjectsFromArray:aryRequest];
        [self.tableView reloadData];    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}

- (void)requestDismiss:(NSString *)reason model:(ModelHailuoOrder *)model{
    [RequestApi requestHaiLuoDismissOrderListWithOrder_id:NSNumber.dou(model.iDProperty).stringValue cancel_content:reason delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        [[NSNotificationCenter defaultCenter]postNotificationName:NOTICE_HAILUO_ORDER_REFERSH object:nil];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
@end
