//
//  MerchantSigninVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/10.
//Copyright © 2020 ping. All rights reserved.
//

#import "MerchantSigninVC.h"
//keyboard observe
#import "BaseTableVC+KeyboardObserve.h"
#import "BaseVC+BaseImageSelectVC.h"
//上传图片
#import "AliClient.h"
#import "BaseTableVC+Authority.h"
#import "YellowButton.h"
//sub view
#import "MerchantSigninView.h"
//request
#import "RequestApi+Neighbor.h"
#import "SelectDistrictView.h"
@interface MerchantSigninVC ()
@property (nonatomic, strong) ModelBaseData *modelShopName;
@property (nonatomic, strong) ModelBaseData *modelCreditNo;
@property (nonatomic, strong) ModelBaseData *modelRegistDistrict;
@property (nonatomic, strong) ModelBaseData *modelRegistAddressDetail;
@property (nonatomic, strong) ModelBaseData *modelBusinessAddressDetail;
@property (nonatomic, strong) ModelBaseData *modelRealName;
@property (nonatomic, strong) ModelBaseData *modelIdentity;
@property (nonatomic, strong) ModelBaseData *modelPhone;
@property (nonatomic, strong) MerchantSigninBottomView *signinFooter;
@property (nonatomic, strong) MerchantConnectBottomView *connectFooter;
@property (nonatomic, strong) MerchantSigninStatusView *statusView;
@property (nonatomic, assign) BOOL isResign;
//connect
@property (nonatomic, strong) ModelBaseData *modelConnectName;
@property (nonatomic, strong) ModelBaseData *modelConnectPhone;

@property (nonatomic, strong) MerchantSigninTopView *header;
@property (nonatomic, assign) int index;
@end

@implementation MerchantSigninVC

#pragma mark lazy init
- (MerchantSigninStatusView *)statusView{
    if (!_statusView) {
        _statusView = [MerchantSigninStatusView new];
        _statusView.top = self.header.switchView.top;
        WEAKSELF
        _statusView.btnBottom.blockClick = ^{
            weakSelf.tableView.scrollEnabled = true;
            [weakSelf.statusView removeFromSuperview];
        };
    }
    return _statusView;
}
- (MerchantSigninBottomView *)signinFooter{
    if (!_signinFooter) {
        _signinFooter = [MerchantSigninBottomView new];
        WEAKSELF
        _signinFooter.btnBottom.blockClick = ^{
            [weakSelf requestMerchantSignIn];
            
        };
    }
    return _signinFooter;
}
- (MerchantConnectBottomView *)connectFooter{
    if (!_connectFooter) {
        _connectFooter = [MerchantConnectBottomView new];
        WEAKSELF
        _connectFooter.btnBottom.blockClick = ^{
            [weakSelf requestConnect];
        };
    }
    return _connectFooter;
}
- (MerchantSigninTopView *)header{
    if (!_header) {
        _header = [MerchantSigninTopView new];
        WEAKSELF
        _header.blockClick = ^(int index) {
            weakSelf.index = index;
            [weakSelf configData];
        };
    }
    return _header;
}

- (ModelBaseData *)modelShopName{
    if (!_modelShopName) {
        _modelShopName = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_TEXT;
            model.locationType = ENUM_CELL_LOCATION_TOP;
            
            model.imageName = @"";
            model.string = @"商户名称";
            model.placeHolderString = @"请请输入工商营业执照上名称";
            return model;
        }();
    }
    return _modelShopName;
}
- (ModelBaseData *)modelCreditNo{
    if (!_modelCreditNo) {
        _modelCreditNo = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_TEXT;
            model.imageName = @"";
            model.string = @"信用代码";
            model.placeHolderString = @"请输入统一社会信用代码";
            //            model.subString = [GlobalData sharedInstance].GB_UserModel.account;
            return model;
        }();
    }
    return _modelCreditNo;
}
- (ModelBaseData *)modelRegistDistrict{
    if (!_modelRegistDistrict) {
        _modelRegistDistrict = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_SELECT;
            model.imageName = @"";
            model.string = @"注册地址";
            //            model.hideState = true;
            model.placeHolderString = @"请选择所在市/区县";
            WEAKSELF
            model.blocClick = ^(ModelBaseData *model) {
                SelectDistrictView * selectView = [SelectDistrictView new];
                selectView.blockCitySeleted = ^(ModelProvince *pro, ModelProvince *city, ModelProvince *area) {
                    weakSelf.modelRegistDistrict.subString = [NSString stringWithFormat:@"%@%@%@",pro.name,[pro.name isEqualToString:city.name]?@"":city.name,area.name];
                    weakSelf.modelRegistDistrict.identifier = strDotF(area.iDProperty);
                    [weakSelf configData];
                };
                [weakSelf.view addSubview:selectView];
            };
            return model;
        }();
    }
    return _modelRegistDistrict;
}
- (ModelBaseData *)modelRegistAddressDetail{
    if (!_modelRegistAddressDetail) {
        _modelRegistAddressDetail = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_ADDRESS;
            model.imageName = @"";
            model.string = @"详细地址";
            model.placeHolderString = @"请输入注册详细地址";
            
            return model;
        }();
    }
    return _modelRegistAddressDetail;
}

