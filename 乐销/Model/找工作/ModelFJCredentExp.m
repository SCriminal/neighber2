//
//  ModelFJCredentExp.m
//
//  Created by 林栋 隋 on 2020/9/16
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import "ModelFJCredentExp.h"


NSString *const kModelFJCredentExpImages = @"images";
NSString *const kModelFJCredentExpUid = @"uid";
NSString *const kModelFJCredentExpId = @"id";
NSString *const kModelFJCredentExpMonth = @"month";
NSString *const kModelFJCredentExpYear = @"year";
NSString *const kModelFJCredentExpName = @"name";
NSString *const kModelFJCredentExpPid = @"pid";


@interface ModelFJCredentExp ()
@end

@implementation ModelFJCredentExp

@synthesize images = _images;
@synthesize uid = _uid;
@synthesize iDProperty = _iDProperty;
@synthesize month = _month;
@synthesize year = _year;
@synthesize name = _name;
@synthesize pid = _pid;


#pragma mark init
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.images = [dict stringValueForKey:kModelFJCredentExpImages];
            self.uid = [dict stringValueForKey:kModelFJCredentExpUid];
            self.iDProperty = [dict stringValueForKey:kModelFJCredentExpId];
            self.month = [dict stringValueForKey:kModelFJCredentExpMonth];
            self.year = [dict stringValueForKey:kModelFJCredentExpYear];
            self.name = [dict stringValueForKey:kModelFJCredentExpName];
            self.pid = [dict stringValueForKey:kModelFJCredentExpPid];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.images forKey:kModelFJCredentExpImages];
    [mutableDict setValue:self.uid forKey:kModelFJCredentExpUid];
    [mutableDict setValue:self.iDProperty forKey:kModelFJCredentExpId];
    [mutableDict setValue:self.month forKey:kModelFJCredentExpMonth];
    [mutableDict setValue:self.year forKey:kModelFJCredentExpYear];
    [mutableDict setValue:self.name forKey:kModelFJCredentExpName];
    [mutableDict setValue:self.pid forKey:kModelFJCredentExpPid];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
