//
//  ModelPartyElite.m
//
//  Created by 林栋 隋 on 2020/8/11
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import "ModelPartyElite.h"


NSString *const kModelPartyEliteDescription = @"description";
NSString *const kModelPartyEliteCommitmentUrl = @"commitmentUrl";
NSString *const kModelPartyEliteCountryName = @"countryName";
NSString *const kModelPartyEliteEstateId = @"estateId";
NSString *const kModelPartyEliteContactPhone = @"contactPhone";
NSString *const kModelPartyEliteFoundDate = @"foundDate";
NSString *const kModelPartyEliteVillageName = @"villageName";
NSString *const kModelPartyEliteAreaLv = @"areaLv";
NSString *const kModelPartyElitePartyBranch = @"partyBranch";
NSString *const kModelPartyEliteEntName = @"entName";
NSString *const kModelPartyEliteBizUrl = @"bizUrl";
NSString *const kModelPartyEliteVillageId = @"villageId";
NSString *const kModelPartyEliteCountyId = @"countyId";
NSString *const kModelPartyEliteLegalPersonName = @"legalPersonName";
NSString *const kModelPartyEliteCountryId = @"countryId";
NSString *const kModelPartyEliteId = @"id";
NSString *const kModelPartyEliteCountyName = @"countyName";
NSString *const kModelPartyEliteProvinceName = @"provinceName";
NSString *const kModelPartyEliteProvinceId = @"provinceId";
NSString *const kModelPartyEliteCityId = @"cityId";
NSString *const kModelPartyEliteTownName = @"townName";
NSString *const kModelPartyEliteTownId = @"townId";
NSString *const kModelPartyEliteReviewStatus = @"reviewStatus";
NSString *const kModelPartyEliteIntroduction = @"introduction";
NSString *const kModelPartyEliteAddr = @"addr";
NSString *const kModelPartyEliteCityName = @"cityName";
NSString *const kModelPartyEliteEstateName = @"estateName";
NSString *const kModelPartyEliteJoinDate = @"joinDate";


@interface ModelPartyElite ()
@end

@implementation ModelPartyElite

@synthesize iDPropertyDescription = _iDPropertyDescription;
@synthesize commitmentUrl = _commitmentUrl;
@synthesize countryName = _countryName;
@synthesize estateId = _estateId;
@synthesize contactPhone = _contactPhone;
@synthesize foundDate = _foundDate;
@synthesize villageName = _villageName;
@synthesize areaLv = _areaLv;
@synthesize partyBranch = _partyBranch;
@synthesize entName = _entName;
@synthesize bizUrl = _bizUrl;
@synthesize villageId = _villageId;
@synthesize countyId = _countyId;
@synthesize legalPersonName = _legalPersonName;
@synthesize countryId = _countryId;
@synthesize iDProperty = _iDProperty;
@synthesize countyName = _countyName;
@synthesize provinceName = _provinceName;
@synthesize provinceId = _provinceId;
@synthesize cityId = _cityId;
@synthesize townName = _townName;
@synthesize townId = _townId;
@synthesize reviewStatus = _reviewStatus;
@synthesize introduction = _introduction;
@synthesize addr = _addr;
@synthesize cityName = _cityName;
@synthesize estateName = _estateName;
@synthesize joinDate = _joinDate;


