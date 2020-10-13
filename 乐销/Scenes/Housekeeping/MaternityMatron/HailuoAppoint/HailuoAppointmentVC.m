//
//  HailuoAppointmentVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/8/19.
//Copyright © 2020 ping. All rights reserved.
//

#import "HailuoAppointmentVC.h"
#import "OrderAddressView.h"
#import "SelectAddressVC.h"
#import "BaseTableVC+Authority.h"
#import "HailuoAppointmentView.h"
#import "DatePicker.h"
#import "YellowButton.h"
#import "ArchivePickView.h"
//request
#import "RequestApi+Hailuo.h"
#import "HailuoAppointmentSuccessView.h"
#import "HailuoOrderDetailVC.h"

@interface HailuoAppointmentVC ()
@property (nonatomic, strong) OrderAddressView *addressView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) HailuoAppointmentView *footerView;
@property (nonatomic, strong) ModelBaseData *modelAuntSelected;
@property (nonatomic, strong) ModelBaseData *modelService;
@property (nonatomic, strong) ModelBaseData *modelTime;
@property (nonatomic, strong) ModelBaseData *modelCompany;
@property (nonatomic, strong) UIView  *viewBottom;
@property (nonatomic, strong) NSArray *aryCompanys;

@end

@implementation HailuoAppointmentVC
- (UIView *)viewBottom{
    if (!_viewBottom) {
        _viewBottom = [UIView new];
        _viewBottom.width = SCREEN_WIDTH;
        _viewBottom.backgroundColor = [UIColor whiteColor];
        YellowButton * _btnBottom = [YellowButton new];
        [_btnBottom resetViewWithWidth:W(335) :W(45) :@"立即预约"];
        WEAKSELF
        _btnBottom.blockClick = ^{
            [weakSelf requestOrder];
        };
        [_viewBottom addSubview:_btnBottom];
        _btnBottom.centerXTop = XY(SCREEN_WIDTH/2.0, W(10));
        _viewBottom.height = _btnBottom.bottom + W(10)+ iphoneXBottomInterval;
        _viewBottom.top = SCREEN_HEIGHT - _viewBottom.height;
    }
    return _viewBottom;
}

