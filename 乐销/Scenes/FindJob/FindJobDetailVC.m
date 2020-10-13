//
//  FindJobDetailVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/9/1.
//Copyright © 2020 ping. All rights reserved.
//

#import "FindJobDetailVC.h"
#import "FindJobDetailView.h"
#import "YellowButton.h"
#import "RequestApi+FindJob.h"

@interface FindJobDetailVC ()
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) FindJobDetailTopView *topView;
@property (nonatomic, strong) FindJobDetailLabelView *labelView;
@property (nonatomic, strong) FindJobDetailCompanyView *companyView;
@property (nonatomic, strong) FindJobDetailJobView *jobView;
@property (nonatomic, strong) FindJobDetailConnectView *connectView;
@property (nonatomic, strong) UIView *alertView;
@property (nonatomic, strong) UIView  *viewBottom;
@property (nonatomic, strong) YellowButton *yellowBtn;
@property (nonatomic, strong) ModelFJJobDetail *modelDetail;

@end

@implementation FindJobDetailVC

- (UIView *)viewBottom{
    if (!_viewBottom) {
        _viewBottom = [UIView new];
        _viewBottom.width = SCREEN_WIDTH;
        _viewBottom.backgroundColor = [UIColor whiteColor];
        YellowButton * _btnBottom = [YellowButton new];
        [_btnBottom resetViewWithWidth:W(335) :W(45) :@"投递简历"];
        WEAKSELF
        _btnBottom.blockClick = ^{
            [weakSelf requestSubmit];
        };
        self.yellowBtn = _btnBottom;
        [_viewBottom addSubview:_btnBottom];
        _btnBottom.centerXTop = XY(SCREEN_WIDTH/2.0, W(10));
        _viewBottom.height = _btnBottom.bottom + W(10)+ iphoneXBottomInterval;
        _viewBottom.top = SCREEN_HEIGHT - _viewBottom.height;
    }
    return _viewBottom;
}
- (UIView *)alertView{
    if (!_alertView) {
        _alertView = [UIView new];
        _alertView.backgroundColor = [UIColor colorWithHexString:@"#FFF6E3"];
        _alertView.widthHeight = XY(SCREEN_WIDTH, W(34));
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        l.textColor = [UIColor colorWithHexString:@"#FF5900"];
        l.backgroundColor = [UIColor clearColor];
        l.numberOfLines = 0;
        l.lineSpace = W(0);
        [l fitTitle:@"面试过程中，遇到用人单位收取费用请提高警" variable:SCREEN_WIDTH - W(30)];
        l.centerXCenterY = XY(_alertView.width/2.0, _alertView.height/2.0);
        [_alertView addSubview:l];

    }
    return _alertView;
}
- (FindJobDetailConnectView *)connectView{
    if (!_connectView) {
        _connectView = [FindJobDetailConnectView new];
    }
    return _connectView;
}
- (FindJobDetailJobView *)jobView{
    if (!_jobView) {
        _jobView = [FindJobDetailJobView new];
    }
    return _jobView;
}
- (FindJobDetailCompanyView *)companyView{
    if (!_companyView) {
        _companyView = [FindJobDetailCompanyView new];
    }
    return _companyView;
}
- (FindJobDetailLabelView *)labelView{
    if (!_labelView) {
        _labelView = [FindJobDetailLabelView new];
    }
    return _labelView;
}
- (FindJobDetailTopView *)topView{
    if (!_topView) {
        _topView = [FindJobDetailTopView new];
    }
    return _topView;
}
- (UIView *)headerView{
    if (!_headerView) {
        _headerView = [UIView new];
        _headerView.backgroundColor = [UIColor clearColor];
    }
    return _headerView;
}

#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    //table
    [self.view addSubview:self.viewBottom];
    self.tableView.frame = CGRectMake(0, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT - self.viewBottom.height);
    self.tableView.backgroundColor = COLOR_GRAY;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(requestList) name:NOTICE_SELFMODEL_CHANGE object:nil];
    //request
    [self requestList];
    [self reconfigView];
}
- (void)reconfigView{
    self.tableView.tableHeaderView = nil;
    [self.headerView removeAllSubViews];
    CGFloat top = 0;
   
    self.topView.top = top;
    [self.headerView addSubview:self.topView];
    top = self.topView.bottom;
    
    self.labelView.top = top;
       [self.headerView addSubview:self.labelView];
       top = self.labelView.bottom;
    
    self.companyView.top = top;
          [self.headerView addSubview:self.companyView];
          top = self.companyView.bottom;
    
    self.jobView.top = top+W(10);
             [self.headerView addSubview:self.jobView];
             top = self.jobView.bottom;
    
    self.connectView.top = top+W(10);
    [self.headerView addSubview:self.connectView];
    top = self.connectView.bottom;
    
    self.alertView.top = top;
       [self.headerView addSubview:self.alertView];
       top = self.alertView.bottom;
    
    self.headerView.height = top ;
    self.tableView.tableHeaderView = self.headerView;
    
}
#pragma mark 添加导航栏
- (void)addNav{
    [self.view addSubview:[BaseNavView initNavBackTitle:UnPackStr(self.modelList.jobsName) rightView:nil]];
}

#pragma mark UITableViewDelegate
//row num
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.aryDatas.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
//cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CGFLOAT_MIN;
}
//table header
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return  nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
//table footer
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

#pragma mark request
- (void)requestList{
    [RequestApi requestFJJobDetail:self.modelList.iDProperty.doubleValue delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.modelDetail = [ModelFJJobDetail modelObjectWithDictionary:response];
        [self.topView resetViewWithModel:self.modelDetail];
        [self.labelView resetViewWithModel:self.modelDetail];
        [self.companyView resetViewWithModel:self.modelDetail];
        [self.jobView resetViewWithModel:self.modelDetail];
        [self.connectView resetViewWithModel:self.modelDetail];

        [self reconfigView];
        
        if (self.modelDetail.isApply) {
            [self.yellowBtn resetWhiteViewWithWidth:W(335) :W(45) :@"投递简历"];
            self.yellowBtn.userInteractionEnabled = false;
        }else{
            self.yellowBtn.userInteractionEnabled = true;
            [self.yellowBtn resetViewWithWidth:W(335) :W(45) :@"投递简历"];
        }
        
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
- (void)requestSubmit{
    if (!isStr([GlobalData sharedInstance].modelFindJob.uid)) {
        [GB_Nav pushVCName:@"LoginViewController" animated:true];
        return;
    }
    [GlobalMethod judgeLoginState:^{
        [RequestApi requestFJResumeInfoDelegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
            ModelResumeDetail *modelDetail = [ModelResumeDetail modelObjectWithDictionary:response];
                             if (modelDetail.iDProperty.doubleValue) {
                                 [RequestApi requestFJSubmitResume:self.modelList.iDProperty.doubleValue delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
                                     [GlobalMethod showAlert:@"投递成功"];
                                     [self requestList];
                                 } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
                                     
                                 }];
                             }else{
                                 [GB_Nav pushVCName:@"CreateFJResumeVC" animated:true];
                             }
        } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
            [GB_Nav pushVCName:@"CreateFJResumeVC" animated:true];

        }];
    }];
}
@end
