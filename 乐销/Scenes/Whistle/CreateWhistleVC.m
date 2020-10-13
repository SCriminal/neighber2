//
//  CreateWhistleVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/17.
//Copyright © 2020 ping. All rights reserved.
//

#import "CreateWhistleVC.h"
//sub view
#import "CreateWhistleView.h"
#import "YellowButton.h"
#import "BaseTableVC+Authority.h"
//image select
#import "BaseVC+BaseImageSelectVC.h"
//request
#import "RequestApi+Neighbor.h"
#import "CreateArchiveVC.h"
#import "DatePicker.h"
#import "ArchivePickView.h"
#import "SelectCommunityVC.h"
@interface CreateWhistleVC ()
@property (nonatomic, strong) MCreateWhistleTopView *topView;
@property (nonatomic, strong) ModelBaseData *modelTime;
@property (nonatomic, strong) ModelBaseData *modelCommunity;
@property (nonatomic, strong) ModelBaseData *modelAddress;
@property (nonatomic, strong) ModelBaseData *modelPhone;
@property (nonatomic, strong) ModelBaseData *modelName;

@property (nonatomic, strong) YellowButton  *btnBottom;

@property (nonatomic, strong) NSArray *aryArchiveDatas;

@end

@implementation CreateWhistleVC
#pragma mark 懒加载
- (YellowButton *)btnBottom{
    if (!_btnBottom) {
        _btnBottom = [YellowButton new];
        [_btnBottom resetViewWithWidth:W(335) :W(45) :@"提交"];
        WEAKSELF
        _btnBottom.blockClick = ^{
            [weakSelf requestAdd];
        };
    }
    return _btnBottom;
}
- (MCreateWhistleTopView *)topView{
    if (!_topView) {
        _topView = [MCreateWhistleTopView new];
    }
    return _topView;
}
- (ModelBaseData *)modelTime{
    if (!_modelTime) {
        _modelTime = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_SELECT;
            model.locationType = ENUM_CELL_LOCATION_TOP;
            model.imageName = @"";
            model.string = @"发现时间";
            model.placeHolderString = @"请选择时间";
            model.subString = [GlobalMethod exchangeDate:[NSDate date] formatter:TIME_MIN_SHOW];
            WEAKSELF
            model.blocClick = ^(ModelBaseData *model) {
                [GlobalMethod endEditing];
                DatePicker * datePickerView = [DatePicker initWithMinDate:[GlobalMethod exchangeStringToDate:@"1900" formatter:@"yyyy"] dateSelectBlock:^(NSDate *date) {
                    weakSelf.modelTime.subString = [GlobalMethod exchangeDate:date formatter:TIME_MIN_SHOW];
                    [weakSelf configData];
                } type:ENUM_PICKER_DATE_YEAR_MONTH_DAY_HOUR_MIN];
                [datePickerView.datePicker selectDate:isStr(weakSelf.modelTime.subString)?[GlobalMethod exchangeStringToDate:weakSelf.modelTime.subString formatter:TIME_MIN_SHOW]:[NSDate date]];
                [weakSelf.view addSubview:datePickerView];
            };
            return model;
        }();
    }
    return _modelTime;
}
- (ModelBaseData *)modelCommunity{
    if (!_modelCommunity) {
        _modelCommunity = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_SELECT;
            model.imageName = @"";
            model.string = @"小区信息";
            model.placeHolderString = @"请选择";
            model.subString = [GlobalData sharedInstance].community.name;
            model.identifier = strDotF([GlobalData sharedInstance].community.iDProperty);

            WEAKSELF
            model.blocClick = ^(ModelBaseData *model) {
                SelectCommunityVC * selctVC = [SelectCommunityVC new];
                selctVC.blockSelectCommunity = ^(ModelCommunity *modelCommunity) {
                    weakSelf.modelCommunity.subString = modelCommunity.name;
                    weakSelf.modelCommunity.identifier = strDotF(modelCommunity.iDProperty);
                    [weakSelf.tableView reloadData];
                    for (UIViewController * vc in GB_Nav.viewControllers) {
                        if ([NSStringFromClass(vc.class) isEqualToString:@"WhistleTabVC" ]) {
                                                [GB_Nav popToViewController:vc animated:true];
                            break;
                        }
                    }
                    
                };
                [GB_Nav pushViewController:selctVC animated:true];
            };
            return model;
        }();
    }
    return _modelCommunity;
}
- (ModelBaseData *)modelPhone{
    if (!_modelPhone) {
        _modelPhone =  ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_TEXT;
            model.imageName = @"";
            model.string = @"手机号码";
            model.placeHolderString = @"请输入手机号码";
            model.hideState = true;
            return model;
        }();
    }
    return _modelPhone;
}
- (ModelBaseData *)modelName{
    if (!_modelName) {
        _modelName =  ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_TEXT;
            model.imageName = @"";
            model.string = @"真实姓名";
            model.placeHolderString = @"请输入真实姓名";
            model.hideState = true;
            model.locationType = ENUM_CELL_LOCATION_BOTTOM;
            return model;
        }();
    }
    return _modelName;
}
- (ModelBaseData *)modelAddress{
    if (!_modelAddress) {
        _modelAddress = ^(){
            WEAKSELF
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_TEXT;
            model.imageName = @"";
            model.string = @"详细地址";
            model.placeHolderString = @"请输入楼号单元门牌等信息";
            model.hideState = true;
            return model;
        }();
    }
    return _modelAddress;
}

