//
//  ParyEliteVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/10.
//Copyright © 2020 ping. All rights reserved.
//

#import "PartyEliteVC.h"
//keyboard observe
#import "BaseTableVC+KeyboardObserve.h"
#import "BaseVC+BaseImageSelectVC.h"
//上传图片
#import "AliClient.h"
#import "BaseTableVC+Authority.h"
#import "YellowButton.h"
//sub view
#import "ParyEliteView.h"
//request
#import "RequestApi+Neighbor.h"
#import "SelectDistrictView.h"
#import "DatePicker.h"
#import "SelectCommunityPickerView.h"


@interface PartyEliteVC ()
@property (nonatomic, strong) ModelBaseData *modelCompanyName;
@property (nonatomic, strong) ModelBaseData *modelName;
@property (nonatomic, strong) ModelBaseData *modelEnterTime;
@property (nonatomic, strong) ModelBaseData *modelPhone;
@property (nonatomic, strong) ModelBaseData *modelAddress;
@property (nonatomic, strong) ModelBaseData *modelCreateTime;
@property (nonatomic, strong) ModelBaseData *modelPartyBranch;
@property (nonatomic, strong) ModelBaseData *modelDistrict;

@property (nonatomic, strong) ParyEliteTopView *header;

@property (nonatomic, strong) ParyEliteBottomView *signinFooter;
@property (nonatomic, strong) ParyEliteStatusView *statusView;

@end

@implementation PartyEliteVC

#pragma mark lazy init
- (ParyEliteStatusView *)statusView{
    if (!_statusView) {
        _statusView = [ParyEliteStatusView new];
        _statusView.top = W(135)+iphoneXTopInterval - 15;
        WEAKSELF
        _statusView.blockResubmitClick = ^{
            weakSelf.tableView.scrollEnabled = true;
            [weakSelf.statusView removeFromSuperview];
        };
    }
    return _statusView;
}
- (ParyEliteBottomView *)signinFooter{
    if (!_signinFooter) {
        _signinFooter = [ParyEliteBottomView new];
        WEAKSELF
        _signinFooter.btnBottom.blockClick = ^{
            [weakSelf requestParyElite];
            
        };
    }
    return _signinFooter;
}

- (ParyEliteTopView *)header{
    if (!_header) {
        _header = [ParyEliteTopView new];
        
    }
    return _header;
}

- (ModelBaseData *)modelCompanyName{
    if (!_modelCompanyName) {
        _modelCompanyName = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_TEXT;
            model.locationType = ENUM_CELL_LOCATION_TOP;
            
            model.imageName = @"";
            model.string = @"企业名称";
            model.placeHolderString = @"请输入企业 (商铺) 名称";
            return model;
        }();
    }
    return _modelCompanyName;
}
- (ModelBaseData *)modelName{
    if (!_modelName) {
        _modelName = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_TEXT;
            model.imageName = @"";
            model.string = @"党员姓名";
            model.placeHolderString = @"请输入姓名";
            return model;
        }();
    }
    return _modelName;
}
- (ModelBaseData *)modelEnterTime{
    if (!_modelEnterTime) {
        _modelEnterTime = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_SELECT;
            model.imageName = @"";
            model.string = @"入党时间";
            model.placeHolderString = @"请选择入党时间";
            WEAKSELF
            model.blocClick = ^(ModelBaseData *model) {
                [GlobalMethod endEditing];
                DatePicker * datePickerView = [DatePicker initWithMinDate:[GlobalMethod exchangeStringToDate:@"1900" formatter:@"yyyy"] dateSelectBlock:^(NSDate *date) {
                    weakSelf.modelEnterTime.subString = [GlobalMethod exchangeDate:date formatter:TIME_DAY_SHOW];
                    [weakSelf configData];
                } type:ENUM_PICKER_DATE_YEAR_MONTH_DAY];
                [datePickerView.datePicker selectDate:isStr(weakSelf.modelEnterTime.subString)?[GlobalMethod exchangeStringToDate:weakSelf.modelEnterTime.subString formatter:TIME_DAY_SHOW]:[NSDate date]];
                [weakSelf.view addSubview:datePickerView];
            };
            return model;
        }();
    }
    return _modelEnterTime;
}
- (ModelBaseData *)modelPhone{
    if (!_modelPhone) {
        _modelPhone = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_TEXT;
            model.imageName = @"";
            model.string = @"联系电话";
            model.placeHolderString = @"请输入联系电话";
            return model;
        }();
    }
    return _modelPhone;
}

