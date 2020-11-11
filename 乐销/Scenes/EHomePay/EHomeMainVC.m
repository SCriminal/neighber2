//
//  EHomeMainVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/9/27.
//Copyright © 2020 ping. All rights reserved.
//

#import "EHomeMainVC.h"
#import "BaseNavView+Logical.h"
#import "RequestApi+Neighbor.h"
#import "RequestApi+EHomePay.h"

#import "ModuleCollectionView.h"
#import "FindJobMainView.h"
#import "ShadowView.h"
#import "EHomeWaitPayListVC.h"

@interface EHomeMainVC ()
@property (nonatomic, strong) EHomeMainTopView *topView;
@property (nonatomic, strong) UIView *tableHeaderView;
@property (nonatomic, strong) ModuleCollectionView *collection;
@property (nonatomic, strong) FindJobNewsView *autoNewsView;
@property (nonatomic, strong) EHomeCompanyView *companyView;
@property (nonatomic, strong) EHomeOrderView *orderView;

@end

@implementation EHomeMainVC

- (EHomeCompanyView *)companyView{
    if (!_companyView) {
        _companyView = [EHomeCompanyView new];
    }
    return _companyView;
}
- (FindJobNewsView *)autoNewsView{
    if (!_autoNewsView) {
        _autoNewsView = [FindJobNewsView new];
        [_autoNewsView timerStart];
        _autoNewsView.blockClick = ^(int index) {
            //            FindJobNoticeListVC * vc = [FindJobNoticeListVC new];
            //            [GB_Nav pushViewController:vc animated:true];
        };
    }
    return _autoNewsView;
}
- (EHomeOrderView *)orderView{
    if (!_orderView) {
        _orderView = [EHomeOrderView new];
        WEAKSELF
        _orderView.blockClick = ^{
            EHomeWaitPayListVC * vc = [EHomeWaitPayListVC new];
            vc.blockBack  = ^(UIViewController *i) {
                [weakSelf requestList];
            };
            [GB_Nav pushViewController:vc animated:true];
        };
    }
    return _orderView;
}
- (ModuleCollectionView *)collection{
    if (!_collection) {
        _collection = [[ModuleCollectionView alloc]initWithNum:5];
    }
    return _collection;
}

- (UIView *)tableHeaderView{
    if (!_tableHeaderView) {
        _tableHeaderView = [UIView new];
        _tableHeaderView.width = SCREEN_WIDTH;
        _tableHeaderView.backgroundColor = [UIColor clearColor];
    }
    return _tableHeaderView;
}

- (EHomeMainTopView *)topView{
    if (!_topView) {
        _topView = [EHomeMainTopView new];
    }
    return _topView;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    self.tableView.top = 0;
    self.tableView.height = SCREEN_HEIGHT;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshHeaderAll) name:NOTICE_EHOME_ARCHIVE_REFERSH object:nil];
    
    //table
    //    [self.tableView registerClass:[<#CellName#> class] forCellReuseIdentifier:@"<#CellName#>"];
    //request
    [self requestList];
    [self reconfigView];
}

- (void)reconfigView{
    [self.tableHeaderView removeAllSubViews];
    //auto sc
    
    CGFloat top = 0;
    
    self.topView.top = top;
    [self.tableHeaderView addSubview:self.topView];
    top = self.topView.bottom+W(15);
    
    if (self.collection.aryModel.count) {
        self.collection.top = top ;
        [self.tableHeaderView addSubview:self.collection];
        top = self.collection.bottom;
    }
    
    if (self.autoNewsView.aryDatas.count) {
        self.autoNewsView.top = top;
        [self.tableHeaderView addSubview:self.autoNewsView];
        top = self.autoNewsView.bottom+W(15);
    }
    
    
    if (isStr(self.companyView.model.orgName)) {
        self.companyView.top = top;
        [self.tableHeaderView addSubview:self.companyView];
        top = self.companyView.bottom+W(15);
    }
    
    if ([GlobalData sharedInstance].modelEHomeArchive.iDProperty) {
        self.orderView.top = top;
        [self.tableHeaderView addSubview:self.orderView];
        top = self.orderView.bottom+W(15);
    }
    
    
    self.tableHeaderView.height = top ;
    self.tableView.tableHeaderView = self.tableHeaderView;
}


