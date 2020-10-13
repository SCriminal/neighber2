//
//  ModelOrderDetail.m
//
//  Created by 林栋 隋 on 2020/4/26
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import "ModelOrderDetail.h"


NSString *const kModelOrderDetailUserId = @"userId";
NSString *const kModelOrderDetailPayTime = @"payTime";
NSString *const kModelOrderDetailAddrContactPhone = @"addrContactPhone";
NSString *const kModelOrderDetailStatus = @"status";
NSString *const kModelOrderDetailStoreName = @"storeName";
NSString *const kModelOrderDetailAddrCountyName = @"addrCountyName";
NSString *const kModelOrderDetailAddrContact = @"addrContact";
NSString *const kModelOrderDetailPayMethod = @"payMethod";
NSString *const kModelOrderDetailAddrCountyId = @"addrCountyId";
NSString *const kModelOrderDetailAddrProvinceName = @"addrProvinceName";
NSString *const kModelOrderDetailMergeNumber = @"mergeNumber";
NSString *const kModelOrderDetailAddrLat = @"addrLat";
NSString *const kModelOrderDetailAddrLng = @"addrLng";
NSString *const kModelOrderDetailAnswer = @"answer";
NSString *const kModelOrderDetailStoreId = @"storeId";
NSString *const kModelOrderDetailAddrCityName = @"addrCityName";
NSString *const kModelOrderDetailAddrDetail = @"addrDetail";
NSString *const kModelOrderDetailAddrId = @"addrId";
NSString *const kModelOrderDetailAddrProvinceId = @"addrProvinceId";
NSString *const kModelOrderDetailAddrCityId = @"addrCityId";
NSString *const kModelOrderDetailNumber = @"number";
NSString *const kModelOrderDetailPayChannel = @"payChannel";
NSString *const kModelOrderDetailSkus = @"skus";
NSString *const kModelOrderDetailCreateTime = @"createTime";
NSString *const kModelOrderDetailPrice = @"price";
NSString *const kModelOrderDetailDescription = @"description";
NSString *const kModelOrderDetailCoverUrl = @"coverUrl";
NSString *const kModelOrderDetailTotalPrice = @"totalPrice";
NSString *const kModelOrderDetailFreightPrice = @"freightPrice";

@interface ModelOrderDetail ()
@property (nonatomic, assign) double status;

@end

@implementation ModelOrderDetail

@synthesize userId = _userId;
@synthesize payTime = _payTime;
@synthesize addrContactPhone = _addrContactPhone;
@synthesize status = _status;
@synthesize storeName = _storeName;
@synthesize addrCountyName = _addrCountyName;
@synthesize addrContact = _addrContact;
@synthesize payMethod = _payMethod;
@synthesize addrCountyId = _addrCountyId;
@synthesize addrProvinceName = _addrProvinceName;
@synthesize mergeNumber = _mergeNumber;
@synthesize addrLat = _addrLat;
@synthesize addrLng = _addrLng;
@synthesize answer = _answer;
@synthesize storeId = _storeId;
@synthesize addrCityName = _addrCityName;
@synthesize addrDetail = _addrDetail;
@synthesize addrId = _addrId;
@synthesize addrProvinceId = _addrProvinceId;
@synthesize addrCityId = _addrCityId;
@synthesize number = _number;
@synthesize payChannel = _payChannel;
@synthesize skus = _skus;
@synthesize createTime = _createTime;
@synthesize price = _price;
@synthesize internalBaseClassDescription = _internalBaseClassDescription;