- (ModelBaseData *)modelAddress{
    if (!_modelAddress) {
        _modelAddress = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_TEXT;
            model.imageName = @"";
            model.string = @"企业地址";
            model.placeHolderString = @"请输入企业 (商铺) 地址";
            return model;
        }();
    }
    return _modelAddress;
}
- (ModelBaseData *)modelCreateTime{
    if (!_modelCreateTime) {
        _modelCreateTime = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_SELECT;
            model.imageName = @"";
            model.string = @"成立时间";
            model.placeHolderString = @"请选择成立时间";
            model.locationType = ENUM_CELL_LOCATION_BOTTOM;
            model.hideState = true;
            WEAKSELF
            model.blocClick = ^(ModelBaseData *model) {
                [GlobalMethod endEditing];
                DatePicker * datePickerView = [DatePicker initWithMinDate:[GlobalMethod exchangeStringToDate:@"1900" formatter:@"yyyy"] dateSelectBlock:^(NSDate *date) {
                    weakSelf.modelCreateTime.subString = [GlobalMethod exchangeDate:date formatter:TIME_DAY_SHOW];
                    [weakSelf configData];
                } type:ENUM_PICKER_DATE_YEAR_MONTH_DAY];
                [datePickerView.datePicker selectDate:isStr(weakSelf.modelCreateTime.subString)?[GlobalMethod exchangeStringToDate:weakSelf.modelCreateTime.subString formatter:TIME_DAY_SHOW]:[NSDate date]];
                [weakSelf.view addSubview:datePickerView];
            };
            return model;
        }();
    }
    return _modelCreateTime;
}
- (ModelBaseData *)modelPartyBranch{
    if (!_modelPartyBranch) {
        _modelPartyBranch = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_TEXT;
            model.locationType = ENUM_CELL_LOCATION_TOP;
            model.imageName = @"";
            model.string = @"所在党支部";
            model.placeHolderString = @"请输入组织关系所在党支部";
            return model;
        }();
    }
    return _modelPartyBranch;
}
- (ModelBaseData *)modelDistrict{
    if (!_modelDistrict) {
        _modelDistrict = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_SELECT;
            model.locationType = ENUM_CELL_LOCATION_BOTTOM;
            model.imageName = @"";
            model.string = @"街道社区";
            model.placeHolderString = @"请选择街道社区";
            model.hideState = true;
            WEAKSELF
            model.blocClick = ^(ModelBaseData *model) {
                [GlobalMethod endEditing];
                SelectCommunityPickerView * viewSelect = [SelectCommunityPickerView new];
                viewSelect.blockSeleted = ^(ModelUserAuthority *selected) {
                    weakSelf.modelDistrict.subString = selected.name;
                    weakSelf.modelDistrict.identifier = strDotF(selected.iDProperty);
                    [weakSelf configData];
                };
                [weakSelf.view addSubview:viewSelect];
            };
            return model;
        }();
    }
    return _modelDistrict;
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
    self.aryDatas = @[self.modelCompanyName,self.modelName,self.modelEnterTime,self.modelPhone,self.modelAddress,self.modelCreateTime,^(){
        ModelBaseData * model = [ModelBaseData new];
        model.string = @"其他信息";
        model.enumType = ENUM_PERFECT_CELL_EMPTY;
        return model;
    }(),self.modelPartyBranch,self.modelDistrict].mutableCopy;
    self.tableView.tableFooterView = self.signinFooter;
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
 
    [RequestApi requestPartyEliteDetailWithId:0  delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {

        ModelPartyElite * detail = [ModelPartyElite modelObjectWithDictionary:response];
        if (detail.iDProperty == 0) {
            return;
        }
        if (detail.reviewStatus) {
            [self.statusView resetViewWithState:detail.reviewStatus model:detail];
            [self configSuccessState];

            self.modelCompanyName.subString = detail.entName;
            self.modelName.subString = detail.legalPersonName;
            self.modelEnterTime.subString = [GlobalMethod exchangeTimeWithStamp:detail.joinDate andFormatter:TIME_DAY_SHOW];
            self.modelPhone.subString = detail.contactPhone;
            self.modelAddress.subString = detail.addr;
            self.modelCreateTime.subString = [GlobalMethod exchangeTimeWithStamp:detail.foundDate andFormatter:TIME_DAY_SHOW];
            self.modelPartyBranch.subString = detail.partyBranch;
            self.modelDistrict.subString = detail.estateName;
            self.modelDistrict.identifier = NSNumber.dou(detail.estateId).stringValue;
            self.signinFooter.textView.text = detail.introduction;
            self.signinFooter.textView1.text = detail.iDPropertyDescription;
            
            [self.signinFooter.ivLeft sd_setImageWithURL:[NSURL URLWithString:detail.bizUrl] placeholderImage:[UIImage imageNamed:@"ParyEliteLicense"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if (error == nil && image) {
                    self.signinFooter.ivLeft.image = [BaseImage imageWithImage:image url:imageURL];
                }
            }];
            [self.signinFooter.ivRight sd_setImageWithURL:[NSURL URLWithString:detail.commitmentUrl] placeholderImage:[UIImage imageNamed:@"signin_identity_country"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if (error == nil && image) {
                    self.signinFooter.ivRight.image = [BaseImage imageWithImage:image url:imageURL];
                }
            }];
            
            [self configData];
        }
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
    
    
}
-(void)requestParyElite{
    for (ModelBaseData *model  in self.aryDatas) {
        if (model.enumType == ENUM_PERFECT_CELL_TEXT||model.enumType == ENUM_PERFECT_CELL_SELECT||model.enumType == ENUM_PERFECT_CELL_ADDRESS) {
            if (!isStr(model.subString)) {
                [GlobalMethod showAlert:model.placeHolderString];
                return;
            }
        }
    }
//    if (!isPhoneNum(self.modelPhone.subString)) {
//        [GlobalMethod showAlert:@"请输入有效电话"];
//        return;
//    }
    
    if (!isStr([BaseImage fetchUrl:self.signinFooter.ivLeft.image])) {
        [GlobalMethod showAlert:@"请上传营业执照"];
        return;
    }
    if (!isStr([BaseImage fetchUrl:self.signinFooter.ivRight.image])) {
        [GlobalMethod showAlert:@"请上传承诺书"];
        return;
    }
    if (!isStr(self.signinFooter.textView.text)) {
        [GlobalMethod showAlert:@"请输入企业简介"];
        return;
    }
    if (self.signinFooter.textView.text.length>500) {
        [GlobalMethod showAlert:@"企业简介不能超过500字"];
        return;
    }
    if (!self.signinFooter.iconAlert.highlighted) {
        [GlobalMethod showAlert:@"请阅读并同意《奎文区党员经营户承诺书》《奎文区党员经营户评选标准》"];
        return;
    }
    [RequestApi requestSubmitPartyEliteWithEntname:self.modelCompanyName.subString legalPersonName:self.modelName.subString joinDate:[GlobalMethod exchangeStringToDate:self.modelEnterTime.subString formatter:TIME_DAY_SHOW].timeIntervalSince1970 contactPhone:self.modelPhone.subString addr:self.modelAddress.subString foundDate:[GlobalMethod exchangeStringToDate:self.modelCreateTime.subString formatter:TIME_DAY_SHOW].timeIntervalSince1970 partyBranch:self.modelPartyBranch.subString areaId:self.modelDistrict.identifier.doubleValue introduction:self.signinFooter.textView.text  description:self.signinFooter.textView1.text bizUrl:[BaseImage fetchUrl:self.signinFooter.ivLeft.image] commitmentUrl:[BaseImage fetchUrl:self.signinFooter.ivRight.image] identity:0 delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        [GlobalMethod showAlert:@"上传成功"];
        
        [self requestDetail];
        
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
    
    
    
}
- (void)configSuccessState{
    self.tableView.contentOffset = CGPointMake(0, 0);
    self.tableView.scrollEnabled = false;
    [self.view addSubview: self.statusView];
    
}
@end
