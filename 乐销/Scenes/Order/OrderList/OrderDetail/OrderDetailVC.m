//
//  OrderDetailVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/4/21.
//Copyright © 2020 ping. All rights reserved.
//

#import "OrderDetailVC.h"
#import "OrderDetailView.h"
#import "OrderAddressView.h"
//request
#import "RequestApi+Neighbor.h"
//cell
#import "ConfirmOrderCell.h"
//sub view
#import "SelectPaymentView.h"
#import "SelectAddressVC.h"

@interface OrderDetailVC ()
@property (nonatomic, strong) OrderDetailTopView *topView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) OrderAddressView *addressView;
@property (nonatomic, strong) OrderDetailBottomView *bottomView;
@property (nonatomic, strong) OrderDetailInfoView *infoView;
@property (nonatomic, strong) ModelOrderDetail *modelDetail;

@end

@implementation OrderDetailVC
- (OrderDetailInfoView *)infoView{
    if (!_infoView) {
        _infoView = [OrderDetailInfoView new];
    }
    return _infoView;
}
- (OrderDetailBottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [OrderDetailBottomView new];
        _bottomView.bottom = SCREEN_HEIGHT;
        [_bottomView resetViewWithModel:nil];
        WEAKSELF
        _bottomView.blockClick = ^(ENUM_ORDER_OPERATE type) {
            switch (type) {
                case ENUM_ORDER_OPERATE_PAY:
                {
                    SelectPaymentView * selectView = [SelectPaymentView new];
                    selectView.blockSelected = ^(ENUM_PAY_TYPE index) {
                        [weakSelf requestPay:index];
                    };
                    [selectView show];
                }
                    break;
                case ENUM_ORDER_OPERATE_CANCEL:{
                    [GlobalMethod showEditAlertWithTitle:@"提示" content:@"确定要取消订单?" dismiss:^{
                        
                    } confirm:^{
                        [weakSelf requestCancel];
                    } view:weakSelf.view];
                }
                    break;
                case ENUM_ORDER_OPERATE_CHANGE_ADDRESS:{
                    SelectAddressVC * selectVC = [SelectAddressVC new];
                    selectVC.blockSelected = ^(ModelShopAddress *modelAddress) {
                        [weakSelf requestChangeAddress:modelAddress];
                    };
                    [GB_Nav pushViewController:selectVC animated:true];
                }
                    break;
                case ENUM_ORDER_OPERATE_CONFIRM_RECEIVE:{
                    [GlobalMethod showEditAlertWithTitle:@"提示" content:@"确定要确认收货?" dismiss:^{
                        
                    } confirm:^{
                        [weakSelf requestConfirm];
                    } view:weakSelf.view];
                }
                    break;
                default:
                    break;
            }
        };
    }
    return _bottomView;
}

- (OrderDetailTopView *)topView{
    if (!_topView) {
        _topView = [OrderDetailTopView new];
    }
    return _topView;
}
- (UIView *)headerView{
    if (!_headerView) {
        _headerView = [UIView new];
        _headerView.backgroundColor = [UIColor clearColor];
    }
    return _headerView;
}
- (OrderAddressView *)addressView{
    if (!_addressView) {
        _addressView = [OrderAddressView new];
        _addressView.isOrderDetail = true;
        _addressView.isClickAvailable = false;
        
    }
    return _addressView;
}

#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //notice
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(requestDetail) name:NOTICE_ORDER_REFERSH object:nil];

    //添加导航栏
    [self addNav];
    self.viewBG.backgroundColor = COLOR_GRAY;
    //table
    [self.tableView registerClass:[ConfirmOrderCell class] forCellReuseIdentifier:@"ConfirmOrderCell"];
    self.tableView.backgroundColor = [UIColor clearColor];
    //request
    [self requestDetail];
}
- (void)configView{
    [self.headerView removeAllSubViews];
    
    [self.headerView addSubview:self.topView];
    
    self.addressView.top = self.topView.bottom + W(10);
    [self.headerView addSubview:self.addressView];
    
    self.headerView.height = self.addressView.bottom+W(10);
    self.tableView.tableHeaderView = self.headerView;
    
    self.tableView.tableFooterView = self.infoView;
    
    [self.view addSubview:self.bottomView];
    self.bottomView.bottom = SCREEN_HEIGHT;
    self.tableView.height = self.bottomView.top - NAVIGATIONBAR_HEIGHT;
    
    [self.tableView reloadData];
}
#pragma mark 添加导航栏
- (void)addNav{
    [self.view addSubview:[BaseNavView initNavBackTitle:@"订单详情" rightView:nil]];
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
    cell.isOrderDetail = true;
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
    topView.isOrderDetail = true;
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
    OrderDetailSectionBottomView * view = [OrderDetailSectionBottomView new];
    [view resetViewWithModel:self.aryDatas[section] modelDetail:self.modelDetail];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    static CGFloat footerHeight = 0;
    if (!footerHeight) {
        footerHeight = [OrderDetailSectionBottomView new].height+W(10);
    }
    return footerHeight;
    
}


#pragma mark request
- (void)requestDetail{
    [RequestApi requestOrderDetailWithNumber:self.orderNumber delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.modelDetail = [ModelOrderDetail modelObjectWithDictionary:response];
        
        self.aryDatas = [NSMutableArray arrayWithObject:^(){
            ModelTrolley * item = [ModelTrolley new];
            item.name = self.modelDetail.storeName;
            item.skus = self.modelDetail.skus;
            return item;
        }()];
        
        [self.topView resetViewWithModel:self.modelDetail];
        [self.addressView resetViewWithModel:self.modelDetail.modelAddress];
        [self.bottomView resetViewWithModel:self.modelDetail];
        [self.infoView resetViewWithModel:self.modelDetail];
        
        [self configView];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}

- (void)requestPay:(ENUM_PAY_TYPE)index{
    switch (index) {
        case ENUM_PAY_WECHAT:
        {
            [RequestApi requestWechatPayWithNumber:self.orderNumber delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
                           [[PayHelper sharedInstance]payWithWeChat:[response stringValueForKey:@"content"] number:self.orderNumber blockSuccsee:^(NSString *json) {
                           }];
                       } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
                           
                       }];
        }
            break;
        case ENUM_PAY_ALI:
        {
            [RequestApi requestAliPayWithNumber:self.orderNumber delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
                [[PayHelper sharedInstance]payWithAli:[response stringValueForKey:@"content"] blockSuccsee:^(NSString * json){
                }];
            } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
                
            }];
        }
            break;
        default:
            break;
    }
}
- (void)requestChangeAddress:(ModelShopAddress *)address{
    [RequestApi requestRemedyAddressWithAddrid:address.iDProperty numbers:self.orderNumber delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        [GlobalMethod showAlert:@"修改地址成功"];
        [self requestDetail];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}

- (void)requestCancel{
    [RequestApi requestCancelOrderWithNumbers:self.orderNumber delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        [GlobalMethod showAlert:@"订单已取消"];
        [self requestDetail];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
- (void)requestConfirm{
    [RequestApi requestReceiveOrderWithNumbers:self.orderNumber delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        [GlobalMethod showAlert:@"确认收货成功"];
        [self requestDetail];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}

@end
