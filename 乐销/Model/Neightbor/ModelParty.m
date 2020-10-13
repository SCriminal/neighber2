//
//  ModelParty.m
//
//  Created by 林栋 隋 on 2020/7/1
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import "ModelParty.h"


NSString *const kModelPartyCountryName = @"countryName";
NSString *const kModelPartyEstateId = @"estateId";
NSString *const kModelPartyVillageName = @"villageName";
NSString *const kModelPartyAreaLv = @"areaLv";
NSString *const kModelPartyLng = @"lng";
NSString *const kModelPartyStaffAmt = @"staffAmt";
NSString *const kModelPartySecretaryName = @"secretaryName";
NSString *const kModelPartyVillageId = @"villageId";
NSString *const kModelPartyCountyId = @"countyId";
NSString *const kModelPartyName = @"name";
NSString *const kModelPartyCountryId = @"countryId";
NSString *const kModelPartyId = @"id";
NSString *const kModelPartyCityId = @"cityId";
NSString *const kModelPartyCountyName = @"countyName";
NSString *const kModelPartyTownName = @"townName";
NSString *const kModelPartyProvinceName = @"provinceName";
NSString *const kModelPartyPhone = @"phone";
NSString *const kModelPartyProvinceId = @"provinceId";
NSString *const kModelPartyTownId = @"townId";
NSString *const kModelPartyLat = @"lat";
NSString *const kModelPartyIntroduction = @"introduction";
NSString *const kModelPartyAddr = @"addr";
NSString *const kModelPartyCadreDescription = @"cadreDescription";
NSString *const kModelPartyCityName = @"cityName";
NSString *const kModelPartyEstateName = @"estateName";
NSString *const kModelPartyDescription = @"description";


@interface ModelParty ()
@end

@implementation ModelParty

@synthesize countryName = _countryName;
@synthesize estateId = _estateId;
@synthesize villageName = _villageName;
@synthesize areaLv = _areaLv;
@synthesize lng = _lng;
@synthesize staffAmt = _staffAmt;
@synthesize secretaryName = _secretaryName;
@synthesize villageId = _villageId;
@synthesize countyId = _countyId;
@synthesize name = _name;
@synthesize countryId = _countryId;
@synthesize iDProperty = _iDProperty;
@synthesize cityId = _cityId;
@synthesize countyName = _countyName;
@synthesize townName = _townName;
@synthesize provinceName = _provinceName;
@synthesize phone = _phone;
@synthesize provinceId = _provinceId;
@synthesize townId = _townId;
@synthesize lat = _lat;
@synthesize introduction = _introduction;
@synthesize addr = _addr;
@synthesize cadreDescription = _cadreDescription;
@synthesize cityName = _cityName;
@synthesize estateName = _estateName;
@synthesize iDPropertyDescription = _iDPropertyDescription;


#pragma mark init
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.countryName = [dict stringValueForKey:kModelPartyCountryName];
            self.estateId = [dict doubleValueForKey:kModelPartyEstateId];
            self.villageName = [dict stringValueForKey:kModelPartyVillageName];
            self.areaLv = [dict doubleValueForKey:kModelPartyAreaLv];
            self.lng = [dict doubleValueForKey:kModelPartyLng];
            self.staffAmt = [dict doubleValueForKey:kModelPartyStaffAmt];
            self.secretaryName = [dict stringValueForKey:kModelPartySecretaryName];
            self.villageId = [dict doubleValueForKey:kModelPartyVillageId];
            self.countyId = [dict doubleValueForKey:kModelPartyCountyId];
            self.name = [dict stringValueForKey:kModelPartyName];
            self.countryId = [dict doubleValueForKey:kModelPartyCountryId];
            self.iDProperty = [dict doubleValueForKey:kModelPartyId];
            self.cityId = [dict doubleValueForKey:kModelPartyCityId];
            self.countyName = [dict stringValueForKey:kModelPartyCountyName];
            self.townName = [dict stringValueForKey:kModelPartyTownName];
            self.provinceName = [dict stringValueForKey:kModelPartyProvinceName];
            self.phone = [dict stringValueForKey:kModelPartyPhone];
            self.provinceId = [dict doubleValueForKey:kModelPartyProvinceId];
            self.townId = [dict doubleValueForKey:kModelPartyTownId];
            self.lat = [dict doubleValueForKey:kModelPartyLat];
            self.introduction = [dict stringValueForKey:kModelPartyIntroduction];
            self.addr = [dict stringValueForKey:kModelPartyAddr];
            self.cadreDescription = [dict stringValueForKey:kModelPartyCadreDescription];
            self.cityName = [dict stringValueForKey:kModelPartyCityName];
            self.estateName = [dict stringValueForKey:kModelPartyEstateName];
            self.iDPropertyDescription = [dict stringValueForKey:kModelPartyDescription];
        
        //logical

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.countryName forKey:kModelPartyCountryName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.estateId] forKey:kModelPartyEstateId];
    [mutableDict setValue:self.villageName forKey:kModelPartyVillageName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.areaLv] forKey:kModelPartyAreaLv];
    [mutableDict setValue:[NSNumber numberWithDouble:self.lng] forKey:kModelPartyLng];
    [mutableDict setValue:[NSNumber numberWithDouble:self.staffAmt] forKey:kModelPartyStaffAmt];
    [mutableDict setValue:self.secretaryName forKey:kModelPartySecretaryName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.villageId] forKey:kModelPartyVillageId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.countyId] forKey:kModelPartyCountyId];
    [mutableDict setValue:self.name forKey:kModelPartyName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.countryId] forKey:kModelPartyCountryId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.iDProperty] forKey:kModelPartyId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.cityId] forKey:kModelPartyCityId];
    [mutableDict setValue:self.countyName forKey:kModelPartyCountyName];
    [mutableDict setValue:self.townName forKey:kModelPartyTownName];
    [mutableDict setValue:self.provinceName forKey:kModelPartyProvinceName];
    [mutableDict setValue:self.phone forKey:kModelPartyPhone];
    [mutableDict setValue:[NSNumber numberWithDouble:self.provinceId] forKey:kModelPartyProvinceId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.townId] forKey:kModelPartyTownId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.lat] forKey:kModelPartyLat];
    [mutableDict setValue:self.introduction forKey:kModelPartyIntroduction];
    [mutableDict setValue:self.addr forKey:kModelPartyAddr];
    [mutableDict setValue:self.cadreDescription forKey:kModelPartyCadreDescription];
    [mutableDict setValue:self.cityName forKey:kModelPartyCityName];
    [mutableDict setValue:self.estateName forKey:kModelPartyEstateName];
    [mutableDict setValue:self.iDPropertyDescription forKey:kModelPartyDescription];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
