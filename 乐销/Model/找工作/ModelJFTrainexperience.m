//
//  ModelJFTrainexperience.m
//
//  Created by 林栋 隋 on 2020/9/16
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import "ModelJFTrainexperience.h"


NSString *const kModelJFTrainexperienceId = @"id";
NSString *const kModelJFTrainexperienceTodate = @"todate";
NSString *const kModelJFTrainexperienceStartmonth = @"startmonth";
NSString *const kModelJFTrainexperienceUid = @"uid";
NSString *const kModelJFTrainexperienceDescription = @"description";
NSString *const kModelJFTrainexperienceStartyear = @"startyear";
NSString *const kModelJFTrainexperienceEndmonth = @"endmonth";
NSString *const kModelJFTrainexperienceCourse = @"course";
NSString *const kModelJFTrainexperienceEndyear = @"endyear";
NSString *const kModelJFTrainexperienceDuration = @"duration";
NSString *const kModelJFTrainexperiencePid = @"pid";
NSString *const kModelJFTrainexperienceAgency = @"agency";


@interface ModelJFTrainexperience ()
@end

@implementation ModelJFTrainexperience

@synthesize iDProperty = _iDProperty;
@synthesize todate = _todate;
@synthesize startmonth = _startmonth;
@synthesize uid = _uid;
@synthesize iDPropertyDescription = _iDPropertyDescription;
@synthesize startyear = _startyear;
@synthesize endmonth = _endmonth;
@synthesize course = _course;
@synthesize endyear = _endyear;
@synthesize duration = _duration;
@synthesize pid = _pid;
@synthesize agency = _agency;


#pragma mark init
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.iDProperty = [dict stringValueForKey:kModelJFTrainexperienceId];
            self.todate = [dict stringValueForKey:kModelJFTrainexperienceTodate];
            self.startmonth = [dict stringValueForKey:kModelJFTrainexperienceStartmonth];
            self.uid = [dict stringValueForKey:kModelJFTrainexperienceUid];
            self.iDPropertyDescription = [dict stringValueForKey:kModelJFTrainexperienceDescription];
            self.startyear = [dict stringValueForKey:kModelJFTrainexperienceStartyear];
            self.endmonth = [dict stringValueForKey:kModelJFTrainexperienceEndmonth];
            self.course = [dict stringValueForKey:kModelJFTrainexperienceCourse];
            self.endyear = [dict stringValueForKey:kModelJFTrainexperienceEndyear];
            self.duration = [dict stringValueForKey:kModelJFTrainexperienceDuration];
            self.pid = [dict stringValueForKey:kModelJFTrainexperiencePid];
            self.agency = [dict stringValueForKey:kModelJFTrainexperienceAgency];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.iDProperty forKey:kModelJFTrainexperienceId];
    [mutableDict setValue:self.todate forKey:kModelJFTrainexperienceTodate];
    [mutableDict setValue:self.startmonth forKey:kModelJFTrainexperienceStartmonth];
    [mutableDict setValue:self.uid forKey:kModelJFTrainexperienceUid];
    [mutableDict setValue:self.iDPropertyDescription forKey:kModelJFTrainexperienceDescription];
    [mutableDict setValue:self.startyear forKey:kModelJFTrainexperienceStartyear];
    [mutableDict setValue:self.endmonth forKey:kModelJFTrainexperienceEndmonth];
    [mutableDict setValue:self.course forKey:kModelJFTrainexperienceCourse];
    [mutableDict setValue:self.endyear forKey:kModelJFTrainexperienceEndyear];
    [mutableDict setValue:self.duration forKey:kModelJFTrainexperienceDuration];
    [mutableDict setValue:self.pid forKey:kModelJFTrainexperiencePid];
    [mutableDict setValue:self.agency forKey:kModelJFTrainexperienceAgency];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