- (ModelBaseData *)modelBusinessAddressDetail{
    if (!_modelBusinessAddressDetail) {
        _modelBusinessAddressDetail = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_ADDRESS;
            model.imageName = @"";
            model.string = @"经营地址";
            model.placeHolderString = @"请输入详细地址";
            //            model.subString = [GlobalData sharedInstance].GB_UserModel.account;
            return model;
        }();
    }
    return _modelBusinessAddressDetail;
}
- (ModelBaseData *)modelRealName{
    if (!_modelRealName) {
        _modelRealName = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_TEXT;
            model.imageName = @"";
            model.string = @"真实姓名";
            model.placeHolderString = @"请输入负责人真实姓名";
            //            model.subString = [GlobalData sharedInstance].GB_UserModel.account;
            return model;
        }();
    }
    return _modelRealName;
}
- (ModelBaseData *)modelIdentity{
    if (!_modelIdentity) {
        _modelIdentity = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_TEXT;
            model.imageName = @"";
            model.string = @"身份证号";
            model.placeHolderString = @"请输入负责人身份证号";
            //            model.subString = [GlobalData sharedInstance].GB_UserModel.account;
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
            model.locationType = ENUM_CELL_LOCATION_BOTTOM;
            model.hideState = true;
            model.imageName = @"";
            model.string = @"联系电话";
            model.placeHolderString = @"请输入负责人联系电话";
            //            model.subString = [GlobalData sharedInstance].GB_UserModel.account;
            return model;
        }();
    }
    return _modelPhone;
}

- (ModelBaseData *)modelConnectName{
    if (!_modelConnectName) {
        _modelConnectName = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_TEXT;
            model.locationType = ENUM_CELL_LOCATION_TOP;
            model.imageName = @"";
            model.string = @"联系人";
            model.placeHolderString = @"请输入联系人称呼";
            return model;
        }();
    }
    return _modelConnectName;
}
- (ModelBaseData *)modelConnectPhone{
    if (!_modelConnectPhone) {
        _modelConnectPhone = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_TEXT;
            model.locationType = ENUM_CELL_LOCATION_BOTTOM;
            model.hideState = true;
            model.imageName = @"";
            model.string = @"联系电话";
            model.placeHolderString = @"请输入联系人电话";
            return model;
        }();
    }
    return _modelConnectPhone;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.top = 0;
    self.tableView.bounces = false;
    self.tableView.height = SCREEN_HEIGHT;
    self.tableView.tableHeaderView = self.header;
    [self registAuthorityCell];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    //config data
    [self configData];
    //add keyboard observe
    [self addObserveOfKeyboard];
    //request detail
    [self requestDetail];
    
    
}

