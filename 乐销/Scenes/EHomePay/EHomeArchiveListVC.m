//
//  EHomeArchiveListVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/9/29.
//Copyright © 2020 ping. All rights reserved.
//

#import "EHomeArchiveListVC.h"
//yellow btn
#import "YellowButton.h"
#import "CreateArchiveVC.h"
//request
#import "RequestApi+EHomePay.h"
//request
#import "RequestApi+Neighbor.h"
#import "AuthenticationVC.h"
#import "EhomeBindAlertView.h"

@interface EHomeArchiveListVC ()
@property (nonatomic, strong) YellowButton *btnBottom;
@property (nonatomic, strong) NSMutableArray *aryEhomeData;
@property (nonatomic, strong) UIView *section1;
@property (nonatomic, strong) ModelAuthentication *modelIdNumber;
@property (nonatomic, strong) UIView *emptyView;

@end

@implementation EHomeArchiveListVC

- (UIView *)emptyView{
    if (!_emptyView) {
        _emptyView = [UIView new];
        _emptyView.backgroundColor = [UIColor whiteColor];
        {
            UIImageView * _iconLogo = [UIImageView new];
            _iconLogo.image = [UIImage imageNamed:@"EHome_lessee"];
            _iconLogo.widthHeight = XY(W(50),W(50));
            _iconLogo.leftTop = XY(W(15), W(20));
            [_emptyView addSubview:_iconLogo];
            UILabel * l = [UILabel new];
            l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightMedium];
            l.textColor = COLOR_333;
            l.backgroundColor = [UIColor clearColor];
            l.numberOfLines = 0;
            l.lineSpace = W(0);
            [l fitTitle:@"暂无房屋建档信息" variable:SCREEN_WIDTH - W(30)];
            l.leftCenterY = XY(_iconLogo.right + W(10), _iconLogo.centerY);
            [_emptyView addSubview:l];
        }
        _emptyView.widthHeight = XY(SCREEN_WIDTH, W(90));
    }
    return _emptyView;
}
- (YellowButton *)btnBottom{
    if (!_btnBottom) {
        _btnBottom = [YellowButton new];
        [_btnBottom resetViewWithWidth:W(335) :W(45) :@"+ 建档"];
        _btnBottom.centerXBottom = XY(SCREEN_WIDTH/2.0, SCREEN_HEIGHT - W(25)-iphoneXBottomInterval);
        WEAKSELF
        _btnBottom.blockClick = ^{
            CreateArchiveVC * vc = [CreateArchiveVC new];
            vc.blockBack = ^(UIViewController *vc) {
                [weakSelf refreshHeaderAll];
            };
            [GB_Nav pushViewController:vc animated:true];
        };
    }
    return _btnBottom;
}
- (NSMutableArray *)aryEhomeData{
    if (!_aryEhomeData) {
        _aryEhomeData = [NSMutableArray new];
    }
    return _aryEhomeData;
}
- (UIView *)section1{
    if (!_section1) {
        _section1 = [UIView new];
        _section1.widthHeight = XY(SCREEN_WIDTH, W(42));
        UIImageView * iv = [UIImageView new];
        iv.backgroundColor = [UIColor clearColor];
        iv.contentMode = UIViewContentModeScaleAspectFill;
        iv.clipsToBounds = true;
        iv.image = [UIImage imageNamed:@"EHome_mid"];
        iv.widthHeight = XY(W(288.5),W(12));
        iv.centerXCenterY = XY(SCREEN_WIDTH/2.0,_section1.height/2.0);
        [_section1 addSubview:iv];
    }
    return _section1;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    //table
    [self.tableView registerClass:[EHomeArchiveListCell class] forCellReuseIdentifier:@"EHomeArchiveListCell"];
    [self.tableView registerClass:[EHomeArchiveItemCell class] forCellReuseIdentifier:@"EHomeArchiveItemCell"];
    
    //request
    [self requestList];
    self.tableView.height = self.btnBottom.top - W(15) - NAVIGATIONBAR_HEIGHT;
    [self.view addSubview:self.btnBottom];
    [self addRefreshHeader];
}

