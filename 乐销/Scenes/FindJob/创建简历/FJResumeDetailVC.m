//
//  FJResumeDetailVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/9/15.
//Copyright © 2020 ping. All rights reserved.
//

#import "FJResumeDetailVC.h"
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


@interface FJResumeDetailVC ()
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
@property (nonatomic, strong) UIView  *viewBottom;

@end

@implementation FJResumeDetailVC
- (UIView *)viewBottom{
    if (!_viewBottom) {
        _viewBottom = [UIView new];
        _viewBottom.width = SCREEN_WIDTH;
        _viewBottom.backgroundColor = [UIColor clearColor];
        YellowButton * _btnBottom = [YellowButton new];
        [_btnBottom resetYellowHollowViewWithWidth:W(335) :W(45) :@"预览简历"];
        _btnBottom.blockClick = ^{
            [GB_Nav pushVCName:@"FJResumePreviewDetailVC" animated:true];
        };
        [_viewBottom addSubview:_btnBottom];
        _btnBottom.centerXTop = XY(SCREEN_WIDTH/2.0, W(18));
        _viewBottom.height = _btnBottom.bottom + W(10)+ iphoneXBottomInterval;
        _viewBottom.top = SCREEN_HEIGHT - _viewBottom.height;
    }
    return _viewBottom;
}

