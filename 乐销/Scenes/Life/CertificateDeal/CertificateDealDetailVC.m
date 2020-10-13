//
//  CertificateDealDetailVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/5/21.
//Copyright © 2020 ping. All rights reserved.
//

#import "CertificateDealDetailVC.h"
#import "BaseTableVC+Authority.h"
#import "YellowButton.h"
#import "CertificateDealDetailView.h"
//request
#import "RequestApi+Neighbor.h"
#import "WebVC.h"

@interface CertificateDealDetailVC ()
@property (nonatomic, strong) ModelBaseData *modelConnectName;
@property (nonatomic, strong) ModelBaseData *modelIdentiyNumber;
@property (nonatomic, strong) UIView *viewBottom;
@property (nonatomic, strong) CertificateDealDetailView *voteView;
@property (nonatomic, strong) UIView *viewHeader;
@property (nonatomic, strong) ModelCertificateContentDetail *modelDetail;

@end

@implementation CertificateDealDetailVC
- (UIView *)viewHeader{
    if (!_viewHeader) {
        _viewHeader = [UIView new];
        _viewHeader.backgroundColor = [UIColor clearColor];
        _viewHeader.width = SCREEN_WIDTH;
    }
    return _viewHeader;
}
- (ModelBaseData *)modelConnectName{
    if (!_modelConnectName) {
        _modelConnectName = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_TEXT;
            model.locationType = ENUM_CELL_LOCATION_TOP;
            model.imageName = @"";
            model.string = @"真实姓名";
            model.placeHolderString = @"请输入真实姓名";
            return model;
        }();
    }
    return _modelConnectName;
}
- (ModelBaseData *)modelIdentiyNumber{
    if (!_modelIdentiyNumber) {
        _modelIdentiyNumber = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_TEXT;
            model.locationType = ENUM_CELL_LOCATION_BOTTOM;
            model.hideState = true;
            model.imageName = @"";
            model.string = @"身份证号";
            model.placeHolderString = @"请输入身份证号";
            return model;
        }();
    }
    return _modelIdentiyNumber;
}
- (UIView *)viewBottom{
    if (!_viewBottom) {
        _viewBottom = [UIView new];
        _viewBottom.backgroundColor = [UIColor clearColor];
        YellowButton *btn = [YellowButton new];
        [btn resetViewWithWidth:W(335) :W(45) :@"提交"];
        WEAKSELF
        btn.blockClick = ^{
            [weakSelf requestSubmit];
        };
        btn.centerXTop = XY(SCREEN_WIDTH/2.0, W(15));
        [_viewBottom addSubview:btn];
        
        {
            UILabel * l = [UILabel new];
            l.font = [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
            l.textColor = COLOR_ORANGE;
            l.backgroundColor = [UIColor clearColor];
            [l fitTitle:[NSString stringWithFormat:@"《%@办理指南》",self.modelItem.title] variable:SCREEN_WIDTH - W(30)];
            l.leftTop = XY(W(25), W(btn.bottom)+W(18));
            [_viewBottom addSubview:l];

            [_viewBottom addControlFrame:CGRectInset(l.frame, -W(20), -W(20)) belowView:l target:self action:@selector(jumpToExplain)];
        }
        _viewBottom.widthHeight = XY(SCREEN_WIDTH, btn.bottom + W(15)+iphoneXBottomInterval);
        _viewBottom.bottom = SCREEN_HEIGHT;
    }
    return _viewBottom;
}
- (CertificateDealDetailView *)voteView{
    if (!_voteView) {
        _voteView = [CertificateDealDetailView new];
    }
    return _voteView;
}

#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    //table
    //table
    [self registAuthorityCell];
    
    //config data
    [self configData];
    //add keyboard observe
    [self addObserveOfKeyboard];
    //request
    [self requestList];
}

#pragma mark 添加导航栏
- (void)addNav{
    WEAKSELF
    [self.view addSubview:[BaseNavView initNavBackTitle:UnPackStr(self.modelItem.title) rightTitle:@"说明" rightBlock:^{
        [weakSelf jumpToExplain];
    }]];
}
- (void)jumpToExplain{
    WebVC * vc = [WebVC new];
    vc.navTitle = [NSString stringWithFormat:@"%@办理指南",self.modelItem.title];
    vc.url = [NSString stringWithFormat:@"https://wsq.hongjiafu.cn/life/onekey/manual?id=%.f&areaId=%.f",self.modelItem.iDProperty,[GlobalData sharedInstance].community.iDProperty];
#ifdef DEBUG
    vc.url = [NSString stringWithFormat:@"http://192.168.20.167:8884/life/onekey/manual?id=%.f&areaId=%.f",self.modelItem.iDProperty,[GlobalData sharedInstance].community.iDProperty];
#endif
    [GB_Nav pushViewController:vc animated:true];
}
- (void)configData{
    self.aryDatas = @[ self.modelConnectName,self.modelIdentiyNumber].mutableCopy;
    
    [self.viewHeader removeAllSubViews];
    [self.viewHeader addSubview:self.voteView];
    self.viewBottom.top = self.voteView.bottom;
    [self.viewHeader addSubview:self.viewBottom];
    
    self.viewHeader.height = self.viewBottom.bottom;
    self.tableView.tableFooterView = self.viewHeader;
    
    [self.tableView reloadData];
}