- (HailuoAppointmentView *)footerView{
    if (!_footerView) {
        _footerView = [HailuoAppointmentView new];
    }
    return _footerView;
}
- (OrderAddressView *)addressView{
    if (!_addressView) {
        _addressView = [OrderAddressView new];
        _addressView.isClickAvailable = true;
        _addressView.addressDefaultAlert = @"请选择服务地址";
        [_addressView resetViewWithModel:nil];
        WEAKSELF
        _addressView.blockClick = ^{
            HailuoSelectAddressVC * selectVC = [HailuoSelectAddressVC new];
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
- (ModelBaseData *)modelTime{
    if (!_modelTime) {
        _modelTime = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_SELECT;
            model.locationType = ENUM_CELL_LOCATION_TOP;
            model.imageName = @"";
            model.string = @"开始时间";
            model.placeHolderString = @"请选择开始时间";
            //            model.subString = [GlobalMethod exchangeDate:[NSDate date] formatter:TIME_MIN_SHOW];
            WEAKSELF
            model.blocClick = ^(ModelBaseData *model) {
                [GlobalMethod endEditing];
                DatePicker * datePickerView = [DatePicker initWithMinDate:[GlobalMethod exchangeStringToDate:@"1900" formatter:@"yyyy"] dateSelectBlock:^(NSDate *date) {
                    weakSelf.modelTime.subString = [GlobalMethod exchangeDate:date formatter:TIME_DAY_SHOW];
                    [weakSelf configData];
                } type:ENUM_PICKER_DATE_YEAR_MONTH_DAY];
                [datePickerView.datePicker selectDate:isStr(weakSelf.modelTime.subString)?[GlobalMethod exchangeStringToDate:weakSelf.modelTime.subString formatter:TIME_DAY_SHOW]:[NSDate date]];
                [weakSelf.view addSubview:datePickerView];
            };
            return model;
        }();
    }
    return _modelTime;
}
- (ModelBaseData *)modelAuntSelected{
    if (!_modelAuntSelected) {
        _modelAuntSelected = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_SELECT;
            model.imageName = @"";
            model.string = @"已选阿姨";
            model.subString = self.modelAunt.name;
            model.hideSubState = true;
            model.isArrowHide = true;
            model.locationType = ENUM_CELL_LOCATION_TOP;
            model.blocClick = ^(ModelBaseData *item) {
                
            };
            return model;
        }();
    }
    return _modelAuntSelected;
}
- (ModelBaseData *)modelService{
    if (!_modelService) {
        _modelService = ^(){
            WEAKSELF
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_SELECT;
            model.imageName = @"";
            model.string = @"已选服务";
            model.placeHolderString = @"请选择服务";
            model.blocClick = ^(ModelBaseData *item) {
                NSMutableArray * aryStr = [NSMutableArray new];
                for (ModelHailuoCompanyServe * modelServe in weakSelf.modelAunt.aryServe) {
                    [aryStr addObject:UnPackStr(modelServe.name)];
                }
                
                ArchivePickView * pickView = [ArchivePickView new];
                [pickView resetViewWithAry:aryStr];
                [[UIApplication sharedApplication].keyWindow addSubview:pickView];
                pickView.blockSelect = ^(NSInteger index) {
                    if (index<=weakSelf.modelAunt.aryServe.count-1) {
                        ModelHailuoCompanyServe * modelSelect = weakSelf.modelAunt.aryServe[index];
                        weakSelf.modelService.identifier = strDotF(modelSelect.serveId);
                        weakSelf.modelService.subString = UnPackStr(modelSelect.name);
                        [weakSelf configData];
                    }
                };
            };
            return model;
        }();
    }
    return _modelService;
}
- (ModelBaseData *)modelCompany{
    if (!_modelCompany) {
        _modelCompany = ^(){
            WEAKSELF
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_SELECT;
            model.imageName = @"";
            model.string = @"售后企业";
            model.placeHolderString = @"请选择售后企业";
            model.blocClick = ^(ModelBaseData *item) {
                NSMutableArray * aryStr = [NSMutableArray new];
                               for (ModelHailuoCompany * modelCompany in weakSelf.aryCompanys) {
                                   [aryStr addObject:UnPackStr(modelCompany.companyName)];
                               }
                               ArchivePickView * pickView = [ArchivePickView new];
                               [pickView resetViewWithAry:aryStr];
                               [[UIApplication sharedApplication].keyWindow addSubview:pickView];
                               pickView.blockSelect = ^(NSInteger index) {
                                   if (index<=weakSelf.aryCompanys.count-1) {
                                       ModelHailuoCompany * modelSelect = weakSelf.aryCompanys[index];
                                       weakSelf.modelCompany.identifier = strDotF(modelSelect.companyId);
                                       weakSelf.modelCompany.subString = UnPackStr(modelSelect.companyName);
                                       [weakSelf configData];
                                   }
                               };
            };
            return model;
        }();
    }
    return _modelCompany;
}
- (void)configData{
    self.aryDatas = @[ self.modelAuntSelected,self.modelService,self.modelTime,self.modelCompany].mutableCopy;
    [self.tableView reloadData];
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    [self.view addSubview:self.viewBottom];
    //table
    self.tableView.backgroundColor = COLOR_GRAY;
    self.tableView.tableFooterView = self.footerView;
    self.tableView.frame = CGRectMake(0, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT - self.viewBottom.height);
    [self registAuthorityCell];
    [self configData];
    //request
    [self requestList];
    [self configView];
}

- (void)configView{
    self.addressView.top = W(15);
    [self.headerView addSubview:self.addressView];
    self.headerView.height = self.addressView.bottom + W(15);
    self.tableView.tableHeaderView = self.headerView;
}
#pragma mark 添加导航栏
- (void)addNav{
    [self.view addSubview:[BaseNavView initNavBackTitle:@"发布需求" rightView:nil]];
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
    [RequestApi requestHaiLuoCompanyListWithAuntID:NSNumber.dou(self.modelAunt.auntId).stringValue company_id:nil delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.aryCompanys = [GlobalMethod exchangeDic:[response arrayValueForKey:@"company"] toAryWithModelName:@"ModelHailuoCompany"];

    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
- (void)requestOrder{
    [GlobalMethod endEditing];
    
      for (ModelBaseData *model  in self.aryDatas) {
          if (model.enumType == ENUM_PERFECT_CELL_TEXT||model.enumType == ENUM_PERFECT_CELL_SELECT||model.enumType == ENUM_PERFECT_CELL_ADDRESS) {
              if (!isStr(model.subString)) {
                  [GlobalMethod showAlert:model.placeHolderString];
                  return;
              }
          }
      }
      double timeStamp = [GlobalMethod exchangeString:self.modelTime.subString formatter:TIME_DAY_SHOW].timeIntervalSince1970;
    if (self.addressView.model.iDProperty == 0) {
        [GlobalMethod showAlert:@"请选择服务地址"];
        return;
    }
    [RequestApi requestHaiLuoAppointmentWithCity_id:nil company_id:self.modelCompany.identifier address_id:self.addressView.model.addressId aunt_id:strDotF(self.modelAunt.auntId) begin_time:NSNumber.dou(timeStamp).stringValue serve_id:self.modelService.identifier.longLongValue need:self.footerView.textView.text  delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        HailuoAppointmentSuccessView * view =[HailuoAppointmentSuccessView new];
        NSLog([NSString stringWithFormat:@"%@",response]);
        view.blockConfirmClick = ^{
            HailuoOrderDetailVC * detail = [HailuoOrderDetailVC new];
            detail.orderID = [response doubleValueForKey:@"order_id"];
            [GB_Nav popLastAndPushVC:detail];
        };
        [self.view addSubview:view];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
@end
