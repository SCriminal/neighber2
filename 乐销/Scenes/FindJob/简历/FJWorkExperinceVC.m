//
//  FJWorkExperinceVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/9/13.
//Copyright © 2020 ping. All rights reserved.
//

#import "FJWorkExperinceVC.h"

@interface FJWorkExperinceVC ()
@property (nonatomic, strong) ModelBaseData *modelName;
@property (nonatomic, strong) ModelBaseData *modelPosition;

@property (nonatomic, strong) ModelBaseData *modelTimeStart;
@property (nonatomic, strong) ModelBaseData *modelTimeEnd;

@end

@implementation FJWorkExperinceVC
#pragma mark self
- (ModelBaseData *)modelName{
    if (!_modelName) {
        _modelName =  ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_TEXT;
            
            model.string = @"公司名称";
            model.placeHolderString = @"请输入公司名称";
            model.locationType =ENUM_CELL_LOCATION_TOP;
            model.isRequired = true;
            model.subString = self.modelWorkExp.companyname;
            return model;
        }();
    }
    return _modelName;
}
- (ModelBaseData *)modelPosition{
    if (!_modelPosition) {
        _modelPosition =  ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_TEXT;
            model.isRequired = true;
            model.string = @"职位名称";
            model.placeHolderString = @"请输入职位名称";
            model.subString = self.modelWorkExp.jobs;
            return model;
        }();
    }
    return _modelPosition;
}

- (ModelBaseData *)modelTimeStart{
    if (!_modelTimeStart) {
        _modelTimeStart =  ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_SELECT;
            model.string = @"开始时间";
            model.placeHolderString = @"请选择开始时间";
            model.isRequired = true;
            model.subString = [ModelFJEducation transferYear:self.modelWorkExp.startyear month:self.modelWorkExp.startmonth];
            
            WEAKSELF
            model.blocClick = ^(ModelBaseData *model) {
                [GlobalMethod endEditing];
                DatePicker * datePickerView = [DatePicker initWithMinDate:[GlobalMethod exchangeStringToDate:@"1900" formatter:@"yyyy"] dateSelectBlock:^(NSDate *date) {
                    weakSelf.modelTimeStart.subString = [GlobalMethod exchangeDate:date formatter:TIME_MONTH_SHOW];
                    [weakSelf configData];
                } type:ENUM_PICKER_DATE_YEAR_MONTH];
                [datePickerView.datePicker selectDate:isStr(weakSelf.modelTimeStart.subString)?[GlobalMethod exchangeStringToDate:weakSelf.modelTimeStart.subString formatter:TIME_MONTH_SHOW]:[NSDate date]];
                [weakSelf.view addSubview:datePickerView];
            };
            return model;
        }();
    }
    return _modelTimeStart;
}
- (ModelBaseData *)modelTimeEnd{
    if (!_modelTimeEnd) {
        _modelTimeEnd =  ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_SELECT;
            model.string = @"结束时间";
            model.placeHolderString = @"请选择结束时间";
            model.isRequired = true;
            model.locationType = ENUM_CELL_LOCATION_BOTTOM;
            model.hideState = true;
            WEAKSELF
            model.subString = [ModelFJEducation transferYear:self.modelWorkExp.endyear month:self.modelWorkExp.endmonth];
            model.blocClick = ^(ModelBaseData *model) {
                [GlobalMethod endEditing];
                DatePicker * datePickerView = [DatePicker initWithMinDate:[GlobalMethod exchangeStringToDate:@"1900" formatter:@"yyyy"] dateSelectBlock:^(NSDate *date) {
                    weakSelf.modelTimeEnd.subString = [GlobalMethod exchangeDate:date formatter:TIME_MONTH_SHOW];
                    [weakSelf configData];
                } type:ENUM_PICKER_DATE_YEAR_MONTH];
                [datePickerView.datePicker selectDate:isStr(weakSelf.modelTimeEnd.subString)?[GlobalMethod exchangeStringToDate:weakSelf.modelTimeEnd.subString formatter:TIME_MONTH_SHOW]:[NSDate date]];
                [weakSelf.view addSubview:datePickerView];
            };
            return model;
        }();
    }
    return _modelTimeEnd;
}



#pragma mark 添加导航栏
- (void)addNav{
    [self.textView.problemDescription fitTitle:@"最多输入1000字" variable:0];
    [self.textView.textView.placeHolder fitTitle:@"请输入工作内容" variable:0];
    self.textView.textView.text = self.modelWorkExp.achievements;
    WEAKSELF
    [self.view addSubview:[BaseNavView initNavBackTitle:@"工作经历修改" rightTitle:@"删除经历" rightBlock:^{
        [GlobalMethod showEditAlertWithTitle:@"提示" content:@"确定删除工作经历" dismiss:nil confirm:^{
            [weakSelf requestDelete];
        } view:weakSelf.view];
    }]];
}
#pragma mark config data
- (void)configData{
    self.aryDatas = @[self.modelName,
                      self.modelPosition,
                      self.modelTimeStart,
                      self.modelTimeEnd,
                       ].mutableCopy;
    [self.tableView reloadData];
}
- (void)configFooterView{
    self.tableView.tableFooterView = [UIView initWithViews:@[self.textView,self.viewBottom]];
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
    
    NSDate * dateStart = [GlobalMethod exchangeStringToDate:self.modelTimeStart.subString formatter:TIME_MONTH_SHOW];
    NSDate * dateEnd = [GlobalMethod exchangeStringToDate:self.modelTimeEnd.subString formatter:TIME_MONTH_SHOW];
    
    [RequestApi requestFJResumeWorkpid:self.modelResumeDetail.iDProperty.doubleValue identity:self.modelWorkExp.iDProperty.doubleValue companyname:self.modelName.subString jobs:self.modelPosition.subString  startyear:dateStart.year startmonth:dateStart.month endyear:dateEnd.year endmonth:dateEnd.month                  achievements:self.textView.textView.text
  delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        [GlobalMethod showAlert:@"添加成功"];
        [GB_Nav popViewControllerAnimated:true];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
- (void)requestDelete{
    /*ResumeEducation：教育经历
    ResumeWork：工作经历
    ResumeTraining：培训经历
    ResumeProject：项目经历
    ResumeLanguage：语言能力
    ResumeCredent：简历证书*/
    [RequestApi requestFJDeletepid:self.modelResumeDetail.iDProperty.doubleValue identity:self.modelWorkExp.iDProperty.doubleValue type:@"ResumeWork" delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        [GlobalMethod showAlert:@"删除成功"];
        [GB_Nav popViewControllerAnimated:true];

    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
@end
