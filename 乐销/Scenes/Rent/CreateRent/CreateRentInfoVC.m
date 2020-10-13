//
//  CreateRentInfoVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/21.
//Copyright © 2020 ping. All rights reserved.
//

#import "CreateRentInfoVC.h"
#import "BaseTableVC+Authority.h"
#import "YellowButton.h"
//request
#import "RequestApi+Neighbor.h"
//sub view
#import "SelectLayoutView.h"
#import "SelectFloorView.h"
#import "SelectDirectionView.h"
#import "SelectRentModeView.h"
#import "RentSelectImageView.h"

@interface CreateRentInfoVC ()
@property (nonatomic, strong) ModelBaseData *modelTitle;
@property (nonatomic, strong) ModelBaseData *modelLayout;
@property (nonatomic, strong) ModelBaseData *modelFloor;
@property (nonatomic, strong) ModelBaseData *modelDirection;
@property (nonatomic, strong) ModelBaseData *modelSoldMode;
@property (nonatomic, strong) ModelBaseData *modelFloorage;
@property (nonatomic, strong) ModelBaseData *modelPrice;
@property (nonatomic, strong) ModelBaseData *modelRemark;
@property (nonatomic, strong) ModelBaseData *modelName;
@property (nonatomic, strong) ModelBaseData *modelPhone;
@property (nonatomic, strong) RentSelectImageView *selectImageView;
@property (nonatomic, strong) YellowButton  *btnBottom;
@property (nonatomic, strong) ModelRentInfo *modelDetail;
@property (nonatomic, strong) NSArray *aryData0;
@property (nonatomic, strong) NSArray *aryData1;

@end

