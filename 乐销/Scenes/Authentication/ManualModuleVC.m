//
//  ManualModuleVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/8/10.
//Copyright © 2020 ping. All rights reserved.
//

#import "ManualModuleVC.h"
#import "ManualModuleCollectionView.h"
//request
#import "RequestApi+Neighbor.h"

#define MANUAL_MODEL_TITLE  @[@"我的应用",@"党建先锋",@"政务服务",@"社区服务",@"物业服务",@"公共服务",@"医疗养老",@"家政服务",@"安全服务"]
#define MANUAL_MODEL_ALIAS @[@"resident_party",@"resident_gov",@"resident_estate",@"resident_property",@"resident_public",@"resident_hospital",@"resident_housekeeping",@"resident_security"]


@interface ManualModuleVC ()
@property (nonatomic, strong) NSMutableArray *arySections;
@property (nonatomic, strong) NSMutableArray *aryCollections;
@property (nonatomic, strong) UIView *tableHeaderView;
@property (nonatomic, strong) NSArray *aryADs;
@property (nonatomic, strong) UIView *arrowView;
@property (nonatomic, strong) UIView *topTitleView;
@property (nonatomic, strong) ManualModuleCollectionView *collectionSelected;
@property (nonatomic, strong) NSMutableArray *arySelected;

@end

@implementation ManualModuleVC