#pragma mark init
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.iDPropertyDescription = [dict stringValueForKey:kModelPartyEliteDescription];
            self.commitmentUrl = [dict stringValueForKey:kModelPartyEliteCommitmentUrl];
            self.countryName = [dict stringValueForKey:kModelPartyEliteCountryName];
            self.estateId = [dict doubleValueForKey:kModelPartyEliteEstateId];
            self.contactPhone = [dict stringValueForKey:kModelPartyEliteContactPhone];
            self.foundDate = [dict doubleValueForKey:kModelPartyEliteFoundDate];
            self.villageName = [dict stringValueForKey:kModelPartyEliteVillageName];
            self.areaLv = [dict doubleValueForKey:kModelPartyEliteAreaLv];
            self.partyBranch = [dict stringValueForKey:kModelPartyElitePartyBranch];
            self.entName = [dict stringValueForKey:kModelPartyEliteEntName];
            self.bizUrl = [dict stringValueForKey:kModelPartyEliteBizUrl];
            self.villageId = [dict doubleValueForKey:kModelPartyEliteVillageId];
            self.countyId = [dict doubleValueForKey:kModelPartyEliteCountyId];
            self.legalPersonName = [dict stringValueForKey:kModelPartyEliteLegalPersonName];
            self.countryId = [dict doubleValueForKey:kModelPartyEliteCountryId];
            self.iDProperty = [dict doubleValueForKey:kModelPartyEliteId];
            self.countyName = [dict stringValueForKey:kModelPartyEliteCountyName];
            self.provinceName = [dict stringValueForKey:kModelPartyEliteProvinceName];
            self.provinceId = [dict doubleValueForKey:kModelPartyEliteProvinceId];
            self.cityId = [dict doubleValueForKey:kModelPartyEliteCityId];
            self.townName = [dict stringValueForKey:kModelPartyEliteTownName];
            self.townId = [dict doubleValueForKey:kModelPartyEliteTownId];
            self.reviewStatus = [dict doubleValueForKey:kModelPartyEliteReviewStatus];
            self.introduction = [dict stringValueForKey:kModelPartyEliteIntroduction];
            self.addr = [dict stringValueForKey:kModelPartyEliteAddr];
            self.cityName = [dict stringValueForKey:kModelPartyEliteCityName];
            self.estateName = [dict stringValueForKey:kModelPartyEliteEstateName];
            self.joinDate = [dict doubleValueForKey:kModelPartyEliteJoinDate];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.iDPropertyDescription forKey:kModelPartyEliteDescription];
    [mutableDict setValue:self.commitmentUrl forKey:kModelPartyEliteCommitmentUrl];
    [mutableDict setValue:self.countryName forKey:kModelPartyEliteCountryName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.estateId] forKey:kModelPartyEliteEstateId];
    [mutableDict setValue:self.contactPhone forKey:kModelPartyEliteContactPhone];
    [mutableDict setValue:[NSNumber numberWithDouble:self.foundDate] forKey:kModelPartyEliteFoundDate];
    [mutableDict setValue:self.villageName forKey:kModelPartyEliteVillageName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.areaLv] forKey:kModelPartyEliteAreaLv];
    [mutableDict setValue:self.partyBranch forKey:kModelPartyElitePartyBranch];
    [mutableDict setValue:self.entName forKey:kModelPartyEliteEntName];
    [mutableDict setValue:self.bizUrl forKey:kModelPartyEliteBizUrl];
    [mutableDict setValue:[NSNumber numberWithDouble:self.villageId] forKey:kModelPartyEliteVillageId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.countyId] forKey:kModelPartyEliteCountyId];
    [mutableDict setValue:self.legalPersonName forKey:kModelPartyEliteLegalPersonName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.countryId] forKey:kModelPartyEliteCountryId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.iDProperty] forKey:kModelPartyEliteId];
    [mutableDict setValue:self.countyName forKey:kModelPartyEliteCountyName];
    [mutableDict setValue:self.provinceName forKey:kModelPartyEliteProvinceName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.provinceId] forKey:kModelPartyEliteProvinceId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.cityId] forKey:kModelPartyEliteCityId];
    [mutableDict setValue:self.townName forKey:kModelPartyEliteTownName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.townId] forKey:kModelPartyEliteTownId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.reviewStatus] forKey:kModelPartyEliteReviewStatus];
    [mutableDict setValue:self.introduction forKey:kModelPartyEliteIntroduction];
    [mutableDict setValue:self.addr forKey:kModelPartyEliteAddr];
    [mutableDict setValue:self.cityName forKey:kModelPartyEliteCityName];
    [mutableDict setValue:self.estateName forKey:kModelPartyEliteEstateName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.joinDate] forKey:kModelPartyEliteJoinDate];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
