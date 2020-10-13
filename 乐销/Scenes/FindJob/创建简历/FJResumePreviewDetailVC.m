//
//  FJResumePreviewDetailVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/9/22.
//Copyright © 2020 ping. All rights reserved.
//

#import "FJResumePreviewDetailVC.h"
//request
#import "RequestApi+FindJob.h"
#import "FJResumeDetailView.h"
#import "FJIntentionVC.h"
#import "FJLaguageVC.h"
#import "FJProjectVC.h"
#import "FJTrainVC.h"
#import "FJWorkExperinceVC.h"
#import "ResumeSelfIntroduceVC.h"
#import "FJEducationVC.h"
#import "FJCertificationVC.h"
#import "EditFJInfoVC.h"
#import "FJResumeDetailListView.h"
#import "YellowButton.h"

@interface FJResumePreviewDetailVC ()
@property (nonatomic, strong) FJResumeDetailJobintentionView *jobIntetionView;
@property (nonatomic, strong) FJResumeDetailEducationView *educationView;
@property (nonatomic, strong) FJResumeDetailWorkView *workView;
@property (nonatomic, strong) FJResumeDetailTrainView *trainView;
@property (nonatomic, strong) FJResumeDetailProjectView *projectView;
@property (nonatomic, strong) FJResumeDetailCredientView *credientView;
@property (nonatomic, strong) FJResumeDetailLanguageView *languageView;
@property (nonatomic, strong) FJResumeDetailIntroduceView *introduceView;
@property (nonatomic, strong) FJResumeDetailTopInfoView *infoView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) ModelResumeDetail *modelDetail;

@end

@implementation FJResumePreviewDetailVC

- (FJResumeDetailTopInfoView *)infoView{
    if (!_infoView) {
        _infoView = [FJResumeDetailTopInfoView new];
       
    }
    return _infoView;
}
- (FJResumeDetailJobintentionView *)jobIntetionView{
    if (!_jobIntetionView) {
        _jobIntetionView = [FJResumeDetailJobintentionView new];
       
    }
    return _jobIntetionView;
}
- (FJResumeDetailEducationView *)educationView{
    if (!_educationView) {
        _educationView = [FJResumeDetailEducationView new];
       
    }
    return _educationView;
}
- (FJResumeDetailWorkView *)workView{
    if (!_workView) {
        _workView = [FJResumeDetailWorkView new];
       
    }
    return _workView;
}
- (FJResumeDetailTrainView *)trainView{
    if (!_trainView) {
        _trainView = [FJResumeDetailTrainView new];
       
    }
    return _trainView;
}
- (FJResumeDetailProjectView *)projectView{
    if (!_projectView) {
        _projectView = [FJResumeDetailProjectView new];
       
    }
    return _projectView;
}
- (FJResumeDetailCredientView *)credientView{
    if (!_credientView) {
        _credientView = [FJResumeDetailCredientView new];
        
    }
    return _credientView;
}
- (FJResumeDetailLanguageView *)languageView{
    if (!_languageView) {
        _languageView = [FJResumeDetailLanguageView new];
       
    }
    return _languageView;
}
- (FJResumeDetailIntroduceView *)introduceView{
    if (!_introduceView) {
        _introduceView = [FJResumeDetailIntroduceView new];
       
    }
    return _introduceView;
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
    //request
    [self requestList];

}
- (void)reconfigView{
    self.tableView.tableHeaderView = nil;
    [self.headerView removeAllSubViews];
    CGFloat top = 0;
    
    self.infoView.top = top;
    [self.headerView addSubview:self.infoView];
    top = self.infoView.bottom;
    
    
    self.jobIntetionView.top = top;
    [self.headerView addSubview:self.jobIntetionView];
    top = self.jobIntetionView.bottom;
    
    self.introduceView.top = top;
    [self.headerView addSubview:self.introduceView];
    top = self.introduceView.bottom;
    
    self.educationView.top = top;
    [self.headerView addSubview:self.educationView];
    top = self.educationView.bottom;
    
    self.workView.top = top;
    [self.headerView addSubview:self.workView];
    top = self.workView.bottom;
    
    self.trainView.top = top;
    [self.headerView addSubview:self.trainView];
    top = self.trainView.bottom;
    
    self.projectView.top = top;
    [self.headerView addSubview:self.projectView];
    top = self.projectView.bottom;
    
    self.credientView.top = top;
    [self.headerView addSubview:self.credientView];
    top = self.credientView.bottom;
    
    self.languageView.top = top;
    [self.headerView addSubview:self.languageView];
    top = self.languageView.bottom;
    
    self.headerView.height = top ;
    self.tableView.tableHeaderView = self.headerView;
    self.headerView.userInteractionEnabled = false;
    [self removeImage:self.headerView];
}
- (void)removeImage:(UIView *)view{
    for (UIView * subView in view.subviews) {
        [self removeImage:subView];
        if ([subView isKindOfClass:UIImageView.class] && subView.left >SCREEN_WIDTH/2.0) {
            subView.hidden = true;
        }
        if ([subView isKindOfClass:UILabel.class] && subView.left >SCREEN_WIDTH/2.0) {
            UILabel * l = (UILabel *)subView;
            if ([l.text isEqualToString:@"添加"]) {
                l.hidden = true;
            }
        }
    }
}
#pragma mark 添加导航栏
- (void)addNav{
    [self.view addSubview:[BaseNavView initNavBackTitle:@"简历预览" rightView:nil]];
}


#pragma mark request
- (void)requestList{
   
    [RequestApi requestFJResumeInfoDelegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.modelDetail = [ModelResumeDetail modelObjectWithDictionary:response];
        [self.jobIntetionView resetViewWithModel:self.modelDetail];
        [self.educationView resetViewWithModel:self.modelDetail];
        [self.introduceView resetViewWithModel:self.modelDetail];
        [self.workView resetViewWithModel:self.modelDetail];
        [self.trainView resetViewWithModel:self.modelDetail];
        [self.projectView resetViewWithModel:self.modelDetail];
        [self.credientView resetViewWithModel:self.modelDetail];
        [self.languageView resetViewWithModel:self.modelDetail];
        [self.infoView resetViewWithModel:self.modelDetail];
        
        [self reconfigView];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
@end
