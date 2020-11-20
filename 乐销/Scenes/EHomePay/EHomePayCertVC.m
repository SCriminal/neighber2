//
//  EHomePayCertVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/10/12.
//Copyright © 2020 ping. All rights reserved.
//

#import "EHomePayCertVC.h"
//yellow btn
#import "YellowButton.h"
#import "EHomeDownloadCertVC.h"
#import "RequestApi+EHomePay.h"

@interface EHomePayCertVC ()
@property (nonatomic, strong) YellowButton *btnBottom;
@property (nonatomic, strong) UIView *tableHeaderView;
@property (nonatomic, strong) ModelEHomePayHistoryItem *modelDetail;

@end

@implementation EHomePayCertVC
- (YellowButton *)btnBottom{
    if (!_btnBottom) {
        _btnBottom = [YellowButton new];
        [_btnBottom resetViewWithWidth:W(335) :W(45) :@"缴费凭证"];
        _btnBottom.centerXBottom = XY(SCREEN_WIDTH/2.0, SCREEN_HEIGHT - W(25)-iphoneXBottomInterval);
        WEAKSELF
        _btnBottom.blockClick = ^{
            EHomeDownloadCertVC * vc = [EHomeDownloadCertVC new];
            vc.modelDetail = weakSelf.modelDetail;
            [GB_Nav pushViewController:vc animated:true];
        };
    }
    return _btnBottom;
}
- (UIView *)tableHeaderView{
    if (!_tableHeaderView) {
        _tableHeaderView = [UIView new];
        _tableHeaderView.width = SCREEN_WIDTH;
        _tableHeaderView.backgroundColor = [UIColor clearColor];
    }
    return _tableHeaderView;
}

- (void)reconfigView{
    [self.tableHeaderView removeAllSubViews];
    //auto sc
    
    CGFloat top = W(40);
    {
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        l.textColor = COLOR_333;
        l.backgroundColor = [UIColor clearColor];
        [l fitTitle:UnPackStr(self.modelDetail.feeStateName) variable:SCREEN_WIDTH - W(30)];
        l.centerXTop = XY(SCREEN_WIDTH/2.0, top);
        [self.tableHeaderView addSubview:l];
        top = l.bottom;
    }
    {
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(25) weight:UIFontWeightMedium];
        l.textColor = COLOR_333;
        l.backgroundColor = [UIColor clearColor];
        [l fitTitle:[NSString stringWithFormat:@"￥%@",NSNumber.dou(self.modelDetail.payAmount).stringValue]  variable:SCREEN_WIDTH - W(30)];
        l.centerXTop = XY(SCREEN_WIDTH/2.0, top+ W(20));
        [self.tableHeaderView addSubview:l];
        top = l.bottom;
    }
    {
        top = [self.tableHeaderView addLineFrame:CGRectMake(W(30), top + W(40), SCREEN_WIDTH - W(60), 1)];
    }
    NSArray * ary = @[^(){
        ModelBaseData * modelItem = [ModelBaseData new];
        modelItem.string = @"业主姓名";
        modelItem.subString = self.modelDetail.custName;
        return modelItem;
    }(),^(){
        ModelBaseData * modelItem = [ModelBaseData new];
        modelItem.string = @"缴费房屋";
        modelItem.subString = [NSString stringWithFormat:@"%@/%@号楼/%@单元/%@室",self.modelDetail.areaName,self.modelDetail.floorName,self.modelDetail.unitNo,self.modelDetail.roomNo];
        return modelItem;
    }(),^(){
        ModelBaseData * modelItem = [ModelBaseData new];
        modelItem.string = @"缴费人";
        modelItem.subString = self.modelDetail.custName;
        return modelItem;
    }(),^(){
        ModelBaseData * modelItem = [ModelBaseData new];
        modelItem.string = @"支付时间";
        modelItem.subString = self.modelDetail.payDate;
        return modelItem;
    }(),^(){
        ModelBaseData * modelItem = [ModelBaseData new];
        modelItem.string = @"支付方式";
        modelItem.subString = self.modelDetail.payType;
        return modelItem;
    }(),^(){
        ModelBaseData * modelItem = [ModelBaseData new];
        modelItem.string = @"缴费状态";
        modelItem.subString = self.modelDetail.payStatus;
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
            l.rightTop = XY(W(92), top + W(20));
            [self.tableHeaderView addSubview:l];
        }
        {
            UILabel * l = [UILabel new];
            l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
            l.textColor = COLOR_333;
            l.backgroundColor = [UIColor clearColor];
            l.numberOfLines = 0;
            l.lineSpace = W(3);
            [l fitTitle:UnPackStr(item.subString) variable: W(224)];
            l.leftTop = XY(W(122), top + W(20));
            [self.tableHeaderView addSubview:l];
            top = l.bottom ;
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
    //request
    [self requestList];
    self.tableView.height = self.btnBottom.top - W(15) - NAVIGATIONBAR_HEIGHT;
    [self.view addSubview:self.btnBottom];
    
}

#pragma mark 添加导航栏
- (void)addNav{
    [self.view addSubview:[BaseNavView initNavBackTitle:@"缴费凭证" rightView:nil]];
}

#pragma mark request
- (void)requestList{
    [self reconfigView];
    [RequestApi requestEHomePayCert:[GlobalData sharedInstance].GB_UserModel.phone feesId:self.modelItem.feesId delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.modelDetail = [ModelEHomePayHistoryItem modelObjectWithDictionary:response];
        [self reconfigView];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
@end
