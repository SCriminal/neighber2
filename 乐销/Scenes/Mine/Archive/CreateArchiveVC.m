//
//  CreateArchiveVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/10.
//Copyright © 2020 ping. All rights reserved.
//

#import "CreateArchiveVC.h"
//keyboard observe
#import "BaseTableVC+KeyboardObserve.h"
#import "BaseVC+BaseImageSelectVC.h"
//上传图片
#import "AliClient.h"
#import "BaseTableVC+Authority.h"
#import "YellowButton.h"
//footer
#import "CreateArchiveView.h"
//request
#import "RequestApi+Neighbor.h"
//base alert
#import "BaseAlertView.h"
//authention
#import "AuthenticationVC.h"

@interface CreateArchiveVC ()
@property (nonatomic, strong) ModelBaseData *modelName;
@property (nonatomic, strong) ModelBaseData *modelIdentity;
@property (nonatomic, strong) ModelBaseData *modelPhone;
@property (nonatomic, strong) ModelBaseData *modelBuilding;
@property (nonatomic, strong) ModelBaseData *modelUnit;
@property (nonatomic, strong) ModelBaseData *modelHouse;
@property (nonatomic, strong) ModelBaseData *modelProfession;
@property (nonatomic, strong) ModelBaseData *modelCompany;
@property (nonatomic, strong) ModelAuthentication *modelAuthentication;
@property (nonatomic, strong) CreateArchiveView *footer;

@end

@implementation CreateArchiveVC

#pragma mark lazy init

- (CreateArchiveView *)footer{
    if (!_footer) {
        _footer = [CreateArchiveView new];
        WEAKSELF
        _footer.btnBottom.blockClick = ^{
            [weakSelf requestCreate];
        };
        [_footer.selectIdentityView selectIndex:self.model.tag?(self.model.tag-1):0] ;
        [_footer.selectRepublicView selectIndex: self.model.isParty];
        
    }
    return _footer;
}
- (ModelBaseData *)modelName{
    if (!_modelName) {
        _modelName = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_TEXT;
            model.imageName = @"";
            model.string = @"真实姓名";
            model.subString = self.model.realName;
            model.placeHolderString = @"请输入真实姓名";
            model.locationType = ENUM_CELL_LOCATION_TOP;
            //            model.isChangeInvalid = true;
            
            return model;
        }();
    }
    return _modelName;
}
- (ModelBaseData *)modelIdentity{
    if (!_modelIdentity) {
        _modelIdentity = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_TEXT;
            model.imageName = @"";
            model.string = @"身份证号";
            model.subString = self.model.idNumber;
            model.placeHolderString = @"请输入身份证号码";
            //            model.isChangeInvalid = true;
            model.subString = self.model.idNumber;
            
            return model;
        }();
    }
    return _modelIdentity;
}
- (ModelBaseData *)modelPhone{
    if (!_modelPhone) {
        _modelPhone = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_TEXT;
            model.imageName = @"";
            model.string = @"手机号码";
            model.subString = self.model.cellPhone;
            model.placeHolderString = @"请输入手机号码";
            //            model.subString = [GlobalData sharedInstance].GB_UserModel.account;
            return model;
        }();
    }
    return _modelPhone;
}
- (ModelBaseData *)modelBuilding{
    if (!_modelBuilding) {
        _modelBuilding = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_TEXT;
            model.imageName = @"";
            model.string = @"楼栋号";
            model.subString = self.model.buildingName;
            
            model.placeHolderString = @"请输入楼栋号";
            //            model.subString = [GlobalData sharedInstance].GB_UserModel.account;
            return model;
        }();
    }
    return _modelBuilding;
}
- (ModelBaseData *)modelUnit{
    if (!_modelUnit) {
        _modelUnit = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_TEXT;
            model.imageName = @"";
            model.subString = self.model.unitName;
            
            model.string = @"单元号";
            model.placeHolderString = @"请输入单元号";
            //            model.subString = [GlobalData sharedInstance].GB_UserModel.account;
            return model;
        }();
    }
    return _modelUnit;
}
- (ModelBaseData *)modelHouse{
    if (!_modelHouse) {
        _modelHouse = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_TEXT;
            model.imageName = @"";
            model.string = @"门牌号";
            model.placeHolderString = @"请输入门牌号";
            model.subString = self.model.roomName;
            
            //            model.subString = [GlobalData sharedInstance].GB_UserModel.account;
            return model;
        }();    }
    return _modelHouse;
}
- (ModelBaseData *)modelProfession{
    if (!_modelProfession) {
        _modelProfession = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_TEXT;
            model.imageName = @"";
            model.string = @"职业";
            model.placeHolderString = @"请输入职业";
            model.subString = self.model.job;
            
            //            model.subString = [GlobalData sharedInstance].GB_UserModel.account;
            return model;
        }();    }
    return _modelProfession;
}
- (ModelBaseData *)modelCompany{
    if (!_modelCompany) {
        _modelCompany = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_TEXT;
            model.imageName = @"";
            model.string = @"单位";
            model.placeHolderString = @"请输入单位名称";
            model.subString = self.model.enterprise;
            
            //            model.subString = [GlobalData sharedInstance].GB_UserModel.account;
            return model;
        }();    }
    return _modelCompany;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    //table
    self.tableView.tableFooterView = self.footer;
    [self registAuthorityCell];
    
    //config data
    [self configData];
    //add keyboard observe
    [self addObserveOfKeyboard];
    //request authority certify
    [self requestCertify];
}

