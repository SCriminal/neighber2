//
//  HailuoAppointmentVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/8/15.
//Copyright © 2020 ping. All rights reserved.
//

#import "HailuoAuntResumeVC.h"
#import "HailuoAuntResumeView.h"
#import "HailuoAuntResumeImageView.h"
#import "YellowButton.h"
#import "RequestApi+Hailuo.h"
#import "HailuoAllCommentListVC.h"
#import "HailuoAppointmentVC.h"
#import "ArchivePickView.h"

@interface HailuoAuntResumeVC ()
@property (nonatomic, strong) HailuoAuntResumeView *infoView;
@property (nonatomic, strong) HailuoAppointmentQualificationView *qualificationView;
@property (nonatomic, strong) HailuoAppointmentCommentView *commentView;
@property (nonatomic, strong) HailuoAuntResumeImageView *imageView;
@property (nonatomic, strong) HailuoAppointmentCommentLabelView *commentLabelView;
@property (nonatomic, strong) HailuoAppointmentMoreView *moreCommentView;
@property (nonatomic, strong) UIView  *viewBottom;
@property (nonatomic, strong) HailuoAppointmentTraningView *trainingView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong) ModelHailuoAunt *modelAunt;

@end

@implementation HailuoAuntResumeVC
- (HailuoAppointmentTraningView *)trainingView{
    if (!_trainingView) {
        _trainingView = [HailuoAppointmentTraningView new];
    }
    return _trainingView;
}
- (UIView *)viewBottom{
    if (!_viewBottom) {
        _viewBottom = [UIView new];
        _viewBottom.width = SCREEN_WIDTH;
        _viewBottom.backgroundColor = [UIColor whiteColor];
        YellowButton * _btnBottom = [YellowButton new];
        [_btnBottom resetViewWithWidth:W(335) :W(45) :@"立即预约"];
        WEAKSELF
        _btnBottom.blockClick = ^{
            [GlobalMethod judgeLoginState:^{
                HailuoAppointmentVC * vc = [HailuoAppointmentVC new];
                           vc.modelAunt = weakSelf.modelAunt;
                           [GB_Nav pushViewController:vc animated:true];
            }];
        };
        [_viewBottom addSubview:_btnBottom];
        _btnBottom.centerXTop = XY(SCREEN_WIDTH/2.0, W(10));
        _viewBottom.height = _btnBottom.bottom + W(10)+ iphoneXBottomInterval;
        _viewBottom.top = SCREEN_HEIGHT - _viewBottom.height;
    }
    return _viewBottom;
}
- (HailuoAppointmentMoreView *)moreCommentView{
    if (!_moreCommentView) {
        _moreCommentView = [HailuoAppointmentMoreView new];
        WEAKSELF
        _moreCommentView.blockMoreClick = ^(BOOL is) {
            HailuoAllCommentListVC * comment = [HailuoAllCommentListVC new];
            comment.auntID = weakSelf.auntID;
            [GB_Nav pushViewController:comment animated:true];
        };
    }
    return _moreCommentView;
}
- (HailuoAppointmentCommentLabelView *)commentLabelView{
    if (!_commentLabelView) {
        _commentLabelView = [HailuoAppointmentCommentLabelView new];
    }
    return _commentLabelView;
}
- (UIView *)headerView{
    if (!_headerView) {
        _headerView = [UIView new];
        _headerView.backgroundColor = [UIColor whiteColor];
        _headerView.width =SCREEN_WIDTH;
        
    }
    return _headerView;
}
- (UIView *)footerView{
    if (!_footerView) {
        _footerView = [UIView new];
        _footerView.backgroundColor = [UIColor whiteColor];
        _footerView.width =SCREEN_WIDTH;
        
    }
    return _footerView;
}
- (HailuoAppointmentQualificationView *)qualificationView{
    if (!_qualificationView) {
        _qualificationView = [HailuoAppointmentQualificationView new];
    }
    return _qualificationView;
}
- (HailuoAuntResumeView *)infoView{
    if (!_infoView) {
        _infoView = [HailuoAuntResumeView new];
    }
    return _infoView;
}

