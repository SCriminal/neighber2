//
//  AuthenticationVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/4/22.
//Copyright © 2020 ping. All rights reserved.
//

#import "AuthenticationVC.h"
//keyboard observe
#import "BaseTableVC+KeyboardObserve.h"
#import "BaseVC+BaseImageSelectVC.h"
//上传图片
#import "AliClient.h"
#import "BaseTableVC+Authority.h"
#import "AuthenticationView.h"
//request
#import "RequestApi+Neighbor.h"

@interface AuthenticationVC ()
@property (nonatomic, strong) ModelBaseData *modelConnectName;
@property (nonatomic, strong) ModelBaseData *modelIdentiyNumber;
@property (nonatomic, strong) AuthenticationBottomView *bottomView;
@property (nonatomic, strong) AuthenticationTopView *topView;
@property (nonatomic, strong) AuthenticationStatusView *statusView;
@property (nonatomic, strong) ModelAuthentication *modelDetail;

@end

@implementation AuthenticationVC
- (AuthenticationStatusView *)statusView{
    if (!_statusView) {
        _statusView = [AuthenticationStatusView new];
        _statusView.top = NAVIGATIONBAR_HEIGHT;
    }
    return _statusView;
}
- (AuthenticationBottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [AuthenticationBottomView new];
        WEAKSELF
        _bottomView.btnBottom.blockClick = ^{
            [weakSelf requestPost];
        };
    }
    return _bottomView;
}
- (AuthenticationTopView *)topView{
    if (!_topView) {
        _topView = [AuthenticationTopView new];
        _topView.top = NAVIGATIONBAR_HEIGHT;
    }
    return _topView;
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
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    //table
    [self registAuthorityCell];
    
    //config data
    [self configData];
    //add keyboard observe
    [self addObserveOfKeyboard];
    //request detail
    [self requestDetail];
    
}
#pragma mark config data
- (void)configData{
    
    self.aryDatas = @[ self.modelConnectName,self.modelIdentiyNumber].mutableCopy;
    self.tableView.tableFooterView = self.bottomView;
    
    
    
    [self.tableView reloadData];
}

#pragma mark 添加导航栏
- (void)addNav{
    [self.view addSubview:[BaseNavView initNavBackTitle:@"实名认证" rightView:nil]];
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
- (void)requestDetail{
    [RequestApi requestAuthenticationDetailWithDelegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.modelDetail = [ModelAuthentication modelObjectWithDictionary:response];
//        审核状态  1-未提交  2-审核中  10审核通过  11-审核未通过
        if (self.modelDetail.status == 2||self.modelDetail.status == 10) {
            [self.statusView resetViewWithState:self.modelDetail.status];
            [self.view addSubview:self.statusView];
        }else{
            [self.statusView removeFromSuperview];
            self.modelConnectName.subString = self.modelDetail.realName;
            self.modelIdentiyNumber.subString = self.modelDetail.idNumber;
            [self.bottomView resetViewWithModel:self.modelDetail];
            [self configData];
        }
        
        if (self.modelDetail.status == 11) {
            [self.topView resetViewWithTitle:UnPackStr(self.modelDetail.internalBaseClassDescription)];
            [self.view addSubview:self.topView];
            self.tableView.top = self.topView.bottom;
            self.tableView.height = SCREEN_HEIGHT - self.topView.bottom;
            
        }else{
            self.tableView.top = NAVIGATIONBAR_HEIGHT;
            self.tableView.height = SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT;
        }
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
    
}
- (void)requestPost{
    [GlobalMethod endEditing];
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
    NSString * urlHead = [BaseImage fetchUrl:self.bottomView.identityHeadIV.image];
    if (!isStr(urlHead)) {
        [GlobalMethod showAlert:@"请上传身份证头像面"];
        return;
    }
    NSString * urlEmblem = [BaseImage fetchUrl:self.bottomView.identityCountryIV.image];
    if (!isStr(urlEmblem)) {
        [GlobalMethod showAlert:@"请上传身份证国徽面"];
        return;
    }
    [RequestApi requestAddAuthenticationWithIdnumber:self.modelIdentiyNumber.subString realName:self.modelConnectName.subString idPortrait:urlHead idEmblem:urlEmblem delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        [self requestDetail];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
@end
