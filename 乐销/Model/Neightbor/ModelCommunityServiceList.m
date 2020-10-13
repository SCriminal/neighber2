//
//  ModelCommunityServiceList.m
//
//  Created by 林栋 隋 on 2020/4/3
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import "ModelCommunityServiceList.h"


NSString *const kModelCommunityServiceListStatus = @"status";
NSString *const kModelCommunityServiceListCreateTime = @"createTime";
NSString *const kModelCommunityServiceListId = @"id";
NSString *const kModelCommunityServiceListDescription = @"description";
NSString *const kModelCommunityServiceListType = @"type";
NSString *const kModelCommunityServiceListCreatorId = @"creatorId";
NSString *const kModelCommunityServiceListCountryName = @"countryName";
NSString *const kModelCommunityServiceListRoomName = @"roomName";
NSString *const kModelCommunityServiceListUnitName = @"unitName";
NSString *const kModelCommunityServiceListEstateId = @"estateId";
NSString *const kModelCommunityServiceListEvaluation = @"evaluation";
NSString *const kModelCommunityServiceListBuildingName = @"buildingName";
NSString *const kModelCommunityServiceListVillageName = @"villageName";
NSString *const kModelCommunityServiceListRealName = @"realName";
NSString *const kModelCommunityServiceListLng = @"lng";
NSString *const kModelCommunityServiceListScore = @"score";
NSString *const kModelCommunityServiceListVillageId = @"villageId";
NSString *const kModelCommunityServiceListCountyId = @"countyId";
NSString *const kModelCommunityServiceListCountryId = @"countryId";
NSString *const kModelCommunityServiceListNumber = @"number";
NSString *const kModelCommunityServiceListCountyName = @"countyName";
NSString *const kModelCommunityServiceListProvinceName = @"provinceName";
NSString *const kModelCommunityServiceListEvaluateTime = @"evaluateTime";
NSString *const kModelCommunityServiceListProvinceId = @"provinceId";
NSString *const kModelCommunityServiceListHandleTime = @"handleTime";
NSString *const kModelCommunityServiceListCityId = @"cityId";
NSString *const kModelCommunityServiceListCellPhone = @"cellphone";
NSString *const kModelCommunityServiceListTownId = @"townId";
NSString *const kModelCommunityServiceListLat = @"lat";
NSString *const kModelCommunityServiceListFindTime = @"findTime";
NSString *const kModelCommunityServiceListHandlerId = @"handlerId";
NSString *const kModelCommunityServiceListResult = @"result";
NSString *const kModelCommunityServiceListEstateName = @"estateName";
NSString *const kModelCommunityServiceListCityName = @"cityName";
NSString *const kModelCommunityServiceListTownName = @"townName";
NSString *const kModelCommunityServiceListHandlerName = @"handlerName";
NSString *const kModelCommunityServiceListUrls = @"urls";


@interface ModelCommunityServiceList ()
@end

@implementation ModelCommunityServiceList

@synthesize status = _status;
@synthesize createTime = _createTime;
@synthesize iDProperty = _iDProperty;
@synthesize iDPropertyDescription = _iDPropertyDescription;
@synthesize type = _type;
@synthesize creatorId = _creatorId;


