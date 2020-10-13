//
//  PersonalCenterVC.m
//  Motorcade
//
//  Created by 隋林栋 on 2019/5/9.
//Copyright © 2019 ping. All rights reserved.
//

#import "PersonalCenterVC.h"
//view
#import "PersonalCenterView.h"
//collection view
#import "ModuleCollectionView.h"
//section title
#import "SectionTitleView.h"
#import "JournalismListVC.h"
//request
#import "RequestApi+Neighbor.h"

@interface PersonalCenterVC ()
@property (nonatomic, strong) PersonalCenterTopView *topView;
@property (nonatomic, strong) UIView *tableHeaderView;
@property (nonatomic, strong) SectionTitleView *infoTitleView;
@property (nonatomic, strong) ModuleCollectionView *collection;

@end

@implementation PersonalCenterVC
@synthesize aryDatas = _aryDatas;

- (ModuleCollectionView *)collection{
    if (!_collection) {
        _collection = [ModuleCollectionView new];

    }
    return _collection;
}
- (PersonalCenterTopView *)topView{
    if (!_topView) {
        _topView = [PersonalCenterTopView new];
    }
    return _topView;
}
- (UIView *)tableHeaderView{
    if (!_tableHeaderView) {
        _tableHeaderView = [UIView new];
        _tableHeaderView.width = SCREEN_WIDTH;
        _tableHeaderView.backgroundColor = [UIColor clearColor];
    }
    return _tableHeaderView;
}
- (SectionTitleView *)infoTitleView{
    if (!_infoTitleView) {
        _infoTitleView = [SectionTitleView new];
        _infoTitleView.title.text = @"系统设置";
        _infoTitleView.arrowRight.hidden = true;
        _infoTitleView.more.hidden = true;
    }
    return _infoTitleView;
}
- (NSMutableArray *)aryDatas{
    if (!_aryDatas) {
        _aryDatas = @[^(){
            ModelBtn * model = [ModelBtn new];
            model.title = @"帮助中心";
            model.blockClick = ^{
                JournalismListVC * vc = [JournalismListVC new];
                vc.type = ENUM_NEWS_LIST_HELP;
                [GB_Nav pushViewController:vc animated:true];
            };
            return model;
        }(),^(){
            ModelBtn * model = [ModelBtn new];
            NSString *appName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
            model.title = [NSString stringWithFormat:@"关于%@",appName];
            model.blockClick = ^{
                JournalismListVC * vc = [JournalismListVC new];
                vc.type = ENUM_NEWS_LIST_ABOUT;
                [GB_Nav pushViewController:vc animated:true];
            };
            return model;
        }(),^(){
            ModelBtn * model = [ModelBtn new];
            model.title = @"设置";
            model.blockClick = ^{
                [GB_Nav pushVCName:@"SettingVC" animated:true];
            };
            return model;
        }()].mutableCopy;
    }
    return _aryDatas;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self reconfigView];
    //table
    
    self.tableView.top = 0;
    self.tableView.bounces = false;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, W(30), 0);
    self.tableView.height = SCREEN_HEIGHT - TABBAR_HEIGHT;
    [self.tableView registerClass:[PersonalCenterCell class] forCellReuseIdentifier:@"PersonalCenterCell"];
    //request
    [self requestList];
}
- (void)reconfigView{
    [self.tableHeaderView removeAllSubViews];
    
    [self.tableHeaderView addSubview:self.topView];
    
    CGFloat top = self.topView.bottom+W(2);
    if (self.collection.aryModel.count) {
        self.collection.top = top;
        [self.tableHeaderView addSubview:self.collection];
        top = self.collection.bottom+W(20);
    }
    self.infoTitleView.top = top;
    [self.tableHeaderView addSubview:self.infoTitleView];
    
    self.tableHeaderView.height = self.infoTitleView.bottom+W(14);
    self.tableView.tableHeaderView = self.tableHeaderView;
}


#pragma mark UITableViewDelegate
//row num
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.aryDatas.count;
}

//cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PersonalCenterCell * cell = [tableView dequeueReusableCellWithIdentifier:@"PersonalCenterCell"];
    [cell resetCellWithModel:self.aryDatas[indexPath.row]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [PersonalCenterCell fetchHeight:self.aryDatas[indexPath.row]];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ModelBtn *model =self.aryDatas[indexPath.row];
    if (model.blockClick) {
        model.blockClick();
    }
}
#pragma mark request
- (void)requestList{
    [RequestApi requestModuleWithLocationaliases:@"resident_person" areaId:[GlobalData sharedInstance].community.iDProperty delegate:nil success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        NSMutableArray * aryResponse = [GlobalMethod exchangeDic:[response arrayValueForKey:@"resident_person"] toAryWithModelName:@"ModelModule"];
        if (!isAry(aryResponse)) {
            return;
        }
        [self.collection resetWithAry:aryResponse];
        [self reconfigView];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
@end