#pragma mark request
- (void)requestList{
    [self requestModule];
    [self requestArchive];
    
}

- (void)requestArchive{
    if ([GlobalData sharedInstance].modelEHomeArchive.iDProperty) {
        if (isStr([GlobalData sharedInstance].modelEHomeArchive.ehomeAreaId)) {
            [self.topView resetViewWithModel:[GlobalData sharedInstance].modelEHomeArchive];
            [self reconfigView];
            [self requestNewsList];
            [self requestWuyeInfo];
            [self requestWaitPayInfo];
        }else{
//            [GlobalData sharedInstance].modelEHomeArchive.ehomeAreaId = @"1319070981750390784";
//            [self requestArchive];
            [RequestApi requestEHomeBindHomeList:[GlobalData sharedInstance].GB_UserModel.phone delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
                NSArray * ary = [GlobalMethod exchangeDic:response toAryWithModelName:@"ModelEhomeHomeItem"];
                for (ModelEhomeHomeItem *item in ary) {
                    if ([item.roomId isEqualToString:[GlobalData sharedInstance].modelEHomeArchive.ehomeRoomId]) {
                        [GlobalData sharedInstance].modelEHomeArchive.ehomeAreaId = item.areaId;
                        [self requestArchive];
                        break;
                    }
                }
            } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {

            }];
        }
        
    }else{
        
        [RequestApi requestArchiveListWithPage:1 count:2000 estateId:0 delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
            NSArray * ary =[GlobalMethod exchangeDic:[response arrayValueForKey:@"list"] toAryWithModelName:@"ModelArchiveList"];
            for (ModelArchiveList *item in ary) {
                if (item.ehomeRoomId.doubleValue) {
                    [GlobalData sharedInstance].modelEHomeArchive = item;
                    [self requestArchive];
                    break;
                }
            }
        } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
            
        }];
    }
}
- (void)requestModule{
    [RequestApi requestModuleWithLocationaliases:@"resident_wfrcsc" areaId:[GlobalData sharedInstance].community.iDProperty delegate:nil success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        NSMutableArray * aryResponse = [GlobalMethod exchangeDic:[response arrayValueForKey:@"resident_wfrcsc"] toAryWithModelName:@"ModelModule"];
        if (!isAry(aryResponse)) {
            return;
        }
        [self.collection resetWithAry:aryResponse];
        [self reconfigView];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}

- (void)requestNewsList{
    [RequestApi requestEHomeNoticeListWithroomId:[GlobalData sharedInstance].modelEHomeArchive.ehomeRoomId areaId:[GlobalData sharedInstance].modelEHomeArchive.ehomeAreaId page:1 pageSize:20 delegate:nil success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        NSArray * ary = [GlobalMethod exchangeDic:response toAryWithModelName:@"ModelNews"];
        [self.autoNewsView resetWithAry:[ary fetchValues:@"title"]];
        
        [self reconfigView];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}

- (void)requestWuyeInfo{
    [RequestApi requestEHomeWuyeInfoWithareaId:[GlobalData sharedInstance].modelEHomeArchive.ehomeAreaId delegate:nil success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        ModelEHomeWuYeInfo * model = [ModelEHomeWuYeInfo modelObjectWithDictionary:response];
        [self.companyView resetViewWithModel:model];
        [self reconfigView];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}

- (void)requestWaitPayInfo{
    NSLog(@"%@",[GlobalData sharedInstance].modelEHomeArchive.ehomeAreaId);
    if (isStr([GlobalData sharedInstance].modelEHomeArchive.ehomeAreaId)) {
        [RequestApi requestEHomeWaitPayListWithtelephone:[GlobalData sharedInstance].GB_UserModel.phone roomId:[GlobalData sharedInstance].modelEHomeArchive.ehomeRoomId delegate:nil success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
            NSArray * ary = [GlobalMethod exchangeDic:response toAryWithModelName:@"ModelEHomeWaitPayList"];
            [self.orderView resetViewWithModel:ary];
            
            [self reconfigView];
        } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
            
        }];
    }else{
       
    }
    
    
    
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}


@end


@implementation EHomeMainTopView

- (BaseNavView *)nav{
    if (!_nav) {
        _nav = [BaseNavView initNavBackTitle:@"" rightTitle:@"切换房屋" rightBlock:^{
            [GB_Nav pushVCName:@"EHomeArchiveListVC" animated:true];
        }];
        WEAKSELF
        _nav.blockBack = ^{
            [GB_Nav popViewControllerAnimated:true];
        };
        [_nav configBlueStyle];
        
    }
    return _nav;
}
- (UIImageView *)BG{
    if (_BG == nil) {
        _BG = [UIImageView new];
        _BG.image = [UIImage imageNamed:@"EHome_Top_bg"];
        _BG.contentMode = UIViewContentModeScaleAspectFill;
        _BG.clipsToBounds = true;
        _BG.widthHeight = XY(SCREEN_WIDTH, W(174)+iphoneXTopInterval);
    }
    return _BG;
}
- (UIImageView *)whiteBG{
    if (_whiteBG == nil) {
        _whiteBG = [UIImageView new];
        _whiteBG.clipsToBounds = true;
        _whiteBG.backgroundColor = [UIColor clearColor];
        _whiteBG.widthHeight = XY(SCREEN_WIDTH,15);
        {
            UIView * view = [UIView new];
            view.backgroundColor = [UIColor whiteColor];
            view.widthHeight = XY(SCREEN_WIDTH, 30);
            [view addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:15 lineWidth:0 lineColor:[UIColor clearColor]];
            [_whiteBG addSubview:view];
        }
    }
    return _whiteBG;
}
- (UIImageView *)head{
    if (_head == nil) {
        _head = [UIImageView new];
        _head.widthHeight = XY(W(50),W(50));
        [GlobalMethod setRoundView:_head color:[UIColor clearColor] numRound:_head.height/2.0 width:0];
    }
    return _head;
}
- (UILabel *)title{
    if (_title == nil) {
        _title = [UILabel new];
        _title.textColor = [UIColor whiteColor];
        _title.font =  [UIFont systemFontOfSize:F(17) weight:UIFontWeightMedium];
    }
    return _title;
}
- (UILabel *)subtitle{
    if (_subtitle == nil) {
        _subtitle = [UILabel new];
        _subtitle.textColor = [UIColor whiteColor];
        _subtitle.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
    }
    return _subtitle;
}


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.width = SCREEN_WIDTH;
        self.clipsToBounds = true;
        [self addSubView];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.BG];
    [self addSubview:self.nav];
    [self addSubview:self.whiteBG];
    [self addSubview:self.head];
    [self addSubview:self.title];
    [self addSubview:self.subtitle];
    
    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelArchiveList *)modelArchive{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    self.whiteBG.bottom = self.BG.bottom;
    self.height = self.BG.bottom;
    
    self.head.leftBottom = XY(W(22), self.height - W(49));
    if (modelArchive.tag == 3) {
        self.head.image = [UIImage imageNamed:@"EHome_租户"];
    }else {
        self.head.image = [UIImage imageNamed:@"EHome_业主"];
    }
    [self.title fitTitle:modelArchive.iDProperty?modelArchive.typeShow:@"暂无业主" variable:0];
    self.title.leftTop = XY(self.head.right + W(15), self.head.top + W(3));
    
    [self.subtitle fitTitle:modelArchive.iDProperty?[NSString stringWithFormat:@"%@%@号楼%@单元%@",UnPackStr(modelArchive.estateName),UnPackStr(modelArchive.buildingName),UnPackStr(modelArchive.unitName),UnPackStr(modelArchive.roomName)]:@"暂无房屋信息" variable:W(250)];
    self.subtitle.leftBottom = XY(self.head.right + W(15), self.head.bottom - W(2));
    
}


