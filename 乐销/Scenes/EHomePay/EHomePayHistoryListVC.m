//
//  EHomePayHistoryListVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/10/10.
//Copyright © 2020 ping. All rights reserved.
//

#import "EHomePayHistoryListVC.h"
//request
#import "RequestApi+EHomePay.h"
#import "RentListFilterListView.h"
#import "EHomePayCertVC.h"

@interface EHomePayHistoryListVC ()
@property (nonatomic, strong) EHomePayHistoryFilterView *filterView;
@property (nonatomic, strong) ModelBaseData *modelPayType;
@property (nonatomic, strong) ModelBaseData *modelFeeType;
@property (nonatomic, strong) NSDate *dateStart;
@property (nonatomic, strong) NSDate *dateEnd;
@property (nonatomic, strong) RentListFilterListView *filterPayFee;
@property (nonatomic, strong) RentListFilterListView *filterPayType;
@property (nonatomic, strong) EHomePayHistoryFilterAlertView *alertView;

@end

@implementation EHomePayHistoryListVC
#pragma mark noresult view
@synthesize noResultView = _noResultView;
- (BOOL)isShowNoResult{
    return true;
}
- (NoResultView *)noResultView{
    if (!_noResultView) {
        _noResultView = [NoResultView new];
        [_noResultView resetWithImageName:@"empty_default" title:@"暂无缴费数据"];
    }
    return _noResultView;
}
- (EHomePayHistoryFilterAlertView *)alertView{
    if (!_alertView) {
        _alertView = [EHomePayHistoryFilterAlertView new];
        WEAKSELF
        _alertView.blockSearchClick = ^(NSDate *dateStart, NSDate *dateEnd) {
            weakSelf.dateStart = dateStart;
            weakSelf.dateEnd = dateEnd;
            [weakSelf refreshHeaderAll];
        };
    }
    return _alertView;
}

- (EHomePayHistoryFilterView *)filterView{
    if (!_filterView) {
        _filterView = [EHomePayHistoryFilterView new];
        _filterView.top = NAVIGATIONBAR_HEIGHT;
        WEAKSELF
        _filterView.blockIndexClick = ^(int index) {
            switch (index) {
                case 0:
                {
                    
                    [weakSelf.view addSubview:weakSelf.filterPayFee];
                }
                    break;
                case 1:
                {
                    
                    [weakSelf.view addSubview:weakSelf.filterPayType];
                }
                    break;
                case 2:
                case 3:
                {
                    [weakSelf.alertView show];
                }
                    break;
                default:
                    break;
            }
        };
    }
    return _filterView;
}
- (ModelBaseData *)modelFeeType{
    if (!_modelFeeType) {
        _modelFeeType = [ModelBaseData new];
        
        _modelFeeType.aryDatas = @[^(){
            ModelFJData * item = [ModelFJData new];
            item.categoryname = @"全部";
            item.iDProperty = nil;
            return item;
        }(),^(){
            ModelFJData * item = [ModelFJData new];
            item.categoryname = @"燃气回费";
            item.iDProperty = @"1";
            return item;
        }(),^(){
            ModelFJData * item = [ModelFJData new];
            item.categoryname = @"水费";
            item.iDProperty = @"2";
            return item;
        }(),^(){
            ModelFJData * item = [ModelFJData new];
            item.categoryname = @"热力缴费";
            item.iDProperty = @"3";
            return item;
        }(),^(){
            ModelFJData * item = [ModelFJData new];
            item.categoryname = @"车位费";
            item.iDProperty = @"4";
            return item;
        }(),^(){
            ModelFJData * item = [ModelFJData new];
            item.categoryname = @"电费";
            item.iDProperty = @"5";
            return item;
        }(),^(){
            ModelFJData * item = [ModelFJData new];
            item.categoryname = @"卫生费";
            item.iDProperty = @"6";
            return item;
        }(),^(){
            ModelFJData * item = [ModelFJData new];
            item.categoryname = @"治安费";
            item.iDProperty = @"7";
            return item;
        }(),^(){
            ModelFJData * item = [ModelFJData new];
            item.categoryname = @"停车费";
            item.iDProperty = @"8";
            return item;
        }(),^(){
            ModelFJData * item = [ModelFJData new];
            item.categoryname = @"物业费";
            item.iDProperty = @"9";
            return item;
        }(),^(){
            ModelFJData * item = [ModelFJData new];
            item.categoryname = @"数字电视";
            item.iDProperty = @"10";
            return item;
        }(),^(){
            ModelFJData * item = [ModelFJData new];
            item.categoryname = @"报事报修";
            item.iDProperty = @"11";
            return item;
        }(),^(){
            ModelFJData * item = [ModelFJData new];
            item.categoryname = @"社区万事通";
            item.iDProperty = @"12";
            return item;
        }(),^(){
            ModelFJData * item = [ModelFJData new];
            item.categoryname = @"临时费项";
            item.iDProperty = @"13";
            return item;
        }()].mutableCopy;
        //        _modelFeeType.string = @"物业费";
        //        _modelFeeType.identifier = @"9";
    }
    return _modelFeeType;
}
- (ModelBaseData *)modelPayType{
    if (!_modelPayType) {
        _modelPayType = [ModelBaseData new];
        _modelPayType.aryDatas = @[^(){
            ModelFJData * item = [ModelFJData new];
            item.categoryname = @"全部";
            item.iDProperty = nil;
            return item;
        }(),^(){
            ModelFJData * item = [ModelFJData new];
            item.categoryname = @"潍坊银行";
            item.iDProperty = @"1";
            return item;
        }(),^(){
            ModelFJData * item = [ModelFJData new];
            item.categoryname = @"微信支付";
            item.iDProperty = @"2";
            return item;
        }(),^(){
            ModelFJData * item = [ModelFJData new];
            item.categoryname = @"其他银行";
            item.iDProperty = @"3";
            return item;
        }()].mutableCopy;
        //        _modelPayType.string = @"微信支付";
        //        _modelPayType.identifier = @"2";
    }
    return _modelPayType;
}

