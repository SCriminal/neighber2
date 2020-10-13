//
//  ModelFJCompany.m
//
//  Created by 林栋 隋 on 2020/9/22
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import "ModelFJCompany.h"


NSString *const kModelFJCompanyId = @"id";
NSString *const kModelFJCompanyScaleCn = @"scale_cn";
NSString *const kModelFJCompanyNatureCn = @"nature_cn";
NSString *const kModelFJCompanyUid = @"uid";
NSString *const kModelFJCompanyReplyTime = @"reply_time";
NSString *const kModelFJCompanyContact = @"contact";
NSString *const kModelFJCompanyReplyRatio = @"reply_ratio";
NSString *const kModelFJCompanyLastLoginTimeCn = @"last_login_time_cn";
NSString *const kModelFJCompanySetmealId = @"setmeal_id";
NSString *const kModelFJCompanyLogo = @"logo";
NSString *const kModelFJCompanyAddress = @"address";
NSString *const kModelFJCompanyAudit = @"audit";
NSString *const kModelFJCompanyLandlineTel = @"landline_tel";
NSString *const kModelFJCompanyTradeCn = @"trade_cn";
NSString *const kModelFJCompanyTelephone = @"telephone";
NSString *const kModelFJCompanyLastLoginTime = @"last_login_time";


@interface ModelFJCompany ()
@end

@implementation ModelFJCompany

@synthesize iDProperty = _iDProperty;
@synthesize scaleCn = _scaleCn;
@synthesize natureCn = _natureCn;
@synthesize uid = _uid;
@synthesize replyTime = _replyTime;
@synthesize contact = _contact;
@synthesize replyRatio = _replyRatio;
@synthesize lastLoginTimeCn = _lastLoginTimeCn;
@synthesize setmealId = _setmealId;
@synthesize logo = _logo;
@synthesize address = _address;
@synthesize audit = _audit;
@synthesize landlineTel = _landlineTel;
@synthesize tradeCn = _tradeCn;
@synthesize telephone = _telephone;
@synthesize lastLoginTime = _lastLoginTime;


#pragma mark init
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.iDProperty = [dict stringValueForKey:kModelFJCompanyId];
            self.scaleCn = [dict stringValueForKey:kModelFJCompanyScaleCn];
            self.natureCn = [dict stringValueForKey:kModelFJCompanyNatureCn];
            self.uid = [dict stringValueForKey:kModelFJCompanyUid];
            self.replyTime = [dict stringValueForKey:kModelFJCompanyReplyTime];
            self.contact = [dict stringValueForKey:kModelFJCompanyContact];
            self.replyRatio = [dict doubleValueForKey:kModelFJCompanyReplyRatio];
            self.lastLoginTimeCn = [dict stringValueForKey:kModelFJCompanyLastLoginTimeCn];
            self.setmealId = [dict stringValueForKey:kModelFJCompanySetmealId];
            self.logo = [dict stringValueForKey:kModelFJCompanyLogo];
            self.address = [dict stringValueForKey:kModelFJCompanyAddress];
            self.audit = [dict stringValueForKey:kModelFJCompanyAudit];
            self.landlineTel = [dict stringValueForKey:kModelFJCompanyLandlineTel];
            self.tradeCn = [dict stringValueForKey:kModelFJCompanyTradeCn];
            self.telephone = [dict stringValueForKey:kModelFJCompanyTelephone];
            self.lastLoginTime = [dict stringValueForKey:kModelFJCompanyLastLoginTime];

        self.logo = [self.logo findJobLogo];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.iDProperty forKey:kModelFJCompanyId];
    [mutableDict setValue:self.scaleCn forKey:kModelFJCompanyScaleCn];
    [mutableDict setValue:self.natureCn forKey:kModelFJCompanyNatureCn];
    [mutableDict setValue:self.uid forKey:kModelFJCompanyUid];
    [mutableDict setValue:self.replyTime forKey:kModelFJCompanyReplyTime];
    [mutableDict setValue:self.contact forKey:kModelFJCompanyContact];
    [mutableDict setValue:[NSNumber numberWithDouble:self.replyRatio] forKey:kModelFJCompanyReplyRatio];
    [mutableDict setValue:self.lastLoginTimeCn forKey:kModelFJCompanyLastLoginTimeCn];
    [mutableDict setValue:self.setmealId forKey:kModelFJCompanySetmealId];
    [mutableDict setValue:self.logo forKey:kModelFJCompanyLogo];
    [mutableDict setValue:self.address forKey:kModelFJCompanyAddress];
    [mutableDict setValue:self.audit forKey:kModelFJCompanyAudit];
    [mutableDict setValue:self.landlineTel forKey:kModelFJCompanyLandlineTel];
    [mutableDict setValue:self.tradeCn forKey:kModelFJCompanyTradeCn];
    [mutableDict setValue:self.telephone forKey:kModelFJCompanyTelephone];
    [mutableDict setValue:self.lastLoginTime forKey:kModelFJCompanyLastLoginTime];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
