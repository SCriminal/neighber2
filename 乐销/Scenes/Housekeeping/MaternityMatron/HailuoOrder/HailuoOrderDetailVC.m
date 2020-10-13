//
//  HailuoOrderDetailVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/8/20.
//Copyright © 2020 ping. All rights reserved.
//

#import "HailuoOrderDetailVC.h"
//request
#import "RequestApi+Hailuo.h"
#import "HailuoOrderDetailView.h"
#import "HailuoDisappointmentView.h"

@interface HailuoOrderDetailVC ()
@property (nonatomic, strong) ModelHailuoOrder *modelOrder;
@property (nonatomic, strong) HailuoOrderDetailTopView *topView;
@property (nonatomic, strong) HailuoOrderDetailOrderInfoView *infoView;
@property (nonatomic, strong) HailuoOrderDetailPayInfoView *payView;
@property (nonatomic, strong) HailuoOrderAddressView *addressView;

@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIView *bottomView;

@end

@implementation HailuoOrderDetailVC
- (UIView *)headerView{
    if (!_headerView) {
        _headerView = [UIView new];
        _headerView.backgroundColor = COLOR_GRAY;
        _headerView.width =SCREEN_WIDTH;
        
    }
    return _headerView;
}
- (HailuoOrderDetailTopView *)topView{
    if (!_topView) {
        _topView = [HailuoOrderDetailTopView new];
    }
    return _topView;
}
- (HailuoOrderAddressView *)addressView{
    if (!_addressView) {
        _addressView = [HailuoOrderAddressView new];
    }
    return _addressView;
}
- (HailuoOrderDetailOrderInfoView *)infoView{
    if (!_infoView) {
        _infoView = [HailuoOrderDetailOrderInfoView new];
    }
    return _infoView;
}
- (HailuoOrderDetailPayInfoView *)payView{
    if (!_payView) {
        _payView = [HailuoOrderDetailPayInfoView new];
    }
    return _payView;
}
- (UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [UIView new];
        _bottomView.backgroundColor = [UIColor whiteColor];
        _bottomView.width =SCREEN_WIDTH;
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.widthHeight = XY(W(103), W(37));
        btn.backgroundColor = [UIColor whiteColor];
        [btn setTitle:@"申请取消" forState:UIControlStateNormal];
        btn.titleLabel.fontNum = F(15);
        [btn setTitleColor:COLOR_999 forState:UIControlStateNormal];
        [btn addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:btn.height/2.0 lineWidth:1 lineColor:COLOR_999];
        [btn addTarget:self action:@selector(btnDismissClick) forControlEvents:UIControlEventTouchUpInside];
        btn.rightTop = XY(SCREEN_WIDTH - W(15), W(6));
        [_bottomView addSubview:btn];
        _bottomView.height = btn.bottom + W(6)+ iphoneXBottomInterval;
        _bottomView.bottom = SCREEN_HEIGHT;
    }
    return _bottomView;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    //table
    self.tableView.backgroundColor = COLOR_GRAY;
//    [self.tableView registerClass:[<#CellName#> class] forCellReuseIdentifier:@"<#CellName#>"];
    //request
    [self requestList];
}
- (void)reconfigView{
    self.tableView.tableHeaderView = nil;
    [self.headerView removeAllSubViews];
    CGFloat top = 0;
    
   
    
    self.topView.top = top+W(10);
    [self.headerView addSubview:self.topView];
    top = self.topView.bottom;
    
    self.addressView.top = top+W(10);
       [self.headerView addSubview:self.addressView];
       top = self.addressView.bottom;
    
    self.infoView.top = top+W(10);
    [self.headerView addSubview:self.infoView];
    top = self.infoView.bottom;
    
    self.payView.top = top+W(10);
    [self.headerView addSubview:self.payView];
    top = self.payView.bottom;
  
    self.headerView.height = top+W(10);
    self.tableView.tableHeaderView = self.headerView;
}
- (void)reconfigBottomView{
    [self.bottomView removeFromSuperview];
    if (self.modelOrder.orderStatus == 0) {
        [self.view addSubview:self.bottomView];
        self.tableView.height = SCREEN_HEIGHT - self.bottomView.height - NAVIGATIONBAR_HEIGHT;
    }else{
        self.tableView.height = SCREEN_HEIGHT  - NAVIGATIONBAR_HEIGHT;

    }
}
- (void)btnDismissClick{
    WEAKSELF
    HailuoDisappointmentView * view = [HailuoDisappointmentView new];
           view.blockConfirmClick = ^(NSString *reason) {
               [weakSelf requestDismiss:reason];
           };
           [GB_Nav.lastVC.view addSubview: view];
}
- (void)requestDismiss:(NSString *)reason {
    [RequestApi requestHaiLuoDismissOrderListWithOrder_id:NSNumber.dou(self.orderID).stringValue cancel_content:reason delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        [[NSNotificationCenter defaultCenter]postNotificationName:NOTICE_HAILUO_ORDER_REFERSH object:nil];
        [self requestList];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}

#pragma mark 添加导航栏
- (void)addNav{
    [self.view addSubview:[BaseNavView initNavBackTitle:@"订单详情" rightView:nil]];
}


#pragma mark request
- (void)requestList{
    [RequestApi requestHaiLuoOrderDetailWithOrder_id:NSNumber.dou(self.orderID).stringValue delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        NSDictionary * dicAddress = [response dictionaryValueForKey:@"address"];
        ModelShopAddress * modelAddress = [ModelShopAddress new];
        modelAddress.contact = [dicAddress stringValueForKey:@"user_name"];
        modelAddress.phone = [dicAddress stringValueForKey:@"phone"];
        modelAddress.addressDetailShow = [NSString stringWithFormat:@"%@%@",[dicAddress stringValueForKey:@"area"],[dicAddress stringValueForKey:@"address"]];
        [self.addressView resetViewWithModel:modelAddress];
        
        self.modelOrder = [ModelHailuoOrder modelObjectWithDictionary:response];
        [self.topView resetViewWithModel:self.modelOrder];
        [self.infoView resetViewWithModel:self.modelOrder];
        [self.payView resetViewWithModel:self.modelOrder];
        [self reconfigView];
        [self reconfigBottomView];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
@end
