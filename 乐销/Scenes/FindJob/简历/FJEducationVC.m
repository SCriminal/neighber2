//
//  FJEducationVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/9/13.
//Copyright © 2020 ping. All rights reserved.
//

#import "FJEducationVC.h"

@interface FJEducationVC ()
@property (nonatomic, strong) ModelBaseData *modelName;
@property (nonatomic, strong) ModelBaseData *modelTimeStart;
@property (nonatomic, strong) ModelBaseData *modelTimeEnd;
@property (nonatomic, strong) ModelBaseData *modelEducation;
@property (nonatomic, strong) ModelBaseData *modelProfessional;

@end

@implementation FJEducationVC
- (UIView *)viewBottom{
    if (!_viewBottom) {
        _viewBottom = [UIView new];
        _viewBottom.width = SCREEN_WIDTH;
        _viewBottom.backgroundColor = [UIColor clearColor];
        YellowButton * _btnBottom = [YellowButton new];
        [_btnBottom resetViewWithWidth:W(335) :W(45) :@"保存"];
        WEAKSELF
        _btnBottom.blockClick = ^{
            [weakSelf requestSave];
        };
        [_viewBottom addSubview:_btnBottom];
        _btnBottom.centerXTop = XY(SCREEN_WIDTH/2.0, W(18));
        _viewBottom.height = _btnBottom.bottom + W(10)+ iphoneXBottomInterval;
        _viewBottom.top = SCREEN_HEIGHT - _viewBottom.height;
    }
    return _viewBottom;
}
- (ResumeSelfIntroduceView *)textView{
    if (!_textView) {
        _textView = [ResumeSelfIntroduceView new];
        [_textView.problemDescription fitTitle:@"最多输入500字" variable:0];
        [_textView.textView.placeHolder fitTitle:@"请输入自我描述" variable:0];
    }
    return _textView;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    //table
    [self registAuthorityCell];
    [self addObserveOfKeyboard];
    self.tableView.backgroundColor = COLOR_GRAY;
    [self configFooterView];
    [self configData];
}

#pragma mark UITableViewDelegate
//row num
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.aryDatas.count;
}
//cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [self dequeueAuthorityCell:indexPath];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self fetchAuthorityCellHeight:indexPath];
}


#pragma mark self
- (ModelBaseData *)modelName{
    if (!_modelName) {
        _modelName =  ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_TEXT;
            
            model.string = @"学校名称";
            model.placeHolderString = @"请输入学校名称";
            model.locationType =ENUM_CELL_LOCATION_TOP;
            model.isRequired = true;
            model.subString = self.modelFJEducation.school;
            return model;
        }();
    }
    return _modelName;
}
- (ModelBaseData *)modelProfessional{
    if (!_modelProfessional) {
        _modelProfessional =  ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_TEXT;
            model.isRequired = true;
            model.locationType = ENUM_CELL_LOCATION_BOTTOM;
            model.hideState = true;
            model.string = @"专业";
            model.placeHolderString = @"请输入专业名称";
            model.subString = self.modelFJEducation.speciality;
            return model;
        }();
    }
    return _modelProfessional;
}
- (ModelBaseData *)modelEducation{
    if (!_modelEducation) {
        _modelEducation =  ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_SELECT;
            model.string = @"学历";
            model.placeHolderString = @"请选择学历";
            model.isRequired = true;
            model.subString = self.modelFJEducation.educationCn;
            model.identifier = self.modelFJEducation.education;
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
- (ModelBaseData *)modelTimeStart{
    if (!_modelTimeStart) {
        _modelTimeStart =  ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_SELECT;
            model.string = @"开始时间";
            model.placeHolderString = @"请选择开始时间";
            model.isRequired = true;
            model.subString = [ModelFJEducation transferYear:self.modelFJEducation.startyear month:self.modelFJEducation.startmonth];
            
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
            WEAKSELF
            model.subString = [ModelFJEducation transferYear:self.modelFJEducation.endyear month:self.modelFJEducation.endmonth];
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
    [self.view addSubview:[BaseNavView initNavBackTitle:@"教育经历修改" rightTitle:@"删除经历" rightBlock:^{
        [GlobalMethod showEditAlertWithTitle:@"提示" content:@"确定删除教育经历" dismiss:nil confirm:^{
            [weakSelf requestDelete];
        } view:weakSelf.view];
    }]];
}
#pragma mark config data
- (void)configData{
    self.aryDatas = @[self.modelName,
                      self.modelTimeStart,
                      self.modelTimeEnd,
                      self.modelEducation,
                      self.modelProfessional, ].mutableCopy;
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
    
    NSDate * dateStart = [GlobalMethod exchangeStringToDate:self.modelTimeStart.subString formatter:TIME_MONTH_SHOW];
    NSDate * dateEnd = [GlobalMethod exchangeStringToDate:self.modelTimeEnd.subString formatter:TIME_MONTH_SHOW];
    
    [RequestApi requestFJResumeEducationpid:self.modelResumeDetail.iDProperty.doubleValue identity:self.modelFJEducation.iDProperty.doubleValue school:self.modelName.subString speciality:self.modelProfessional.subString startyear:dateStart.year startmonth:dateStart.month endyear:dateEnd.year endmonth:dateEnd.month education:self.modelEducation.identifier.doubleValue delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
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
    [RequestApi requestFJDeletepid:self.modelResumeDetail.iDProperty.doubleValue identity:self.modelFJEducation.iDProperty.doubleValue type:@"ResumeEducation" delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        [GlobalMethod showAlert:@"删除成功"];
        [GB_Nav popViewControllerAnimated:true];

    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
@end
