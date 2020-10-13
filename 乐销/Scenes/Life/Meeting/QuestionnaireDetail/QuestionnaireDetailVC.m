//
//  QuestionnaireDetailVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/4/10.
//Copyright © 2020 ping. All rights reserved.
//

#import "QuestionnaireDetailVC.h"
//request
#import "RequestApi+Neighbor.h"
//
#import "QuestionnaireDetailTopView.h"
#import "QuestionnaireDetailVoteView.h"
//yellow btn
#import "YellowButton.h"
//create archive
#import "CreateArchiveVC.h"
//select archive view
#import "SelectArchiveAlertView.h"

@interface QuestionnaireDetailVC ()
@property (nonatomic, strong) ModelQuestionnairDetail *modelDetail;
@property (nonatomic, strong) QuestionnaireDetailTopView *topView;
@property (nonatomic, strong) QuestionnaireDetailVoteView *voteView;
@property (nonatomic, strong) YellowButton *btnBottom;
@property (nonatomic, strong) NSArray *aryAchives;

@end

@implementation QuestionnaireDetailVC
- (YellowButton *)btnBottom{
    if (!_btnBottom) {
        _btnBottom = [YellowButton new];
        [_btnBottom resetViewWithWidth:W(335) :W(45) :@"提交"];
        _btnBottom.centerXBottom = XY(SCREEN_WIDTH/2.0, SCREEN_HEIGHT - W(25)-iphoneXBottomInterval);
        WEAKSELF
        _btnBottom.blockClick = ^{
            [weakSelf requestArchiveList];
        };
    }
    return _btnBottom;
}

- (QuestionnaireDetailVoteView *)voteView{
    if (!_voteView) {
        _voteView = [QuestionnaireDetailVoteView new];
    }
    return _voteView;
}
- (QuestionnaireDetailTopView *)topView{
    if (!_topView) {
        _topView = [QuestionnaireDetailTopView new];
    }
    return _topView;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    //table
//    [self.tableView registerClass:[<#CellName#> class] forCellReuseIdentifier:@"<#CellName#>"];
    self.tableView.height = self.btnBottom.top - W(15) - NAVIGATIONBAR_HEIGHT;
    [self.view addSubview:self.btnBottom];

    //request
    [self requestList];
}

#pragma mark 添加导航栏
- (void)addNav{
    [self.view addSubview:[BaseNavView initNavBackTitle:@"议事厅" rightView:nil]];
}

#pragma mark request
- (void)requestList{
    [RequestApi requestQuestionairDetailWithId:self.modelList.iDProperty delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        ModelQuestionnairDetail * modelDetail = [ModelQuestionnairDetail modelObjectWithDictionary:response];
        self.modelDetail = modelDetail;
        if (self.modelDetail.isParticipant) {
            [self.btnBottom resetWhiteViewWithWidth:W(335) :W(45) :@"已提交"];
        }
        
        [self.topView resetViewWithModel:self.modelDetail];
        self.tableView.tableHeaderView = self.topView;
        
        [self.voteView resetViewWithModel:self.modelDetail];
        self.tableView.tableFooterView = self.voteView;

    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
- (void)requestParticipate:(ModelArchiveList *)modelArchive{
    
    [RequestApi requestParticipateQuestionairWithArchiveid:modelArchive.iDProperty content:[GlobalMethod exchangeModelsToJson:self.modelDetail.content ] id:self.modelDetail.iDProperty delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        [GlobalMethod showAlert:@"提交成功"];
        [self refreshHeaderAll];

    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
    
}
- (void)requestArchiveList{
    for (ModelQuestionnairDetailContent * content in self.modelDetail.content) {
        [content exchangeValue];
        if (isStr([content judgeRequirement])) {
            [GlobalMethod showAlert:[content judgeRequirement]];
            return;
        }
    }
    [RequestApi requestArchiveListWithPage:1 count:500 estateId:[GlobalData sharedInstance].community.iDProperty delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        NSMutableArray * aryResponse = [GlobalMethod exchangeDic:[response arrayValueForKey:@"list"] toAryWithModelName:@"ModelArchiveList"];
        self.aryAchives = aryResponse;
        if (aryResponse.count == 0) {
           [GlobalMethod showEditAlertWithTitle:@"提示" content:@"请先创建档案，才可以提交" dismiss:^{

           } confirm:^{
                CreateArchiveVC * vc = [CreateArchiveVC new];
                
                [GB_Nav pushViewController:vc animated:true];
            } view:self.view];
        }else if(self.aryAchives.count == 1){
            [self requestParticipate:self.aryAchives.lastObject];
        }else{
            NSMutableArray * aryStr = [NSMutableArray new];
            for (ModelArchiveList * modelArchive in self.aryAchives) {
                [aryStr addObject:[NSString stringWithFormat:@"%@号楼%@单元%@",UnPackStr(modelArchive.buildingName),UnPackStr(modelArchive.unitName),UnPackStr(modelArchive.roomName)]];
            }
            WEAKSELF
            SelectArchiveAlertView * selectView = [SelectArchiveAlertView new];
            [selectView showWithAry:self.aryAchives];
            selectView.blockComplete = ^(ModelArchiveList *modelArchive) {
                [weakSelf requestParticipate:modelArchive];
            };
        }
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}

@end