#pragma mark 添加导航栏
- (void)addNav{
    [self.view addSubview:[BaseNavView initNavBackTitle:@"居住档案" rightView:nil]];
}

#pragma mark UITableViewDelegate
//row num
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return section == 0? self.aryDatas.count : self.aryEhomeData.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
//cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        EHomeArchiveListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"EHomeArchiveListCell"];
        ModelArchiveList * item = self.aryDatas[indexPath.row];
        [cell resetCellWithModel:item];
        cell.iconSelected.highlighted = [GlobalData sharedInstance].modelEHomeArchive.iDProperty && item.iDProperty == [GlobalData sharedInstance].modelEHomeArchive.iDProperty;
        return cell;
    }
    EHomeArchiveItemCell * cell = [tableView dequeueReusableCellWithIdentifier:@"EHomeArchiveItemCell"];
    [cell resetCellWithModel:self.aryEhomeData[indexPath.row]];
    WEAKSELF
    cell.blockBindClick = ^(ModelEhomeHomeItem *item) {
        [weakSelf requestBind:item];
    };
    return cell;
    
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return [EHomeArchiveListCell fetchHeight:self.aryDatas[indexPath.row]];
    }
    return [EHomeArchiveItemCell fetchHeight:self.aryEhomeData[indexPath.row]];
    
}
//table header
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        if (self.aryDatas.count == 0) {
            return self.emptyView;
        }
    }
    if (section == 1) {
        return self.section1;
    }
    return  nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        if (self.aryDatas.count == 0) {
            return self.emptyView.height;
        }
    }
    if (section == 1) {
        return self.section1.height;
    }
    return CGFLOAT_MIN;
}
//table footer
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        [GlobalData sharedInstance].modelEHomeArchive = self.aryDatas[indexPath.row];
        [self.tableView reloadData];
    }
}
#pragma mark request
- (void)requestList{
    
    [RequestApi requestArchiveListWithPage:1 count:2000 estateId:0 delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.aryDatas =[GlobalMethod exchangeDic:[response arrayValueForKey:@"list"] toAryWithModelName:@"ModelArchiveList"];
        [self.tableView reloadData];
        
        NSDictionary * dic = [self.aryDatas exchangeDicWithKeyPath:@"ehomeRoomId"];
        [RequestApi requestEHomeBindHomeList:[GlobalData sharedInstance].GB_UserModel.phone delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
            NSMutableArray * ary =[GlobalMethod exchangeDic:response toAryWithModelName:@"ModelEhomeHomeItem"];
            [self.aryEhomeData removeAllObjects];
            for (ModelEhomeHomeItem * item in ary) {
                if ([item.type isEqualToString:@"1"]) {
                    bool isEqual = false;
                    for (NSNumber * num in dic) {
                        if ([num.stringValue isEqualToString:item.roomId]) {
                            isEqual = true;
                            break;
                        }
                    }
                    //                    if (!isEqual) {
                    [self.aryEhomeData addObject:item];
                    //                    }
                }
            }
            [self.tableView reloadData];
        } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
            
        }];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }]  ;
    
}
- (void)requestBind:(ModelEhomeHomeItem *)model{
    if (self.modelIdNumber == nil) {
        [self requestCertify:model];
        return;
    }
    EhomeBindAlertView * view = [EhomeBindAlertView new];
    [view resetViewWithModel:model];
    [self.view addSubview:view];
    WEAKSELF
    view.blockConfirmClick = ^(ModelEhomeHomeItem *model) {
        if (isStr(model.areaCode)) {
            [RequestApi requestAddArchiveWithEstateid:0 areaCode:model.areaCode cellPhone:[GlobalData sharedInstance].GB_UserModel.phone buildingName:model.floorName unitName:model.unitNo roomName:model.roomNo tag:1 lng:nil lat:nil job:nil enterprise:nil isPart:0 scope:nil realName:self.modelIdNumber.realName idNumber:self.modelIdNumber.idNumber ehomeRoomId:model.roomId delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
                [weakSelf refreshHeaderAll];
            } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
                
            }];
        }else{
            [GlobalMethod showAlert:@"暂无小区数据"];
            [RequestApi requestAddArchiveWithEstateid:0 areaCode:@"200224" cellPhone:[GlobalData sharedInstance].GB_UserModel.phone buildingName:model.floorName unitName:model.unitNo roomName:model.roomNo tag:1 lng:nil lat:nil job:nil enterprise:nil isPart:0 scope:nil realName:self.modelIdNumber.realName idNumber:self.modelIdNumber.idNumber ehomeRoomId:model.roomId delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
                [weakSelf refreshHeaderAll];
            } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
                
            }];
        }
        
    };
}
- (void)requestCertify:(ModelEhomeHomeItem *)model{
    [RequestApi requestAuthenticationDetailWithDelegate:nil success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        ModelAuthentication *modelDetail = [ModelAuthentication modelObjectWithDictionary:response];
        WEAKSELF
        //                审核状态  1-未提交  2-审核中  10审核通过  11-审核未通过
        if (modelDetail.status != 10) {
            ModelBtn * modelDismiss = [ModelBtn modelWithTitle:@"取消" imageName:nil highImageName:nil tag:TAG_LINE color:[UIColor redColor]];
            modelDismiss.blockClick = ^{
            };
            ModelBtn * modelConfirm = [ModelBtn modelWithTitle:@"确认" imageName:nil highImageName:nil tag:TAG_LINE color:COLOR_SUBTITLE];
            modelConfirm.blockClick = ^{
                AuthenticationVC * vc = [AuthenticationVC new];
                vc.blockBack = ^(UIViewController *vc) {
                    [weakSelf requestCertify:model];
                };
                [GB_Nav popLastAndPushVC:vc];
            };
            [BaseAlertView initWithTitle:@"提示" content:@"您还没有实名认证，请您先去实名认证" aryBtnModels:@[modelDismiss,modelConfirm] viewShow:self.view];
        }else{
            self.modelIdNumber = modelDetail;
            [weakSelf requestBind:model];
            
        }
        
        
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
    
}
@end



@implementation EHomeArchiveListCell
#pragma mark 懒加载
- (UIImageView *)iconLogo{
    if (_iconLogo == nil) {
        _iconLogo = [UIImageView new];
        _iconLogo.image = [UIImage imageNamed:@"EHome_lessee"];
        _iconLogo.widthHeight = XY(W(50),W(50));
    }
    return _iconLogo;
}
- (UIImageView *)iconSelected{
    if (_iconSelected == nil) {
        _iconSelected = [UIImageView new];
        _iconSelected.image = [UIImage imageNamed:@"select_default"];
        _iconSelected.highlightedImage = [UIImage imageNamed:@"select_highlighted"];
        _iconSelected.widthHeight = XY(W(19),W(19));
    }
    return _iconSelected;
}
- (UILabel *)name{
    if (_name == nil) {
        _name = [UILabel new];
        _name.textColor = COLOR_333;
        _name.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightMedium];
    }
    return _name;
}
- (UILabel *)address{
    if (_address == nil) {
        _address = [UILabel new];
        _address.textColor = COLOR_999;
        _address.font =  [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
    }
    return _address;
}

#pragma mark 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.iconLogo];
        [self.contentView addSubview:self.iconSelected];
        [self.contentView addSubview:self.name];
        [self.contentView addSubview:self.address];
        
    }
    return self;
}
#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelArchiveList *)modelArchive{
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    
    //[self.iconLogo sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:IMAGE_HEAD_DEFAULT]];
    self.iconLogo.leftTop = XY(W(15),W(15));
    if (modelArchive.tag == 3) {
        self.iconLogo.image = [UIImage imageNamed:@"EHome_租户"];
    }else {
        self.iconLogo.image = [UIImage imageNamed:@"EHome_业主"];
    }
    
    self.iconSelected.rightCenterY = XY(SCREEN_WIDTH - W(15),self.iconLogo.centerY+W(0));
    [self.name fitTitle:modelArchive.typeShow variable:W(230)];
    self.name.leftTop = XY(self.iconLogo.right + W(10),self.iconLogo.top+W(3.5));
    [self.address fitTitle:[NSString stringWithFormat:@"%@ %@号楼 %@单元 %@",UnPackStr(modelArchive.estateName),UnPackStr(modelArchive.buildingName),UnPackStr(modelArchive.unitName),UnPackStr(modelArchive.roomName)] variable:W(230)];
    self.address.leftBottom = XY(self.iconLogo.right + W(10),self.iconLogo.bottom-W(3.5));
    
    //设置总高度
    self.height = self.iconLogo.bottom + W(15);
}

