//
//  ModelHaiLuo.m
//
//  Created by 林栋 隋 on 2020/8/17
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import "ModelHaiLuo.h"


NSString *const kModelHaiLuoCityId = @"cityId";
NSString *const kModelHaiLuoPhone = @"phone";
NSString *const kModelHaiLuoHaveClass = @"haveClass";
NSString *const kModelHaiLuoHeader = @"header";
NSString *const kModelHaiLuoUid = @"uid";
NSString *const kModelHaiLuoUserId = @"userId";
NSString *const kModelHaiLuoToken = @"token";
NSString *const kModelHaiLuoSex = @"sex";
NSString *const kModelHaiLuoNickName = @"nickName";


@interface ModelHaiLuo ()
@end

@implementation ModelHaiLuo

@synthesize cityId = _cityId;
@synthesize phone = _phone;
@synthesize haveClass = _haveClass;
@synthesize header = _header;
@synthesize uid = _uid;
@synthesize userId = _userId;
@synthesize token = _token;
@synthesize sex = _sex;
@synthesize nickName = _nickName;


#pragma mark init
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.cityId = [dict doubleValueForKey:kModelHaiLuoCityId];
            self.phone = [dict stringValueForKey:kModelHaiLuoPhone];
            self.haveClass = [dict doubleValueForKey:kModelHaiLuoHaveClass];
            self.header = [dict stringValueForKey:kModelHaiLuoHeader];
            self.uid = [dict stringValueForKey:kModelHaiLuoUid];
            self.userId = [dict doubleValueForKey:kModelHaiLuoUserId];
            self.token = [dict stringValueForKey:kModelHaiLuoToken];
            self.sex = [dict doubleValueForKey:kModelHaiLuoSex];
            self.nickName = [dict stringValueForKey:kModelHaiLuoNickName];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.cityId] forKey:kModelHaiLuoCityId];
    [mutableDict setValue:self.phone forKey:kModelHaiLuoPhone];
    [mutableDict setValue:[NSNumber numberWithDouble:self.haveClass] forKey:kModelHaiLuoHaveClass];
    [mutableDict setValue:self.header forKey:kModelHaiLuoHeader];
    [mutableDict setValue:self.uid forKey:kModelHaiLuoUid];
    [mutableDict setValue:[NSNumber numberWithDouble:self.userId] forKey:kModelHaiLuoUserId];
    [mutableDict setValue:self.token forKey:kModelHaiLuoToken];
    [mutableDict setValue:[NSNumber numberWithDouble:self.sex] forKey:kModelHaiLuoSex];
    [mutableDict setValue:self.nickName forKey:kModelHaiLuoNickName];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