- (NSString *)configStatusShow{
    switch (self.orderStatus) {
        case ENUM_ORDER_STATUS_SUBMIT:
            return @"等待买家付款";
            break;
            case ENUM_ORDER_STATUS_PAY:
            return @"买家已付款";
            break;
            case ENUM_ORDER_STATUS_SEND:
            return @"商家已发货";
            break;
            case ENUM_ORDER_STATUS_COMPLETE:
            return @"订单已完成";
            break;
            case ENUM_ORDER_STATUS_CLOSE:
            return @"订单已关闭";
            break;
        default:
            break;
    }
}
- (ENUM_ORDER_STATUS )configOrderStatus{
    ////1已下单 5已付款 7已发货 10已完成 99已关闭
    switch ((int)self.status) {
        case 1:
            return ENUM_ORDER_STATUS_SUBMIT;
            break;
        case 5:
            return ENUM_ORDER_STATUS_PAY;
            break;
        case 7:
            return ENUM_ORDER_STATUS_SEND;
            break;
        case 10:
            return ENUM_ORDER_STATUS_COMPLETE;
            break;
        case 99:
            return ENUM_ORDER_STATUS_CLOSE;
            break;
        default:
            break;
    }
    return ENUM_ORDER_STATUS_CLOSE;
    
}
#pragma mark init
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
        self.userId = [dict doubleValueForKey:kModelOrderDetailUserId];
        self.payTime = [dict doubleValueForKey:kModelOrderDetailPayTime];
        self.addrContactPhone = [dict stringValueForKey:kModelOrderDetailAddrContactPhone];
        self.status = [dict doubleValueForKey:kModelOrderDetailStatus];
        self.storeName = [dict stringValueForKey:kModelOrderDetailStoreName];
        self.addrCountyName = [dict stringValueForKey:kModelOrderDetailAddrCountyName];
        self.addrContact = [dict stringValueForKey:kModelOrderDetailAddrContact];
        self.payMethod = [dict doubleValueForKey:kModelOrderDetailPayMethod];
        self.addrCountyId = [dict doubleValueForKey:kModelOrderDetailAddrCountyId];
        self.addrProvinceName = [dict stringValueForKey:kModelOrderDetailAddrProvinceName];
        self.mergeNumber = [dict stringValueForKey:kModelOrderDetailMergeNumber];
        self.addrLat = [dict doubleValueForKey:kModelOrderDetailAddrLat];
        self.addrLng = [dict doubleValueForKey:kModelOrderDetailAddrLng];
        self.answer = [dict stringValueForKey:kModelOrderDetailAnswer];
        self.storeId = [dict doubleValueForKey:kModelOrderDetailStoreId];
        self.addrCityName = [dict stringValueForKey:kModelOrderDetailAddrCityName];
        self.addrDetail = [dict stringValueForKey:kModelOrderDetailAddrDetail];
        self.addrId = [dict doubleValueForKey:kModelOrderDetailAddrId];
        self.addrProvinceId = [dict doubleValueForKey:kModelOrderDetailAddrProvinceId];
        self.addrCityId = [dict doubleValueForKey:kModelOrderDetailAddrCityId];
        self.number = [dict stringValueForKey:kModelOrderDetailNumber];
        self.payChannel = [dict doubleValueForKey:kModelOrderDetailPayChannel];
        self.skus = [GlobalMethod exchangeDic:[dict objectForKey:kModelOrderDetailSkus] toAryWithModelName:NSStringFromClass(ModelIntegralProduct.class)];
        self.createTime = [dict doubleValueForKey:kModelOrderDetailCreateTime];
        self.price = [dict doubleValueForKey:kModelOrderDetailPrice];
        self.internalBaseClassDescription = [dict stringValueForKey:kModelOrderDetailDescription];
        self.coverUrl = [dict stringValueForKey:kModelOrderDetailCoverUrl];
        self.totalPrice = [dict doubleValueForKey:kModelOrderDetailTotalPrice];
        self.freightPrice = [dict doubleValueForKey:kModelOrderDetailFreightPrice];

        self.orderStatus = [self configOrderStatus];
        self.statusShow = [self configStatusShow];
        self.modelAddress = ^(){
            ModelShopAddress * item = [ModelShopAddress new];
            item.iDProperty = self.addrId;
            item.contact = self.addrContact;
            item.phone = self.addrContactPhone;
            item.provinceName = self.addrProvinceName;
            item.cityName = self.addrCityName;
            item.countyName = self.addrCountyName;
            item.detail = self.addrDetail;
            return item;
        }();
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.userId] forKey:kModelOrderDetailUserId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.payTime] forKey:kModelOrderDetailPayTime];
    [mutableDict setValue:self.addrContactPhone forKey:kModelOrderDetailAddrContactPhone];
    [mutableDict setValue:[NSNumber numberWithDouble:self.status] forKey:kModelOrderDetailStatus];
    [mutableDict setValue:self.storeName forKey:kModelOrderDetailStoreName];
    [mutableDict setValue:self.addrCountyName forKey:kModelOrderDetailAddrCountyName];
    [mutableDict setValue:self.addrContact forKey:kModelOrderDetailAddrContact];
    [mutableDict setValue:[NSNumber numberWithDouble:self.payMethod] forKey:kModelOrderDetailPayMethod];
    [mutableDict setValue:[NSNumber numberWithDouble:self.addrCountyId] forKey:kModelOrderDetailAddrCountyId];
    [mutableDict setValue:self.addrProvinceName forKey:kModelOrderDetailAddrProvinceName];
    [mutableDict setValue:self.mergeNumber forKey:kModelOrderDetailMergeNumber];
    [mutableDict setValue:[NSNumber numberWithDouble:self.addrLat] forKey:kModelOrderDetailAddrLat];
    [mutableDict setValue:[NSNumber numberWithDouble:self.addrLng] forKey:kModelOrderDetailAddrLng];
    [mutableDict setValue:self.answer forKey:kModelOrderDetailAnswer];
    [mutableDict setValue:[NSNumber numberWithDouble:self.storeId] forKey:kModelOrderDetailStoreId];
    [mutableDict setValue:self.addrCityName forKey:kModelOrderDetailAddrCityName];
    [mutableDict setValue:self.addrDetail forKey:kModelOrderDetailAddrDetail];
    [mutableDict setValue:[NSNumber numberWithDouble:self.addrId] forKey:kModelOrderDetailAddrId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.addrProvinceId] forKey:kModelOrderDetailAddrProvinceId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.addrCityId] forKey:kModelOrderDetailAddrCityId];
    [mutableDict setValue:self.number forKey:kModelOrderDetailNumber];
    [mutableDict setValue:[NSNumber numberWithDouble:self.payChannel] forKey:kModelOrderDetailPayChannel];
    [mutableDict setValue:[GlobalMethod exchangeAryModelToAryDic:self.skus] forKey:kModelOrderDetailSkus];
    [mutableDict setValue:[NSNumber numberWithDouble:self.createTime] forKey:kModelOrderDetailCreateTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.price] forKey:kModelOrderDetailPrice];
    [mutableDict setValue:self.internalBaseClassDescription forKey:kModelOrderDetailDescription];
    [mutableDict setValue:self.coverUrl forKey:kModelOrderDetailCoverUrl];
    [mutableDict setValue:[NSNumber numberWithDouble:self.totalPrice] forKey:kModelOrderDetailTotalPrice];
    [mutableDict setValue:[NSNumber numberWithDouble:self.freightPrice] forKey:kModelOrderDetailFreightPrice];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