- (RentListFilterListView *)filterPayFee{
    if (!_filterPayFee) {
        _filterPayFee = [RentListFilterListView new];
        NSMutableArray * aryStr = [NSMutableArray new];
        for (ModelFJData * modelData in self.modelFeeType.aryDatas) {
            [aryStr addObject:UnPackStr(modelData.categoryname)];
        }
        [_filterPayFee resetViewWithArys:aryStr top:self.filterView.bottom];
        WEAKSELF
        _filterPayFee.blockSelected = ^(int index) {
            if (weakSelf.modelFeeType.aryDatas.count > index) {
                ModelFJData * data = weakSelf.modelFeeType.aryDatas[index];
                weakSelf.modelFeeType.identifier = data.iDProperty;
                [weakSelf refreshHeaderAll];
            }
            
        };
    }
    return _filterPayFee;
}
- (RentListFilterListView *)filterPayType{
    if (!_filterPayType) {
        _filterPayType = [RentListFilterListView new];
        NSMutableArray * aryStr = [NSMutableArray new];
        for (ModelFJData * modelData in self.modelPayType.aryDatas) {
            [aryStr addObject:UnPackStr(modelData.categoryname)];
        }
        [self.filterPayType resetViewWithArys:aryStr top:self.filterView.bottom];
        WEAKSELF
        _filterPayType.blockSelected = ^(int index) {
            if (weakSelf.modelPayType.aryDatas.count > index) {
                ModelFJData * data = weakSelf.modelPayType.aryDatas[index];
                weakSelf.modelPayType.identifier = data.iDProperty;
                [weakSelf refreshHeaderAll];
            }
            
        };
    }
    return _filterPayType;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    [self.view addSubview:self.filterView];
    self.tableView.top = self.filterView.bottom;
    self.tableView.height = SCREEN_HEIGHT - self.filterView.bottom;
    //table
    [self.tableView registerClass:[EHomePayHistoryListCell class] forCellReuseIdentifier:@"EHomePayHistoryListCell"];
    //request
    [self requestList];
    [self addRefresh];
}

#pragma mark 添加导航栏
- (void)addNav{
    [self.view addSubview:[BaseNavView initNavBackTitle:@"历史查询" rightView:nil]];
}

