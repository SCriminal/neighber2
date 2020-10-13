//
//  PartyMapVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/6/30.
//Copyright © 2020 ping. All rights reserved.
//

#import "PartyMapVC.h"

#import "BaseVC+Location.h"
#import "PartyMapView.h"
#import "PartySearchListVC.h"
//request
#import "RequestApi+Neighbor.h"
@interface PartyMapVC ()<MAMapViewDelegate,NSURLSessionDelegate>
//地图
@property (nonatomic,strong) MAMapView *mapView;
@property (nonatomic, strong) NSMutableArray *aryDatas;
@property (nonatomic, strong) PartyMapJumpSearchView *searchView;
@property (nonatomic, strong) CustomAnnotation *annotationSelected;
@property (nonatomic, strong) PartySearchBottomView *bottomView;

@end

@implementation PartyMapVC
- (PartySearchBottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [PartySearchBottomView new];
        _bottomView.bottom = SCREEN_HEIGHT;
    }
    return _bottomView;
}
- (PartyMapJumpSearchView *)searchView{
    if (!_searchView) {
        _searchView = [PartyMapJumpSearchView new];
        WEAKSELF
        _searchView.blockSearchClick = ^{
            PartySearchListVC * searchList = [PartySearchListVC new];
            searchList.blockSelected = ^(ModelParty *item) {
                [weakSelf selecteModel:item];
            };
            [GB_Nav pushViewController:searchList animated:true];
        };
    }
    return _searchView;
}
- (MAMapView *)mapView{
    if (!_mapView) {
        _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _mapView.showsCompass= NO; // 设置成NO表示关闭指南针；YES表示显示指南针
        _mapView.showsScale= NO;
        _mapView.delegate = self;
        ///如果您需要进入地图就显示定位小蓝点，则需要下面两行代码
        _mapView.rotateEnabled = false;
        _mapView.rotateCameraEnabled = false;
        _mapView.showsUserLocation = true;
        [_mapView setZoomLevel:MAPZOOMNUM animated:true];
        _mapView.userTrackingMode = MAUserTrackingModeNone;
    }
    return _mapView;
}
- (NSMutableArray *)aryDatas{
    if (!_aryDatas) {
        _aryDatas = [NSMutableArray new];
    }
    return _aryDatas;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(requestList) name:NOTICE_LOCATION_CHANGE object:nil];
    //添加导航栏
    [self.view addSubview:self.mapView];
    [self addNav];
    [self requestList];
}

#pragma mark 添加导航栏
- (void)addNav{
    [self.view addSubview:self.searchView];
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAUserLocation class]]) {
        return nil;
    }
    if ([annotation isKindOfClass:[CustomAnnotation class]])
    {
        static NSString *reuseIndetifier = @"annotationReuseIndetifier";
        MAAnnotationView *annotationView =  [mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIndetifier];
            // 设置为NO，用以调用自定义的calloutView
            annotationView.canShowCallout = NO;
        }
        annotationView.image =  [UIImage imageNamed:@"annotationParty"];
        if (annotation == self.annotationSelected) {
            annotationView.image =  [UIImage imageNamed:@"annotationPartySelected"];
        }
        
        // 设置中心点偏移，使得标注底部中间点成为经纬度对应点
        //        annotationView.centerOffset = CGPointMake(0, -18);
        return annotationView;
    }
    return nil;
}

- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view{
    if ([view.annotation isKindOfClass:[CustomAnnotation class]]){
        CustomAnnotation * customAnnotation = view.annotation;
        [self selecteModel:customAnnotation.model];
    }
}
- (void)selecteModel:(ModelParty *)modelSelect{
    MAAnnotationView * viewBefore = [self.mapView viewForAnnotation:self.annotationSelected];
               viewBefore.image = [UIImage imageNamed:@"annotationParty"];
    
    [self.bottomView resetViewWithModel:modelSelect];
    [self.view addSubview:self.bottomView];
    self.bottomView.bottom = SCREEN_HEIGHT;

    [self.mapView setCenterCoordinate:CLLocationCoordinate2DMake(modelSelect.lat, modelSelect.lng) animated:true];

    BOOL isAryElement = false;
    for (CustomAnnotation * customItem in self.aryDatas) {
        if (customItem.model.iDProperty == modelSelect.iDProperty) {
           MAAnnotationView * annoatationView = [self.mapView viewForAnnotation:customItem];
            annoatationView.image =[UIImage imageNamed:@"annotationPartySelected"];
            isAryElement = true;
            self.annotationSelected = customItem;
            break;
        }
    }
    
    if (isAryElement == false) {
        CustomAnnotation *pointAnnotation = [CustomAnnotation new];
        pointAnnotation.coordinate = CLLocationCoordinate2DMake(modelSelect.lat, modelSelect.lng);
        [self.mapView addAnnotation:pointAnnotation];
        [self.aryDatas addObject:pointAnnotation];
        pointAnnotation.model = modelSelect;
        self.annotationSelected = pointAnnotation;
    }
        
}

#pragma mark request
- (void)requestList{
    ModelAddress * model = [GlobalMethod readModelForKey:LOCAL_LOCATION  modelName:@"ModelAddress" exchange:false];
//    model.lat = 39;
//    model.lng = 116;
    if (model.lat) {
        [RequestApi requestPartyListWithLat:model.lat lng:model.lng radius:0 name:nil page:1 count:5000 delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
            NSArray * aryResponse = [GlobalMethod exchangeDic:[response arrayValueForKey:@"list"] toAryWithModelName:@"ModelParty"];
            
            [self.mapView removeAnnotations:self.aryDatas];
            [self.aryDatas removeAllObjects];
            for (ModelParty * item in aryResponse) {
                CustomAnnotation *pointAnnotation = [CustomAnnotation new];
                pointAnnotation.coordinate = CLLocationCoordinate2DMake(item.lat, item.lng);
                [self.mapView addAnnotation:pointAnnotation];
                [self.aryDatas addObject:pointAnnotation];
                pointAnnotation.model = item;
            }
            [self.mapView setCenterCoordinate:CLLocationCoordinate2DMake(model.lat, model.lng) animated:false];
        } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
            
        }];
    }else{
        [self addLocalAuthorityListen];
    }
}


@end


@implementation CustomAnnotation


@end

