//
//  EditFJInfoVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/9/15.
//Copyright © 2020 ping. All rights reserved.
//

#import "EditFJInfoVC.h"
#import "BaseTableVC+Authority.h"
#import "YellowButton.h"
#import "MultipleSelectView.h"
#import "RequestApi+FindJob.h"
#import "ArchivePickView.h"

@interface EditFJInfoVC ()
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
//@property (nonatomic, strong) ModelBaseData *modelHeight;
@property (nonatomic, strong) ModelBaseData *modelHouseHoldAddress;
@property (nonatomic, strong) ModelBaseData *modelMarrage;
@property (nonatomic, strong) ModelBaseData *modelQQ;
@property (nonatomic, strong) ModelBaseData *modelWeichat;
@property (nonatomic, strong) ModelBaseData *modelIdNumber;
@property (nonatomic, strong) MultipleSelectView *selectIdentityView;
@property (nonatomic, strong) MultipleSelectView *selectMarrageView;

@end

@implementation EditFJInfoVC
- (MultipleSelectView *)selectIdentityView{
    if (!_selectIdentityView) {
        _selectIdentityView = [MultipleSelectView new];
        [_selectIdentityView resetViewWith:@[@"男",@"女"]];
        WEAKSELF
        _selectIdentityView.blockClick = ^(int index) {
            weakSelf.modelSex.identifier = NSNumber.dou(index).stringValue;
        };
                           [_selectIdentityView selectIndex:self.modelResumeDetail.sex.doubleValue-1];
    }
    return _selectIdentityView;
}
- (MultipleSelectView *)selectMarrageView{
    if (!_selectMarrageView) {
        _selectMarrageView = [MultipleSelectView new];
        [_selectMarrageView resetViewWith:@[@"未婚",@"已婚",@"保密"]];
        WEAKSELF
        _selectMarrageView.blockClick = ^(int index) {
            weakSelf.modelMarrage.identifier = NSNumber.dou(index).stringValue;
        };
        [_selectMarrageView selectIndex:self.modelResumeDetail.marriage.doubleValue-1];
    }
    return _selectMarrageView;
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
            model.subString = self.modelResumeDetail.fullname;
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
            model.subString = self.modelResumeDetail.birthdate;

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
            model.subString = self.modelResumeDetail.educationCn;
            model.identifier = self.modelResumeDetail.education;

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
            model.subString = self.modelResumeDetail.majorCn;
            model.identifier = self.modelResumeDetail.major;

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
            model.subString = self.modelResumeDetail.experienceCn;
            model.identifier = self.modelResumeDetail.experience;

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
            model.subString = self.modelResumeDetail.residence;

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
            model.subString = self.modelResumeDetail.telephone;

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
            model.subString = self.modelResumeDetail.email;

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
            model.string = @"选填信息";
            return model;
        }();
    }
    return _modelEmpty;
}
//- (ModelBaseData *)modelHeight{
//    if (!_modelHeight) {
//        _modelHeight =  ^(){
//            ModelBaseData * model = [ModelBaseData new];
//            model.enumType = ENUM_PERFECT_CELL_TEXT;
//            model.locationType = ENUM_CELL_LOCATION_TOP;
//            model.string = @"身高";
//            model.placeHolderString = @"请输入身高";
//            model.subString = self.modelResumeDetail.height;
//
//            return model;
//        }();
//    }
//    return _modelHeight;
//}
- (ModelBaseData *)modelHouseHoldAddress{
    if (!_modelHouseHoldAddress) {
        _modelHouseHoldAddress =  ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_TEXT;
            model.locationType = ENUM_CELL_LOCATION_TOP;
            model.string = @"籍贯地址";
            model.placeHolderString = @"请输入籍贯地址";
           model.subString = self.modelResumeDetail.householdaddress;

            
            
            return model;
        }();
    }
    return _modelHouseHoldAddress;
}
- (ModelBaseData *)modelMarrage{
    if (!_modelMarrage) {
        _modelMarrage =  ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_SELECT;
            model.isArrowHide = true;
            model.string = @"婚姻状况";
            
            model.placeHolderString = @"";

            return model;
        }();
    }
    return _modelMarrage;
}
- (ModelBaseData *)modelQQ{
    if (!_modelQQ) {
        _modelQQ =  ^(){
             ModelBaseData * model = [ModelBaseData new];
                      model.enumType = ENUM_PERFECT_CELL_TEXT;
                      model.string = @"QQ";
                      model.placeHolderString = @"请输入QQ";
            model.subString = self.modelResumeDetail.qq;

            return model;
        }();
    }
    return _modelQQ;
}
- (ModelBaseData *)modelWeichat{
    if (!_modelWeichat) {
        _modelWeichat =  ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_TEXT;
                                 model.string = @"微信";
                                 model.placeHolderString = @"请输入微信号";
            model.subString = self.modelResumeDetail.weixin;

            return model;
        }();
    }
    return _modelWeichat;
}
- (ModelBaseData *)modelIdNumber{
    if (!_modelIdNumber) {
        _modelIdNumber =  ^(){
            ModelBaseData * model = [ModelBaseData new];
               model.enumType = ENUM_PERFECT_CELL_TEXT;
                              model.string = @"身份证号";
                              model.placeHolderString = @"请输入身份证号";
            model.subString = self.modelResumeDetail.idcard;

            return model;
        }();
    }
    return _modelIdNumber;
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
                       self.modelHouseHoldAddress,
                       self.modelMarrage,
                       self.modelQQ,
                       self.modelWeichat,
                       self.modelIdNumber,].mutableCopy;
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
    }else if (model == self.modelMarrage) {
        if (self.selectMarrageView.superview == nil) {
             [cell.contentView addSubview:self.selectMarrageView];
                       self.selectMarrageView.leftCenterY = XY(W(122), cell.height/2.0);
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
    [RequestApi requestFJEditInfopid:self.modelResumeDetail.iDProperty.doubleValue fullname:self.modelName.subString sex:self.modelSex.identifier.doubleValue+1 birthdate:self.modelBirt.subString residence:self.modelAddress.subString education:self.modelEducation.identifier.doubleValue experience:self.modelWorkExperience.identifier.doubleValue telephone:self.modelPhone.subString email:self.modelEmail.subString major:self.modelProfessional.identifier.doubleValue height:0 householdaddress:self.modelHouseHoldAddress.subString marriage:self.modelMarrage.identifier.doubleValue+1 qq:self.modelQQ.subString weixin:self.modelWeichat.subString idcard:self.modelIdNumber.subString shanggegw:@"" delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        [GlobalMethod showAlert:@"保存成功"];
        [GB_Nav popViewControllerAnimated: true];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
   
    
}
@end


@interface SelectExpactProfessionView ()<UIPickerViewDelegate,UIPickerViewDataSource>


@property (strong, nonatomic) UIPickerView *pickView;

@end

@implementation SelectExpactProfessionView

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
      
        default:
            break;
    }
   
    return pickerLabel;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    switch (component) {
        case 0:
            return  self.aryDatas0.count;
            break;
        case 1:
            return  self.aryDatas1.count;
            break;
       
        default:
            break;
    }
    return  0;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return self.frame.size.width/2.0;
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
        if (self.aryDatas1.count > [self.pickView selectedRowInComponent:1]) {
                    self.blockSelect([self.aryDatas1 objectAtIndex:[self.pickView selectedRowInComponent:1]]);
        }
    }
    [self removeFromSuperview];
}
@end
