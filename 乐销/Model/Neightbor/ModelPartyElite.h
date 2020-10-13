//
//  ModelPartyElite.h
//
//  Created by 林栋 隋 on 2020/8/11
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelPartyElite : NSObject

@property (nonatomic, strong) NSString *iDPropertyDescription;
@property (nonatomic, strong) NSString *commitmentUrl;
@property (nonatomic, strong) NSString *countryName;
@property (nonatomic, assign) double estateId;
@property (nonatomic, strong) NSString *contactPhone;
@property (nonatomic, assign) double foundDate;
@property (nonatomic, strong) NSString *villageName;
@property (nonatomic, assign) double areaLv;
@property (nonatomic, strong) NSString *partyBranch;
@property (nonatomic, strong) NSString *entName;
@property (nonatomic, strong) NSString *bizUrl;
@property (nonatomic, assign) double villageId;
@property (nonatomic, assign) double countyId;
@property (nonatomic, strong) NSString *legalPersonName;
@property (nonatomic, assign) double countryId;
@property (nonatomic, assign) double iDProperty;
@property (nonatomic, strong) NSString *countyName;
@property (nonatomic, strong) NSString *provinceName;
@property (nonatomic, assign) double provinceId;
@property (nonatomic, assign) double cityId;
@property (nonatomic, strong) NSString *townName;
@property (nonatomic, assign) double townId;
@property (nonatomic, assign) double reviewStatus;
@property (nonatomic, strong) NSString *introduction;
@property (nonatomic, strong) NSString *addr;
@property (nonatomic, strong) NSString *cityName;
@property (nonatomic, strong) NSString *estateName;
@property (nonatomic, assign) double joinDate;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