@end

@implementation EHomeArchiveItemCell
#pragma mark 懒加载
- (UIImageView *)iconLogo{
    if (_iconLogo == nil) {
        _iconLogo = [UIImageView new];
        _iconLogo.image = [UIImage imageNamed:@"EHome_lessee"];
        _iconLogo.widthHeight = XY(W(50),W(50));
    }
    return _iconLogo;
}
- (UIButton *)btnSelected{
    if (!_btnSelected) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.widthHeight = XY(W(47), W(25));
        btn.backgroundColor = [UIColor colorWithHexString:@"#FDF9F0"];
        [btn setTitle:@"绑定" forState:UIControlStateNormal];
        btn.titleLabel.fontNum = F(12);
        [btn setTitleColor:COLOR_ORANGE forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(bindClick) forControlEvents:UIControlEventTouchUpInside];
        [GlobalMethod setRoundView:btn color:COLOR_ORANGE numRound:5 width:1];
        _btnSelected = btn;
    }
    return _btnSelected;
}

- (UILabel *)name{
    if (_name == nil) {
        _name = [UILabel new];
        _name.textColor = COLOR_333;
        _name.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightMedium];
    }
    return _name;
}
- (UILabel *)address{
    if (_address == nil) {
        _address = [UILabel new];
        _address.textColor = COLOR_999;
        _address.font =  [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
    }
    return _address;
}

#pragma mark 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.iconLogo];
        [self.contentView addSubview:self.btnSelected];
        [self.contentView addSubview:self.name];
        [self.contentView addSubview:self.address];
        
    }
    return self;
}
#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelEhomeHomeItem *)model{
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    self.model = model;
    //[self.iconLogo sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:IMAGE_HEAD_DEFAULT]];
    self.iconLogo.leftTop = XY(W(15),W(15));
    if ([model.type isEqualToString:@"2"]) {
        self.iconLogo.image = [UIImage imageNamed:@"EHome_租户"];
    }else {
        self.iconLogo.image = [UIImage imageNamed:@"EHome_业主"];
    }
    // [self.iconSelected sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:IMAGE_HEAD_DEFAULT]];
    self.btnSelected.rightCenterY = XY(SCREEN_WIDTH - W(15),self.iconLogo.centerY+W(0));
    [self.name fitTitle:model.typeShow variable:W(230)];
    self.name.leftTop = XY(self.iconLogo.right + W(10),self.iconLogo.top+W(3.5));
    [self.address fitTitle:[NSString stringWithFormat:@"%@小区 %@号楼 %@单元 %@室",model.areaName,model.floorName,model.unitNo,model.roomNo]  variable:W(230)];
    self.address.leftBottom = XY(self.iconLogo.right + W(10),self.iconLogo.bottom-W(3.5));
    
    //设置总高度
    self.height = self.iconLogo.bottom + W(15);
}
- (void)bindClick{
    if (self.blockBindClick) {
        self.blockBindClick(self.model);
    }
}
@end