- (HailuoAppointmentCommentView *)commentView{
    if (!_commentView) {
        _commentView = [HailuoAppointmentCommentView new];
    }
    return _commentView;
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
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    [self.view addSubview:self.viewBottom];
    //table
    [self.tableView registerClass:[HailuoAppointmentCell class] forCellReuseIdentifier:@"HailuoAppointmentCell"];
    self.tableView.frame = CGRectMake(0, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT - self.viewBottom.height);
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
    
    self.commentView.top = top;
    [self.headerView addSubview:self.commentView];
    top = self.commentView.bottom;
    
    if (self.imageView.aryDatas.count) {
        self.imageView.top = top;
        [self.headerView addSubview:self.imageView];
        top = self.imageView.bottom;
    }
    
    if (self.aryDatas.count) {
        self.commentLabelView.top = top;
        [self.headerView addSubview:self.commentLabelView];
        top = self.commentLabelView.bottom;
    }
    
    self.headerView.height = top;
    self.tableView.tableHeaderView = self.headerView;
    
    [self reconfigFooterView];
}
- (void)reconfigFooterView{
    self.tableView.tableFooterView = nil;
    [self.footerView removeAllSubViews];
    CGFloat top = 0;
    
    if (self.aryDatas.count) {
        self.moreCommentView.top = top;
        [self.footerView addSubview:self.moreCommentView];
        top = self.moreCommentView.bottom;
    }
    
    if (self.trainingView.ary.count) {
        self.trainingView.top = top;
        [self.footerView addSubview:self.trainingView];
        top = self.trainingView.bottom;
    }
    self.footerView.height = top;
    self.tableView.tableFooterView = self.footerView;
    
    
}
#pragma mark 添加导航栏
- (void)addNav{
    [self.view addSubview:[BaseNavView initNavBackTitle:[NSString stringWithFormat:@"%@的简历",self.auntName] rightView:nil]];
}

#pragma mark UITableViewDelegate
//row num
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.aryDatas.count;
}
//cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HailuoAppointmentCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HailuoAppointmentCell"];
    [cell resetCellWithModel:self.aryDatas[indexPath.row]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [HailuoAppointmentCell fetchHeight:self.aryDatas[indexPath.row]];
}

#pragma mark request
- (void)requestList{
    [RequestApi requestHaiLuoResumeID:strDotF(self.auntID) delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        ModelHailuoAunt * modelAunt = [ModelHailuoAunt modelObjectWithDictionary:[response dictionaryValueForKey:@"aunt"]];
        self.modelAunt = modelAunt;
        self.modelAunt.auntId = self.auntID;
        modelAunt.estimatePrice = self.estimatePrice;
        modelAunt.orderCount = self.orderCount;
        self.modelAunt.aryServe = [GlobalMethod exchangeDic:[response arrayValueForKey:@"serve"] toAryWithModelName:@"ModelHailuoCompanyServe"];
        
        [self.infoView resetViewWithModel:modelAunt];
        [self.qualificationView resetViewWithModel:modelAunt];
        [self.commentLabelView resetViewWithModel:modelAunt];
        [self.trainingView resetViewWithAry:[response arrayValueForKey:@"experience"]];
        
        //reload image
        NSMutableArray * aryimages = [NSMutableArray new];
        for (NSString * strURL in modelAunt.showPhoto) {
            ModelImage * model = [ModelImage new];
            model.url = strURL;
            [aryimages addObject:model];
        }
        self.imageView.aryDatas = aryimages;
        [self.imageView.collectionView reloadData];
        
        self.aryDatas = [GlobalMethod exchangeDic:[response arrayValueForKey:@"comment"] toAryWithModelName:@"ModelHailuoComment"];
        [self.tableView reloadData];
        [self reconfigView];

    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
@end
