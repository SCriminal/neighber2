//
//  ModelOrderDetail.h
//
//  Created by 林栋 隋 on 2020/4/26
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
//1已下单 5已付款 7已发货 10已完成 99已关闭
typedef NS_ENUM(NSUInteger, ENUM_ORDER_STATUS) {
    ENUM_ORDER_STATUS_CLOSE =0,
    ENUM_ORDER_STATUS_SUBMIT,
    ENUM_ORDER_STATUS_PAY,
    ENUM_ORDER_STATUS_SEND,
    ENUM_ORDER_STATUS_COMPLETE,
};

@interface ModelOrderDetail : NSObject

@property (nonatomic, assign) double userId;
@property (nonatomic, assign) double payTime;
@property (nonatomic, strong) NSString *addrContactPhone;
@property (nonatomic, strong) NSString *storeName;
@property (nonatomic, strong) NSString *addrCountyName;
@property (nonatomic, strong) NSString *addrContact;
@property (nonatomic, assign) double payMethod;
@property (nonatomic, assign) double addrCountyId;
@property (nonatomic, strong) NSString *addrProvinceName;
@property (nonatomic, strong) NSString *mergeNumber;
@property (nonatomic, assign) double addrLat;
@property (nonatomic, assign) double addrLng;
@property (nonatomic, strong) NSString *answer;
@property (nonatomic, assign) double storeId;
@property (nonatomic, strong) NSString *addrCityName;
@property (nonatomic, strong) NSString *addrDetail;
@property (nonatomic, assign) double addrId;
@property (nonatomic, assign) double addrProvinceId;
@property (nonatomic, assign) double addrCityId;
@property (nonatomic, strong) NSString *number;
@property (nonatomic, assign) double payChannel;
@property (nonatomic, strong) NSMutableArray *skus;
@property (nonatomic, assign) double createTime;
@property (nonatomic, assign) double price;
@property (nonatomic, strong) NSString *internalBaseClassDescription;
@property (nonatomic, strong) NSString *coverUrl;
@property (nonatomic, assign) double totalPrice;
@property (nonatomic, assign) double freightPrice;

//logical
@property (nonatomic, strong) NSString *statusShow;
@property (nonatomic, assign) ENUM_ORDER_STATUS orderStatus;
@property (nonatomic, strong) ModelShopAddress* modelAddress;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
