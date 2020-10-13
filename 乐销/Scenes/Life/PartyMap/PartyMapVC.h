//
//  PartyMapVC.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/6/30.
//Copyright © 2020 ping. All rights reserved.
//

#import "BaseVC.h"
//高德地图
#import <MAMapKit/MAMapView.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import <MAMapKit/MAPinAnnotationView.h>
#import <MAMapKit/MAPolyline.h>
#import <MAMapKit/MAPolylineRenderer.h>

@interface PartyMapVC : BaseVC

@end

@interface CustomAnnotation : MAPointAnnotation
@property (nonatomic, strong) ModelParty *model;

@end
