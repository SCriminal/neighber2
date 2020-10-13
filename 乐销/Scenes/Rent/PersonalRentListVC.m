//
//  PersonalRentListVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/21.
//Copyright © 2020 ping. All rights reserved.
//

#import "PersonalRentListVC.h"
//request
#import "RequestApi+Neighbor.h"
#import "PersonalRentListCell.h"
#import "CreateRentInfoVC.h"

@interface PersonalRentListVC ()

@end

@implementation PersonalRentListVC
#pragma mark noresult view
@synthesize noResultView = _noResultView;
- (BOOL)isShowNoResult{
    return true;
}
- (NoResultView *)noResultView{
    if (!_noResultView) {
        _noResultView = [NoResultView new];
        [_noResultView resetWithImageName:@"empty_rent" title:@"暂无房屋信息"];
    }
    return _noResultView;
}

#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    //table
    [self.tableView registerClass:[PersonalRentListCell class] forCellReuseIdentifier:@"PersonalRentListCell"];
    //request
    [self requestList];
    [self addRefreshHeader];
    [self addRefreshFooter];

}

#pragma mark 添加导航栏
- (void)addNav{
    [self.view addSubview:[BaseNavView initNavBackTitle:@"个人中心" rightView:nil]];
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
    PersonalRentListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"PersonalRentListCell"];
    [cell resetCellWithModel:self.aryDatas[indexPath.row]];
    WEAKSELF
    cell.blockUpDown = ^(ModelRentInfo *item) {
        [weakSelf requestUPDown:item];
    };
    cell.blockEdit = ^(ModelRentInfo *item) {
        [weakSelf jumpToEdit:item];
    };
    cell.blockDelete = ^(ModelRentInfo *item) {
        [weakSelf requestDelete:item];
    };
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [PersonalRentListCell fetchHeight:self.aryDatas[indexPath.row]];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self jumpToEdit:self.aryDatas[indexPath.row]];
}
- (void)jumpToEdit:(ModelRentInfo *)model{
    CreateRentInfoVC * vc = [CreateRentInfoVC new];
    WEAKSELF
    vc.modelList = model;
    vc.blockBack = ^(UIViewController *item) {
        if (item.requestState) {
            [weakSelf refreshHeaderAll];
        }
    };
    [GB_Nav pushViewController:vc animated:true];
}
#pragma mark request
- (void)requestList{
    [RequestApi requestRentPersonalListWithCount:50 areaId:[GlobalData sharedInstance].community.iDProperty scope:4 page:self.pageNum delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.pageNum ++;
        NSMutableArray  * aryRequest = [GlobalMethod exchangeDic:[response arrayValueForKey:@"list"] toAryWithModelName:@"ModelRentInfo"];
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
- (void)requestDelete:(ModelRentInfo *)item{
    [RequestApi requestRentCloseWithId:strDotF(item.iDProperty) scope:4 delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        [GlobalMethod showAlert:@"删除成功"];
        [self refreshHeaderAll];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}

- (void)requestUPDown:(ModelRentInfo *)item{
    //交易板状态 1提交 2审核中 11未通过 9已上架 21已下架 99关闭
    if (item.status == 9) {
        [RequestApi requestRentOutWithId:strDotF(item.iDProperty) scope:4 delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
            [GlobalMethod showAlert:@"下架成功"];
            [self refreshHeaderAll];

        } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
            
        }];
    }else if (item.status == 21){
        [RequestApi requestRentUploadWithId:strDotF(item.iDProperty) scope:4 delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
            [GlobalMethod showAlert:@"上架成功"];
            [self refreshHeaderAll];

        } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
            
        }];
    }
}
@end
