//
//  ModelFJWorkExperience.m
//
//  Created by 林栋 隋 on 2020/9/16
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import "ModelFJWorkExperience.h"


NSString *const kModelFJWorkExperienceId = @"id";
NSString *const kModelFJWorkExperienceTodate = @"todate";
NSString *const kModelFJWorkExperienceStartmonth = @"startmonth";
NSString *const kModelFJWorkExperienceUid = @"uid";
NSString *const kModelFJWorkExperienceJobs = @"jobs";
NSString *const kModelFJWorkExperienceStartyear = @"startyear";
NSString *const kModelFJWorkExperienceEndmonth = @"endmonth";
NSString *const kModelFJWorkExperienceEndyear = @"endyear";
NSString *const kModelFJWorkExperienceDuration = @"duration";
NSString *const kModelFJWorkExperienceCompanyname = @"companyname";
NSString *const kModelFJWorkExperienceAchievements = @"achievements";
NSString *const kModelFJWorkExperiencePid = @"pid";


@interface ModelFJWorkExperience ()
@end

@implementation ModelFJWorkExperience

@synthesize iDProperty = _iDProperty;
@synthesize todate = _todate;
@synthesize startmonth = _startmonth;
@synthesize uid = _uid;
@synthesize jobs = _jobs;
@synthesize startyear = _startyear;
@synthesize endmonth = _endmonth;
@synthesize endyear = _endyear;
@synthesize duration = _duration;
@synthesize companyname = _companyname;
@synthesize achievements = _achievements;
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
            self.iDProperty = [dict stringValueForKey:kModelFJWorkExperienceId];
            self.todate = [dict stringValueForKey:kModelFJWorkExperienceTodate];
            self.startmonth = [dict stringValueForKey:kModelFJWorkExperienceStartmonth];
            self.uid = [dict stringValueForKey:kModelFJWorkExperienceUid];
            self.jobs = [dict stringValueForKey:kModelFJWorkExperienceJobs];
            self.startyear = [dict stringValueForKey:kModelFJWorkExperienceStartyear];
            self.endmonth = [dict stringValueForKey:kModelFJWorkExperienceEndmonth];
            self.endyear = [dict stringValueForKey:kModelFJWorkExperienceEndyear];
            self.duration = [dict stringValueForKey:kModelFJWorkExperienceDuration];
            self.companyname = [dict stringValueForKey:kModelFJWorkExperienceCompanyname];
            self.achievements = [dict stringValueForKey:kModelFJWorkExperienceAchievements];
            self.pid = [dict stringValueForKey:kModelFJWorkExperiencePid];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.iDProperty forKey:kModelFJWorkExperienceId];
    [mutableDict setValue:self.todate forKey:kModelFJWorkExperienceTodate];
    [mutableDict setValue:self.startmonth forKey:kModelFJWorkExperienceStartmonth];
    [mutableDict setValue:self.uid forKey:kModelFJWorkExperienceUid];
    [mutableDict setValue:self.jobs forKey:kModelFJWorkExperienceJobs];
    [mutableDict setValue:self.startyear forKey:kModelFJWorkExperienceStartyear];
    [mutableDict setValue:self.endmonth forKey:kModelFJWorkExperienceEndmonth];
    [mutableDict setValue:self.endyear forKey:kModelFJWorkExperienceEndyear];
    [mutableDict setValue:self.duration forKey:kModelFJWorkExperienceDuration];
    [mutableDict setValue:self.companyname forKey:kModelFJWorkExperienceCompanyname];
    [mutableDict setValue:self.achievements forKey:kModelFJWorkExperienceAchievements];
    [mutableDict setValue:self.pid forKey:kModelFJWorkExperiencePid];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