#pragma mark 添加导航栏
- (void)addNav{
    BaseNavView *nav = [BaseNavView initNavBackTitle:@"建档" rightTitle:@"" rightBlock:^{
    }];
    [self.view addSubview:nav];
}

#pragma mark config data
- (void)configData{
    self.aryDatas = @[ self.modelName,self.modelIdentity,self.modelPhone,self.modelBuilding,self.modelUnit,self.modelHouse,self.modelProfession,self.modelCompany].mutableCopy;
    //    self.aryDatas = @[ self.modelPhone,self.modelBuilding,self.modelUnit,self.modelHouse,self.modelProfession,self.modelCompany].mutableCopy;
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

- (void)requestCreate{
    //    if (self.modelAuthentication.status != 10) {
    //        [self requestCertify];
    //        return;
    //    }
    [GlobalMethod endEditing];
    for (ModelBaseData *model  in self.aryDatas) {
        if (model.enumType == ENUM_PERFECT_CELL_TEXT||model.enumType == ENUM_PERFECT_CELL_SELECT||model.enumType == ENUM_PERFECT_CELL_ADDRESS) {
            if (!isStr(model.subString)) {
                [GlobalMethod showAlert:model.placeHolderString];
                return;
            }
        }
    }
    if (!isIdentityNum(self.modelIdentity.subString)) {
        [GlobalMethod showAlert:@"请输入有效身份证号"];
        return;
    }
    if (!isPhoneNum(self.modelPhone.subString)) {
        [GlobalMethod showAlert:@"请输入有效手机号"];
        return;
    }
    ModelAddress * modelAddress = [GlobalMethod readModelForKey:LOCAL_LOCATION modelName:@"ModelAddress" exchange:false];
    if (self.model.iDProperty) {
        [RequestApi requestEditArchiveWithEstateid:[GlobalData sharedInstance].community.iDProperty  cellPhone:self.modelPhone.subString buildingName:self.modelBuilding.subString unitName:self.modelUnit.subString roomName:self.modelHouse.subString tag:self.footer.selectIdentityView.index+1  lng:[NSString stringWithFormat:@"%lf",modelAddress.lng] lat:[NSString stringWithFormat:@"%lf",modelAddress.lat] job:self.modelProfession.subString enterprise:self.modelCompany.subString isPart:self.footer.selectRepublicView.index identity:self.model.iDProperty scope:nil                                      realName:self.modelName.subString
                                          idNumber:self.modelIdentity.subString
                                       ehomeRoomId:self.model.ehomeRoomId.doubleValue
                                          delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
            [GlobalMethod showAlert:@"编辑成功"];
            [GB_Nav popViewControllerAnimated:true];
            
        } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
            
        }];
        return;
    }
    [RequestApi requestAddArchiveWithEstateid:[GlobalData sharedInstance].community.iDProperty areaCode:nil  cellPhone:self.modelPhone.subString buildingName:self.modelBuilding.subString unitName:self.modelUnit.subString roomName:self.modelHouse.subString tag:self.footer.selectIdentityView.index+1  lng:[NSString stringWithFormat:@"%lf",modelAddress.lng] lat:[NSString stringWithFormat:@"%lf",modelAddress.lat] job:self.modelProfession.subString enterprise:self.modelCompany.subString isPart:self.footer.selectRepublicView.index scope:nil
                                     realName:self.modelName.subString
                                     idNumber:self.modelIdentity.subString
                                  ehomeRoomId:0
                                     delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        [GlobalMethod showAlert:@"添加成功"];
        [[NSNotificationCenter defaultCenter]postNotificationName:NOTICE_ARCHIVE_CREATE object:nil];
        [GB_Nav popViewControllerAnimated:true];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
- (void)requestCertify{
    [RequestApi requestAuthenticationDetailWithDelegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        ModelAuthentication *modelDetail = [ModelAuthentication modelObjectWithDictionary:response];
        self.modelAuthentication = modelDetail;
        WEAKSELF
        //        审核状态  1-未提交  2-审核中  10审核通过  11-审核未通过
        //            if (modelDetail.status != 10) {
        //               ModelBtn * modelDismiss = [ModelBtn modelWithTitle:@"取消" imageName:nil highImageName:nil tag:TAG_LINE color:[UIColor redColor]];
        //                modelDismiss.blockClick = ^{
        //                };
        //                  ModelBtn * modelConfirm = [ModelBtn modelWithTitle:@"确认" imageName:nil highImageName:nil tag:TAG_LINE color:COLOR_SUBTITLE];
        //                modelConfirm.blockClick = ^{
        //                    AuthenticationVC * vc = [AuthenticationVC new];
        //                    vc.blockBack = ^(UIViewController *vc) {
        //                        [weakSelf requestCertify];
        //                    };
        //                    [GB_Nav popLastAndPushVC:vc];
        //                };
        //                [BaseAlertView initWithTitle:@"提示" content:@"您还没有实名认证，请您先去实名认证" aryBtnModels:@[modelDismiss,modelConfirm] viewShow:self.view];
        //            }
        if (!self.model.iDProperty) {
            self.modelName.subString = modelDetail.realName;
            self.modelIdentity.subString = modelDetail.idNumber;
            [self configData];
        }
        
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
    
}
@end
