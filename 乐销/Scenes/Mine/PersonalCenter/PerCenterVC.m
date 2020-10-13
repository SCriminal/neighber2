//
//  PerCenterVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/8/14.
//Copyright © 2020 ping. All rights reserved.
//

#import "PerCenterVC.h"

@interface PerCenterVC ()
@property (nonatomic, strong) UIView *headerView;

@property (nonatomic, strong) PerCenterTopView *topView;
@property (nonatomic, strong) PerCenterSignView *signView;
@property (nonatomic, strong) PerCenterOrderView *orderView;
@property (nonatomic, strong) PerCenterDealView *dealView;
@property (nonatomic, strong) PerCenterBtnView *btnView;
@property (nonatomic, strong) PerCenterTitleAlertView *alertBusiness;
@property (nonatomic, strong) PerCenterTitleAlertView *alertUs;
@property (nonatomic, strong) PerCenterUsView *usView;
@property (nonatomic, strong) PerCenterShopView *shopView;

@end

@implementation PerCenterVC
- (PerCenterShopView *)shopView{
    if (!_shopView) {
        _shopView = [PerCenterShopView new];
    }
    return _shopView;
}
- (PerCenterUsView *)usView{
    if (!_usView) {
        _usView = [PerCenterUsView new];
    }
    return _usView;
}
- (PerCenterTitleAlertView *)alertBusiness{
    if (!_alertBusiness) {
        _alertBusiness = [PerCenterTitleAlertView new];
        [_alertBusiness changeTitle:@"我是商户"];
    }
    return _alertBusiness;
}
- (PerCenterTitleAlertView *)alertUs{
    if (!_alertUs) {
        _alertUs = [PerCenterTitleAlertView new];
        [_alertUs changeTitle:@"了解我们"];
    }
    return _alertUs;
}
- (PerCenterBtnView *)btnView{
    if (!_btnView) {
        _btnView = [PerCenterBtnView new];
    }
    return _btnView;
}
- (PerCenterDealView *)dealView{
    if (!_dealView) {
        _dealView = [PerCenterDealView new];
    }
    return _dealView;
}
- (PerCenterSignView *)signView{
    if (!_signView) {
        _signView = [PerCenterSignView new];
        _signView.blockIntegralClick = ^{
            [GlobalMethod judgeLoginState:^{
                [GB_Nav pushVCName:@"IntegralStoreVC" animated:true];
            }];
        };
        _signView.blockSignClick = ^{
            [GlobalMethod judgeLoginState:^{
                [GB_Nav pushVCName:@"SignInVC" animated:true];
                       }];
        };
    }
    return _signView;
}
- (PerCenterOrderView *)orderView{
    if (!_orderView) {
        _orderView = [PerCenterOrderView new];
    }
    return _orderView;
}
- (UIView *)headerView{
    if (!_headerView) {
        _headerView = [UIView new];
        _headerView.width = SCREEN_WIDTH;
        _headerView.backgroundColor = COLOR_GRAY;
    }
    return _headerView;
}
- (PerCenterTopView *)topView{
    if (!_topView) {
        _topView = [PerCenterTopView new];
    }
    return _topView;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //table
    self.tableView.top = 0;
    self.tableView.backgroundColor = COLOR_GRAY;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, W(30), 0);
    self.tableView.height = SCREEN_HEIGHT - TABBAR_HEIGHT;
    //request
    [self reconfigHeader];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.topView requestMsgNum];
    [self.topView requestCertificate];
    [self.signView requestIntegralNum];
    [self.orderView requestOrderNum];
    [self.dealView requestNum];
    [self.shopView requestShop];
}
#pragma mark request
- (void)reconfigHeader{
    [self.headerView removeAllSubViews];
    self.tableView.tableHeaderView = nil;
    CGFloat top = 0;
    
    self.topView.top = top;
    [self.headerView addSubview:self.topView];
    top = self.topView.bottom;
    
    self.signView.top = top+W(10);
       [self.headerView addSubview:self.signView];
       top = self.signView.bottom;
    
    self.orderView.top = top+W(10);
       [self.headerView addSubview:self.orderView];
       top = self.orderView.bottom;
    
    self.dealView.top = top+W(10);
          [self.headerView addSubview:self.dealView];
          top = self.dealView.bottom;
    
    self.btnView.top = top+W(10);
          [self.headerView addSubview:self.btnView];
          top = self.btnView.bottom;

    self.alertBusiness.top = top+W(19);
             [self.headerView addSubview:self.alertBusiness];
             top = self.alertBusiness.bottom;
    
    self.shopView.top = top+W(19);
    [self.headerView addSubview:self.shopView];
    top = self.shopView.bottom;
    
    self.alertUs.top = top+W(15);
             [self.headerView addSubview:self.alertUs];
             top = self.alertUs.bottom;
    
    self.usView.top = top+W(15);
               [self.headerView addSubview:self.usView];
               top = self.usView.bottom;
    
    self.headerView.height = top;
    self.tableView.tableHeaderView = self.headerView;
    
}
@end
