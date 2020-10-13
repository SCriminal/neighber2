//
//  FJCertificationVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/9/13.
//Copyright © 2020 ping. All rights reserved.
//

#import "FJCertificationVC.h"

@interface FJCertificationVC ()

@property (nonatomic, strong) ModelBaseData *modelName;
@property (nonatomic, strong) ModelBaseData *modelTimeEnd;

@end

@implementation FJCertificationVC
#pragma mark self
- (ModelBaseData *)modelName{
    if (!_modelName) {
        _modelName =  ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_TEXT;
            
            model.string = @"证书名称";
            model.placeHolderString = @"请输入证书名称";
            model.locationType =ENUM_CELL_LOCATION_TOP;
            model.isRequired = true;
            model.subString = self.modelCredientExp.name;
            return model;
        }();
    }
    return _modelName;
}
- (ModelBaseData *)modelTimeEnd{
    if (!_modelTimeEnd) {
        _modelTimeEnd =  ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_SELECT;
            model.string = @"获得时间";
            model.placeHolderString = @"请选择获得时间";
            model.isRequired = true;
            model.locationType = ENUM_CELL_LOCATION_BOTTOM;
            model.hideState = true;
            WEAKSELF
            model.subString = [ModelFJEducation transferYear:self.modelCredientExp.year month:self.modelCredientExp.month];
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
   
    WEAKSELF
    [self.view addSubview:[BaseNavView initNavBackTitle:@"获得证书修改" rightTitle:@"删除证书" rightBlock:^{
        [GlobalMethod showEditAlertWithTitle:@"提示" content:@"确定删除证书" dismiss:nil confirm:^{
            [weakSelf requestDelete];
        } view:weakSelf.view];
    }]];
}
#pragma mark config data
- (void)configData{
    self.aryDatas = @[self.modelName,
                      self.modelTimeEnd,
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
    
    NSDate * dateEnd = [GlobalMethod exchangeStringToDate:self.modelTimeEnd.subString formatter:TIME_MONTH_SHOW];
    
    [RequestApi requestFJResumeCertificatepid:self.modelResumeDetail.iDProperty.doubleValue identity:self.modelCredientExp.iDProperty.doubleValue name:self.modelName.subString year:dateEnd.year month:dateEnd.month
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
    [RequestApi requestFJDeletepid:self.modelResumeDetail.iDProperty.doubleValue identity:self.modelCredientExp.iDProperty.doubleValue type:@"ResumeCredent" delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        [GlobalMethod showAlert:@"删除成功"];
        [GB_Nav popViewControllerAnimated:true];

    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}

@end
