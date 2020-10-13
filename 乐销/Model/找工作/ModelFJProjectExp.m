//
//  ModelFJProjectExp.m
//
//  Created by 林栋 隋 on 2020/9/16
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import "ModelFJProjectExp.h"


NSString *const kModelFJProjectExpId = @"id";
NSString *const kModelFJProjectExpTodate = @"todate";
NSString *const kModelFJProjectExpProjectname = @"projectname";
NSString *const kModelFJProjectExpUid = @"uid";
NSString *const kModelFJProjectExpStartmonth = @"startmonth";
NSString *const kModelFJProjectExpDescription = @"description";
NSString *const kModelFJProjectExpStartyear = @"startyear";
NSString *const kModelFJProjectExpEndmonth = @"endmonth";
NSString *const kModelFJProjectExpEndyear = @"endyear";
NSString *const kModelFJProjectExpRole = @"role";
NSString *const kModelFJProjectExpDuration = @"duration";
NSString *const kModelFJProjectExpPid = @"pid";


@interface ModelFJProjectExp ()
@end

@implementation ModelFJProjectExp

@synthesize iDProperty = _iDProperty;
@synthesize todate = _todate;
@synthesize projectname = _projectname;
@synthesize uid = _uid;
@synthesize startmonth = _startmonth;
@synthesize iDPropertyDescription = _iDPropertyDescription;
@synthesize startyear = _startyear;
@synthesize endmonth = _endmonth;
@synthesize endyear = _endyear;
@synthesize role = _role;
@synthesize duration = _duration;
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
            self.iDProperty = [dict stringValueForKey:kModelFJProjectExpId];
            self.todate = [dict stringValueForKey:kModelFJProjectExpTodate];
            self.projectname = [dict stringValueForKey:kModelFJProjectExpProjectname];
            self.uid = [dict stringValueForKey:kModelFJProjectExpUid];
            self.startmonth = [dict stringValueForKey:kModelFJProjectExpStartmonth];
            self.iDPropertyDescription = [dict stringValueForKey:kModelFJProjectExpDescription];
            self.startyear = [dict stringValueForKey:kModelFJProjectExpStartyear];
            self.endmonth = [dict stringValueForKey:kModelFJProjectExpEndmonth];
            self.endyear = [dict stringValueForKey:kModelFJProjectExpEndyear];
            self.role = [dict stringValueForKey:kModelFJProjectExpRole];
            self.duration = [dict stringValueForKey:kModelFJProjectExpDuration];
            self.pid = [dict stringValueForKey:kModelFJProjectExpPid];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.iDProperty forKey:kModelFJProjectExpId];
    [mutableDict setValue:self.todate forKey:kModelFJProjectExpTodate];
    [mutableDict setValue:self.projectname forKey:kModelFJProjectExpProjectname];
    [mutableDict setValue:self.uid forKey:kModelFJProjectExpUid];
    [mutableDict setValue:self.startmonth forKey:kModelFJProjectExpStartmonth];
    [mutableDict setValue:self.iDPropertyDescription forKey:kModelFJProjectExpDescription];
    [mutableDict setValue:self.startyear forKey:kModelFJProjectExpStartyear];
    [mutableDict setValue:self.endmonth forKey:kModelFJProjectExpEndmonth];
    [mutableDict setValue:self.endyear forKey:kModelFJProjectExpEndyear];
    [mutableDict setValue:self.role forKey:kModelFJProjectExpRole];
    [mutableDict setValue:self.duration forKey:kModelFJProjectExpDuration];
    [mutableDict setValue:self.pid forKey:kModelFJProjectExpPid];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
