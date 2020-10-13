//
//  FJIntentionVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/9/13.
//Copyright © 2020 ping. All rights reserved.
//

#import "FJIntentionVC.h"

@interface FJIntentionVC ()
@property (nonatomic, strong) ModelBaseData *modelCurrent;
@property (nonatomic, strong) ModelBaseData *modelNature;
@property (nonatomic, strong) ModelBaseData *modelIntentionTrade;
@property (nonatomic, strong) ModelBaseData *modelIntentionJob;
@property (nonatomic, strong) ModelBaseData *modelWage;
@property (nonatomic, strong) ModelBaseData *modelDistrict;

@end

@implementation FJIntentionVC
#pragma mark self
- (ModelBaseData *)modelDistrict{
    if (!_modelDistrict) {
        _modelDistrict =  ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_SELECT;
            model.locationType =ENUM_CELL_LOCATION_BOTTOM;
            model.string = @"工作地区";
            model.placeHolderString = @"请选择工作地区";
            model.isRequired = true;
            model.hideState = true;
            model.subString = self.modelResumeDetail.districtCn;
            model.identifier = self.modelResumeDetail.district;
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
                            weakSelf.modelDistrict.identifier = modelSelect.iDProperty;
                            weakSelf.modelDistrict.subString = modelSelect.categoryname;
                            [weakSelf configData];
                        }
                    };
                }else{
                    [RequestApi requestFJDistrictDataListDelegate:weakSelf success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
                        item.aryDatas = [GlobalMethod exchangeDic:[response arrayValueForKey:@"list"] toAryWithModelName:@"ModelFJData"];
                        [weakSelf.modelDistrict click];
                    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
                        
                    }];
                }
            };
            return model;
        }();
    }
    return _modelDistrict;
}
- (ModelBaseData *)modelWage{
    if (!_modelWage) {
        _modelWage =  ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_SELECT;
            model.string = @"期望薪资";
            model.placeHolderString = @"请选择期望薪资";
            model.isRequired = true;
            model.subString = self.modelResumeDetail.wageCn;
            model.identifier = self.modelResumeDetail.wage;
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
                            weakSelf.modelWage.identifier = modelSelect.iDProperty;
                            weakSelf.modelWage.subString = modelSelect.categoryname;
                            [weakSelf configData];
                        }
                    };
                }else{
                    [RequestApi requestFJWageDataListDelegate:weakSelf success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
                        item.aryDatas = [ModelFJData transferDic:[response objectForKey:@"list"]];
                        [weakSelf.modelWage click];
                    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
                        
                    }];
                }
            };
            return model;
        }();
    }
    return _modelWage;
}
- (ModelBaseData *)modelIntentionJob{
    if (!_modelIntentionJob) {
        _modelIntentionJob =  ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_SELECT;
            model.string = @"期望职位";
            model.placeHolderString = @"请选择期望职位";
            model.isRequired = true;
            model.subString = self.modelResumeDetail.intentionJobs;
            model.identifier = self.modelResumeDetail.intentionJobsId;
            WEAKSELF
            model.blocClick = ^(ModelBaseData *item) {
                if (item.aryDatas.count) {
                    SelectExpactJobView * view = [SelectExpactJobView new];
                    view.aryDatas0 = item.aryDatas;
                    [view selectRow:0 inComponent:0];
                                                  view.blockSelect = ^(NSString * idDot,NSString * name) {
                        weakSelf.modelIntentionJob.identifier = idDot;
                                                 weakSelf.modelIntentionJob.subString = name;
                                                 [weakSelf configData];
                    };

                    [weakSelf.view addSubview:view];
                }else{
                    [RequestApi requestFJIntentionJobDataListDelegate:weakSelf success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
                        item.aryDatas = [GlobalMethod exchangeDic:[response arrayValueForKey:@"list"] toAryWithModelName:@"ModelUserAuthority"];
                        [weakSelf.modelIntentionJob click];
                    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
                        
                    }];
                }
            };
            return model;
        }();
    }
    return _modelIntentionJob;
}
- (ModelBaseData *)modelCurrent{
    if (!_modelCurrent) {
        _modelCurrent =  ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_SELECT;
            model.locationType =ENUM_CELL_LOCATION_TOP;
            model.string = @"目前状态";
            model.placeHolderString = @"请选择目前状态";
            model.isRequired = true;
            model.subString = self.modelResumeDetail.currentCn;
            model.identifier = self.modelResumeDetail.current;
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
                            weakSelf.modelCurrent.identifier = modelSelect.iDProperty;
                            weakSelf.modelCurrent.subString = modelSelect.categoryname;
                            [weakSelf configData];
                        }
                    };
                }else{
                    [RequestApi requestFJNowStateDataListDelegate:weakSelf success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
                        item.aryDatas = [ModelFJData transferDic:[response objectForKey:@"list"]];
                        [weakSelf.modelCurrent click];
                    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
                        
                    }];
                }
            };
            return model;
        }();
    }
    return _modelCurrent;
}
- (ModelBaseData *)modelNature{
    if (!_modelNature) {
        _modelNature =  ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_SELECT;
            model.string = @"工作性质";
            model.placeHolderString = @"请选择工作性质";
            model.isRequired = true;
            model.subString = self.modelResumeDetail.natureCn;
            model.identifier = self.modelResumeDetail.nature;
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
                            weakSelf.modelNature.identifier = modelSelect.iDProperty;
                            weakSelf.modelNature.subString = modelSelect.categoryname;
                            [weakSelf configData];
                        }
                    };
                }else{
                    [RequestApi requestFJJobNatureDataListDelegate:weakSelf success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
                        item.aryDatas = [ModelFJData transferDic:[response objectForKey:@"list"]];
                        [weakSelf.modelNature click];
                    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
                        
                    }];
                }
            };
            return model;
        }();
    }
    return _modelNature;
}
- (ModelBaseData *)modelIntentionTrade{
    if (!_modelIntentionTrade) {
        _modelIntentionTrade =  ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_SELECT;
            model.string = @"期望行业";
            model.placeHolderString = @"请选择期望行业";
            model.subString = self.modelResumeDetail.tradeCn;
            model.identifier = self.modelResumeDetail.trade;
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
                            weakSelf.modelIntentionTrade.identifier = modelSelect.iDProperty;
                            weakSelf.modelIntentionTrade.subString = modelSelect.categoryname;
                            [weakSelf configData];
                        }
                    };
                }else{
                    [RequestApi requestFJTradeDataListDelegate:weakSelf success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
                        item.aryDatas = [ModelFJData transferDic:[response objectForKey:@"list"]];
                        [weakSelf.modelIntentionTrade click];
                    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
                        
                    }];
                }
            };
            return model;
        }();
    }
    return _modelIntentionTrade;
}

