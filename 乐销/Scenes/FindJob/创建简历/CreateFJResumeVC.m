//
//  CreateFJResumeVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/9/15.
//Copyright © 2020 ping. All rights reserved.
//

#import "CreateFJResumeVC.h"
#import "BaseTableVC+Authority.h"
#import "YellowButton.h"
#import "MultipleSelectView.h"
#import "RequestApi+FindJob.h"
#import "ArchivePickView.h"
#import "FJIntentionVC.h"
#import "EditFJInfoVC.h"
#import "FJResumeDetailVC.h"

@interface CreateFJResumeVC ()
@property (nonatomic, strong) UIView  *viewBottom;
@property (nonatomic, strong) ModelBaseData *modelName;
@property (nonatomic, strong) ModelBaseData *modelSex;
@property (nonatomic, strong) ModelBaseData *modelBirt;
@property (nonatomic, strong) ModelBaseData *modelEducation;
@property (nonatomic, strong) ModelBaseData *modelProfessional;
@property (nonatomic, strong) ModelBaseData *modelWorkExperience;
@property (nonatomic, strong) ModelBaseData *modelAddress;
@property (nonatomic, strong) ModelBaseData *modelPhone;
@property (nonatomic, strong) ModelBaseData *modelEmail;
@property (nonatomic, strong) ModelBaseData *modelEmpty;
@property (nonatomic, strong) ModelBaseData *modelCurrentState;
@property (nonatomic, strong) ModelBaseData *modelWorkProperty;
@property (nonatomic, strong) ModelBaseData *modelExpactProfession;
@property (nonatomic, strong) ModelBaseData *modelExpactPosition;
@property (nonatomic, strong) ModelBaseData *modelExpactMoney;
@property (nonatomic, strong) ModelBaseData *modelExpactDistrict;
@property (nonatomic, strong) MultipleSelectView *selectIdentityView;

@end