#pragma mark UITableViewDelegate
//row num
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.aryDatas.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
//cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    EHomePayHistoryListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"EHomePayHistoryListCell"];
    [cell resetCellWithModel:self.aryDatas[indexPath.row]];
    return cell;;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [EHomePayHistoryListCell fetchHeight:self.aryDatas[indexPath.row]];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    EHomePayCertVC * vc = [EHomePayCertVC new];
    vc.modelItem = self.aryDatas[indexPath.row];
    [GB_Nav pushViewController:vc animated:true];
}
#pragma mark request
- (void)requestList{
    [RequestApi requestEHomePayHistoryList:[GlobalData sharedInstance].GB_UserModel.phone roomId:[GlobalData sharedInstance].modelEHomeArchive.ehomeRoomId itemType:self.modelFeeType.identifier payType:self.modelPayType.identifier startTime:[GlobalMethod exchangeDate:self.dateStart formatter:@"yyyyMMdd"] endTime:[GlobalMethod exchangeDate:self.dateEnd formatter:@"yyyyMMdd"] page:NSNumber.dou(self.pageNum).stringValue pageSize:@"20" delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.pageNum ++;
        NSMutableArray  * aryRequest = [GlobalMethod exchangeDic:response toAryWithModelName:@"ModelEHomePayHistoryItem"];
        if (self.isRemoveAll) {
            [self.aryDatas removeAllObjects];
        }
        if (!isAry(aryRequest)) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        [self.aryDatas addObjectsFromArray:aryRequest];
        [self.tableView reloadData];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
@end



@implementation EHomePayHistoryFilterView
#pragma mark 懒加载
- (UILabel *)filter0{
    if (_filter0 == nil) {
        _filter0 = [UILabel new];
        _filter0.textColor = COLOR_333;
        _filter0.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        [_filter0 fitTitle:@"缴费类型" variable:0];
    }
    return _filter0;
}
- (UILabel *)filter1{
    if (_filter1 == nil) {
        _filter1 = [UILabel new];
        _filter1.textColor = COLOR_333;
        _filter1.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        [_filter1 fitTitle:@"支付方式" variable:0];
        
    }
    return _filter1;
}
- (UILabel *)filter2{
    if (_filter2 == nil) {
        _filter2 = [UILabel new];
        _filter2.textColor = COLOR_333;
        _filter2.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        [_filter2 fitTitle:@"开始时间" variable:0];
        
    }
    return _filter2;
}
- (UILabel *)filter3{
    if (_filter3 == nil) {
        _filter3 = [UILabel new];
        _filter3.textColor = COLOR_333;
        _filter3.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        [_filter3 fitTitle:@"结束时间" variable:0];
        
    }
    return _filter3;
}

- (UIImageView *)icon0{
    if (_icon0 == nil) {
        _icon0 = [UIImageView new];
        _icon0.image = [UIImage imageNamed:@"arrow_down_default"];
        _icon0.highlightedImage = [UIImage imageNamed:@"arrow_down_selected"];
        _icon0.widthHeight = XY(W(15),W(15));
    }
    return _icon0;
}
- (UIImageView *)icon1{
    if (_icon1 == nil) {
        _icon1 = [UIImageView new];
        _icon1.image = [UIImage imageNamed:@"arrow_down_default"];
        _icon1.highlightedImage = [UIImage imageNamed:@"arrow_down_selected"];
        _icon1.widthHeight = XY(W(15),W(15));
    }
    return _icon1;
}
- (UIImageView *)icon2{
    if (_icon2 == nil) {
        _icon2 = [UIImageView new];
        _icon2.image = [UIImage imageNamed:@"arrow_down_default"];
        _icon2.highlightedImage = [UIImage imageNamed:@"arrow_down_selected"];
        _icon2.widthHeight = XY(W(15),W(15));
    }
    return _icon2;
}
- (UIImageView *)icon3{
    if (_icon3 == nil) {
        _icon3 = [UIImageView new];
        _icon3.image = [UIImage imageNamed:@"arrow_down_default"];
        _icon3.highlightedImage = [UIImage imageNamed:@"arrow_down_selected"];
        _icon3.widthHeight = XY(W(15),W(15));
    }
    return _icon3;
}


#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.width = SCREEN_WIDTH;
        [self addSubView];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.filter0];
    [self addSubview:self.filter1];
    [self addSubview:self.filter2];
    [self addSubview:self.filter3];
    
    [self addSubview:self.icon0];
    [self addSubview:self.icon1];
    [self addSubview:self.icon2];
    [self addSubview:self.icon3];
    
    self.filter0.leftTop = XY(W(15),W(18));
    self.icon0.leftCenterY = XY(self.filter0.right + W(2), self.filter0.centerY);
    
    self.filter1.leftCenterY = XY(self.icon0.right + W(15),self.filter0.centerY);
    self.icon1.leftCenterY = XY(self.filter1.right + W(2), self.filter0.centerY);
    
    self.filter2.leftCenterY = XY(self.icon1.right + W(15),self.filter0.centerY);
    self.icon2.leftCenterY = XY(self.filter2.right + W(2), self.filter0.centerY);
    
    self.filter3.leftCenterY = XY(self.icon2.right + W(15),self.filter0.centerY);
    self.icon3.leftCenterY = XY(self.filter3.right + W(2), self.filter0.centerY);
    
    
    //设置总高度
    self.height = self.filter0.bottom + W(12);
    [self addControlFrame:CGRectMake(0, 0, self.icon0.right + W(7), self.height) target:self action:@selector(click0)];
    [self addControlFrame:CGRectMake(self.filter1.left - W(7), 0, self.icon0.right + W(7), self.height) target:self action:@selector(click1)];
    [self addControlFrame:CGRectMake(self.filter2.left - W(7), 0, self.icon1.right + W(7), self.height) target:self action:@selector(click2)];
    [self addControlFrame:CGRectMake(self.filter3.left - W(7), 0, self.icon2.right + W(7), self.height) target:self action:@selector(click3)];
    
    
}

