//
//  EHomeWaitPayListVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/9/30.
//Copyright © 2020 ping. All rights reserved.
//

#import "EHomeWaitPayListVC.h"
#import "EHomeWaitPayView.h"
#import "RequestApi+Neighbor.h"
#import "RequestApi+EHomePay.h"
#import "EHomePayOrderVC.h"

@interface EHomeWaitPayListVC ()
@property (nonatomic, strong) EHomeWaitPayBottomView *bottomView;

@end

@implementation EHomeWaitPayListVC
#pragma mark noresult view
@synthesize noResultView = _noResultView;
- (BOOL)isShowNoResult{
    return true;
}
- (NoResultView *)noResultView{
    if (!_noResultView) {
        _noResultView = [NoResultView new];
        [_noResultView resetWithImageName:@"empty_trolley" title:@"暂无待付账单"];
    }
    return _noResultView;
}

- (EHomeWaitPayBottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [EHomeWaitPayBottomView new];
        _bottomView.bottom = SCREEN_HEIGHT;
        WEAKSELF
        _bottomView.blockSelectAll = ^(BOOL selectAll) {
            for (ModelEHomeWaitPayList * item in weakSelf.aryDatas) {
                item.selected = selectAll;
            }
            [weakSelf.bottomView resetViewWithModel:weakSelf.aryDatas];
            [weakSelf.tableView reloadData];
        };
        _bottomView.blockSubmitClick = ^{
            for (ModelEHomeWaitPayList * item in weakSelf.aryDatas) {
                if (item.selected) {
                    [weakSelf requestPay];
                    return;
                }
            }
            [GlobalMethod showAlert:@"请选择缴费项目"];
            
        };
    }
    return _bottomView;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    [self.view addSubview:self.bottomView];
    self.tableView.height = SCREEN_HEIGHT - self.bottomView.height - NAVIGATIONBAR_HEIGHT;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, W(20), 0);
    //table
    [self.tableView registerClass:[EHomeWaitPayCell class] forCellReuseIdentifier:@"EHomeWaitPayCell"];
    //    self.tableView.backgroundColor = COLOR_GRAY;
    //request
    [self requestList];
}

#pragma mark 添加导航栏
- (void)addNav{
    [self.view addSubview:[BaseNavView initNavBackTitle:@"待付账单" rightTitle:@"历史查询" rightBlock:^{
        [GB_Nav pushVCName:@"EHomePayHistoryListVC" animated:true];

    }]];
}

#pragma mark UITableViewDelegate
//row num
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.aryDatas.count;
}
//cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    EHomeWaitPayCell * cell = [tableView dequeueReusableCellWithIdentifier:@"EHomeWaitPayCell"];
    [cell resetCellWithModel:self.aryDatas[indexPath.row]];
    WEAKSELF
    cell.blockSelected  = ^(ModelEHomeWaitPayList *item) {
        [weakSelf.bottomView resetViewWithModel:weakSelf.aryDatas];
    };
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [EHomeWaitPayCell fetchHeight:self.aryDatas[indexPath.row]];
}


#pragma mark request
- (void)requestList{
    [RequestApi requestEHomeWaitPayListWithtelephone:[GlobalData sharedInstance].GB_UserModel.phone roomId:[GlobalData sharedInstance].modelEHomeArchive.ehomeRoomId delegate:nil success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        //        ModelEhomeWaitPayInfo * model = [ModelEhomeWaitPayInfo modelObjectWithDictionary:response];
        self.aryDatas = [GlobalMethod exchangeDic:response toAryWithModelName:@"ModelEHomeWaitPayList"];
        [self.bottomView resetViewWithModel:self.aryDatas];
        [self.tableView reloadData];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
- (void)requestPay{
    EHomePayOrderVC * vc = [EHomePayOrderVC new];
    WEAKSELF
    vc.blockBack = ^(UIViewController *item) {
        [weakSelf requestList];
    };
    [vc.aryDatas removeAllObjects];
    for (ModelEHomeWaitPayList * item in weakSelf.aryDatas) {
        if (item.selected) {
            [vc.aryDatas addObject:item];
        }
    }
    [GB_Nav pushViewController:vc animated:true];
}

@end