@implementation CreateFJResumeVC
- (MultipleSelectView *)selectIdentityView{
    if (!_selectIdentityView) {
        _selectIdentityView = [MultipleSelectView new];
        [_selectIdentityView resetViewWith:@[@"男",@"女"]];
        WEAKSELF
        _selectIdentityView.blockClick = ^(int index) {
            weakSelf.modelSex.identifier = NSNumber.dou(index).stringValue;
        };
        [_selectIdentityView selectIndex:-1];
    }
    return _selectIdentityView;
}
- (ModelBaseData *)modelName{
    if (!_modelName) {
        _modelName =  ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_TEXT;
            
            model.string = @"姓名";
            model.placeHolderString = @"请输入姓名";
            model.locationType =ENUM_CELL_LOCATION_TOP;
            model.isRequired = true;
            return model;
        }();
    }
    return _modelName;
}
- (ModelBaseData *)modelSex{
    if (!_modelSex) {
        _modelSex =  ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_SELECT;
            model.isArrowHide = true;
            model.string = @"性别";
            model.placeHolderString = @"";
            model.isRequired = true;
            return model;
        }();
    }
    return _modelSex;
}
- (ModelBaseData *)modelBirt{
    if (!_modelBirt) {
        _modelBirt =  ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_TEXT;
            model.string = @"出生年份";
            model.placeHolderString = @"请输入出生年份";
            model.isRequired = true;
            return model;
        }();
    }
    return _modelBirt;
}
- (ModelBaseData *)modelEducation{
    if (!_modelEducation) {
        _modelEducation =  ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_SELECT;
            
            model.string = @"最高学历";
            model.placeHolderString = @"请选择最高学历";
            model.isRequired = true;
            WEAKSELF
            model.blocClick = ^(ModelBaseData *item) {
                if (item.aryDatas.count) {
                    NSMutableArray * aryStr = [NSMutableArray new];
                    for (ModelFJData * modelData in item.aryDatas) {
                        [aryStr addObject:UnPackStr(modelData.categoryname)];
                    }
                    ArchivePickView * pickView = [ArchivePickView new];
                    [pickView resetViewWithAry:aryStr];
                    [[UIApplication sharedApplication].keyWindow addSubview:pickView];
                    pickView.blockSelect = ^(NSInteger index) {
                        if (index<=item.aryDatas.count-1) {
                            ModelFJData * modelSelect = item.aryDatas[index];
                            weakSelf.modelEducation.identifier = modelSelect.iDProperty;
                            weakSelf.modelEducation.subString = modelSelect.categoryname;
                            [weakSelf configData];
                        }
                    };
                }else{
                    [RequestApi requestFJEducationDataListDelegate:weakSelf success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
                        item.aryDatas = [ModelFJData transferDic:[response objectForKey:@"list"]];
                        [weakSelf.modelEducation click];
                    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
                        
                    }];
                }
            };
            return model;
        }();
    }
    return _modelEducation;
}
- (ModelBaseData *)modelProfessional{
    if (!_modelProfessional) {
        _modelProfessional =  ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_SELECT;
            
            model.string = @"专业";
            model.placeHolderString = @"请选择专业";
             WEAKSELF
                                model.blocClick = ^(ModelBaseData *item) {
                                    if (item.aryDatas.count) {
                                        SelectExpactProfessionView * view = [SelectExpactProfessionView new];
                                        view.aryDatas0 = item.aryDatas;
                                        [view selectRow:0 inComponent:0];
                                        view.blockSelect = ^(ModelUserAuthority * itemSelect) {
                                            weakSelf.modelProfessional.identifier = NSNumber.dou(itemSelect.iDProperty).stringValue;
                                                                     weakSelf.modelProfessional.subString = itemSelect.name;
                                                                     [weakSelf configData];
                                        };
                                        [weakSelf.view addSubview:view];
                                    }else{
                                        [RequestApi requestFJProfessionalDataListDelegate:weakSelf success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
                                            item.aryDatas = [GlobalMethod exchangeDic:[response arrayValueForKey:@"list"] toAryWithModelName:@"ModelUserAuthority"];
                                            [weakSelf.modelProfessional click];
                                        } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
                                            
                                        }];
                                    }
                                };
            return model;
        }();
    }
    return _modelProfessional;
}
- (ModelBaseData *)modelWorkExperience{
    if (!_modelWorkExperience) {
        _modelWorkExperience =  ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_SELECT;
            
            model.string = @"工作经验";
            model.placeHolderString = @"请选择工作经验";
            model.isRequired = true;
            WEAKSELF
            model.blocClick = ^(ModelBaseData *item) {
                if (item.aryDatas.count) {
                    NSMutableArray * aryStr = [NSMutableArray new];
                    for (ModelFJData * modelData in item.aryDatas) {
                        [aryStr addObject:UnPackStr(modelData.categoryname)];
                    }
                    ArchivePickView * pickView = [ArchivePickView new];
                    [pickView resetViewWithAry:aryStr];
                    [[UIApplication sharedApplication].keyWindow addSubview:pickView];
                    pickView.blockSelect = ^(NSInteger index) {
                        if (index<=item.aryDatas.count-1) {
                            ModelFJData * modelSelect = item.aryDatas[index];
                            weakSelf.modelWorkExperience.identifier = modelSelect.iDProperty;
                            weakSelf.modelWorkExperience.subString = modelSelect.categoryname;
                            [weakSelf configData];
                        }
                    };
                }else{
                    [RequestApi requestFJExperienceDataListDelegate:weakSelf success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
                        item.aryDatas = [ModelFJData transferDic:[response objectForKey:@"list"]];
                        [weakSelf.modelWorkExperience click];
                    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
                        
                    }];
                }
            };
            return model;
        }();
    }
    return _modelWorkExperience;
}

