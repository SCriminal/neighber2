//
//  ConfirmOrderVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/4/21.
//Copyright © 2020 ping. All rights reserved.
//

#import "ConfirmOrderVC.h"
#import "OrderAddressView.h"
#import "ConfirmOrderView.h"
#import "SelectPaymentView.h"
#import "SelectAddressVC.h"
#import "ConfirmOrderCell.h"
//request
#import "RequestApi+Neighbor.h"
#import "OrderDetailVC.h"

@interface ConfirmOrderVC ()
@property (nonatomic, strong) OrderAddressView *addressView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) ConfirmOrderView *bottomView;
@property (nonatomic, strong) NSString *orderNumbers;

@end

@implementation ConfirmOrderVC
- (ConfirmOrderView *)bottomView{
    if (!_bottomView) {
        _bottomView = [ConfirmOrderView new];
        [_bottomView resetViewWithModel:self.aryDatas];
        _bottomView.bottom = SCREEN_HEIGHT;
        WEAKSELF
        _bottomView.blockSubmitClick = ^{
            if (!weakSelf.addressView.model) {
                [GlobalMethod showAlert:@"请选择收货地址"];
                return;
            }
            [weakSelf requestConfirm];
        };
    }
    return _bottomView;
}
- (OrderAddressView *)addressView{
    if (!_addressView) {
        _addressView = [OrderAddressView new];
        _addressView.isClickAvailable = true;
        [_addressView resetViewWithModel:nil];
        WEAKSELF
        _addressView.blockClick = ^{
            SelectAddressVC * selectVC = [SelectAddressVC new];
            selectVC.blockSelected = ^(ModelShopAddress *modelAddress) {
                [weakSelf.addressView resetViewWithModel:modelAddress];
                [weakSelf configView];
            };
            [GB_Nav pushViewController:selectVC animated:true];
        };
    }
    return _addressView;
}
- (UIView *)headerView{
    if (!_headerView) {
        _headerView = [UIView new];
        _headerView.backgroundColor = [UIColor clearColor];
    }
    return _headerView;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    self.viewBG.backgroundColor = COLOR_GRAY;
    [self.view addSubview:self.bottomView];
    self.tableView.height = self.bottomView.top - NAVIGATIONBAR_HEIGHT;
    //table
    [self.tableView registerClass:[ConfirmOrderCell class] forCellReuseIdentifier:@"ConfirmOrderCell"];
    self.tableView.backgroundColor = COLOR_GRAY;
    [self configView];
    //request
    [self requestAddressList];
}
- (void)configView{
    self.addressView.top = W(15);
    [self.headerView addSubview:self.addressView];
    self.headerView.height = self.addressView.bottom + W(15);
    self.tableView.tableHeaderView = self.headerView;
}
#pragma mark 添加导航栏
- (void)addNav{
    [self.view addSubview:[BaseNavView initNavBackTitle:@"确认订单" rightView:nil]];
}

#pragma mark UITableViewDelegate
//row num
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    ModelTrolley * model = self.aryDatas[section];
    return model.skus.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.aryDatas.count;
}
//cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ModelTrolley * model = self.aryDatas[indexPath.section];
    
    ConfirmOrderCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ConfirmOrderCell"];
    [cell resetCellWithModel:model.skus[indexPath.row]];
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ModelTrolley * model = self.aryDatas[indexPath.section];
    return [ConfirmOrderCell fetchHeight:model.skus[indexPath.row]];
}
//table header
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    ConfirmOrderSectionTopView * topView = [ConfirmOrderSectionTopView new];
    [topView resetViewWithModel:self.aryDatas[section]];
    
    return  topView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    static CGFloat headerHeight = 0;
    if (!headerHeight) {
        headerHeight = [ConfirmOrderSectionTopView new].height;
    }
    return headerHeight;
}
//table footer
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    ConfirmOrderSectionBottomView * view = [ConfirmOrderSectionBottomView new];
    [view resetViewWithModel:self.aryDatas[section]];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    static CGFloat footerHeight = 0;
    if (!footerHeight) {
        footerHeight = [ConfirmOrderSectionBottomView new].height+W(10);
    }
    return footerHeight;
    
}


#pragma mark request
- (void)requestAddressList{
    [RequestApi requestAddressListWithPage:1 count:50 delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        NSMutableArray  * aryRequest = [GlobalMethod exchangeDic:[response arrayValueForKey:@"list"] toAryWithModelName:@"ModelShopAddress"];
        if (aryRequest.count) {
            [self.addressView resetViewWithModel:aryRequest[0]];
            [self configView];
        }
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
- (void)requestConfirm{
    NSMutableArray * aryJson = [NSMutableArray array];
    for (ModelTrolley * modelTrolley  in self.aryDatas) {
        for (ModelIntegralProduct * modelPro in modelTrolley.skus) {
            [aryJson addObject:@{@"code":modelPro.code,@"qty":NSNumber.dou(modelPro.qty)}];
        }
    }
    [RequestApi requestSubmitOrderWithSkus:[GlobalMethod exchangeDicToJson:aryJson] addrId:self.addressView.model.iDProperty description:@"" delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        NSArray * aryModels = [GlobalMethod exchangeDic:response toAryWithModelName:@"ModelOrderDetail"];
        ModelOrderDetail * modelItem = aryModels.lastObject;
        self.orderNumbers = aryModels.count>1?modelItem.mergeNumber:modelItem.number;
        [self requestDelete];
        WEAKSELF
        SelectPaymentView * selectView = [SelectPaymentView new];
        selectView.blockSelected = ^(ENUM_PAY_TYPE index) {
            [weakSelf requestPay:index];
        };
        selectView.blockCancel = ^{
            [weakSelf jumpToOrderDetail];
        };
        [selectView show];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
- (void)requestDelete{
    NSMutableArray * aryJson = [NSMutableArray array];
    for (ModelTrolley * modelTrolley  in self.aryDatas) {
        for (ModelIntegralProduct * modelPro in modelTrolley.skus) {
            [aryJson addObject:modelPro.code];
        }
    }
    [RequestApi requestDeleteTrolleyWithIds:[aryJson componentsJoinedByString:@","] scope:@"" delegate:nil success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
- (void)requestPay:(ENUM_PAY_TYPE)index{
    switch (index) {
        case ENUM_PAY_WECHAT:
        {
            [RequestApi requestWechatPayWithNumber:self.orderNumbers delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
                [[PayHelper sharedInstance]payWithWeChat:[response stringValueForKey:@"content"] number:self.orderNumbers blockSuccsee:^(NSString *json) {
                }];
                [self jumpToOrderDetail];
            } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
                
            }];
        }
            break;
        case ENUM_PAY_ALI:
        {
            [RequestApi requestAliPayWithNumber:self.orderNumbers delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
                [[PayHelper sharedInstance]payWithAli:[response stringValueForKey:@"content"] blockSuccsee:^(NSString * json){
                }];
                [self jumpToOrderDetail];
            } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
                
            }];
        }
            break;
        default:
            break;
    }
}
- (void)jumpToOrderDetail{
    if (self.orderNumbers) {
        [GB_Nav popLastAndPushVC:[NSClassFromString(@"OrderListManagementVC") new]];
//        OrderDetailVC * detailVC =  [OrderDetailVC new];
//        detailVC.orderNumber = [self.orderNumbers componentsSeparatedByString:@","].firstObject;
//        [GB_Nav popLastAndPushVC:detailVC];
    }else{
        [GB_Nav popViewControllerAnimated:true];
    }
}
@end