@end



@implementation EHomeCompanyView
#pragma mark 懒加载
- (UILabel *)companyName{
    if (_companyName == nil) {
        _companyName = [UILabel new];
        _companyName.textColor = COLOR_333;
        _companyName.font =  [UIFont systemFontOfSize:F(14) weight:UIFontWeightMedium];
    }
    return _companyName;
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.width = SCREEN_WIDTH;
        self.clipsToBounds = false;
        [self addSubView];
    }
    return self;
}
//添加subview
- (void)addSubView{
    ShadowView * shadowView = [ShadowView new];
    [self addSubview:shadowView];
    
    UILabel * l = [UILabel new];
    l.font = [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
    l.textColor = COLOR_333;
    l.backgroundColor = [UIColor clearColor];
    [l fitTitle:@"服务物业：" variable:SCREEN_WIDTH - W(30)];
    l.leftTop = XY(W(30), W(15));
    [self addSubview:l];
    
    UIView * view = [UIView new];
    view.backgroundColor = [UIColor colorWithHexString:@"#FDF9F0"];
    view.widthHeight = XY(W(99.5), W(30));
    view.rightTop = XY(SCREEN_WIDTH - W(30), W(22.5));
    [view addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:5 lineWidth:1 lineColor:[UIColor colorWithHexString:@"#FFA900"]];
    [view addTarget:self action:@selector(phoneClick)];
    [self addSubview:view];
    
    UIImageView * iv = [UIImageView new];
    iv.backgroundColor = [UIColor clearColor];
    iv.contentMode = UIViewContentModeScaleAspectFill;
    iv.clipsToBounds = true;
    iv.image = [UIImage imageNamed:@"map_phone"];
    iv.widthHeight = XY(W(20),W(20));
    iv.leftCenterY = XY(view.left + W(12),view.centerY);
    [self addSubview:iv];
    
    l = [UILabel new];
    l.font = [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
    l.textColor = [UIColor colorWithHexString:@"#FFA900"];
    [l fitTitle:@"联系物业" variable:SCREEN_WIDTH - W(30)];
    l.leftCenterY = XY(iv.right + W(6), iv.centerY);
    [self addSubview:l];
    
    [self addSubview:self.companyName];
    
    [shadowView resetViewWith:CGRectMake(W(15), 0, SCREEN_WIDTH - W(30), W(75))];
    
    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelEHomeWuYeInfo *)model{
    self.model = model;
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    [self.companyName fitTitle:UnPackStr(model.orgName) variable:W(200)];
    self.companyName.leftTop = XY(W(30),W(41));
    
    //设置总高度
    self.height = W(75);
}

- (void)phoneClick{
    if (isStr(self.model.contact)) {
        NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel://%@",self.model.contact];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }else{
        [GlobalMethod showAlert:@"暂无联系电话"];
    }
    
}
@end


@implementation EHomeOrderView

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.width = SCREEN_WIDTH;
        self.clipsToBounds = false;
        [self resetViewWithModel:nil];
        [self addTarget:self action:@selector(click)];
    }
    return self;
}
//添加subview
- (void)resetViewWithModel:(NSArray *)ary{
    double fee = 0;
    double num = 0;
    for (ModelEHomeWaitPayList * item in ary) {
        fee += item.debtsAmount;
        fee += item.dueFineFee;
        num += item.billCount.doubleValue;
    }
    
    ShadowView * shadowView = [ShadowView new];
    [self addSubview:shadowView];
    
    UIImageView * iv = [UIImageView new];
    iv.backgroundColor = [UIColor clearColor];
    iv.contentMode = UIViewContentModeScaleAspectFill;
    iv.clipsToBounds = true;
    iv.image = [UIImage imageNamed:@"EHome_Main_Money"];
    iv.widthHeight = XY(W(40),W(40));
    iv.leftTop = XY(W(40),W(7));
    [self addSubview:iv];
    
    UILabel * l = [UILabel new];
    l.font = [UIFont systemFontOfSize:F(11) weight:UIFontWeightRegular];
    l.textColor = [UIColor colorWithHexString:@"#717273"];
    l.backgroundColor = [UIColor clearColor];
    [l fitTitle:@"物业账单" variable:SCREEN_WIDTH - W(30)];
    l.centerXTop = XY(iv.centerX, W(52));
    [self addSubview:l];
    
    iv = [UIImageView new];
    iv.backgroundColor = [UIColor clearColor];
    iv.contentMode = UIViewContentModeScaleAspectFill;
    iv.clipsToBounds = true;
    iv.image = [UIImage imageNamed:@"EHome_Shadow"];
    iv.widthHeight = XY(W(10),W(61));
    iv.leftTop = XY(W(105),W(7));
    [self addSubview:iv];
    
    l = [UILabel new];
    l.font = [UIFont systemFontOfSize:F(20) weight:UIFontWeightMedium];
    l.textColor = COLOR_333;
    [l fitTitle:NSNumber.dou(num).stringValue variable:SCREEN_WIDTH - W(30)];
    l.rightTop = XY( W(175.5), W(15));
    [self addSubview:l];
    
    UILabel * l1 = [UILabel new];
    l1.font = [UIFont systemFontOfSize:F(11) weight:UIFontWeightRegular];
    l1.textColor = COLOR_333;
    [l1 fitTitle:@"笔" variable:SCREEN_WIDTH - W(30)];
    l1.leftBottom = XY(l.right + W(3), l.bottom-W(3));
    [self addSubview:l1];
    
    l = [UILabel new];
    l.font = [UIFont systemFontOfSize:F(11) weight:UIFontWeightRegular];
    l.textColor = [UIColor colorWithHexString:@"#717273"];
    l.backgroundColor = [UIColor clearColor];
    [l fitTitle:@"待付账单" variable:SCREEN_WIDTH - W(30)];
    l.centerXTop = XY(W(174), W(52));
    [self addSubview:l];
    
    l = [UILabel new];
    l.font = [UIFont systemFontOfSize:F(20) weight:UIFontWeightMedium];
    l.textColor = COLOR_333;
    [l fitTitle:NSNumber.dou(fee).stringValue variable:SCREEN_WIDTH - W(30)];
    l.centerXTop = XY(SCREEN_WIDTH - W(68), W(15));
    [self addSubview:l];
    
    l1 = [UILabel new];
    l1.font = [UIFont systemFontOfSize:F(11) weight:UIFontWeightRegular];
    l1.textColor = COLOR_333;
    [l1 fitTitle:@"¥" variable:SCREEN_WIDTH - W(30)];
    l1.rightBottom = XY(l.left - W(3), l.bottom-W(3));
    [self addSubview:l1];
    
    l = [UILabel new];
    l.font = [UIFont systemFontOfSize:F(11) weight:UIFontWeightRegular];
    l.textColor = [UIColor colorWithHexString:@"#717273"];
    l.backgroundColor = [UIColor clearColor];
    [l fitTitle:@"待付金额" variable:SCREEN_WIDTH - W(30)];
    l.centerXTop = XY(SCREEN_WIDTH - W(76), W(52));
    [self addSubview:l];
    
    [self addLineFrame:CGRectMake(SCREEN_WIDTH - W(137), W(17.5), 1, W(40))];
    
    [shadowView resetViewWith:CGRectMake(W(15), 0, SCREEN_WIDTH - W(30), W(75))];
    
    self.height = W(75);
}
- (void)click{
    if (self.blockClick) {
        self.blockClick();
    }
}
@end
