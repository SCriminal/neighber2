//
//  ModelCommunityCity.m
//
//  Created by 林栋 隋 on 2020/3/29
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import "ModelCommunityCity.h"


NSString *const kModelCommunityCityAreaCode = @"areaCode";
NSString *const kModelCommunityCityId = @"id";
NSString *const kModelCommunityCityAreaName = @"areaName";
NSString *const kModelCommunityCityInitial = @"initial";


@interface ModelCommunityCity ()
@end

@implementation ModelCommunityCity

@synthesize areaCode = _areaCode;
@synthesize iDProperty = _iDProperty;
@synthesize areaName = _areaName;
@synthesize initial = _initial;


#pragma mark init
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.areaCode = [dict stringValueForKey:kModelCommunityCityAreaCode];
            self.iDProperty = [dict doubleValueForKey:kModelCommunityCityId];
            self.areaName = [dict stringValueForKey:kModelCommunityCityAreaName];
            self.initial = [dict stringValueForKey:kModelCommunityCityInitial];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.areaCode forKey:kModelCommunityCityAreaCode];
    [mutableDict setValue:[NSNumber numberWithDouble:self.iDProperty] forKey:kModelCommunityCityId];
    [mutableDict setValue:self.areaName forKey:kModelCommunityCityAreaName];
    [mutableDict setValue:self.initial forKey:kModelCommunityCityInitial];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