- (ModelBaseData *)modelAddress{
    if (!_modelAddress) {
        _modelAddress =  ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_TEXT;
            model.string = @"现居地址";
            model.placeHolderString = @"请输入现居地址";
            return model;
        }();
    }
    return _modelAddress;
}
- (ModelBaseData *)modelPhone{
    if (!_modelPhone) {
        _modelPhone =  ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_TEXT;
            model.string = @"手机号码";
            model.placeHolderString = @"请输入手机号码";
            return model;
        }();
    }
    return _modelPhone;
}
- (ModelBaseData *)modelEmail{
    if (!_modelEmail) {
        _modelEmail =  ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_TEXT;
            
            model.string = @"邮箱";
            
            model.placeHolderString = @"请输入邮箱";
            model.locationType = ENUM_CELL_LOCATION_BOTTOM;
            model.hideState = true;
            
            return model;
        }();
    }
    return _modelEmail;
}
- (ModelBaseData *)modelEmpty{
    if (!_modelEmpty) {
        _modelEmpty =  ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_EMPTY;
            
            return model;
        }();
    }
    return _modelEmpty;
}
- (ModelBaseData *)modelCurrentState{
    if (!_modelCurrentState) {
        _modelCurrentState =  ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_SELECT;
            model.locationType = ENUM_CELL_LOCATION_TOP;
            model.string = @"目前状态";
            
            model.placeHolderString = @"请选择目前状态";
            model.isRequired = true;
            WEAKSELF
                       model.blocClick = ^(ModelBaseData *item) {
                           if (item.aryDatas.count) {
                               NSMutableArray * aryStr = [NSMutableArray new];
                               for (ModelFJData * modelData in item.aryDatas) {
                                   [aryStr addObject:UnPackStr(modelData.categoryname)];
                               }
                               ArchivePickView * pickView = [ArchivePickView new];
                               [pickView resetViewWithAry:aryStr];
                               [[UIApplication sharedApplication].keyWindow addSubview:pickView];
                               pickView.blockSelect = ^(NSInteger index) {
                                   if (index<=item.aryDatas.count-1) {
                                       ModelFJData * modelSelect = item.aryDatas[index];
                                       weakSelf.modelCurrentState.identifier = modelSelect.iDProperty;
                                       weakSelf.modelCurrentState.subString = modelSelect.categoryname;
                                       [weakSelf configData];
                                   }
                               };
                           }else{
                               [RequestApi requestFJNowStateDataListDelegate:weakSelf success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
                                   item.aryDatas = [ModelFJData transferDic:[response objectForKey:@"list"]];
                                   [weakSelf.modelCurrentState click];
                               } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
                                   
                               }];
                           }
                       };
               
            
            return model;
        }();
    }
    return _modelCurrentState;
}
- (ModelBaseData *)modelWorkProperty{
    if (!_modelWorkProperty) {
        _modelWorkProperty =  ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_SELECT;
            
            model.string = @"工作性质";
            
            model.placeHolderString = @"请选择工作性质";
            model.isRequired = true;
            WEAKSELF
                    model.blocClick = ^(ModelBaseData *item) {
                        if (item.aryDatas.count) {
                            NSMutableArray * aryStr = [NSMutableArray new];
                            for (ModelFJData * modelData in item.aryDatas) {
                                [aryStr addObject:UnPackStr(modelData.categoryname)];
                            }
                            ArchivePickView * pickView = [ArchivePickView new];
                            [pickView resetViewWithAry:aryStr];
                            [[UIApplication sharedApplication].keyWindow addSubview:pickView];
                            pickView.blockSelect = ^(NSInteger index) {
                                if (index<=item.aryDatas.count-1) {
                                    ModelFJData * modelSelect = item.aryDatas[index];
                                    weakSelf.modelWorkProperty.identifier = modelSelect.iDProperty;
                                    weakSelf.modelWorkProperty.subString = modelSelect.categoryname;
                                    [weakSelf configData];
                                }
                            };
                        }else{
                            [RequestApi requestFJJobNatureDataListDelegate:weakSelf success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
                                item.aryDatas = [ModelFJData transferDic:[response objectForKey:@"list"]];
                                [weakSelf.modelWorkProperty click];
                            } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
                                
                            }];
                        }
                    };
            
            
            return model;
        }();
    }
    return _modelWorkProperty;
}
- (ModelBaseData *)modelExpactProfession{
    if (!_modelExpactProfession) {
        _modelExpactProfession =  ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_SELECT;
            
            model.string = @"期望行业";
            
            model.placeHolderString = @"请选择期望行业";
            WEAKSELF
            model.blocClick = ^(ModelBaseData *item) {
                if (item.aryDatas.count) {
                    NSMutableArray * aryStr = [NSMutableArray new];
                    for (ModelFJData * modelData in item.aryDatas) {
                        [aryStr addObject:UnPackStr(modelData.categoryname)];
                    }
                    ArchivePickView * pickView = [ArchivePickView new];
                    [pickView resetViewWithAry:aryStr];
                    [[UIApplication sharedApplication].keyWindow addSubview:pickView];
                    pickView.blockSelect = ^(NSInteger index) {
                        if (index<=item.aryDatas.count-1) {
                            ModelFJData * modelSelect = item.aryDatas[index];
                            weakSelf.modelExpactProfession.identifier = modelSelect.iDProperty;
                            weakSelf.modelExpactProfession.subString = modelSelect.categoryname;
                            [weakSelf configData];
                        }
                    };
                }else{
                    [RequestApi requestFJTradeDataListDelegate:weakSelf success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
                        item.aryDatas = [ModelFJData transferDic:[response objectForKey:@"list"]];
                        [weakSelf.modelExpactProfession click];
                    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
                        
                    }];
                }
            };
            
            return model;
        }();
    }
    return _modelExpactProfession;
}
- (ModelBaseData *)modelExpactPosition{
    if (!_modelExpactPosition) {
        _modelExpactPosition =  ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_SELECT;
            
            model.string = @"期望职位";
            
            model.placeHolderString = @"请选择期望职位";
            model.isRequired = true;
            WEAKSELF
            model.blocClick = ^(ModelBaseData *item) {
                           if (item.aryDatas.count) {
                               SelectExpactJobView * view = [SelectExpactJobView new];
                               view.aryDatas0 = item.aryDatas;
                               [view selectRow:0 inComponent:0];
                               view.blockSelect = ^(NSString * idDot,NSString * name) {
                                   weakSelf.modelExpactPosition.identifier = idDot;
                                                            weakSelf.modelExpactPosition.subString = name;
                                                            [weakSelf configData];
                               };
                               [weakSelf.view addSubview:view];
                           }else{
                               [RequestApi requestFJIntentionJobDataListDelegate:weakSelf success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
                                   item.aryDatas = [GlobalMethod exchangeDic:[response arrayValueForKey:@"list"] toAryWithModelName:@"ModelUserAuthority"];
                                   [weakSelf.modelExpactPosition click];
                               } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
                                   
                               }];
                           }
                       };
            
            return model;
        }();
    }
    return _modelExpactPosition;
}
- (ModelBaseData *)modelExpactMoney{
    if (!_modelExpactMoney) {
        _modelExpactMoney =  ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_SELECT;
            
            model.string = @"期望薪资";
            
            model.placeHolderString = @"请选择期望薪资";
            model.isRequired = true;
            WEAKSELF
                       model.blocClick = ^(ModelBaseData *item) {
                           if (item.aryDatas.count) {
                               NSMutableArray * aryStr = [NSMutableArray new];
                               for (ModelFJData * modelData in item.aryDatas) {
                                   [aryStr addObject:UnPackStr(modelData.categoryname)];
                               }
                               ArchivePickView * pickView = [ArchivePickView new];
                               [pickView resetViewWithAry:aryStr];
                               [[UIApplication sharedApplication].keyWindow addSubview:pickView];
                               pickView.blockSelect = ^(NSInteger index) {
                                   if (index<=item.aryDatas.count-1) {
                                       ModelFJData * modelSelect = item.aryDatas[index];
                                       weakSelf.modelExpactMoney.identifier = modelSelect.iDProperty;
                                       weakSelf.modelExpactMoney.subString = modelSelect.categoryname;
                                       [weakSelf configData];
                                   }
                               };
                           }else{
                               [RequestApi requestFJWageDataListDelegate:weakSelf success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
                                   item.aryDatas = [ModelFJData transferDic:[response objectForKey:@"list"]];
                                   [weakSelf.modelExpactMoney click];
                               } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
                                   
                               }];
                           }
                       };
            
            return model;
        }();
    }
    return _modelExpactMoney;
}
- (ModelBaseData *)modelExpactDistrict{
    if (!_modelExpactDistrict) {
        _modelExpactDistrict =  ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_SELECT;
            model.locationType = ENUM_CELL_LOCATION_BOTTOM;
            model.string = @"工作地区";
            
            model.placeHolderString = @"请选择工作地区";
            model.isRequired = true;
            WEAKSELF
            model.blocClick = ^(ModelBaseData *item) {
                if (item.aryDatas.count) {
                    NSMutableArray * aryStr = [NSMutableArray new];
                    for (ModelFJData * modelData in item.aryDatas) {
                        [aryStr addObject:UnPackStr(modelData.categoryname)];
                    }
                    ArchivePickView * pickView = [ArchivePickView new];
                    [pickView resetViewWithAry:aryStr];
                    [[UIApplication sharedApplication].keyWindow addSubview:pickView];
                    pickView.blockSelect = ^(NSInteger index) {
                        if (index<=item.aryDatas.count-1) {
                            ModelFJData * modelSelect = item.aryDatas[index];
                            weakSelf.modelExpactDistrict.identifier = modelSelect.iDProperty;
                            weakSelf.modelExpactDistrict.subString = modelSelect.categoryname;
                            [weakSelf configData];
                        }
                    };
                }else{
                    [RequestApi requestFJDistrictDataListDelegate:weakSelf success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
                        
                        item.aryDatas = [GlobalMethod exchangeDic:[response arrayValueForKey:@"list"] toAryWithModelName:@"ModelFJData"];
                        [weakSelf.modelExpactDistrict click];
                    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
                        
                    }];
                }
            };
            
            return model;
        }();
    }
    return _modelExpactDistrict;
}