#pragma mark lazy init
- (NSMutableArray *)arySections{
    if (!_arySections) {
        _arySections = [NSMutableArray new];
    }
    return _arySections;
}
- (NSMutableArray *)aryCollections{
    if (!_aryCollections) {
        _aryCollections = [NSMutableArray new];
    }
    return _aryCollections;
}
- (NSMutableArray *)arySelected{
    if (!_arySelected) {
        _arySelected = [NSMutableArray new];
    }
    return _arySelected;
}
- (UIView *)arrowView{
    if (!_arrowView) {
        _arrowView = [UIView new];
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        l.textColor = COLOR_333;
        l.backgroundColor = [UIColor clearColor];
        [l fitTitle:@"全部应用" variable:0];
        l.centerXTop = XY(SCREEN_WIDTH/2.0, W(0));
        [_arrowView addSubview:l];
        _arrowView.widthHeight = XY(SCREEN_WIDTH, l.bottom + W(20));
    }
    return _arrowView;
}
- (UIView *)topTitleView{
    if (!_topTitleView) {
        _topTitleView = [UIView new];
        _topTitleView.backgroundColor = [UIColor whiteColor];
        CGFloat top = 0;
        {
            UILabel * l = [UILabel new];
            l.font = [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
            l.textColor = COLOR_333;
            l.backgroundColor = [UIColor clearColor];
            [l fitTitle:@"你可以将常用的应用添加到潍社区首页" variable:0];
            l.centerXTop = XY(SCREEN_WIDTH/2.0, W(15));
            [_topTitleView addSubview:l];
            top = l.bottom;
        }
        {
            UILabel * l = [UILabel new];
            l.font = [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
            l.textColor = COLOR_333;
            l.backgroundColor = [UIColor clearColor];
            [l fitTitle:@"也可以按住拖动调整应用的顺序" variable:0];
            l.centerXTop = XY(SCREEN_WIDTH/2.0,top + W(6));
            [_topTitleView addSubview:l];
            top = l.bottom;
        }
        _topTitleView.widthHeight = XY(SCREEN_WIDTH, top + W(25));
    }
    return _topTitleView;
}
- (UIView *)tableHeaderView{
    if (!_tableHeaderView) {
        _tableHeaderView = [UIView new];
        _tableHeaderView.width = SCREEN_WIDTH;
        _tableHeaderView.backgroundColor = [UIColor clearColor];
    }
    return _tableHeaderView;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    [self configView];
    [self reconfigView];
    
    //request
    [self requestModule];
}
- (void)configView{
    WEAKSELF
    NSArray * aryTitles = MANUAL_MODEL_TITLE;
    for (NSString * title in aryTitles) {
        UIView * _section0 = [UIView new];
        _section0.width = SCREEN_WIDTH;
        UILabel * label = [UILabel new];
        label.textColor = COLOR_333;
        label.font = [UIFont systemFontOfSize:F(17) weight:UIFontWeightMedium];
        [label fitTitle:title variable:0];
        label.left = W(25);
        _section0.height = label.height;
        [_section0 addSubview:label];
        [self.arySections addObject:_section0];
        
        BOOL isFirst = [title isEqualToString:@"我的应用"];
        ManualModuleCollectionView * view = [[ManualModuleCollectionView alloc]initWithNum:5 isEditable:isFirst];
        view.blockModelClick = ^(ModelModule *modelModule, BOOL isEditable) {
            if(isEditable){
                [weakSelf deleteModel:modelModule];
            }else{
                [weakSelf addModel:modelModule];
            }
            [self exchangeModel];
        };
        view.isMyself = isFirst;
        if(isFirst){
            self.collectionSelected = view;
        }
        [self.aryCollections addObject:view];
    }
    
}
- (void)addModel:(ModelModule *)model{
    if([self.arySelected fetchSameModelKeyPath:@"iDProperty" model:model]){
        return;
    }
    [self.arySelected addObject:model];
    [self.collectionSelected resetWithAry:self.arySelected];
    [self reconfigView];
}
- (void)deleteModel:(ModelModule *)model{
    [self.arySelected removeObjectForKeyPath:@"iDProperty" object:model];
    [self.collectionSelected resetWithAry:self.arySelected];
    [self reconfigView];
}
- (void)reconfigView{
    [self.tableHeaderView removeAllSubViews];
    //auto sc
    [self.tableHeaderView addSubview:self.topTitleView];
    
    CGFloat top = self.topTitleView.bottom;
    for (int i = 0; i<self.aryCollections.count; i++) {
        ManualModuleCollectionView * collection = self.aryCollections[i];
        UIView * section = self.arySections[i];
        
        if (collection.isMyself) {
            collection.top = top;
//            [self.tableHeaderView addSubview:collection];
            top = collection.bottom ;
            self.arrowView.top = top ;
            [self.tableHeaderView addSubview:self.arrowView];
            top = self.arrowView.bottom;
            
            
        }else if(collection.aryModel.count){
            section.top = top;
            [self.tableHeaderView addSubview:section];
            
            collection.top = section.bottom+W(20);
            [self.tableHeaderView addSubview:collection];
            top = collection.bottom + W(25);
        }
    }
    [self.tableHeaderView addSubview:self.collectionSelected];

    self.tableHeaderView.height = top - W(11.5);
    self.tableView.tableHeaderView = self.tableHeaderView;
}
#pragma mark 添加导航栏
- (void)addNav{
    WEAKSELF
    [self.view addSubview:[BaseNavView initNavBackTitle:@"管理我的应用" rightTitle:@"完成" rightBlock:^{
        [weakSelf requestSubmit];
    }]];
}
#pragma mark request
- (void)requestModule{
    
    
    NSArray * aryAlias = MANUAL_MODEL_ALIAS;
    [RequestApi requestModuleWithLocationaliases:[aryAlias componentsJoinedByString:@","] areaId:[GlobalData sharedInstance].community.iDProperty delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        for (int i = 0; i<aryAlias.count; i++) {
            NSString * strAlias = aryAlias[i];
            ManualModuleCollectionView * collectionView = self.aryCollections[i+1];
            NSMutableArray * aryResponse = [GlobalMethod exchangeDic:[response arrayValueForKey:strAlias] toAryWithModelName:@"ModelModule"];
            if (isAry(aryResponse)) {
                [collectionView resetWithAry:aryResponse];
            }
        }
        [self reconfigView];
        [self requestSelfModule];

    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
- (void)requestSubmit{
    NSMutableArray * aryJson = [NSMutableArray new];
    int index = 1;
    for (ModelModule *model in self.collectionSelected.aryModel) {
        [aryJson addObject:@{@"sort":NSNumber.lon(index),@"id":NSNumber.lon(model.iDProperty)}];
        index ++;
    }
    [RequestApi requestCustomizePersonalModuleWithModules:[GlobalMethod exchangeDicToJson:aryJson] delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        [[NSNotificationCenter defaultCenter]postNotificationName:NOTICE_SELFMODEL_CHANGE object:nil];
        [GlobalMethod showAlert:@"保存成功"];
        [GB_Nav popViewControllerAnimated:true];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
- (void)requestSelfModule{
  
    [RequestApi requestPersonalModuleWithDelegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        NSMutableArray * aryResponse = [GlobalMethod exchangeDic:[response arrayValueForKey:@"list"] toAryWithModelName:@"ModelModule"];
        self.arySelected = aryResponse;
        [self.collectionSelected resetWithAry:self.arySelected];
        [self exchangeModel];
        [self reconfigView];

    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {

    }];
}
- (void)exchangeModel{
    NSArray * aryAlias = MANUAL_MODEL_ALIAS;
    for (int i = 0; i<aryAlias.count; i++) {
        ManualModuleCollectionView * collectionView = self.aryCollections[i+1];
        NSMutableArray * ary = [collectionView.aryModel fetchSameElementKeyPath:@"iDProperty" aryCompare:self.arySelected];
        for (ModelModule * item in collectionView.aryModel) {
            item.isSelected = false;
        }
        for (ModelModule * item in ary) {
            item.isSelected = true;
        }
        [collectionView.myCollectionView reloadData];
    }
}
@end