#pragma mark config data
- (void)configData{
    //
    if (self.index==0) {
        self.aryDatas = @[ self.modelShopName,self.modelCreditNo,self.modelRegistDistrict,self.modelRegistAddressDetail,self.modelBusinessAddressDetail,self.modelRealName,self.modelIdentity,self.modelPhone].mutableCopy;
        self.tableView.tableFooterView = self.signinFooter;
        
    }else{
        self.aryDatas = @[ self.modelConnectName,self.modelConnectPhone].mutableCopy;
        self.tableView.tableFooterView = self.connectFooter;
    }
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
- (void)requestDetail{
    [RequestApi requestMerchantSiginDetailWithAreaId:[GlobalData sharedInstance].community.iDProperty delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        ModelMerchantDetail * detail = [ModelMerchantDetail modelObjectWithDictionary:response];
        if (detail.reviewStatus) {
            self.isResign = true;
            [self.statusView resetViewWithState:detail.reviewStatus];
            [self configSuccessState];
            
            self.modelShopName.subString = detail.storeName;
            self.modelCreditNo.subString = detail.bizNumber;
            
            self.modelRegistDistrict.subString = [NSString stringWithFormat:@"%@%@%@",detail.regProvinceName,[detail.regProvinceName isEqualToString:detail.regCityName]?@"":detail.regCityName,detail.regCountyName];
            self.modelRegistDistrict.identifier = strDotF(detail.regCountyId);
            self.modelRegistAddressDetail.subString = detail.regAddr;
            self.modelBusinessAddressDetail.subString = detail.bizAddr;
            self.modelRealName.subString = detail.realName;
            self.modelIdentity.subString = detail.idNumber;
            self.modelPhone.subString = detail.contactPhone;
            [self.signinFooter.identityHeadIV sd_setImageWithURL:[NSURL URLWithString:detail.idNegativeUrl] placeholderImage:[UIImage imageNamed:@"signin_identity_head"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if (error == nil && image) {
                    self.signinFooter.identityHeadIV.image = [BaseImage imageWithImage:image url:imageURL];
                }
            }];
            [self.signinFooter.identityCountryIV sd_setImageWithURL:[NSURL URLWithString:detail.idPositiveUrl] placeholderImage:[UIImage imageNamed:@"signin_identity_country"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if (error == nil && image) {
                    self.signinFooter.identityCountryIV.image = [BaseImage imageWithImage:image url:imageURL];
                }
            }];
            [self.signinFooter.businessLicenseIV sd_setImageWithURL:[NSURL URLWithString:detail.bizUrl] placeholderImage:[UIImage imageNamed:@"signin_business"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if (error == nil && image) {
                    self.signinFooter.businessLicenseIV.image = [BaseImage imageWithImage:image url:imageURL];
                }
            }];
            [self configData];
        }
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
    
}
- (void)requestConnect{
    [GlobalMethod endEditing];
    for (ModelBaseData *model  in self.aryDatas) {
        if (model.enumType == ENUM_PERFECT_CELL_TEXT||model.enumType == ENUM_PERFECT_CELL_SELECT||model.enumType == ENUM_PERFECT_CELL_ADDRESS) {
            if (!isStr(model.subString)) {
                [GlobalMethod showAlert:model.placeHolderString];
                return;
            }
        }
    }
    
    if (!isPhoneNum(self.modelConnectPhone.subString)) {
        [GlobalMethod showAlert:@"请输入有效电话"];
        return;
    }
    [RequestApi requestMerchantConnectWithContactphone:self.modelConnectPhone.subString contact:self.modelConnectName.subString delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        [GlobalMethod showAlert:@"提交成功"];
        
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}

-(void)requestMerchantSignIn{
    for (ModelBaseData *model  in self.aryDatas) {
        if (model.enumType == ENUM_PERFECT_CELL_TEXT||model.enumType == ENUM_PERFECT_CELL_SELECT||model.enumType == ENUM_PERFECT_CELL_ADDRESS) {
            if (!isStr(model.subString)) {
                [GlobalMethod showAlert:model.placeHolderString];
                return;
            }
        }
    }
    if (!isPhoneNum(self.modelPhone.subString)) {
        [GlobalMethod showAlert:@"请输入有效电话"];
        return;
    }
    if (!isBusinessNum(self.modelCreditNo.subString)) {
        [GlobalMethod showAlert:@"请输入有效营业证号"];
        return;
    }
    if (!isIdentityNum(self.modelIdentity.subString)) {
        [GlobalMethod showAlert:@"请输入有效身份证号"];
        return;
    }
    if (!isStr([BaseImage fetchUrl:self.signinFooter.identityHeadIV.image])) {
        [GlobalMethod showAlert:@"请上传身份证人面像"];
        return;
    }
    if (!isStr([BaseImage fetchUrl:self.signinFooter.identityCountryIV.image])) {
        [GlobalMethod showAlert:@"请上传身份证国徽像"];
        return;
    }
    if (!isStr([BaseImage fetchUrl:self.signinFooter.businessLicenseIV.image])) {
        [GlobalMethod showAlert:@"请上传营业执照"];
        return;
    }
    if (!self.signinFooter.iconAlert.highlighted) {
        [GlobalMethod showAlert:@"请阅读并同意《商家入驻协议》"];
        return;
    }
    if (self.isResign) {
        [RequestApi requestMerchantResigninWithStorename:self.modelShopName.subString bizNumber:self.modelCreditNo.subString idNumber:self.modelIdentity.subString realName:self.modelRealName.subString bizUrl:[BaseImage fetchUrl:self.signinFooter.businessLicenseIV.image] idPositiveUrl:[BaseImage fetchUrl:self.signinFooter.identityCountryIV.image] idNegativeUrl:[BaseImage fetchUrl:self.signinFooter.identityHeadIV.image] contactPhone:self.modelPhone.subString regCountyId:self.modelRegistDistrict.identifier.doubleValue regAddr:self.modelRegistAddressDetail.subString bizAreaId:[GlobalData sharedInstance].community.iDProperty bizAddr:self.modelBusinessAddressDetail.subString delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
            [GlobalMethod showAlert:@"上传成功"];
            [self.statusView resetViewWithState:1];
            [self configSuccessState];
        } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
            
        }];
    }else{
        [RequestApi requestMerchantSigninWithStorename:self.modelShopName.subString bizNumber:self.modelCreditNo.subString idNumber:self.modelIdentity.subString realName:self.modelRealName.subString bizUrl:[BaseImage fetchUrl:self.signinFooter.businessLicenseIV.image] idPositiveUrl:[BaseImage fetchUrl:self.signinFooter.identityCountryIV.image] idNegativeUrl:[BaseImage fetchUrl:self.signinFooter.identityHeadIV.image] contactPhone:self.modelPhone.subString regCountyId:self.modelRegistDistrict.identifier.doubleValue regAddr:self.modelRegistAddressDetail.subString bizAreaId:[GlobalData sharedInstance].community.iDProperty bizAddr:self.modelBusinessAddressDetail.subString delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
            [self.statusView resetViewWithState:1];
            [GlobalMethod showAlert:@"上传成功"];
            [self configSuccessState];
        } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
            
        }];
    }
    
}
- (void)configSuccessState{
    self.tableView.contentOffset = CGPointMake(0, 0);
    self.tableView.scrollEnabled = false;
    [self.view addSubview: self.statusView];
    
}
@end