#pragma mark 添加导航栏
- (void)addNav{
   
    WEAKSELF
    [self.view addSubview:[BaseNavView initNavBackTitle:@"求职意向修改" rightTitle:@"" rightBlock:^{
    }]];
}
#pragma mark config data
- (void)configData{
    self.aryDatas = @[self.modelCurrent,
    self.modelNature,
    self.modelIntentionTrade,
    self.modelIntentionJob,
    self.modelWage,
    self.modelDistrict,
                       ].mutableCopy;
    [self.tableView reloadData];
}
- (void)configFooterView{
    self.tableView.tableFooterView = self.viewBottom;
}

#pragma mark request
- (void)requestSave{
    [GlobalMethod endEditing];
    for (ModelBaseData *model  in self.aryDatas) {
        if (model.enumType == ENUM_PERFECT_CELL_TEXT||model.enumType == ENUM_PERFECT_CELL_SELECT||model.enumType == ENUM_PERFECT_CELL_ADDRESS) {
            if (!isStr(model.subString) && model.isRequired) {
                [GlobalMethod showAlert:model.placeHolderString];
                return;
            }
        }
    }
    
    [RequestApi requestFJResumeIntentionpid:self.modelResumeDetail.iDProperty.doubleValue current:self.modelCurrent.identifier.doubleValue nature:self.modelNature.identifier.doubleValue trade:self.modelIntentionTrade.identifier.doubleValue intention_jobs_id:self.modelIntentionJob.identifier district:self.modelDistrict.identifier.doubleValue wage:self.modelWage.identifier.doubleValue delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        [GlobalMethod showAlert:@"添加成功"];
        [GB_Nav popViewControllerAnimated:true];

    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
   
}


@end



@interface SelectExpactJobView ()<UIPickerViewDelegate,UIPickerViewDataSource>


@property (strong, nonatomic) UIPickerView *pickView;

@end

@implementation SelectExpactJobView

#pragma mark lazy init

- (UIPickerView *)pickView{
    if (!_pickView) {
        _pickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 180 , SCREEN_WIDTH,  180)];
        _pickView.delegate   = self;
        _pickView.dataSource = self;
        _pickView.backgroundColor = [UIColor colorWithRed:242/255.0 green:243/255.0 blue:249/255.0 alpha:1];
    }
    return _pickView;
}
#pragma mark  init
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    self.widthHeight = XY(SCREEN_WIDTH, SCREEN_HEIGHT);
    if (self) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        [self setBaseView];
        [self addTarget:self action:@selector(cancelClick)];
        [GlobalMethod endEditing];
    }
    return self;
}
- (void)setBaseView {
    CGFloat height = self.frame.size.height;
    CGFloat width = self.frame.size.width;
    UIColor *color = [UIColor colorWithRed:242/255.0 green:243/255.0 blue:249/255.0 alpha:1];
    UIColor *btnColor = [UIColor colorWithRed:65.0/255 green:164.0/255 blue:249.0/255 alpha:1];
    UIView *selectView = [[UIView alloc] initWithFrame:CGRectMake(0, height - 210, width, 30)];
    selectView.backgroundColor = color;
    UIButton *cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancleBtn setTitle:@"取消" forState:0];
    [cancleBtn setTitleColor:btnColor forState:0];
    cancleBtn.titleLabel.fontNum = F(16);
    cancleBtn.frame = CGRectMake(0, 0, 60, 40);
    [cancleBtn addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    [selectView addSubview:cancleBtn];
    
    UIButton *ensureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [ensureBtn setTitle:@"确定" forState:0];
    [ensureBtn setTitleColor:btnColor forState:0];
    ensureBtn.titleLabel.fontNum = F(16);
    ensureBtn.frame = CGRectMake(width - 60, 0, 60, 40);
    [ensureBtn addTarget:self action:@selector(confirmClick) forControlEvents:UIControlEventTouchUpInside];
    [selectView addSubview:ensureBtn];
    [self addSubview:selectView];
    
    [self addSubview:self.pickView];
}

