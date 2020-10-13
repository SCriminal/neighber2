//
//  HailuoCompanyVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/8/18.
//Copyright © 2020 ping. All rights reserved.
//

#import "HailuoCompanyVC.h"
#import "HailuoCompanyView.h"
#import "HailuoAuntResumeImageView.h"
#import "YellowButton.h"
#import "RequestApi+Hailuo.h"
#import "HailuoAllCommentListVC.h"
#import "SliderView.h"
#import "HailuoServiceListVC.h"
#import "HailuoAuntResumeView.h"
@interface HailuoCompanyVC ()<SliderViewDelegate>

@end

@interface HailuoCompanyVC ()
@property (nonatomic, strong) HailuoCompanyInfoView *infoView;
@property (nonatomic, strong) HailuoCompanyQualificationView *qualificationView;
@property (nonatomic, strong) HailuoCompanyAddressView *addressView;
@property (nonatomic, strong) HailuoAuntResumeImageView *imageView;
@property (nonatomic, strong) UIView *headerView;
@property (strong, nonatomic) SliderView *sliderView;
@property (nonatomic, strong) HailuoCompanyServeView *serveView;
@property (nonatomic, assign) int index;
@property (nonatomic, strong) HailuoAppointmentMoreView *moreCommentView;

@end

@implementation HailuoCompanyVC
- (SliderView *)sliderView{
    if (_sliderView == nil) {
        _sliderView = ^(){
            SliderView * sliderView = [SliderView new];
            sliderView.frame = CGRectMake(0, 0, SCREEN_WIDTH, W(50));
            sliderView.isHasSlider = true;
            sliderView.viewSlidColor = COLOR_ORANGE;
            sliderView.viewSlidWidth = W(45);
            sliderView.isScroll = false;
            sliderView.isLineVerticalHide = true;
            sliderView.delegate = self;
            sliderView.line.hidden = true;
            [sliderView resetWithAry:@[^(){
                ModelBtn * model = [ModelBtn new];
                model.title = @"服务项目";
                return model;
            }(),^(){
                ModelBtn * model = [ModelBtn new];
                model.title = @"评价";
                return model;
            }()]];
            return sliderView;
        }();
    }
    return _sliderView;
}
- (HailuoAppointmentMoreView *)moreCommentView{
    if (!_moreCommentView) {
        _moreCommentView = [HailuoAppointmentMoreView new];
        WEAKSELF
        _moreCommentView.blockMoreClick = ^(BOOL is) {
            HailuoAllCommentListVC * comment = [HailuoAllCommentListVC new];
            comment.companyID = weakSelf.companyID;
            [GB_Nav pushViewController:comment animated:true];
        };
    }
    return _moreCommentView;
}
- (UIView *)headerView{
    if (!_headerView) {
        _headerView = [UIView new];
        _headerView.backgroundColor = [UIColor whiteColor];
        _headerView.width =SCREEN_WIDTH;
        
    }
    return _headerView;
}
- (HailuoCompanyServeView *)serveView{
    if (!_serveView) {
        _serveView = [HailuoCompanyServeView new];
        WEAKSELF
        _serveView.blockServeClick = ^(ModelHailuoCompanyServe *model) {
            HailuoServiceListVC * list = [HailuoServiceListVC new];
            list.type = model.serveId;
            list.companyID = weakSelf.companyID;
            list.navTitle = model.name;
            [GB_Nav pushViewController:list animated:true];
        };
    }
    return _serveView;
}
- (HailuoCompanyQualificationView *)qualificationView{
    if (!_qualificationView) {
        _qualificationView = [HailuoCompanyQualificationView new];
    }
    return _qualificationView;
}
- (HailuoCompanyInfoView *)infoView{
    if (!_infoView) {
        _infoView = [HailuoCompanyInfoView new];
    }
    return _infoView;
}
- (HailuoCompanyAddressView *)addressView{
    if (!_addressView) {
        _addressView = [HailuoCompanyAddressView new];
    }
    return _addressView;
}
- (HailuoAuntResumeImageView *)imageView{
    if (!_imageView) {
        _imageView = [HailuoAuntResumeImageView new];
        NSMutableArray * aryImage = [NSMutableArray new];
        for (int i = 0; i<5; i++) {
            ModelImage * modelImageInfo = [ModelImage new];
            [aryImage addObject:modelImageInfo];
        }
        _imageView.aryDatas = aryImage;
        [_imageView.collectionView reloadData];
    }
    return _imageView;
}
#pragma mark view did load
- (void)viewDidLoad{
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    //table
    [self.tableView registerClass:[HailuoCompanyCell class] forCellReuseIdentifier:@"HailuoCompanyCell"];
//    self.tableView.contentInset = UIEdgeInsetsMake(W(20), 0, 0, 0);
    
    //request
    [self reconfigView];
    [self requestList];
}
- (void)reconfigView{
    self.tableView.tableHeaderView = nil;
    [self.headerView removeAllSubViews];
    CGFloat top = 0;
    
    self.infoView.top = top;
    [self.headerView addSubview:self.infoView];
    top = self.infoView.bottom;
    
    self.qualificationView.top = top;
    [self.headerView addSubview:self.qualificationView];
    top = self.qualificationView.bottom;
    
    self.addressView.top = top;
    [self.headerView addSubview:self.addressView];
    top = self.addressView.bottom;
    
    if (self.imageView.aryDatas.count) {
        self.imageView.top = top;
        [self.headerView addSubview:self.imageView];
        top = self.imageView.bottom;
    }
    
    self.sliderView.top = top;
    [self.headerView addSubview:self.sliderView];
    top = self.sliderView.bottom;
  
    if (self.index == 0) {
        self.serveView.top = top;
        [self.headerView addSubview:self.serveView];
        top = self.serveView.bottom;
    }
    
    self.headerView.height = top;
    self.tableView.tableHeaderView = self.headerView;
    
    if (self.index == 0) {
        self.tableView.tableFooterView = nil;
    }else{
        self.tableView.tableFooterView = self.moreCommentView;
    }
    
}
#pragma mark 添加导航栏
- (void)addNav{
    [self.view addSubview:[BaseNavView initNavBackTitle:[NSString stringWithFormat:@"%@",@"企业详情"] rightView:nil]];
}