#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    
    self.tableView.top = 0;
    self.tableView.backgroundColor = COLOR_GRAY;
    self.tableView.tableFooterView = ^(){
        UIView * footer = [UIView new];
        [footer addSubview:self.btnBottom];
        self.btnBottom.centerXTop = XY(SCREEN_WIDTH/2.0, W(15));
        footer.widthHeight = XY(SCREEN_WIDTH, self.btnBottom.bottom+W(15));
        return footer;
    }();
    [self registAuthorityCell];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    //config data
    [self configData];
    //add keyboard observe
    [self addObserveOfKeyboard];
    [self requestArchiveList];
}

#pragma mark config data
- (void)configData{
    self.tableView.tableHeaderView = self.topView;
    self.aryDatas = @[ self.modelTime,self.modelCommunity,self.modelAddress].mutableCopy;
    [self.tableView reloadData];
}
#pragma mark 选择图片
- (void)imagesSelect:(NSArray *)aryImages
{
    [AliClient sharedInstance].imageType = ENUM_UP_IMAGE_TYPE_WHISTLE;
    
    [[AliClient sharedInstance]updateImageAry:aryImages  storageSuccess:nil upSuccess:nil fail:nil];
    for (BaseImage *image in aryImages) {
        ModelImage * modelImageInfo = [ModelImage new];
        modelImageInfo.url = image.imageURL;
        modelImageInfo.image = image;
        modelImageInfo.width = image.size.width;
        modelImageInfo.height = image.size.height;
        [self.topView.collection_Image.aryDatas insertObject:modelImageInfo atIndex:0];
    }
    [self.topView.collection_Image.collectionView reloadData];
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
- (void)requestAdd{
    [GlobalMethod endEditing];
    
    NSString * strImage = [[self.topView.collection_Image.aryDatas fetchValues:@"url"] componentsJoinedByString:@","];
    if (!isStr(strImage)) {
        [GlobalMethod showAlert:@"请先添加图片"];
        return;
    }
    NSString * strDes = self.topView.textView.text;
    if (!isStr(strDes)) {
        [GlobalMethod showAlert:@"请先输入信息"];
        return;
    }
    for (ModelBaseData *model  in self.aryDatas) {
        if (model.enumType == ENUM_PERFECT_CELL_TEXT||model.enumType == ENUM_PERFECT_CELL_SELECT||model.enumType == ENUM_PERFECT_CELL_ADDRESS) {
            if (!isStr(model.subString)) {
                [GlobalMethod showAlert:model.placeHolderString];
                return;
            }
        }
    }
    double timeStamp = [GlobalMethod exchangeString:self.modelTime.subString formatter:TIME_MIN_SHOW].timeIntervalSince1970;
    [RequestApi requestAddWhistleWithArchiveid:self.modelAddress.identifier.doubleValue whistleTime:NSNumber.lon(timeStamp) description:strDes url:strImage scope:@"4" categoryId:self.topView.modelWhistleType.identifier.doubleValue areaId:self.modelCommunity.identifier.doubleValue detailAddr:self.modelAddress.subString realName:self.modelName.subString cellPhone:[GlobalData sharedInstance].GB_UserModel.phone  delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        WEAKSELF
        ModelBtn * modelConfirm = [ModelBtn modelWithTitle:@"确认" imageName:nil highImageName:nil tag:TAG_LINE color:COLOR_ORANGE];
        modelConfirm.blockClick = ^{
            if (weakSelf.blockRequestSuccess) {
                weakSelf.blockRequestSuccess();
            }
            [self.topView removeFromSuperview];
            self.topView = nil;
            self.modelTime = nil;
            [self configData];
        };
        [BaseAlertView initWithTitle:@"提交成功" content:@"您的问题已收到，感谢您的反馈！" aryBtnModels:@[modelConfirm] viewShow:self.view];
        
        
        
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}

- (void)requestArchiveList{
    [RequestApi requestArchiveListWithPage:1 count:500 estateId:[GlobalData sharedInstance].community.iDProperty delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        NSMutableArray * aryResponse = [GlobalMethod exchangeDic:[response arrayValueForKey:@"list"] toAryWithModelName:@"ModelArchiveList"];
        if (aryResponse.count == 0) {
           
        }else{
            self.aryArchiveDatas = aryResponse;
            ModelArchiveList * modelArchive = aryResponse.firstObject;
            self.modelAddress.subString = [NSString stringWithFormat:@"%@号楼%@单元%@",UnPackStr(modelArchive.buildingName),UnPackStr(modelArchive.unitName),UnPackStr(modelArchive.roomName)];
            self.modelAddress.identifier = strDotF(modelArchive.iDProperty);
            [self configData];
        }
        [RequestApi requestAuthenticationDetailWithDelegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
            ModelAuthentication * detail = [ModelAuthentication modelObjectWithDictionary:response];
            //        审核状态  1-未提交  2-审核中  10审核通过  11-审核未通过
            if (detail.status == 10) {
                self.modelName.subString = detail.realName;
            }
        } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
            
        }];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}

@end