#pragma mark init
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.status = [dict doubleValueForKey:kModelCommunityServiceListStatus];
            self.createTime = [dict doubleValueForKey:kModelCommunityServiceListCreateTime];
            self.iDProperty = [dict doubleValueForKey:kModelCommunityServiceListId];
            self.iDPropertyDescription = [dict stringValueForKey:kModelCommunityServiceListDescription];
            self.type = [dict doubleValueForKey:kModelCommunityServiceListType];
            self.creatorId = [dict doubleValueForKey:kModelCommunityServiceListCreatorId];
        self.countryName = [dict stringValueForKey:kModelCommunityServiceListCountryName];
                   self.roomName = [dict stringValueForKey:kModelCommunityServiceListRoomName];
                   self.unitName = [dict stringValueForKey:kModelCommunityServiceListUnitName];
                   self.estateId = [dict doubleValueForKey:kModelCommunityServiceListEstateId];
                   self.evaluation = [dict stringValueForKey:kModelCommunityServiceListEvaluation];
                   self.buildingName = [dict stringValueForKey:kModelCommunityServiceListBuildingName];
                   self.villageName = [dict stringValueForKey:kModelCommunityServiceListVillageName];
                   self.realName = [dict stringValueForKey:kModelCommunityServiceListRealName];
                   self.lng = [dict doubleValueForKey:kModelCommunityServiceListLng];
                   self.score = [dict doubleValueForKey:kModelCommunityServiceListScore];
                   self.villageId = [dict doubleValueForKey:kModelCommunityServiceListVillageId];
                   self.countyId = [dict doubleValueForKey:kModelCommunityServiceListCountyId];
                   self.countryId = [dict doubleValueForKey:kModelCommunityServiceListCountryId];
                   self.number = [dict stringValueForKey:kModelCommunityServiceListNumber];
                   self.countyName = [dict stringValueForKey:kModelCommunityServiceListCountyName];
                   self.provinceName = [dict stringValueForKey:kModelCommunityServiceListProvinceName];
                   self.evaluateTime = [dict doubleValueForKey:kModelCommunityServiceListEvaluateTime];
                   self.provinceId = [dict doubleValueForKey:kModelCommunityServiceListProvinceId];
                   self.handleTime = [dict doubleValueForKey:kModelCommunityServiceListHandleTime];
                   self.cityId = [dict doubleValueForKey:kModelCommunityServiceListCityId];
                   self.cellPhone = [dict stringValueForKey:kModelCommunityServiceListCellPhone];
                   self.townId = [dict doubleValueForKey:kModelCommunityServiceListTownId];
                   self.lat = [dict doubleValueForKey:kModelCommunityServiceListLat];
                   self.findTime = [dict doubleValueForKey:kModelCommunityServiceListFindTime];
                   self.handlerId = [dict doubleValueForKey:kModelCommunityServiceListHandlerId];
                   self.result = [dict stringValueForKey:kModelCommunityServiceListResult];
                   self.estateName = [dict stringValueForKey:kModelCommunityServiceListEstateName];
                   self.cityName = [dict stringValueForKey:kModelCommunityServiceListCityName];
                   self.townName = [dict stringValueForKey:kModelCommunityServiceListTownName];
                   self.handlerName = [dict stringValueForKey:kModelCommunityServiceListHandlerName];
        self.urls =  [dict arrayValueForKey:kModelCommunityServiceListUrls];

        //logical 1未处理  9已处理   10 已评价
        switch ((int)self.status) {
                  case 1:
                  {
                      self.statusShow = @"未处理";
                      self.statusColorShow = COLOR_ORANGE;
                  }
                      break;
                  case 9:
                  {
                      self.statusShow = @"已处理";
                      self.statusColorShow = COLOR_GREEN;
                  }
                      break;
                  case 10:
                  {
                      self.statusShow = @"已评价";
                      self.statusColorShow = [UIColor colorWithHexString:@"35B2FF"];
                  }
                      break;
                  default:
                      break;
              }
        
        self.aryImages = [NSMutableArray new];
               for (NSString * strURL in self.urls) {
                   ModelImage * model = [ModelImage new];
                   model.url = strURL;
                   [self.aryImages addObject:model];
               }
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.status] forKey:kModelCommunityServiceListStatus];
    [mutableDict setValue:[NSNumber numberWithDouble:self.createTime] forKey:kModelCommunityServiceListCreateTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.iDProperty] forKey:kModelCommunityServiceListId];
    [mutableDict setValue:self.iDPropertyDescription forKey:kModelCommunityServiceListDescription];
    [mutableDict setValue:[NSNumber numberWithDouble:self.type] forKey:kModelCommunityServiceListType];
    [mutableDict setValue:[NSNumber numberWithDouble:self.creatorId] forKey:kModelCommunityServiceListCreatorId];
    [mutableDict setValue:self.countryName forKey:kModelCommunityServiceListCountryName];
    [mutableDict setValue:self.roomName forKey:kModelCommunityServiceListRoomName];
    [mutableDict setValue:self.unitName forKey:kModelCommunityServiceListUnitName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.estateId] forKey:kModelCommunityServiceListEstateId];
    [mutableDict setValue:self.evaluation forKey:kModelCommunityServiceListEvaluation];
    [mutableDict setValue:self.buildingName forKey:kModelCommunityServiceListBuildingName];
    [mutableDict setValue:self.villageName forKey:kModelCommunityServiceListVillageName];
    [mutableDict setValue:self.realName forKey:kModelCommunityServiceListRealName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.lng] forKey:kModelCommunityServiceListLng];
    [mutableDict setValue:[NSNumber numberWithDouble:self.score] forKey:kModelCommunityServiceListScore];
    [mutableDict setValue:[NSNumber numberWithDouble:self.villageId] forKey:kModelCommunityServiceListVillageId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.countyId] forKey:kModelCommunityServiceListCountyId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.countryId] forKey:kModelCommunityServiceListCountryId];
    [mutableDict setValue:self.number forKey:kModelCommunityServiceListNumber];
    [mutableDict setValue:self.countyName forKey:kModelCommunityServiceListCountyName];
    [mutableDict setValue:self.provinceName forKey:kModelCommunityServiceListProvinceName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.evaluateTime] forKey:kModelCommunityServiceListEvaluateTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.provinceId] forKey:kModelCommunityServiceListProvinceId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.handleTime] forKey:kModelCommunityServiceListHandleTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.cityId] forKey:kModelCommunityServiceListCityId];
    [mutableDict setValue:self.cellPhone forKey:kModelCommunityServiceListCellPhone];
    [mutableDict setValue:[NSNumber numberWithDouble:self.townId] forKey:kModelCommunityServiceListTownId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.lat] forKey:kModelCommunityServiceListLat];
    [mutableDict setValue:[NSNumber numberWithDouble:self.findTime] forKey:kModelCommunityServiceListFindTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.handlerId] forKey:kModelCommunityServiceListHandlerId];
    [mutableDict setValue:self.result forKey:kModelCommunityServiceListResult];
    [mutableDict setValue:self.estateName forKey:kModelCommunityServiceListEstateName];
    [mutableDict setValue:self.cityName forKey:kModelCommunityServiceListCityName];
    [mutableDict setValue:self.townName forKey:kModelCommunityServiceListTownName];
    [mutableDict setValue:self.handlerName forKey:kModelCommunityServiceListHandlerName];
    [mutableDict setValue:[GlobalMethod exchangeAryModelToAryDic:self.urls] forKey:kModelCommunityServiceListUrls];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
