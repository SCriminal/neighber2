//
//  RentTabVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/21.
//Copyright © 2020 ping. All rights reserved.
//

#import "RentTabVC.h"
//sub view
#import "WhistleTabView.h"
//vc
#import "RentInfoListVC.h"
#import "CreateRentInfoVC.h"
#import "PersonalRentListVC.h"
@interface RentTabVC ()
@property (nonatomic, strong) WhistleTabView *tabView;
@property (nonatomic, strong) RentInfoListVC *infoListVC;
@property (nonatomic, strong) PersonalRentListVC *personalListVC;

@end

@implementation RentTabVC

- (RentInfoListVC *)infoListVC{
    if (!_infoListVC) {
        _infoListVC = [RentInfoListVC new];
        _infoListVC.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - self.tabView.height);
        _infoListVC.tableView.height = SCREEN_HEIGHT - _infoListVC.filterView.bottom - self.tabView.height;
        _infoListVC.view.hidden = false;
        _infoListVC.viewBG.hidden = true;
    }
    return _infoListVC;
}
- (PersonalRentListVC *)personalListVC{
    if (!_personalListVC) {
        _personalListVC = [PersonalRentListVC new];
        _personalListVC.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - self.tabView.height);
        _personalListVC.tableView.height = SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT - self.tabView.height;
        _personalListVC.view.hidden = true;
        _personalListVC.viewBG.hidden = true;
        
    }
    return _personalListVC;
}
- (WhistleTabView *)tabView{
    if (!_tabView) {
        _tabView = [WhistleTabView new];
        [_tabView resetWithAry:@[^(){
            ModelBtn * model = [ModelBtn new];
            model.imageName = @"rent_main_default";
            model.highImageName = @"rent_main_selected";
            model.title = @"信息";
            return model;
        }(),^(){
            ModelBtn * model = [ModelBtn new];
            model.imageName = @"rent_send_default";
            model.highImageName = @"rent_send_selectend";
            model.title = @"发布";
            return model;
        }(),^(){
            ModelBtn * model = [ModelBtn new];
            model.imageName = @"rent_personal_default";
            model.highImageName = @"rent_personal_selectend";
            model.title = @"管理";
            return model;
        }()]];
        _tabView.bottom = SCREEN_HEIGHT;
        WEAKSELF
        _tabView.blockSwitch = ^(NSInteger index) {
            [weakSelf selectIndex:index];
        };
    }
    return _tabView;
}
- (void)selectIndex:(NSInteger)index{
    static NSInteger indexBefore = 0;
    if (index == 1) {
        CreateRentInfoVC *createVC = [CreateRentInfoVC new];
        WEAKSELF
        createVC.blockBack = ^(UIViewController *item) {
            if (item.requestState) {
                [weakSelf.personalListVC refreshHeaderAll];
                [weakSelf.infoListVC refreshHeaderAll];
                [weakSelf.tabView selectIndex:0];
                [weakSelf selectIndex:0];
            }else{
                [weakSelf.tabView selectIndex:indexBefore];
                [weakSelf selectIndex:indexBefore];
            }
        };
        [GB_Nav pushViewController:createVC animated:true];
    }else{
        indexBefore = index;
        self.infoListVC.view.hidden = index !=0;
        self.personalListVC.view.hidden = index !=2;
    }
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tabView];
    [self addChildViewController:self.infoListVC];
    [self addChildViewController:self.personalListVC];
    [self.view addSubview:self.infoListVC.view];
    [self.view addSubview:self.personalListVC.view];
    
}


@end