#pragma mark click
- (void)click0{
    if (self.blockIndexClick) {
        self.blockIndexClick(0);
    }
}
- (void)click1{
    if (self.blockIndexClick) {
        self.blockIndexClick(1);
    }
}
- (void)click2{
    if (self.blockIndexClick) {
        self.blockIndexClick(2);
    }
}
- (void)click3{
    if (self.blockIndexClick) {
        self.blockIndexClick(3);
    }
}
#pragma mark 刷新view
- (void)resetViewWithModel:(id)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
}

@end



@implementation EHomePayHistoryListCell
#pragma mark 懒加载
- (UILabel *)name{
    if (_name == nil) {
        _name = [UILabel new];
        _name.textColor = COLOR_333;
        _name.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightMedium];
        _name.numberOfLines = 1;
        _name.lineSpace = 0;
    }
    return _name;
}
- (UILabel *)timePay{
    if (_timePay == nil) {
        _timePay = [UILabel new];
        _timePay.textColor = COLOR_999;
        _timePay.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        _timePay.numberOfLines = 1;
    }
    return _timePay;
}
- (UILabel *)person{
    if (_person == nil) {
        _person = [UILabel new];
        _person.textColor = COLOR_999;
        _person.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        _person.numberOfLines = 1;
    }
    return _person;
}
- (UILabel *)price{
    if (_price == nil) {
        _price = [UILabel new];
        _price.textColor = COLOR_333;
        _price.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightMedium];
        _price.numberOfLines = 1;
    }
    return _price;
}

#pragma mark 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.name];
        [self.contentView addSubview:self.person];
        [self.contentView addSubview:self.price];
        [self.contentView addSubview:self.timePay];
    }
    return self;
}
#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelEHomePayHistoryItem *)model{
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    self.model = model;
    [self.name fitTitle:UnPackStr(model.feeStateName) variable:W(200)];
    self.name.leftTop = XY(W(15),W(18));
    
    [self.person fitTitle:[NSString stringWithFormat:@"业主：%@",UnPackStr(model.custName)]  variable:W(220)];
    self.person.leftTop = XY(W(15),self.name.bottom+W(13));
    
    
    [self.price fitTitle:[NSString stringWithFormat:@"￥%@",NSNumber.dou(model.payAmount).stringValue]  variable:0];
    self.price.rightCenterY = XY(SCREEN_WIDTH - W(15),self.name.centerY);
    
    [self.timePay fitTitle:[NSString stringWithFormat:@"%@ %@",UnPackStr(model.payDate),UnPackStr(model.payType)]  variable:0];
    self.timePay.rightCenterY = XY(SCREEN_WIDTH - W(15),self.person.centerY);
    
    //设置总高度
    self.height = self.person.bottom + W(18);
    [self.contentView addLineFrame:CGRectMake(W(15), self.height - 1, SCREEN_WIDTH - W(15), 1)];
}

@end


//date picker
#import "DatePicker.h"
//list view
#import "ListAlertView.h"
//date
#import "NSDate+YYAdd.h"
#import "SelectDistrictView.h"

