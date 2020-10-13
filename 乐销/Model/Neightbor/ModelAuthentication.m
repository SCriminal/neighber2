//
//  ModelAuthentication.m
//
//  Created by 林栋 隋 on 2020/4/23
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import "ModelAuthentication.h"


NSString *const kModelAuthenticationStatus = @"status";
NSString *const kModelAuthenticationIdPortrait = @"idPortrait";
NSString *const kModelAuthenticationIdEmblem = @"idEmblem";
NSString *const kModelAuthenticationDescription = @"description";
NSString *const kModelAuthenticationRealName = @"realName";
NSString *const kModelAuthenticationIdNumber = @"idNumber";


@interface ModelAuthentication ()
@end

@implementation ModelAuthentication

@synthesize status = _status;
@synthesize idPortrait = _idPortrait;
@synthesize idEmblem = _idEmblem;
@synthesize internalBaseClassDescription = _internalBaseClassDescription;
@synthesize realName = _realName;
@synthesize idNumber = _idNumber;


#pragma mark init
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.status = [dict doubleValueForKey:kModelAuthenticationStatus];
            self.idPortrait = [dict stringValueForKey:kModelAuthenticationIdPortrait];
            self.idEmblem = [dict stringValueForKey:kModelAuthenticationIdEmblem];
            self.internalBaseClassDescription = [dict stringValueForKey:kModelAuthenticationDescription];
            self.realName = [dict stringValueForKey:kModelAuthenticationRealName];
            self.idNumber = [dict stringValueForKey:kModelAuthenticationIdNumber];

//           审核状态  1-未提交  2-审核中  10审核通过  11-审核未通过
        switch ((int)self.status) {
            case 1:
                self.statusShow = @"未提交";
                break;
                case 2:
                self.statusShow = @"审核中";
                break;
                case 10:
                self.statusShow = @"审核通过";
                break;
                case 11:
                self.statusShow = @"审核未通过";
                break;
                
            default:
                break;
        }
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.status] forKey:kModelAuthenticationStatus];
    [mutableDict setValue:self.idPortrait forKey:kModelAuthenticationIdPortrait];
    [mutableDict setValue:self.idEmblem forKey:kModelAuthenticationIdEmblem];
    [mutableDict setValue:self.internalBaseClassDescription forKey:kModelAuthenticationDescription];
    [mutableDict setValue:self.realName forKey:kModelAuthenticationRealName];
    [mutableDict setValue:self.idNumber forKey:kModelAuthenticationIdNumber];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