#pragma picker view delegate
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        pickerLabel.textAlignment = NSTextAlignmentCenter;
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:14]];
    }
    switch (component) {
        case 0:
            {
                if (row <= self.aryDatas0.count-1) {
                    ModelUserAuthority * item = self.aryDatas0[row];
                    pickerLabel.text = item.name;
                }
            }
            break;
        case 1:
        {
            if (row <= self.aryDatas1.count-1) {
                ModelUserAuthority * item = self.aryDatas1[row];
                pickerLabel.text = item.name;
            }
        }
            break;
        case 2:
        {
            if (row <= self.aryDatas2.count-1) {
                ModelUserAuthority * item = self.aryDatas2[row];
                pickerLabel.text = item.name;
            }
        }
            break;
        default:
            break;
    }
   
    return pickerLabel;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    switch (component) {
        case 0:
            return  self.aryDatas0.count;
            break;
        case 1:
            return  self.aryDatas1.count;
            break;
        case 2:
            return  self.aryDatas2.count;
            break;
        default:
            break;
    }
    return  0;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return self.frame.size.width/3.0;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    [self selectRow:row inComponent:component];
}
- (void)selectRow:(NSInteger)row inComponent:(NSInteger)component{
    switch (component) {
           case 0:
           {
               ModelUserAuthority * item = self.aryDatas0[row];
               if (item.children.count) {
                   self.aryDatas1 = item.children;
                   [self.pickView selectRow:0 inComponent:1 animated:false];
                   ModelUserAuthority * item1 = self.aryDatas1[0];
                   if (item.children) {
                       self.aryDatas2 = item1.children;
                       [self.pickView selectRow:0 inComponent:2 animated:false];

                   }
               }
           }
               break;
               case 1:
                      {
                          ModelUserAuthority * item = self.aryDatas1[row];
                          if (item.children.count) {
                              self.aryDatas2 = item.children;
                              [self.pickView selectRow:0 inComponent:2 animated:false];
                          }
                      }
                          break;
           default:
               break;
       }
       [self.pickView reloadAllComponents];
}



#pragma mark click
- (void)cancelClick{
    [self removeFromSuperview];
}
- (void)confirmClick{
    if (self.blockSelect ) {
        if (self.aryDatas2.count > [self.pickView selectedRowInComponent:2]) {
            ModelUserAuthority * modelItem0 = [self.aryDatas0 objectAtIndex:[self.pickView selectedRowInComponent:0]];
            ModelUserAuthority * modelItem1 = [self.aryDatas1 objectAtIndex:[self.pickView selectedRowInComponent:1]];
           ModelUserAuthority * modelItem2 = [self.aryDatas2 objectAtIndex:[self.pickView selectedRowInComponent:2]];
            self.blockSelect([NSString stringWithFormat:@"%@.%@.%@",NSNumber.dou(modelItem0.iDProperty).stringValue,NSNumber.dou(modelItem1.iDProperty).stringValue,NSNumber.dou(modelItem2.iDProperty).stringValue], modelItem2.name);
        }
    }
    [self removeFromSuperview];
}
@end