- (FJResumeDetailTopInfoView *)infoView{
    if (!_infoView) {
        _infoView = [FJResumeDetailTopInfoView new];
        WEAKSELF
        _infoView.blockAdd = ^{
            EditFJInfoVC * vc = [EditFJInfoVC new];
            vc.modelResumeDetail = weakSelf.modelDetail;
            vc.blockBack = ^(UIViewController *item) {
                [weakSelf requestList];
            };
            [GB_Nav pushViewController:vc animated:true];
        };
    }
    return _infoView;
}
- (FJResumeDetailJobintentionView *)jobIntetionView{
    if (!_jobIntetionView) {
        _jobIntetionView = [FJResumeDetailJobintentionView new];
        WEAKSELF
        _jobIntetionView.addView.blockAdd = ^{
            FJIntentionVC * vc = [FJIntentionVC new];
            vc.modelResumeDetail = weakSelf.modelDetail;
            vc.blockBack = ^(UIViewController *item) {
                [weakSelf requestList];
            };
            [GB_Nav pushViewController:vc animated:true];
        };
    }
    return _jobIntetionView;
}
- (FJResumeDetailEducationView *)educationView{
    if (!_educationView) {
        _educationView = [FJResumeDetailEducationView new];
        WEAKSELF
        _educationView.addView.blockAdd = ^{
            FJEducationVC * vc = [FJEducationVC new];
            vc.blockBack = ^(UIViewController *item) {
                [weakSelf requestList];
            };
            vc.modelResumeDetail = weakSelf.modelDetail;
            [GB_Nav pushViewController:vc animated:true];
        };
        _educationView.blockDelete = ^(ModelFJEducation * modelSub) {
            [GlobalMethod showEditAlertWithTitle:@"提示" content:@"确定删除教育经历" dismiss:nil confirm:^{
                [weakSelf requestDeleteEducation:modelSub];
            } view:weakSelf.view];
        };
        _educationView.blockEdit  = ^(ModelFJEducation * modelSub) {
            FJEducationVC * vc = [FJEducationVC new];
            vc.modelResumeDetail = weakSelf.modelDetail;
            vc.modelFJEducation = modelSub;
            vc.blockBack = ^(UIViewController *item) {
                [weakSelf requestList];
            };
            [GB_Nav pushViewController:vc animated:true];
        };
    }
    return _educationView;
}
- (FJResumeDetailWorkView *)workView{
    if (!_workView) {
        _workView = [FJResumeDetailWorkView new];
        WEAKSELF
        _workView.addView.blockAdd = ^{
            FJWorkExperinceVC * vc = [FJWorkExperinceVC new];
            vc.blockBack = ^(UIViewController *item) {
                [weakSelf requestList];
            };
            vc.modelResumeDetail = weakSelf.modelDetail;
            [GB_Nav pushViewController:vc animated:true];
        };
        _workView.blockDelete = ^(ModelFJWorkExperience * modelSub) {
            [GlobalMethod showEditAlertWithTitle:@"提示" content:@"确定删除工作经历" dismiss:nil confirm:^{
                [weakSelf requestDeleteWork:modelSub];
            } view:weakSelf.view];
        };
        _workView.blockEdit  = ^(ModelFJWorkExperience * modelSub) {
            FJWorkExperinceVC * vc = [FJWorkExperinceVC new];
            vc.modelResumeDetail = weakSelf.modelDetail;
            vc.modelWorkExp = modelSub;
            vc.blockBack = ^(UIViewController *item) {
                [weakSelf requestList];
            };
            [GB_Nav pushViewController:vc animated:true];
        };
    }
    return _workView;
}
- (FJResumeDetailTrainView *)trainView{
    if (!_trainView) {
        _trainView = [FJResumeDetailTrainView new];
        WEAKSELF
        _trainView.addView.blockAdd = ^{
            FJTrainVC * vc = [FJTrainVC new];
            vc.blockBack = ^(UIViewController *item) {
                [weakSelf requestList];
            };
            vc.modelResumeDetail = weakSelf.modelDetail;
            [GB_Nav pushViewController:vc animated:true];
        };
        _trainView.blockDelete = ^(ModelJFTrainexperience * modelSub) {
            [GlobalMethod showEditAlertWithTitle:@"提示" content:@"确定删除培训经历" dismiss:nil confirm:^{
                [weakSelf requestDeleteTrain:modelSub];
            } view:weakSelf.view];
        };
        _trainView.blockEdit  = ^(ModelJFTrainexperience * modelSub) {
            FJTrainVC * vc = [FJTrainVC new];
            vc.modelResumeDetail = weakSelf.modelDetail;
            vc.modelTrainExp = modelSub;
            vc.blockBack = ^(UIViewController *item) {
                [weakSelf requestList];
            };
            [GB_Nav pushViewController:vc animated:true];
        };
    }
    return _trainView;
}
- (FJResumeDetailProjectView *)projectView{
    if (!_projectView) {
        _projectView = [FJResumeDetailProjectView new];
        WEAKSELF
        _projectView.addView.blockAdd = ^{
            FJProjectVC * vc = [FJProjectVC new];
            vc.blockBack = ^(UIViewController *item) {
                [weakSelf requestList];
            };
            vc.modelResumeDetail = weakSelf.modelDetail;
            [GB_Nav pushViewController:vc animated:true];
        };
        _projectView.blockDelete = ^(ModelFJProjectExp * modelSub) {
            [GlobalMethod showEditAlertWithTitle:@"提示" content:@"确定删除项目经历" dismiss:nil confirm:^{
                [weakSelf requestDeleteProject:modelSub];
            } view:weakSelf.view];
        };
        _projectView.blockEdit  = ^(ModelFJProjectExp * modelSub) {
            FJProjectVC * vc = [FJProjectVC new];
            vc.modelResumeDetail = weakSelf.modelDetail;
            vc.modelProjectExp = modelSub;
            vc.blockBack = ^(UIViewController *item) {
                [weakSelf requestList];
            };
            [GB_Nav pushViewController:vc animated:true];
        };
    }
    return _projectView;
}
- (FJResumeDetailCredientView *)credientView{
    if (!_credientView) {
        _credientView = [FJResumeDetailCredientView new];
        WEAKSELF
        _credientView.addView.blockAdd = ^{
            FJCertificationVC  * vc = [FJCertificationVC new];
            vc.blockBack = ^(UIViewController *item) {
                [weakSelf requestList];
            };
            vc.modelResumeDetail = weakSelf.modelDetail;
            [GB_Nav pushViewController:vc animated:true];
        };
        _credientView.blockDelete = ^(ModelFJCredentExp * modelSub) {
            [GlobalMethod showEditAlertWithTitle:@"提示" content:@"确定删证书" dismiss:nil confirm:^{
                [weakSelf requestDeleteCredient:modelSub];
            } view:weakSelf.view];
        };
        _credientView.blockEdit  = ^(ModelFJCredentExp * modelSub) {
            FJCertificationVC * vc = [FJCertificationVC new];
            vc.modelResumeDetail = weakSelf.modelDetail;
            vc.modelCredientExp = modelSub;
            vc.blockBack = ^(UIViewController *item) {
                [weakSelf requestList];
            };
            [GB_Nav pushViewController:vc animated:true];
        };
    }
    return _credientView;
}
- (FJResumeDetailLanguageView *)languageView{
    if (!_languageView) {
        _languageView = [FJResumeDetailLanguageView new];
        WEAKSELF
        _languageView.addView.blockAdd = ^{
            FJLaguageVC * vc = [FJLaguageVC new];
            vc.blockBack = ^(UIViewController *item) {
                [weakSelf requestList];
            };
            vc.modelResumeDetail = weakSelf.modelDetail;
            [GB_Nav pushViewController:vc animated:true];
        };
        _languageView.blockDelete = ^(ModelFJLanguageExp * modelSub) {
            [GlobalMethod showEditAlertWithTitle:@"提示" content:@"确定删除语言能力" dismiss:nil confirm:^{
                [weakSelf requestDeleteLanguage:modelSub];
            } view:weakSelf.view];
        };
        _languageView.blockEdit  = ^(ModelFJLanguageExp * modelSub) {
            FJLaguageVC * vc = [FJLaguageVC new];
            vc.modelResumeDetail = weakSelf.modelDetail;
            vc.modelLaguangeExp = modelSub;
            vc.blockBack = ^(UIViewController *item) {
                [weakSelf requestList];
            };
            [GB_Nav pushViewController:vc animated:true];
        };
    }
    return _languageView;
}
- (FJResumeDetailIntroduceView *)introduceView{
    if (!_introduceView) {
        _introduceView = [FJResumeDetailIntroduceView new];
        WEAKSELF
        _introduceView.addView.blockAdd = ^{
            ResumeSelfIntroduceVC * vc = [ResumeSelfIntroduceVC new];
            vc.blockBack = ^(UIViewController *item) {
                [weakSelf requestList];
            };
            vc.modelResumeDetail = weakSelf.modelDetail;
            [GB_Nav pushViewController:vc animated:true];
        };
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
    self.tableView.height = SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT - self.viewBottom.height;
    self.viewBottom.bottom = SCREEN_HEIGHT;
    [self.view addSubview:self.viewBottom];
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
    
}
#pragma mark 添加导航栏
- (void)addNav{
    [self.view addSubview:[BaseNavView initNavBackTitle:@"我的简历" rightView:nil]];
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

- (void)requestDeleteEducation:(ModelFJEducation *)modelSub{
    [RequestApi requestFJDeletepid:self.modelDetail.iDProperty.doubleValue identity:modelSub.iDProperty.doubleValue type:@"ResumeEducation" delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        [GlobalMethod showAlert:@"删除成功"];
        [self requestList];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
- (void)requestDeleteWork:(ModelFJWorkExperience *)modelSub{
    
    [RequestApi requestFJDeletepid:self.modelDetail.iDProperty.doubleValue identity:modelSub.iDProperty.doubleValue type:@"ResumeWork" delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        [GlobalMethod showAlert:@"删除成功"];
        [self requestList];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
- (void)requestDeleteTrain:(ModelJFTrainexperience *)modelSub{
    [RequestApi requestFJDeletepid:self.modelDetail.iDProperty.doubleValue identity:modelSub.iDProperty.doubleValue type:@"ResumeTraining" delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        [GlobalMethod showAlert:@"删除成功"];
        [self requestList];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
- (void)requestDeleteProject:(ModelFJProjectExp *)modelSub{
    [RequestApi requestFJDeletepid:self.modelDetail.iDProperty.doubleValue identity:modelSub.iDProperty.doubleValue type:@"ResumeProject" delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        [GlobalMethod showAlert:@"删除成功"];
        [self requestList];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
- (void)requestDeleteLanguage:(ModelFJLanguageExp *)modelSub{
    [RequestApi requestFJDeletepid:self.modelDetail.iDProperty.doubleValue identity:modelSub.iDProperty.doubleValue type:@"ResumeLanguage" delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        [GlobalMethod showAlert:@"删除成功"];
        [self requestList];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
- (void)requestDeleteCredient:(ModelFJCredentExp *)modelSub{
    [RequestApi requestFJDeletepid:self.modelDetail.iDProperty.doubleValue identity:modelSub.iDProperty.doubleValue type:@"ResumeCredent" delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        [GlobalMethod showAlert:@"删除成功"];
        [self requestList];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
@end
