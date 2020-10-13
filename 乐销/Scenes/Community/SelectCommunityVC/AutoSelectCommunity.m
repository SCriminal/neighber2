//
//  AutoSelectCommunity.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/4/8.
//Copyright © 2020 ping. All rights reserved.
//

#import "AutoSelectCommunity.h"
#import <AMapLocationKit/AMapLocationKit.h>
//request
#import "RequestApi+Neighbor.h"
@interface AutoSelectCommunity()<AMapSearchDelegate,CLLocationManagerDelegate>
@property (nonatomic, strong) AMapLocationManager *locationManager;//获取地址
@property (nonatomic, assign) int numRepeat;//重复获取地理位置次数
@property (nonatomic, strong) CLLocationManager *manager;

@end

@implementation AutoSelectCommunity

SYNTHESIZE_SINGLETONE_FOR_CLASS(AutoSelectCommunity)
//auto select
- (void)autoSelectCommunity{
    [self requestList];
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
#pragma mark - 定位
- (void)addLocalAuthorityListen{
   self.manager = [[CLLocationManager alloc] init];
    self.manager.delegate= self;
    [self.manager requestWhenInUseAuthorization];
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status) {
        case kCLAuthorizationStatusAuthorizedAlways: {
//            NSLog(@"sld Always Authorized");
            [self initLocation];
        }
            break;
        case kCLAuthorizationStatusAuthorizedWhenInUse: {
//            NSLog(@"sldAuthorizedWhenInUse");
            [self initLocation];
        }
            break;
        case kCLAuthorizationStatusNotDetermined: {
//            NSLog(@"sldnot Determined");
        }
            break;
        case kCLAuthorizationStatusDenied: {
//            NSLog(@"sldDenied");
        }
            break;
        case kCLAuthorizationStatusRestricted: {
//            NSLog(@"sldRestricted");
        }
            break; default: break;
    }
    
}
- (void)initLocation
{
    if (!self.locationManager) {
        self.locationManager = [[AMapLocationManager alloc]init];
    }
    //带逆地理信息的一次定位（返回坐标和地址信息）
    //kCLLocationAccuracyHundredMeters，一次还不错的定位，偏差在百米左右，超时时间设置在2s-3s左右即可。
    //高精度：kCLLocationAccuracyBest，可以获取精度很高的一次定位，偏差在十米左右。
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    //定位超时时间，最低2s，此处设置为2s
    self.locationManager.locationTimeout = 2;
    //逆地理请求超时时间，最低2s，此处设置为2s
    self.locationManager.reGeocodeTimeout = 2;
    
    //带逆地理（返回坐标和地址信息）。将下面代码中的 YES 改成 NO ，则不会返回地址信息。
    WEAKSELF
    [self.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        STRONGSELF
        if (error)
        {
            NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
            if (error.code == AMapLocationErrorLocateFailed)
            {
                return;
            }
        }
        if (!regeocode && self.numRepeat < 3) {
            self.numRepeat ++;
            [self initLocation];
        }else{
            ModelAddress * modelAddress = [ModelAddress initWithAMapLocationReGeocode:regeocode location:location];
            [self fetchAddress:modelAddress];
        }
    }];
}

- (void)fetchAddress:(ModelAddress *)clPlace{
    [self requestList];
}
- (void)requestList{
   
    ModelAddress * modelAddress = [GlobalMethod readModelForKey:LOCAL_LOCATION modelName:@"ModelAddress" exchange:false];

    [RequestApi requestSelectCommunityWithLng:modelAddress.lng lat:modelAddress.lat name:@"" scope:0 page:1 count:50 delegate:nil success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        NSMutableArray  * aryRequest = [GlobalMethod exchangeDic:[response arrayValueForKey:@"list"] toAryWithModelName:@"ModelCommunity"];
        if (aryRequest.count) {
            ModelCommunity * model = aryRequest.firstObject;
            [GlobalData sharedInstance].community = model;
        }else{
            [GlobalData sharedInstance].community = ^(){
                ModelCommunity * item = [ModelCommunity new];
                item.name = @"全国";
                item.iDProperty = 3;
                return item;
            }();
        }
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
@end