@interface EHomePayHistoryFilterAlertView ()<UITextFieldDelegate>
@property (nonatomic, assign) CGRect borderFrame;
@end

@implementation EHomePayHistoryFilterAlertView

#pragma mark 懒加载
- (UIView *)viewBG{
    if (_viewBG == nil) {
        _viewBG = [UIView new];
        _viewBG.backgroundColor = [UIColor whiteColor];
    }
    return _viewBG;
}

- (UILabel *)selectEndTime{
    if (_selectEndTime == nil) {
        _selectEndTime = [UILabel new];
        _selectEndTime.font = [UIFont systemFontOfSize:F(15)];
        _selectEndTime.textColor = COLOR_666;
        _selectEndTime.backgroundColor = [UIColor clearColor];
        
        [_selectEndTime fitTitle:@"请选择结束时间" variable:0];
    }
    return _selectEndTime;
}
- (UILabel *)selectStartTime{
    if (_selectStartTime == nil) {
        _selectStartTime = [UILabel new];
        _selectStartTime.font = [UIFont systemFontOfSize:F(15)];
        _selectStartTime.textColor = COLOR_666;
        _selectStartTime.backgroundColor = [UIColor clearColor];
        [_selectStartTime fitTitle:@"请选择开始时间" variable:0];
    }
    return _selectStartTime;
}

-(UIButton *)btnSearch{
    if (_btnSearch == nil) {
        _btnSearch = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnSearch.backgroundColor = COLOR_ORANGE;
        _btnSearch.titleLabel.font = [UIFont systemFontOfSize:F(15)];
        [_btnSearch setTitle:@"筛选" forState:(UIControlStateNormal)];
        [_btnSearch setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btnSearch addTarget:self action:@selector(btnSearchClick) forControlEvents:UIControlEventTouchUpInside];
        [GlobalMethod setRoundView:_btnSearch color:[UIColor clearColor] numRound:5 width:0];
    }
    return _btnSearch;
}
-(UIButton *)btnReset{
    if (_btnReset == nil) {
        _btnReset = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnReset.backgroundColor = COLOR_ORANGE;
        _btnReset.titleLabel.font = [UIFont systemFontOfSize:F(15)];
        [_btnReset setTitle:@"重置" forState:(UIControlStateNormal)];
        [_btnReset setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btnReset addTarget:self action:@selector(btnResetClick) forControlEvents:UIControlEventTouchUpInside];
        [GlobalMethod setRoundView:_btnReset color:[UIColor clearColor] numRound:5 width:0];
    }
    return _btnReset;
}
- (UIView *)viewBlackAlpha{
    if (!_viewBlackAlpha) {
        _viewBlackAlpha = [UIView new];
        _viewBlackAlpha.frame = CGRectMake(0, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT);
        _viewBlackAlpha.backgroundColor =  [[UIColor blackColor] colorWithAlphaComponent:0.5];
    }
    return _viewBlackAlpha;
}
#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.widthHeight = XY(SCREEN_WIDTH, SCREEN_HEIGHT);
        [self addSubView];
        [self addTarget:self action:@selector(closeClick)];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.viewBlackAlpha];
    [self addSubview:self.viewBG];
    [self.viewBG addSubview:self.btnSearch];
    [self.viewBG addSubview:self.btnReset];
    [self.viewBG addSubview:self.selectEndTime];
    [self.viewBG addSubview:self.selectStartTime];
    //初始化页面
    [self configView];
}

