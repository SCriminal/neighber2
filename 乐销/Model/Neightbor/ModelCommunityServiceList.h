//
//  ModelCommunityServiceList.h
//
//  Created by 林栋 隋 on 2020/4/3
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelCommunityServiceList : NSObject

@property (nonatomic, assign) double status;
@property (nonatomic, assign) double createTime;
@property (nonatomic, assign) double iDProperty;
@property (nonatomic, strong) NSString *iDPropertyDescription;
@property (nonatomic, assign) double type;
@property (nonatomic, assign) double creatorId;
@property (nonatomic, strong) NSString *countryName;
@property (nonatomic, strong) NSString *roomName;
@property (nonatomic, strong) NSString *unitName;
@property (nonatomic, assign) double estateId;
@property (nonatomic, strong) NSString *evaluation;
@property (nonatomic, strong) NSString *buildingName;
@property (nonatomic, strong) NSString *villageName;
@property (nonatomic, strong) NSString *realName;
@property (nonatomic, assign) double lng;
@property (nonatomic, assign) double score;
@property (nonatomic, assign) double villageId;
@property (nonatomic, assign) double countyId;
@property (nonatomic, assign) double countryId;
@property (nonatomic, strong) NSString *number;
@property (nonatomic, strong) NSString *countyName;
@property (nonatomic, strong) NSString *provinceName;
@property (nonatomic, assign) double evaluateTime;
@property (nonatomic, assign) double provinceId;
@property (nonatomic, assign) double handleTime;
@property (nonatomic, assign) double cityId;
@property (nonatomic, strong) NSString *cellPhone;
@property (nonatomic, assign) double townId;
@property (nonatomic, assign) double lat;
@property (nonatomic, assign) double findTime;
@property (nonatomic, assign) double handlerId;
@property (nonatomic, strong) NSString *result;
@property (nonatomic, strong) NSString *estateName;
@property (nonatomic, strong) NSString *cityName;
@property (nonatomic, strong) NSString *townName;
@property (nonatomic, strong) NSString *handlerName;
@property (nonatomic, strong) NSArray *urls;

@property (nonatomic, strong) NSString *statusShow;
@property (nonatomic, strong) UIColor *statusColorShow;
@property (nonatomic, strong) NSMutableArray *aryImages;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
