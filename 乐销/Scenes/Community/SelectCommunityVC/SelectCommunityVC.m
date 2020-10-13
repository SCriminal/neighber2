//
//  SelectCommunityVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/12.
//Copyright © 2020 ping. All rights reserved.
//

#import "SelectCommunityVC.h"
#import "SelectCommunityView.h"
//request
#import "RequestApi+Neighbor.h"
//location
#import "BaseVC+Location.h"
//view
#import "SearchShopView.h"
#import "SelectCommunityCityVC.h"
@interface SelectCommunityVC ()
@property (nonatomic, strong) SearchShopNavView *searchView;
@property (nonatomic, strong) SelectCommunityTopView *selectView;
@end

@implementation SelectCommunityVC
- (SelectCommunityTopView *)selectView{
    if (!_selectView) {
        _selectView = [SelectCommunityTopView new];
        _selectView.top = self.searchView.bottom;
        WEAKSELF
        _selectView.blockManualClick = ^{
            SelectCommunityCityVC * vc = [SelectCommunityCityVC new];
            vc.blockSelectCommunity = weakSelf.blockSelectCommunity;
            [GB_Nav pushViewController:vc animated:true];
        };
    }
    return _selectView;
}
- (SearchShopNavView *)searchView{
    if (!_searchView) {
        _searchView = [SearchShopNavView new];
        _searchView.top = NAVIGATIONBAR_HEIGHT;
        _searchView.tfSearch.placeholder = @"请输入小区名称";
        WEAKSELF
        _searchView.blockSearch = ^(NSString *str) {
            [weakSelf refreshHeaderAll];
        };
    }
    return _searchView;
}

#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.searchView];
    [self.view addSubview:self.selectView];
    self.tableView.top = self.selectView.bottom;
    self.tableView.height = SCREEN_HEIGHT - self.selectView.bottom;
    //table
    [self.tableView registerClass:[SelectCommunityCell class] forCellReuseIdentifier:@"SelectCommunityCell"];
    //request
    [self addRefreshHeader];
    [self addNav];
    [self configLocation];
  
}
- (void)configLocation{
    [self fetchAddressFail];
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];

    switch (status) {
        case kCLAuthorizationStatusAuthorizedAlways: {
            [self initLocation];
        }
            break;
        case kCLAuthorizationStatusAuthorizedWhenInUse: {
            [self initLocation];
        }
            break;
        case kCLAuthorizationStatusNotDetermined: {
            [self addLocalAuthorityListen];
        }
            break;
        case kCLAuthorizationStatusDenied: {
        }
            break;
        case kCLAuthorizationStatusRestricted: {
        }
            break;
        default:
            break;
    }
}
- (void)addNav{
        [self.view addSubview:[BaseNavView initNavBackTitle:@"选择小区" rightView:nil]];
}
#pragma mark UITableViewDelegate
//row num
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.aryDatas.count;
}

//cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SelectCommunityCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SelectCommunityCell"];
    [cell resetCellWithModel:self.aryDatas[indexPath.row]];
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [SelectCommunityCell fetchHeight:self.aryDatas[indexPath.row]];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ModelCommunity * model = self.aryDatas[indexPath.row];
    if (self.blockSelectCommunity) {
        self.blockSelectCommunity(model);
        return;
    }
    [GlobalData sharedInstance].community = model;
    [GB_Nav popViewControllerAnimated:true];
}

#pragma mark request
- (void)requestList{
   
    ModelAddress * modelAddress = [GlobalMethod readModelForKey:LOCAL_LOCATION modelName:@"ModelAddress" exchange:false];

    [RequestApi requestSelectCommunityWithLng:modelAddress.lng lat:modelAddress.lat name:self.searchView.tfSearch.text scope:0 page:1 count:50 delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        NSMutableArray  * aryRequest = [GlobalMethod exchangeDic:[response arrayValueForKey:@"list"] toAryWithModelName:@"ModelCommunity"];
        self.aryDatas = aryRequest;
        if (self.aryDatas.count == 0) {
            [self.aryDatas addObject:^(){
                ModelCommunity * item = [ModelCommunity new];
                item.name = @"全国";
                item.iDProperty = 3;
                return item;
            }()];
        }
        [self.tableView reloadData];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}

- (void)fetchAddress:(ModelAddress *)clPlace{
//    [self requestCommunity:clPlace];
    [self requestList];

}
- (void)fetchAddressFail{
    [self requestList];
}
@end
