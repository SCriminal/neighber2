//
//  CertificateDealListVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/5/20.
//Copyright © 2020 ping. All rights reserved.
//

#import "CertificateDealListVC.h"
#import "CertificateDealDetailVC.h"
//request
#import "RequestApi+Neighbor.h"
#import "CertificateDealDetailVC.h"
@interface CertificateDealListVC ()

@end

@implementation CertificateDealListVC
#pragma mark noresult view
@synthesize noResultView = _noResultView;
- (BOOL)isShowNoResult{
    return true;
}
- (NoResultView *)noResultView{
    if (!_noResultView) {
        _noResultView = [NoResultView new];
        [_noResultView resetWithImageName:@"empty_default" title:@"暂无可办理项目"];
    }
    return _noResultView;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    //table
    [self.tableView registerClass:[CertificateDealListCell class] forCellReuseIdentifier:@"CertificateDealListCell"];
    [self addRefreshHeader];
    //request
    [self requestList];
}

#pragma mark 添加导航栏
- (void)addNav{
    [self.view addSubview:[BaseNavView initNavBackTitle:self.navTitle rightView:nil]];
}

#pragma mark UITableViewDelegate
//row num
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    ModelCertificateDealCategory * model = self.aryDatas[section];
    return model.list.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.aryDatas.count;
}
//cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CertificateDealListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CertificateDealListCell"];
    ModelCertificateDealCategory * model = self.aryDatas[indexPath.section];
    [cell resetCellWithModel:model.list[indexPath.row]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ModelCertificateDealCategory * model = self.aryDatas[indexPath.section];
    return [CertificateDealListCell fetchHeight:model.list[indexPath.row]];
}
//table header
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    CertificateDealListSectionView * sectionView = [CertificateDealListSectionView new];
    ModelCertificateDealCategory * model = self.aryDatas[section];
    [sectionView resetViewWithModel:model.categoryName];
    return  sectionView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return W(44);
}
//table footer
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ModelCertificateDealCategory * model = self.aryDatas[indexPath.section];
    CertificateDealDetailVC * vc = [CertificateDealDetailVC new];
    vc.modelItem = model.list[indexPath.row];
    [GB_Nav pushViewController:vc animated:true];
}
#pragma mark request
- (void)requestList{
    [RequestApi requestCertificateDealCategoryListWithCategoryalias:self.requestAlias areaId:[GlobalData sharedInstance].community.iDProperty page:1 count:5000 delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        NSMutableArray  * aryRequest = [GlobalMethod exchangeDic:response toAryWithModelName:@"ModelCertificateDealCategory"];
                    
        [self.aryDatas removeAllObjects];
        [self.aryDatas addObjectsFromArray:aryRequest];
        [self.tableView reloadData];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
@end

