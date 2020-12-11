//
//  EHomePayOrderVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/10/2.
//Copyright © 2020 ping. All rights reserved.
//

#import "EHomePayOrderVC.h"
#import "EHomeWaitPayView.h"
#import "RequestApi+EHomePay.h"
#import <ISSBankSDK/ISSBankSDK.h>
#import "EHomePayHistoryListVC.h"
#import "UIDevice+YYAdd.h"
@interface EHomePayOrderVC ()
@property (nonatomic, strong) EHomeWaitPayBottomView *bottomView;
@property (nonatomic, strong) UIView *tableHeaderView;

@end

@implementation EHomePayOrderVC
#pragma mark noresult view
- (UIView *)tableHeaderView{
    if (!_tableHeaderView) {
        _tableHeaderView = [UIView new];
        _tableHeaderView.width = SCREEN_WIDTH;
        _tableHeaderView.backgroundColor = [UIColor clearColor];
    }
    return _tableHeaderView;
}

- (EHomeWaitPayBottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [EHomeWaitPayBottomView new];
        _bottomView.bottom = SCREEN_HEIGHT;
        _bottomView.ivSelected.hidden = true;
        _bottomView.num.hidden = true;
        WEAKSELF
        _bottomView.blockSubmitClick = ^{
            [weakSelf requestPay];
            
        };
        [_bottomView resetViewWithModel:self.aryDatas];
    }
    return _bottomView;
}
- (void)reconfigView{
    [self.tableHeaderView removeAllSubViews];
    //auto sc
    
    CGFloat top = W(25);
    ModelArchiveList *modelArchive = [GlobalData sharedInstance].modelEHomeArchive;
    
    NSArray * ary = @[^(){
        ModelBaseData * modelItem = [ModelBaseData new];
        modelItem.string = @"缴费项目";
        modelItem.subString = @"物业费";
        return modelItem;
    }(),^(){
        ModelBaseData * modelItem = [ModelBaseData new];
        modelItem.string = @"业主姓名";
        modelItem.subString = modelArchive.realName;
        return modelItem;
    }(),^(){
        ModelBaseData * modelItem = [ModelBaseData new];
        modelItem.string = @"缴费房屋";
        modelItem.subString = [NSString stringWithFormat:@"%@%@号楼%@单元%@",UnPackStr(modelArchive.estateName),UnPackStr(modelArchive.buildingName),UnPackStr(modelArchive.unitName),UnPackStr(modelArchive.roomName)];
        
        return modelItem;
    }()];
    for (int i = 0; i<ary.count; i++) {
        ModelBaseData * item = ary[i];
        {
            UILabel * l = [UILabel new];
            l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
            l.textColor = COLOR_666;
            l.backgroundColor = [UIColor clearColor];
            l.numberOfLines = 0;
            l.lineSpace = W(0);
            [l fitTitle:item.string variable:SCREEN_WIDTH - W(30)];
            l.leftTop = XY(W(30), top);
            [self.tableHeaderView addSubview:l];
        }
        {
            UILabel * l = [UILabel new];
            l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
            l.textColor = COLOR_333;
            l.backgroundColor = [UIColor clearColor];
            l.numberOfLines = 0;
            l.lineSpace = W(3);
            [l fitTitle:item.subString variable: W(224)];
            l.leftTop = XY(W(122), top);
            [self.tableHeaderView addSubview:l];
            top = l.bottom + W(20);
        }
    }
    
    {
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        l.textColor = COLOR_666;
        l.backgroundColor = [UIColor clearColor];
        l.numberOfLines = 0;
        l.lineSpace = W(0);
        [l fitTitle:@"交费项目" variable:SCREEN_WIDTH - W(30)];
        l.leftTop = XY(W(30),[self.tableHeaderView addLineFrame:CGRectMake(W(30), top, SCREEN_WIDTH - W(30), 1)]+W(20));
        [self.tableHeaderView addSubview:l];
        top = l.bottom + W(35);
    }
    
    
    for (int i = 0; i<self.aryDatas.count; i++) {
        ModelEHomeWaitPayList * model = self.aryDatas[i];
        
        UIView * view = [UIView new];
        view.backgroundColor = [UIColor colorWithHexString:@"#FCFCFC"];
        view.width = W(315);
        view.height = W(88);
        view.centerXTop = XY(SCREEN_WIDTH/2.0, top - W(15));
        [view addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:10 lineWidth:1 lineColor:[UIColor colorWithHexString:@"#FBFBFB"]];
        
        [self.tableHeaderView addSubview:view];
        {
            UILabel * l = [UILabel new];
            l.font = [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
            l.textColor = COLOR_666;
            l.backgroundColor = [UIColor clearColor];
            l.numberOfLines = 0;
            l.lineSpace = W(0);
            [l fitTitle:@"缴费周期" variable:SCREEN_WIDTH - W(30)];
            l.leftTop = XY(W(45), top);
            [self.tableHeaderView addSubview:l];
            
            l = [UILabel new];
            l.font = [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
            l.textColor = COLOR_666;
            l.backgroundColor = [UIColor clearColor];
            l.numberOfLines = 0;
            l.lineSpace = W(0);
            [l fitTitle:[NSString stringWithFormat:@"%@-%@",UnPackStr(model.feesStartDate),UnPackStr(model.feesEndDate)] variable:SCREEN_WIDTH - W(30)];
            l.rightTop = XY(SCREEN_WIDTH -  W(45), top);
            [self.tableHeaderView addSubview:l];
        }
        {
            UILabel * l = [UILabel new];
            l.font = [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
            l.textColor = COLOR_666;
            l.backgroundColor = [UIColor clearColor];
            l.numberOfLines = 0;
            l.lineSpace = W(0);
            [l fitTitle:@"滞纳金" variable:SCREEN_WIDTH - W(30)];
            l.leftTop = XY(W(45), top+W(23));
            [self.tableHeaderView addSubview:l];
            
            l = [UILabel new];
            l.font = [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
            l.textColor = COLOR_666;
            l.backgroundColor = [UIColor clearColor];
            l.numberOfLines = 0;
            l.lineSpace = W(0);
            [l fitTitle:[NSString stringWithFormat:@"￥%@",NSNumber.dou(model.dueFineFee).stringValue] variable:SCREEN_WIDTH - W(30)];
            l.rightTop = XY(SCREEN_WIDTH -  W(45), top+W(23));
            [self.tableHeaderView addSubview:l];
        }
        {
            UILabel * l = [UILabel new];
            l.font = [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
            l.textColor = COLOR_666;
            l.backgroundColor = [UIColor clearColor];
            l.numberOfLines = 0;
            l.lineSpace = W(0);
            [l fitTitle:@"缴费金额" variable:SCREEN_WIDTH - W(30)];
            l.leftTop = XY(W(45), top+W(46));
            [self.tableHeaderView addSubview:l];
            
            l = [UILabel new];
            l.font = [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
            l.textColor = COLOR_666;
            l.backgroundColor = [UIColor clearColor];
            l.numberOfLines = 0;
            l.lineSpace = W(0);
            [l fitTitle:[NSString stringWithFormat:@"￥%@",NSNumber.dou(model.debtsAmount).stringValue] variable:SCREEN_WIDTH - W(30)];
            l.rightTop = XY(SCREEN_WIDTH -  W(45), top+W(46));
            [self.tableHeaderView addSubview:l];
            top = l.bottom + W(45);
        }
    }
    
    self.tableHeaderView.height = top ;
    self.tableView.tableHeaderView = self.tableHeaderView;
}

#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    [self.view addSubview:self.bottomView];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshHeaderAll) name:NOTICE_TROLLEY_EXCHANGE object:nil];
    self.tableView.height = SCREEN_HEIGHT - self.bottomView.height - NAVIGATIONBAR_HEIGHT;
    //table
    //self.tableView.backgroundColor = COLOR_GRAY;
    //request
    [self requestList];
    [self reconfigView];
}

#pragma mark 添加导航栏
- (void)addNav{
    [self.view addSubview:[BaseNavView initNavBackTitle:@"待付账单" rightTitle:@"历史查询" rightBlock:^{
        [GB_Nav pushVCName:@"EHomePayHistoryListVC" animated:true];
    }]];
}

#pragma mark request
- (void)requestList{
    
}
- (void)requestPay{
    NSMutableArray * ary = [NSMutableArray array];
    CGFloat numAll = 0;
    for (ModelEHomeWaitPayList * modelItem in self.aryDatas) {
        if (modelItem.selected) {
            numAll += modelItem.debtsAmount;
            numAll += modelItem.dueFineFee;
        }
        [ary addObjectsFromArray:modelItem.feesIds];
    }
    /*@JHG 15666666666
     15510787767
     15264299715
     17685571713
     17685571713
     17685571713
     18899990000
     18799999999
     18900007777
     18799990000
     17685571713
     13791635878
     17685571713
     13794833124
     17685571713
     18867996625
     [GlobalMethod exchangeDicToJson:ary]
     */
    
    [RequestApi requestEHomePayWithtelephone:[GlobalData sharedInstance].GB_UserModel.phone feesIds:[NSString stringWithFormat:@"[%@]",[ary componentsJoinedByString:@","]] feeAmounts:NSNumber.dou(numAll).stringValue payType:@"1" transType:@"1" delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        EHomePayWeichatInfo * model = [EHomePayWeichatInfo modelObjectWithDictionary:response];
        [self payWithModel:model];
        NSLog(@"aa");
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}

- (void)payWithModel:(EHomePayWeichatInfo *)model{
    NSDictionary * requestHeader = @{
        @"opId": @"ebus_PYOrderDealApp",
        @"rqId": @"Z6",
        @"ver": @"03",
    };
    NSString * ipCell = [UIDevice currentDevice].ipAddressCell;
    NSString * ipWifi = [UIDevice currentDevice].ipAddressWIFI;

    NSDictionary * requestData = @{
        @"orderNo": model.payOrderNo,
        @"orderAmt": NSNumber.dou(model.fee).stringValue,
        @"oneMerchNo" : model.epishopId,
        @"notifyURL" : model.notifyUrl,
        @"currency" : @"CNY",
        @"transType" : @"AP04",
        @"orderDesc" : model.orderDesc,
        @"orderTitle" : model.orderTitle,
        @"ipAddress":isStr(ipWifi)?ipWifi:UnPackStr(ipCell),
        @"orderTime" : [GlobalMethod exchangeDate:[NSDate date] formatter:@"yyyyMMddHHmmss"],
        
    };
    ISSPaySDK *paySDK = [ISSPaySDK payBankID:@"802" environmentMode:ISSBankSDKEnvironmentMode_ST scene:ISSBankSDKUseScenePay];
    [paySDK showPayAddedTo:self url:@"PYOrderDeal.do" channelID:@"B2" requestHeader:requestHeader requestData:requestData success:^{
        [GlobalMethod showAlert:@"支付成功"];
        [GB_Nav popLastAndPushVC:[EHomePayHistoryListVC new]];
        NSLog(@"sld %s", __func__);
    } failure:^(NSString *message) {
        [GlobalMethod showAlert:@"支付失败"];
        NSLog(@"%s", __func__);
        NSLog(@"sld %@", message);
    } cancel:^(id result) {
        NSLog(@"%s", __func__);
        [GlobalMethod showAlert:@"支付取消"];
        NSLog(@"sld %@", result);
        NSString * strJson = (NSString *)result;
        if ([strJson isKindOfClass:[NSString class]]) {
            NSDictionary * dic = [GlobalMethod exchangeStringToDic:strJson];
            if ([dic isKindOfClass:[NSDictionary class]]) {
                double state = [dic doubleValueForKey:@"orderState"];
                if (state == 90) {
                    [GlobalMethod showAlert:@"支付成功"];
                    [GB_Nav popLastAndPushVC:[EHomePayHistoryListVC new]];
                }else{
                    [GlobalMethod showAlert:@"支付失败"];
                }
            }
        }
    }];
}

@end
