//
//  ModelParty.h
//
//  Created by 林栋 隋 on 2020/7/1
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelParty : NSObject

@property (nonatomic, strong) NSString *countryName;
@property (nonatomic, assign) double estateId;
@property (nonatomic, strong) NSString *villageName;
@property (nonatomic, assign) double areaLv;
@property (nonatomic, assign) double lng;
@property (nonatomic, assign) double staffAmt;
@property (nonatomic, strong) NSString *secretaryName;
@property (nonatomic, assign) double villageId;
@property (nonatomic, assign) double countyId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) double countryId;
@property (nonatomic, assign) double iDProperty;
@property (nonatomic, assign) double cityId;
@property (nonatomic, strong) NSString *countyName;
@property (nonatomic, strong) NSString *townName;
@property (nonatomic, strong) NSString *provinceName;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, assign) double provinceId;
@property (nonatomic, assign) double townId;
@property (nonatomic, assign) double lat;
@property (nonatomic, strong) NSString *introduction;
@property (nonatomic, strong) NSString *addr;
@property (nonatomic, strong) NSString *cadreDescription;
@property (nonatomic, strong) NSString *cityName;
@property (nonatomic, strong) NSString *estateName;
@property (nonatomic, strong) NSString *iDPropertyDescription;

@property (nonatomic, strong) NSString *addressShow;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
