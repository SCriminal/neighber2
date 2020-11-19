//
//  EHomePayWeichatInfo.m
//
//  Created by 林栋 隋 on 2020/10/12
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import "EHomePayWeichatInfo.h"


NSString *const kEHomePayWeichatInfoEpishopId = @"epishopId";
NSString *const kEHomePayWeichatInfoEpiKey = @"epiKey";
NSString *const kEHomePayWeichatInfoFeesIds = @"feesIds";
NSString *const kEHomePayWeichatInfoPayOrderNo = @"payOrderNo";
NSString *const kEHomePayWeichatInfoFee = @"fee";


@interface EHomePayWeichatInfo ()
@end

@implementation EHomePayWeichatInfo

@synthesize epishopId = _epishopId;
@synthesize epiKey = _epiKey;
@synthesize feesIds = _feesIds;
@synthesize payOrderNo = _payOrderNo;
@synthesize fee = _fee;


#pragma mark init
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.epishopId = [dict stringValueForKey:kEHomePayWeichatInfoEpishopId];
            self.epiKey = [dict stringValueForKey:kEHomePayWeichatInfoEpiKey];
            self.feesIds = [dict stringValueForKey:kEHomePayWeichatInfoFeesIds];
            self.payOrderNo = [dict stringValueForKey:kEHomePayWeichatInfoPayOrderNo];
            self.fee = [dict doubleValueForKey:kEHomePayWeichatInfoFee];
        self.notifyUrl = [dict stringValueForKey:@"notifyUrl"];
        self.orderTitle = [dict stringValueForKey:@"orderTitle"];
        self.orderDesc = [dict stringValueForKey:@"orderDesc"];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.epishopId forKey:kEHomePayWeichatInfoEpishopId];
    [mutableDict setValue:self.epiKey forKey:kEHomePayWeichatInfoEpiKey];
    [mutableDict setValue:self.feesIds forKey:kEHomePayWeichatInfoFeesIds];
    [mutableDict setValue:self.payOrderNo forKey:kEHomePayWeichatInfoPayOrderNo];
    [mutableDict setValue:[NSNumber numberWithDouble:self.fee] forKey:kEHomePayWeichatInfoFee];
    [mutableDict setValue:self.notifyUrl forKey:@"notifyUrl"];
    [mutableDict setValue:self.orderTitle forKey:@"orderTitle"];
    [mutableDict setValue:self.orderDesc forKey:@"orderDesc"];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