#pragma mark UITableViewDelegate
//row num
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.index ==0?0:self.aryDatas.count;
}
//cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HailuoCompanyCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HailuoCompanyCell"];
    [cell resetCellWithModel:self.aryDatas[indexPath.row]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [HailuoCompanyCell fetchHeight:self.aryDatas[indexPath.row]];
}

#pragma mark request
- (void)requestList{
    [RequestApi requestHaiLuoCompanyID:strDotF(self.companyID) delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        ModelHailuoCompany * modelCompany = [ModelHailuoCompany modelObjectWithDictionary:response];
        [self.infoView resetViewWithModel:modelCompany];
        [self.qualificationView resetViewWithModel:modelCompany];
        [self.addressView resetViewWithModel:modelCompany];

        //reload image
        NSMutableArray * aryimages = [NSMutableArray new];
        for (NSString * strURL in modelCompany.companyPhoto) {
            ModelImage * model = [ModelImage new];
            model.url = strURL;
            [aryimages addObject:model];
        }
        self.imageView.aryDatas = aryimages;
        [self.imageView.collectionView reloadData];
        
        NSArray * aryServe = [GlobalMethod exchangeDic:[response arrayValueForKey:@"serve"] toAryWithModelName:@"ModelHailuoCompanyServe"];
        [self.serveView resetViewWithModel:aryServe];
        
        self.aryDatas = [GlobalMethod exchangeDic:[response arrayValueForKey:@"comment"] toAryWithModelName:@"ModelHailuoComment"];
        [self.tableView reloadData];
        [self reconfigView];

    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
    
}
#pragma mark slid delegate
- (void)protocolSliderViewBtnSelect:(NSUInteger)tag btn:(CustomSliderControl *)control{
    self.index = (int)tag;
    [self.tableView reloadData];
    [self reconfigView];
}

@end
