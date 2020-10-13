//
//  ModelIntegralOrder.m
//
//  Created by 林栋 隋 on 2020/4/28
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import "ModelIntegralOrder.h"


NSString *const kModelIntegralOrderReply = @"reply";
NSString *const kModelIntegralOrderSkuScore = @"skuScore";
NSString *const kModelIntegralOrderSkuId = @"skuId";
NSString *const kModelIntegralOrderContactPhone = @"contactPhone";
NSString *const kModelIntegralOrderSkuName = @"skuName";
NSString *const kModelIntegralOrderScore = @"score";
NSString *const kModelIntegralOrderLng = @"lng";
NSString *const kModelIntegralOrderSkuCoverUrl = @"skuCoverUrl";
NSString *const kModelIntegralOrderContact = @"contact";
NSString *const kModelIntegralOrderCountyId = @"countyId";
NSString *const kModelIntegralOrderNumber = @"number";
NSString *const kModelIntegralOrderCountyName = @"countyName";
NSString *const kModelIntegralOrderAddrId = @"addrId";
NSString *const kModelIntegralOrderQty = @"qty";
NSString *const kModelIntegralOrderAddrDetail = @"addrDetail";
NSString *const kModelIntegralOrderProvinceId = @"provinceId";
NSString *const kModelIntegralOrderCityId = @"cityId";
NSString *const kModelIntegralOrderProvinceName = @"provinceName";
NSString *const kModelIntegralOrderLat = @"lat";
NSString *const kModelIntegralOrderCreateTime = @"createTime";
NSString *const kModelIntegralOrderCityName = @"cityName";
NSString *const kModelIntegralOrderUserId = @"userId";


@interface ModelIntegralOrder ()
@end

@implementation ModelIntegralOrder

@synthesize reply = _reply;
@synthesize skuScore = _skuScore;
@synthesize skuId = _skuId;
@synthesize contactPhone = _contactPhone;
@synthesize skuName = _skuName;
@synthesize score = _score;
@synthesize lng = _lng;
@synthesize skuCoverUrl = _skuCoverUrl;
@synthesize contact = _contact;
@synthesize countyId = _countyId;
@synthesize countyName = _countyName;
@synthesize addrId = _addrId;
@synthesize qty = _qty;
@synthesize addrDetail = _addrDetail;
@synthesize provinceId = _provinceId;
@synthesize cityId = _cityId;
@synthesize provinceName = _provinceName;
@synthesize lat = _lat;
@synthesize createTime = _createTime;
@synthesize cityName = _cityName;
@synthesize userId = _userId;


#pragma mark init
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.reply = [dict stringValueForKey:kModelIntegralOrderReply];
            self.skuScore = [dict doubleValueForKey:kModelIntegralOrderSkuScore];
            self.skuId = [dict doubleValueForKey:kModelIntegralOrderSkuId];
            self.contactPhone = [dict stringValueForKey:kModelIntegralOrderContactPhone];
            self.skuName = [dict stringValueForKey:kModelIntegralOrderSkuName];
            self.score = [dict doubleValueForKey:kModelIntegralOrderScore];
            self.lng = [dict doubleValueForKey:kModelIntegralOrderLng];
            self.skuCoverUrl = [dict stringValueForKey:kModelIntegralOrderSkuCoverUrl];
            self.contact = [dict stringValueForKey:kModelIntegralOrderContact];
            self.countyId = [dict doubleValueForKey:kModelIntegralOrderCountyId];
            self.number = [dict stringValueForKey:kModelIntegralOrderNumber];
            self.countyName = [dict stringValueForKey:kModelIntegralOrderCountyName];
            self.addrId = [dict doubleValueForKey:kModelIntegralOrderAddrId];
            self.qty = [dict doubleValueForKey:kModelIntegralOrderQty];
            self.addrDetail = [dict stringValueForKey:kModelIntegralOrderAddrDetail];
            self.provinceId = [dict doubleValueForKey:kModelIntegralOrderProvinceId];
            self.cityId = [dict doubleValueForKey:kModelIntegralOrderCityId];
            self.provinceName = [dict stringValueForKey:kModelIntegralOrderProvinceName];
            self.lat = [dict doubleValueForKey:kModelIntegralOrderLat];
            self.createTime = [dict doubleValueForKey:kModelIntegralOrderCreateTime];
            self.cityName = [dict stringValueForKey:kModelIntegralOrderCityName];
            self.userId = [dict doubleValueForKey:kModelIntegralOrderUserId];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.reply forKey:kModelIntegralOrderReply];
    [mutableDict setValue:[NSNumber numberWithDouble:self.skuScore] forKey:kModelIntegralOrderSkuScore];
    [mutableDict setValue:[NSNumber numberWithDouble:self.skuId] forKey:kModelIntegralOrderSkuId];
    [mutableDict setValue:self.contactPhone forKey:kModelIntegralOrderContactPhone];
    [mutableDict setValue:self.skuName forKey:kModelIntegralOrderSkuName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.score] forKey:kModelIntegralOrderScore];
    [mutableDict setValue:[NSNumber numberWithDouble:self.lng] forKey:kModelIntegralOrderLng];
    [mutableDict setValue:self.skuCoverUrl forKey:kModelIntegralOrderSkuCoverUrl];
    [mutableDict setValue:self.contact forKey:kModelIntegralOrderContact];
    [mutableDict setValue:[NSNumber numberWithDouble:self.countyId] forKey:kModelIntegralOrderCountyId];
    [mutableDict setValue:self.number forKey:kModelIntegralOrderNumber];
    [mutableDict setValue:self.countyName forKey:kModelIntegralOrderCountyName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.addrId] forKey:kModelIntegralOrderAddrId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.qty] forKey:kModelIntegralOrderQty];
    [mutableDict setValue:self.addrDetail forKey:kModelIntegralOrderAddrDetail];
    [mutableDict setValue:[NSNumber numberWithDouble:self.provinceId] forKey:kModelIntegralOrderProvinceId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.cityId] forKey:kModelIntegralOrderCityId];
    [mutableDict setValue:self.provinceName forKey:kModelIntegralOrderProvinceName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.lat] forKey:kModelIntegralOrderLat];
    [mutableDict setValue:[NSNumber numberWithDouble:self.createTime] forKey:kModelIntegralOrderCreateTime];
    [mutableDict setValue:self.cityName forKey:kModelIntegralOrderCityName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.userId] forKey:kModelIntegralOrderUserId];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
