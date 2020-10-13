//
//  ModelUser.m
//
//  Created by 林栋 隋 on 2020/3/14
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import "ModelUser.h"


NSString *const kModelUserPhone = @"phone";
NSString *const kModelUserGender = @"gender";
NSString *const kModelUserHeadUrl = @"headUrl";
NSString *const kModelUserEstateId = @"estateId";
NSString *const kModelUserNickname = @"nickname";
NSString *const kModelUserEstateName = @"estateName";
NSString *const kModelUserAddr = @"addr";


@interface ModelUser ()
@property (nonatomic, assign) double userId;

@end

@implementation ModelUser

@synthesize phone = _phone;
@synthesize gender = _gender;
@synthesize headUrl = _headUrl;
@synthesize estateId = _estateId;
@synthesize nickname = _nickname;
@synthesize estateName = _estateName;
@synthesize addr = _addr;


#pragma mark init
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
        self.phone = [dict stringValueForKey:kModelUserPhone];
        self.gender = [dict doubleValueForKey:kModelUserGender];
        self.headUrl = [dict stringValueForKey:kModelUserHeadUrl];
        self.estateId = [dict stringValueForKey:kModelUserEstateId];
        self.nickname = [dict stringValueForKey:kModelUserNickname];
        self.estateName = [dict stringValueForKey:kModelUserEstateName];
        self.addr = [dict stringValueForKey:kModelUserAddr];
        
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.phone forKey:kModelUserPhone];
    [mutableDict setValue:[NSNumber numberWithDouble:self.gender] forKey:kModelUserGender];
    [mutableDict setValue:self.headUrl forKey:kModelUserHeadUrl];
    [mutableDict setValue:self.estateId forKey:kModelUserEstateId];
    [mutableDict setValue:self.nickname forKey:kModelUserNickname];
    [mutableDict setValue:self.estateName forKey:kModelUserEstateName];
    [mutableDict setValue:self.addr forKey:kModelUserAddr];
    
    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