- (UIView *)viewBottom{
    if (!_viewBottom) {
        _viewBottom = [UIView new];
        _viewBottom.width = SCREEN_WIDTH;
        _viewBottom.backgroundColor = [UIColor clearColor];
        YellowButton * _btnBottom = [YellowButton new];
        [_btnBottom resetViewWithWidth:W(335) :W(45) :@"保存"];
        WEAKSELF
        _btnBottom.blockClick = ^{
                        [weakSelf requestSubmit];
        };
        [_viewBottom addSubview:_btnBottom];
        _btnBottom.centerXTop = XY(SCREEN_WIDTH/2.0, W(18));
        _viewBottom.height = _btnBottom.bottom + W(10)+ iphoneXBottomInterval;
        _viewBottom.top = SCREEN_HEIGHT - _viewBottom.height;
    }
    return _viewBottom;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    //table
    self.tableView.tableFooterView = self.viewBottom;
    [self registAuthorityCell];
    self.tableView.backgroundColor = COLOR_GRAY;
    
    //config data
    [self configData];
    //add keyboard observe
    [self addObserveOfKeyboard];
}

#pragma mark 添加导航栏
- (void)addNav{
    [self.view addSubview:[BaseNavView initNavBackTitle:@"创建简历" rightView:nil]];
}
#pragma mark config data
- (void)configData{
    self.aryDatas = @[ self.modelName,
                       self.modelSex,
                       self.modelBirt,
                       self.modelEducation,
                       self.modelProfessional,
                       self.modelWorkExperience,
                       self.modelAddress,
                       self.modelPhone,
                       self.modelEmail,
                       self.modelEmpty,
                       self.modelCurrentState,
                       self.modelWorkProperty,
                       self.modelExpactProfession,
                       self.modelExpactPosition,
                       self.modelExpactMoney,
                       self.modelExpactDistrict,].mutableCopy;
    [self.tableView reloadData];
}
#pragma mark UITableViewDelegate
//row num
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.aryDatas.count;
}
//cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [self dequeueAuthorityCell:indexPath];
    ModelBaseData * model = self.aryDatas[indexPath.row];
    if (model == self.modelSex) {
        if (self.selectIdentityView.superview == nil) {
             [cell.contentView addSubview:self.selectIdentityView];
                       self.selectIdentityView.leftCenterY = XY(W(122), cell.height/2.0);
        }
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self fetchAuthorityCellHeight:indexPath];
}