#pragma mark 刷新view
- (void)configView{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    CGFloat remove = W(65);
    self.viewBG.widthHeight = XY(SCREEN_WIDTH, W(280) - remove);
    self.viewBG.centerXTop = XY(SCREEN_WIDTH/2.0,NAVIGATIONBAR_HEIGHT);
    
    {
        UIView * viewBorder = [self generateBorder:CGRectMake(W(96), W(20), W(259), W(45))];
        [self.viewBG addSubview:viewBorder];
        [viewBorder addTarget:self action:@selector(selectTimeStartClick)];
        self.selectStartTime.leftCenterY = XY(viewBorder.left + W(15),viewBorder.centerY);
        
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        l.textColor = COLOR_333;
        l.backgroundColor = [UIColor clearColor];
        [l fitTitle:@"开始时间" variable:0];
        l.leftCenterY = XY(W(20), viewBorder.centerY);
        [self.viewBG addSubview:l];
        
        UIImageView *ivDown = [UIImageView new];
        ivDown.image = [UIImage imageNamed:@"accountDown"];
        ivDown.widthHeight = XY(W(25),W(25));
        [self.viewBG addSubview:ivDown];
        ivDown.rightCenterY = XY(viewBorder.right - W(10), viewBorder.centerY);
        
    }
    {
        UIView * viewBorder = [self generateBorder:CGRectMake(W(96), W(85), W(259), W(45))];
        [self.viewBG addSubview:viewBorder];
        [viewBorder addTarget:self action:@selector(selectEndTimeClick)];
        self.selectEndTime.leftCenterY = XY(viewBorder.left + W(15),viewBorder.centerY);
        
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        l.textColor = COLOR_333;
        l.backgroundColor = [UIColor clearColor];
        [l fitTitle:@"结束时间" variable:0];
        l.leftCenterY = XY(W(20), viewBorder.centerY);
        [self.viewBG addSubview:l];
        
        UIImageView *ivDown = [UIImageView new];
        ivDown.image = [UIImage imageNamed:@"accountDown"];
        ivDown.widthHeight = XY(W(25),W(25));
        [self.viewBG addSubview:ivDown];
        ivDown.rightCenterY = XY(viewBorder.right - W(10), viewBorder.centerY);
        
    }
    
    self.btnSearch.widthHeight = XY(W(160),W(45));
    self.btnReset.widthHeight = XY(W(160),W(45));
    self.btnSearch.leftBottom = XY(self.viewBG.width/2.0 + W(7.5),self.viewBG.height- W(20));
    self.btnReset.rightBottom = XY(self.viewBG.width/2.0 - W(7.5),self.viewBG.height- W(20));
}
- (UIView *)generateBorder:(CGRect)frame{
    UIView * viewBorder = [UIView new];
    viewBorder.backgroundColor = [UIColor clearColor];
    [GlobalMethod setRoundView:viewBorder color:COLOR_LINE numRound:5 width:1];
    viewBorder.frame = frame;
    return viewBorder;
}


#pragma mark 销毁
- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
#pragma mark click
- (void)closeClick{
    if ([self fetchFirstResponder]) {
        [GlobalMethod endEditing];
        return;
    }
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
- (void)show{
    self.alpha = 1;
    [GB_Nav.lastVC.view addSubview:self];
}


- (void)selectTimeStartClick{
    [GlobalMethod endEditing];
    WEAKSELF
    DatePicker * datePickerView = [DatePicker initWithMinDate:[GlobalMethod exchangeStringToDate:@"1900" formatter:@"yyyy"] dateSelectBlock:^(NSDate *date) {
        weakSelf.dateStart = date;
        [weakSelf.selectStartTime fitTitle:[GlobalMethod exchangeDate:date formatter:TIME_DAY_SHOW] variable:0];
        weakSelf.selectStartTime.textColor = COLOR_333;
    } type:ENUM_PICKER_DATE_YEAR_MONTH_DAY];
    [GB_Nav.lastVC.view addSubview:datePickerView];
}

- (void)selectEndTimeClick{
    [GlobalMethod endEditing];
    WEAKSELF
    DatePicker * datePickerView = [DatePicker initWithMinDate:[GlobalMethod exchangeStringToDate:@"1900" formatter:@"yyyy"] dateSelectBlock:^(NSDate *date) {
        weakSelf.dateEnd = date;
        [weakSelf.selectEndTime fitTitle:[GlobalMethod exchangeDate:date formatter:TIME_DAY_SHOW] variable:0];
        weakSelf.selectEndTime.textColor = COLOR_333;
    } type:ENUM_PICKER_DATE_YEAR_MONTH_DAY];
    [GB_Nav.lastVC.view addSubview:datePickerView];
}

- (void)btnSearchClick{
    if (self.blockSearchClick) {
        self.blockSearchClick(self.dateStart,self.dateEnd);
    }
    [GlobalMethod endEditing];
    [self removeFromSuperview];
}

- (void)btnResetClick{
    self.dateEnd = nil;
    [self.selectEndTime fitTitle:@"请选择结束时间" variable:0];
    self.selectEndTime.textColor = COLOR_666;
    
    
    self.dateStart = nil;
    [self.selectStartTime fitTitle:@"请选择开始时间" variable:0];
    self.selectStartTime.textColor = COLOR_666;
    [self btnSearchClick];
    
}
@end
