//
//  FJLaguageVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/9/13.
//Copyright © 2020 ping. All rights reserved.
//

#import "FJLaguageVC.h"

@interface FJLaguageVC ()

@property (nonatomic, strong) ModelBaseData *modelName;
@property (nonatomic, strong) ModelBaseData *modelDegree;

@end

@implementation FJLaguageVC
#pragma mark self
- (ModelBaseData *)modelName{
    if (!_modelName) {
        _modelName =  ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_SELECT;
            model.locationType =ENUM_CELL_LOCATION_TOP;
            model.string = @"选择语种";
            model.placeHolderString = @"请选择语种";
            model.isRequired = true;
            model.subString = self.modelLaguangeExp.languageCn;
            model.identifier = self.modelLaguangeExp.language;
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
                            weakSelf.modelName.identifier = modelSelect.iDProperty;
                            weakSelf.modelName.subString = modelSelect.categoryname;
                            [weakSelf configData];
                        }
                    };
                }else{
                    [RequestApi requestFJLaguageDataListDelegate:weakSelf success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
                        item.aryDatas = [ModelFJData transferDic:[response objectForKey:@"list"]];
                        [weakSelf.modelName click];
                    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
                        
                    }];
                }
            };
            return model;
        }();
    }
    return _modelName;
}
- (ModelBaseData *)modelDegree{
    if (!_modelDegree) {
        _modelDegree =  ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_SELECT;
            model.string = @"熟悉程度";
            model.placeHolderString = @"请选择熟悉程度";
            model.locationType =ENUM_CELL_LOCATION_BOTTOM;
            model.hideState = true;
            model.isRequired = true;
            model.subString = self.modelLaguangeExp.levelCn;
            model.identifier = self.modelLaguangeExp.level;
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
                            weakSelf.modelDegree.identifier = modelSelect.iDProperty;
                            weakSelf.modelDegree.subString = modelSelect.categoryname;
                            [weakSelf configData];
                        }
                    };
                }else{
                    [RequestApi requestFJLaguageLevelDataListDelegate:weakSelf success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
                        item.aryDatas = [ModelFJData transferDic:[response objectForKey:@"list"]];
                        [weakSelf.modelDegree click];
                    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
                        
                    }];
                }
            };
            return model;
        }();
    }
    return _modelDegree;
}


#pragma mark 添加导航栏
- (void)addNav{
   
    WEAKSELF
    [self.view addSubview:[BaseNavView initNavBackTitle:@"语言能力修改" rightTitle:@"删除语言" rightBlock:^{
        [GlobalMethod showEditAlertWithTitle:@"提示" content:@"确定删除语言" dismiss:nil confirm:^{
            [weakSelf requestDelete];
        } view:weakSelf.view];
    }]];
}
#pragma mark config data
- (void)configData{
    self.aryDatas = @[self.modelName,
                      self.modelDegree,
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
    
    
    [RequestApi requestFJResumeLanguagepid:self.modelResumeDetail.iDProperty.doubleValue identity:self.modelLaguangeExp.iDProperty.doubleValue language:self.modelName.identifier.doubleValue level:self.modelDegree.identifier.doubleValue
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
    [RequestApi requestFJDeletepid:self.modelResumeDetail.iDProperty.doubleValue identity:self.modelLaguangeExp.iDProperty.doubleValue type:@"ResumeLanguage" delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        [GlobalMethod showAlert:@"删除成功"];
        [GB_Nav popViewControllerAnimated:true];

    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}

@end
