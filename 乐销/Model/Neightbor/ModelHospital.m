//
//  ModelHospital.m
//
//  Created by 林栋 隋 on 2020/3/25
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import "ModelHospital.h"


NSString *const kModelHospitalLogoUrl = @"logoUrl";
NSString *const kModelHospitalId = @"id";
NSString *const kModelHospitalPhone = @"phone";
NSString *const kModelHospitalAddr = @"addr";
NSString *const kModelHospitalName = @"name";


@interface ModelHospital ()
@end

@implementation ModelHospital

@synthesize logoUrl = _logoUrl;
@synthesize iDProperty = _iDProperty;
@synthesize phone = _phone;
@synthesize addr = _addr;
@synthesize name = _name;


#pragma mark init
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.logoUrl = [dict stringValueForKey:kModelHospitalLogoUrl];
            self.iDProperty = [dict doubleValueForKey:kModelHospitalId];
            self.phone = [dict stringValueForKey:kModelHospitalPhone];
            self.addr = [dict stringValueForKey:kModelHospitalAddr];
            self.name = [dict stringValueForKey:kModelHospitalName];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.logoUrl forKey:kModelHospitalLogoUrl];
    [mutableDict setValue:[NSNumber numberWithDouble:self.iDProperty] forKey:kModelHospitalId];
    [mutableDict setValue:self.phone forKey:kModelHospitalPhone];
    [mutableDict setValue:self.addr forKey:kModelHospitalAddr];
    [mutableDict setValue:self.name forKey:kModelHospitalName];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