#pragma mark UITableViewDelegate
//row num
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.aryDatas.count;
}
//cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self dequeueAuthorityCell:indexPath];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self fetchAuthorityCellHeight:indexPath];
}

#pragma mark request
- (void)requestList{
    if (self.modelResutlDetail) {
        [self.voteView resetViewWithModel:self.modelResutlDetail.participant];
        self.modelConnectName.subString = self.modelResutlDetail.realName;
        self.modelIdentiyNumber.subString = self.modelResutlDetail.idNumber;
        [self configData];
        return;
    }
    [RequestApi requestCertificateContentWithId:self.modelItem.iDProperty areaId:[GlobalData sharedInstance].community.iDProperty delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        ModelCertificateContentDetail * model = [ModelCertificateContentDetail modelObjectWithDictionary:response];
        self.modelDetail = model;
        [self.voteView resetViewWithModel:model.template];
        [self configData];
        [self requestDetail];
        
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
    
}
- (void)requestDetail{
    [RequestApi requestAuthenticationDetailWithDelegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        ModelAuthentication * detail = [ModelAuthentication modelObjectWithDictionary:response];
        //        审核状态  1-未提交  2-审核中  10审核通过  11-审核未通过
        if (detail.status == 10) {
            self.modelConnectName.subString = detail.realName;
            self.modelIdentiyNumber.subString = detail.idNumber;
            [self configData];
        }
        
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
    
}

- (void)requestSubmit{
    if (self.modelResutlDetail) {//resubmit
        
        for (ModelQuestionnairDetailContent * content in self.modelResutlDetail.participant) {
            [content exchangeValue];
            if (isStr([content judgeRequirement])) {
                [GlobalMethod showAlert:[content judgeRequirement]];
                return;
            }
        }
        [GlobalMethod endEditing];
        for (ModelBaseData *model  in self.aryDatas) {
            if (model.enumType == ENUM_PERFECT_CELL_TEXT||model.enumType == ENUM_PERFECT_CELL_SELECT||model.enumType == ENUM_PERFECT_CELL_ADDRESS) {
                if (!isStr(model.subString)) {
                    [GlobalMethod showAlert:model.placeHolderString];
                    return;
                }
            }
        }
        if (!isIdentityNum(self.modelIdentiyNumber.subString)) {
            [GlobalMethod showAlert:@"请输入有效身份证号"];
            return;
        }
        [RequestApi requestResubmitCertificateWithNumber:self.modelResutlDetail.number content:[GlobalMethod exchangeModelsToJson:self.modelResutlDetail.participant] realName:self.modelConnectName.subString idNumber:self.modelIdentiyNumber.subString delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
            [GlobalMethod showAlert:@"重新提交成功"];
            [GB_Nav popViewControllerAnimated:true];
            
        } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
            
        }];
    }else{
        
        for (ModelQuestionnairDetailContent * content in self.modelDetail.template) {
            [content exchangeValue];
            if (isStr([content judgeRequirement])) {
                [GlobalMethod showAlert:[content judgeRequirement]];
                return;
            }
        }
        [GlobalMethod endEditing];
        for (ModelBaseData *model  in self.aryDatas) {
            if (model.enumType == ENUM_PERFECT_CELL_TEXT||model.enumType == ENUM_PERFECT_CELL_SELECT||model.enumType == ENUM_PERFECT_CELL_ADDRESS) {
                if (!isStr(model.subString)) {
                    [GlobalMethod showAlert:model.placeHolderString];
                    return;
                }
            }
        }
        if (!isIdentityNum(self.modelIdentiyNumber.subString)) {
            [GlobalMethod showAlert:@"请输入有效身份证号"];
            return;
        }
        [RequestApi requestSubmitCertificateWithRealname:self.modelConnectName.subString idNumber:self.modelIdentiyNumber.subString content:[GlobalMethod exchangeModelsToJson:self.modelDetail.template] areaId:[GlobalData sharedInstance].community.iDProperty identity:self.modelItem.iDProperty delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
            [GlobalMethod showAlert:@"提交成功"];
            [GB_Nav popViewControllerAnimated:true];
        } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
            
        }];
    }
}
@end