@implementation CreateRentInfoVC
#pragma mark lazy init
- (RentSelectImageView *)selectImageView{
    if (!_selectImageView) {
        _selectImageView = [RentSelectImageView new];
    }
    return _selectImageView;
}
- (YellowButton *)btnBottom{
    if (!_btnBottom) {
        _btnBottom = [YellowButton new];
        [_btnBottom resetViewWithWidth:W(335) :W(45) :@"提交"];
        WEAKSELF
        _btnBottom.blockClick = ^{
            [weakSelf requestCreateRent];
        };
    }
    return _btnBottom;
}
- (ModelBaseData *)modelTitle{
    if (!_modelTitle) {
        _modelTitle = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_TEXT;
            model.imageName = @"";
            model.locationType = ENUM_CELL_LOCATION_TOP;
            model.string = @"房源标题";
            model.placeHolderString = @"请输入房源标题";
            return model;
        }();
    }
    return _modelTitle;
}
- (ModelBaseData *)modelLayout{
    if (!_modelLayout) {
        _modelLayout = ^(){
            WEAKSELF
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_SELECT;
            model.string = @"户型";
            model.placeHolderString = @"请选择室/厅/卫";
            model.blocClick = ^(ModelBaseData *time) {
                SelectLayoutView * view = [SelectLayoutView new];
                view.blockSelect = ^(double room, double living, double toilet) {
                    weakSelf.modelDetail.layoutBedroom  = room;
                    weakSelf.modelDetail.layoutParlor = living;
                    weakSelf.modelDetail.layoutToilet = toilet;
                    weakSelf.modelLayout.subString = weakSelf.modelDetail.layoutShow;
                    [weakSelf configData];
                };
                [weakSelf.view addSubview:view];
            };
            return model;
        }();
    }
    return _modelLayout;
}
- (ModelBaseData *)modelFloor{
    if (!_modelFloor) {
        _modelFloor = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_SELECT;
            model.string = @"楼层";
            model.placeHolderString = @"请选择所在楼层/全部楼层";
            WEAKSELF
            model.blocClick = ^(ModelBaseData *item) {
                SelectFloorView * view = [SelectFloorView new];
                view.blockSelect = ^(double current, double total) {
                    weakSelf.modelDetail.floor  = (current);
                    weakSelf.modelDetail.totalFloor = total;
                    weakSelf.modelFloor.subString = weakSelf.modelDetail.floorShow;
                    [weakSelf configData];
                };
                [weakSelf.view addSubview:view];
            };
            return model;
        }();
    }
    return _modelFloor;
}
- (ModelBaseData *)modelDirection{
    if (!_modelDirection) {
        _modelDirection = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_SELECT;
            model.string = @"朝向";
            model.placeHolderString = @"请选择房间朝向";
            WEAKSELF
            model.blocClick = ^(ModelBaseData *item) {
                SelectDirectionView * view = [SelectDirectionView new];
                view.blockSelect = ^(double current) {
                    weakSelf.modelDetail.direction  = current;
                    weakSelf.modelDirection.subString = weakSelf.modelDetail.directionShow;
                    [weakSelf configData];
                };
                [weakSelf.view addSubview:view];

            };
            return model;
        }();
    }
    return _modelDirection;
}
- (ModelBaseData *)modelSoldMode{
    if (!_modelSoldMode) {
        _modelSoldMode = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_SELECT;
            model.string = @"租售方式";
            model.placeHolderString = @"请选择租售方式";
            WEAKSELF
            model.blocClick = ^(ModelBaseData *item) {
                SelectRentModeView * view = [SelectRentModeView new];
                view.blockSelect = ^(double current) {
                    weakSelf.modelDetail.houseMode  = current;
                    weakSelf.modelSoldMode.subString = weakSelf.modelDetail.rentModeShow;
                    weakSelf.modelPrice.string = weakSelf.modelDetail.rentPriceTitleShow;
                    weakSelf.modelPrice.placeHolderString = weakSelf.modelDetail.rentPriceSubtitleShow;
                    [weakSelf configData];
                };
                [weakSelf.view addSubview:view];
                
            };
            return model;
        }();
    }
    return _modelSoldMode;
}
- (ModelBaseData *)modelFloorage{
    if (!_modelFloorage) {
        _modelFloorage = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_TEXT;
            model.string = @"面积";
            model.placeHolderString = @"请输入房屋面积（㎡）";
            return model;
        }();
    }
    return _modelFloorage;
}
- (ModelBaseData *)modelPrice{
    if (!_modelPrice) {
        _modelPrice = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_TEXT;
            model.string = self.modelDetail.rentPriceTitleShow;
            model.placeHolderString = self.modelDetail.rentPriceSubtitleShow;
            return model;
        }();
    }
    return _modelPrice;
}
- (ModelBaseData *)modelRemark{
    if (!_modelRemark) {
        _modelRemark = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_TEXT;
            model.locationType = ENUM_CELL_LOCATION_BOTTOM;
            model.hideState = true;

            model.string = @"备注";
            model.placeHolderString = @"请输入其他备注内容";
            return model;
        }();
    }
    return _modelRemark;
}
- (ModelBaseData *)modelName{
    if (!_modelName) {
        _modelName = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_TEXT;
            model.locationType = ENUM_CELL_LOCATION_TOP;
            model.string = @"联系人";
            model.placeHolderString = @"请输入联系人姓名";
            return model;
        }();
    }
    return _modelName;
}
- (ModelBaseData *)modelPhone{
    if (!_modelPhone) {
        _modelPhone = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_TEXT;
            model.locationType = ENUM_CELL_LOCATION_BOTTOM;
            model.hideState = true;
            model.string = @"联系电话";
            model.placeHolderString = @"请输入联系电话";
            return model;
        }();
    }
    return _modelPhone;
}
- (ModelRentInfo *)modelDetail{
    if (!_modelDetail) {
        _modelDetail = [ModelRentInfo new];
    }
    return _modelDetail;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    //table
    self.tableView.tableFooterView = ^(){
        UIView * footer = [UIView new];
        [footer addSubview:self.btnBottom];
        self.btnBottom.centerXTop = XY(SCREEN_WIDTH/2.0, W(35));
        
        footer.widthHeight = XY(SCREEN_WIDTH, self.btnBottom.bottom);
        return footer;
    }();
    [self registAuthorityCell];
    
    //config data
    [self configData];
    //add keyboard observe
    [self addObserveOfKeyboard];
    if (self.modelList.iDProperty) {
        [self requestDetail];
    }
}

#pragma mark 添加导航栏
- (void)addNav{
    [self.view addSubview:[BaseNavView initNavBackTitle:@"房屋租售发布" rightView:nil]];
}

