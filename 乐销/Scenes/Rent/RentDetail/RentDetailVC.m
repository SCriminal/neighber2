//
//  RentDetailVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/26.
//Copyright © 2020 ping. All rights reserved.
//

#import "RentDetailVC.h"
//request
#import "RequestApi+Neighbor.h"
#import "AutoScView.h"
#import "YellowButton.h"
#import "RentDetailView.h"

@interface RentDetailVC ()
@property (nonatomic, strong) BaseNavView *nav;
@property (nonatomic, strong) UIView *header;
@property (nonatomic, strong) ModelRentInfo *modelDetail;
@property (nonatomic, strong) AutoScView *autoSCView;
@property (nonatomic, strong) UIView *viewBottom;
@property (nonatomic, strong) RentDetailView *titleView;


@end

@implementation RentDetailVC
- (RentDetailView *)titleView{
    if (!_titleView) {
        _titleView = [RentDetailView new];
    }
    return _titleView;
}
- (UIView *)viewBottom{
    if (!_viewBottom) {
        _viewBottom = [UIView new];
        _viewBottom.backgroundColor = [UIColor clearColor];
        YellowButton *btn = [YellowButton new];
        [btn resetViewWithWidth:W(335) :W(45) :@"打电话"];
        WEAKSELF
        btn.blockClick = ^{
            if (isStr(weakSelf.modelDetail.contactPhone)) {
                 NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel://%@",weakSelf.modelDetail.contactPhone];
                           [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
            }else{
                [GlobalMethod showAlert:@"暂无联系电话"];
            }
           
        };
        btn.centerXTop = XY(SCREEN_WIDTH/2.0, W(15));
        [_viewBottom addSubview:btn];
        _viewBottom.widthHeight = XY(SCREEN_WIDTH, btn.bottom + W(15)+iphoneXBottomInterval);
        _viewBottom.bottom = SCREEN_HEIGHT;
    }
    return _viewBottom;
}
- (AutoScView *)autoSCView{
    if (!_autoSCView) {
        _autoSCView = [[AutoScView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, W(323)) image:@[]];
        _autoSCView.pageCurrentColor = [UIColor whiteColor];
        _autoSCView.pageDefaultColor = [UIColor colorWithHexString:@"ffffff" alpha:0.5];
//        _autoSCView.isClickValid = true;
    }
    return _autoSCView;
}
- (UIView *)header{
    if (!_header) {
        _header = [UIView new];
        _header.backgroundColor = [UIColor whiteColor];
    }
    return _header;
}
- (BaseNavView *)nav{
    if (!_nav) {
        _nav = [BaseNavView initNavTitle:@"" leftImageName:@"nav_black_back" leftImageSize:CGSizeMake(W(30), W(30)) leftBlock:^{
            [GB_Nav popViewControllerAnimated:true];
        } rightImageName:nil rightImageSize:CGSizeZero righBlock:nil];
        _nav.backgroundColor = [UIColor clearColor];
    }
    return _nav;
}

#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.viewBottom];
    //table
    self.tableView.top = 0;
    self.tableView.bounces = false;
    self.tableView.height = SCREEN_HEIGHT- self.viewBottom.height;

    [self requestList];
}

- (void)config{
    [self.header removeAllSubViews];
    [self.header addSubview:self.autoSCView];
    [self.header addSubview:self.nav];
    self.titleView.top = self.autoSCView.bottom - 15;
    [self.header addSubview:self.titleView];
    self.header.height = self.titleView.bottom;
    self.tableView.tableHeaderView = self.header;
    
}

#pragma mark request
- (void)requestList{
    [RequestApi requestRentDetailWithId:self.modelList.iDProperty scope:4 delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.modelDetail = [ModelRentInfo modelObjectWithDictionary:response];
        [self.autoSCView resetWithImageAry:self.modelDetail.urls];
        [self.titleView resetViewWithModel:self.modelDetail];
        [self config];
       
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];

}
@end