#pragma mark request
- (void)requestSubmit{
    [GlobalMethod endEditing];
    for (ModelBaseData *model  in self.aryDatas) {
        if (model.enumType == ENUM_PERFECT_CELL_TEXT||model.enumType == ENUM_PERFECT_CELL_SELECT||model.enumType == ENUM_PERFECT_CELL_ADDRESS) {
            if (model.isRequired  ) {
                if (!isStr(model.subString) && !isStr(model.identifier)) {
                    [GlobalMethod showAlert:model.placeHolderString];
                    return;
                }
            }
        }
    }
    
    if (self.modelSex.identifier.doubleValue<0) {
        [GlobalMethod showAlert:@"请选择性别"];
        return;
    }
    
    [RequestApi requestFJCreateResumeDistrict:self.modelExpactDistrict.identifier.doubleValue sex:self.modelSex.identifier.doubleValue+1 birthdate:self.modelBirt.subString major:self.modelProfessional.identifier.doubleValue experience:self.modelWorkExperience.identifier.doubleValue nature:self.modelWorkProperty.identifier.doubleValue current:self.modelCurrentState.identifier.doubleValue wage:self.modelExpactMoney.identifier.doubleValue telephone:self.modelPhone.subString fullname:self.modelName.subString email:self.modelEmail.subString intention_jobs_id:self.modelExpactPosition.identifier trade:self.modelExpactProfession.identifier.doubleValue marriage:0 householdaddress:nil residence:self.modelAddress.subString qq:nil weixin:nil
                                    education:self.modelEducation.identifier.doubleValue
delegate:self  success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        [GB_Nav popLastAndPushVC:[FJResumeDetailVC new]];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
    
}
@end