#pragma mark config data
- (void)configData{
    
    self.aryData0 = @[ self.modelTitle,self.modelLayout,self.modelFloor,self.modelDirection,self.modelSoldMode,self.modelFloorage,self.modelPrice];
    self.aryData1 = @[self.modelRemark,^(){
        ModelBaseData * model = [ModelBaseData new];
        model.enumType = ENUM_PERFECT_CELL_EMPTY;
        return model;
    }(),self.modelName,self.modelPhone];
    [self.tableView reloadData];
}
#pragma mark UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
//row num
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section == 0?self.aryData0.count:self.aryData1.count;
}
//cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return [self dequeueAuthorityCellWithModel:self.aryData0[indexPath.row]];
    }
    return [self dequeueAuthorityCellWithModel:self.aryData1[indexPath.row]];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return [self fetchAuthorityCellHeightWithModel:self.aryData0[indexPath.row]];
    }
    return [self fetchAuthorityCellHeightWithModel:self.aryData1[indexPath.row]];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return  self.selectImageView;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return self.selectImageView.height;
    }
    return CGFLOAT_MIN;
}

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
        [self.selectImageView.aryDatas insertObject:modelImageInfo atIndex:0];
    }
    [self.selectImageView.collectionView reloadData];
}
#pragma mark request
- (void)requestCreateRent{
    [GlobalMethod endEditing];
    for (ModelBaseData *model  in self.aryData0) {
        if (model.enumType == ENUM_PERFECT_CELL_TEXT||model.enumType == ENUM_PERFECT_CELL_SELECT||model.enumType == ENUM_PERFECT_CELL_ADDRESS) {
            if (!isStr(model.subString)) {
                [GlobalMethod showAlert:model.placeHolderString];
                return;
            }
        }
    }
    if (!isPhoneNum(self.modelPhone.subString)) {
        [GlobalMethod showAlert:@"请输入有效电话"];
        return;
    }
    if (self.selectImageView.aryDatas.count == 0) {
        [GlobalMethod showAlert:@"请选择房源图片"];
        return;
    }
    [GlobalMethod endEditing];
    for (ModelBaseData *model  in self.aryData1) {
        if (model.enumType == ENUM_PERFECT_CELL_TEXT||model.enumType == ENUM_PERFECT_CELL_SELECT||model.enumType == ENUM_PERFECT_CELL_ADDRESS) {
            if (!isStr(model.subString)) {
                [GlobalMethod showAlert:model.placeHolderString];
                return;
            }
        }
    }
    NSArray * aryUrls = [self.selectImageView.aryDatas fetchValues:@"url"];
    NSString * strUrls = [aryUrls componentsJoinedByString:@","];
    ModelAddress * modelAddress = [GlobalMethod readModelForKey:LOCAL_LOCATION  modelName:@"ModelAddress" exchange:false];
    [RequestApi requestRentSubmitWithId:self.modelList.iDProperty title:self.modelTitle.subString coverUrl:aryUrls.firstObject description:self.modelRemark.subString price:self.modelPrice.subString.doubleValue*100.0 contact:self.modelName.subString contactPhone:self.modelPhone.subString floor:self.modelDetail.floor totalFloor:self.modelDetail.totalFloor layoutBedroom:self.modelDetail.layoutBedroom layoutParlor:self.modelDetail.layoutParlor layoutToilet:self.modelDetail.layoutToilet direction:self.modelDetail.direction houseMode:self.modelDetail.houseMode lng:[NSDecimalNumber numberWithDouble:modelAddress.lng].stringValue lat:[NSDecimalNumber numberWithDouble:modelAddress.lat].stringValue floorage:self.modelFloorage.subString areaId:[GlobalData sharedInstance].community.iDProperty displayMode:1 urls:strUrls scope:4 delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.requestState = 1;
        [GlobalMethod showAlert:@"发布成功"];
        [GB_Nav popViewControllerAnimated:true];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
- (void)requestDetail{
    [RequestApi requestRentDetailWithId:self.modelList.iDProperty scope:4 delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.modelDetail = [ModelRentInfo modelObjectWithDictionary:response];
        self.modelTitle.subString = self.modelDetail.title;
        self.modelLayout.subString = self.modelDetail.layoutShow;
        self.modelFloor.subString = self.modelDetail.floorShow;
        self.modelDirection.subString = self.modelDetail.directionShow;
        self.modelSoldMode.subString = self.modelDetail.rentModeShow;
        self.modelFloorage.subString = self.modelDetail.floorage?[NSDecimalNumber numberWithDouble:self.modelDetail.floorage].stringValue:@"";
        self.modelPrice.subString = self.modelDetail.price?NSNumber.price(self.modelDetail.price).stringValue:@"";
        self.modelRemark.subString = self.modelDetail.body;
        self.modelName.subString = self.modelDetail.contact;
        self.modelPhone.subString = self.modelDetail.contactPhone;
        
        [self configData];
        //reload image
        NSMutableArray * aryimages = [NSMutableArray new];
        for (NSString * strURL in self.modelDetail.urls) {
            ModelImage * model = [ModelImage new];
            model.url = strURL;
            [aryimages addObject:model];
        }
        self.selectImageView.aryDatas = aryimages;
        [self.selectImageView.collectionView reloadData];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
@end
