//
//  ActivityDetailVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/4/3.
//Copyright © 2020 ping. All rights reserved.
//

#import "ActivityDetailVC.h"
//sub view
#import "ActivityDetailView.h"
//request
#import "RequestApi+Neighbor.h"
//create archive
#import "CreateArchiveVC.h"
//select archive view
#import "SelectArchiveAlertView.h"
@interface ActivityDetailVC ()
@property (nonatomic, strong) ActivityDetailView *topView;
@property (nonatomic, strong) ActivityDetailBottomView *bottomView;
@property (nonatomic, strong) ModelActivity *modelDetail;
@property (nonatomic, strong) ActivityDetailWebView *webView;
@property (nonatomic, strong) NSArray *aryAchives;

@end

@implementation ActivityDetailVC
- (ActivityDetailWebView *)webView{
    if (!_webView) {
        _webView = [ActivityDetailWebView new];
        WEAKSELF
        _webView.blockWebRefresh = ^{
            [weakSelf.tableView reloadData];
        };
    }
    return _webView;
}
- (ActivityDetailView *)topView{
    if (!_topView) {
        _topView = [ActivityDetailView new];
    }
    return _topView;
}
- (ActivityDetailBottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [ActivityDetailBottomView new];
        WEAKSELF
        _bottomView.btnBottom.blockClick = ^{
            if (weakSelf.modelDetail.isParticipant) {
                return;
            }else{
                [weakSelf requestArchiveList];
            }
        };
    }
    return _bottomView;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    //table
//    [self.tableView registerClass:[<#CellName#> class] forCellReuseIdentifier:@"<#CellName#>"];
    //request
    [self requestList];
}

#pragma mark 添加导航栏
- (void)addNav{
    [self.view addSubview:[BaseNavView initNavBackTitle:@"社区活动" rightView:nil]];
}
#pragma mark table view
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return self.webView.height;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return self.webView;
}
#pragma mark request
- (void)requestList{
    [RequestApi requestActivityDetailWithId:self.modelList.iDProperty delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.modelDetail = [ModelActivity modelObjectWithDictionary:response];
        [self.topView resetViewWithModel:self.modelDetail];
        self.tableView.tableHeaderView = self.topView;
        [self.webView resetViewWithModel:self.modelDetail];

        if (self.modelDetail.eventType == 2) {
            [self requestAssociation];
        }else{
            [self.bottomView resetViewWithModel:self.modelDetail];
            self.tableView.tableFooterView = self.bottomView;
        }
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
    
}
- (void)requestAssociation{
    [RequestApi requestAssociationDetailWithId:self.modelDetail.teamId  delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        ModelAssociation * modelAssociation = [ModelAssociation modelObjectWithDictionary:response];
        self.bottomView.modelAssociation = modelAssociation;
        [self.bottomView resetViewWithModel:self.modelDetail];
        self.tableView.tableFooterView = self.bottomView;

    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
- (void)requestParticipate:(ModelArchiveList *)modelArchive{
    [RequestApi requestParticipateActivityWithEventid:self.modelDetail.iDProperty archiveId:modelArchive.iDProperty delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        [GlobalMethod showAlert:@"报名成功"];
        self.modelDetail.isParticipant = 1;
        [self.bottomView resetViewWithModel:self.modelDetail];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
- (void)requestArchiveList{
    [RequestApi requestArchiveListWithPage:1 count:500 estateId:[GlobalData sharedInstance].community.iDProperty delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        NSMutableArray * aryResponse = [GlobalMethod exchangeDic:[response arrayValueForKey:@"list"] toAryWithModelName:@"ModelArchiveList"];
        self.aryAchives = aryResponse;
        if (aryResponse.count == 0) {
           [GlobalMethod showEditAlertWithTitle:@"提示" content:@"请先创建档案，才可以报名" dismiss:^{

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
