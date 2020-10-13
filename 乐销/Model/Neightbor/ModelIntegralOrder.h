//
//  ModelIntegralOrder.h
//
//  Created by 林栋 隋 on 2020/4/28
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelIntegralOrder : NSObject

@property (nonatomic, strong) NSString *reply;
@property (nonatomic, assign) double skuScore;
@property (nonatomic, assign) double skuId;
@property (nonatomic, strong) NSString *contactPhone;
@property (nonatomic, strong) NSString *skuName;
@property (nonatomic, assign) double score;
@property (nonatomic, assign) double lng;
@property (nonatomic, strong) NSString *skuCoverUrl;
@property (nonatomic, strong) NSString *contact;
@property (nonatomic, assign) double countyId;
@property (nonatomic, strong) NSString *number;
@property (nonatomic, strong) NSString *countyName;
@property (nonatomic, assign) double addrId;
@property (nonatomic, assign) double qty;
@property (nonatomic, strong) NSString *addrDetail;
@property (nonatomic, assign) double provinceId;
@property (nonatomic, assign) double cityId;
@property (nonatomic, strong) NSString *provinceName;
@property (nonatomic, assign) double lat;
@property (nonatomic, assign) double createTime;
@property (nonatomic, strong) NSString *cityName;
@property (nonatomic, assign) double userId;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
