//
//  ModelFJEducation.m
//
//  Created by 林栋 隋 on 2020/9/16
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import "ModelFJEducation.h"


NSString *const kModelFJEducationId = @"id";
NSString *const kModelFJEducationTodate = @"todate";
NSString *const kModelFJEducationStartmonth = @"startmonth";
NSString *const kModelFJEducationUid = @"uid";
NSString *const kModelFJEducationSchool = @"school";
NSString *const kModelFJEducationEducationCn = @"education_cn";
NSString *const kModelFJEducationCampusId = @"campus_id";
NSString *const kModelFJEducationEndmonth = @"endmonth";
NSString *const kModelFJEducationStartyear = @"startyear";
NSString *const kModelFJEducationSpeciality = @"speciality";
NSString *const kModelFJEducationEndyear = @"endyear";
NSString *const kModelFJEducationEducation = @"education";
NSString *const kModelFJEducationPid = @"pid";
NSString *const kModelFJEducationDuration = @"duration";


@interface ModelFJEducation ()
@end

@implementation ModelFJEducation

@synthesize iDProperty = _iDProperty;
@synthesize todate = _todate;
@synthesize startmonth = _startmonth;
@synthesize uid = _uid;
@synthesize school = _school;
@synthesize educationCn = _educationCn;
@synthesize campusId = _campusId;
@synthesize endmonth = _endmonth;
@synthesize startyear = _startyear;
@synthesize speciality = _speciality;
@synthesize endyear = _endyear;
@synthesize education = _education;
@synthesize pid = _pid;
@synthesize duration = _duration;


#pragma mark init
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
        self.iDProperty = [dict stringValueForKey:kModelFJEducationId];
        self.todate = [dict stringValueForKey:kModelFJEducationTodate];
        self.startmonth = [dict stringValueForKey:kModelFJEducationStartmonth];
        self.uid = [dict stringValueForKey:kModelFJEducationUid];
        self.school = [dict stringValueForKey:kModelFJEducationSchool];
        self.educationCn = [dict stringValueForKey:kModelFJEducationEducationCn];
        self.campusId = [dict stringValueForKey:kModelFJEducationCampusId];
        self.endmonth = [dict stringValueForKey:kModelFJEducationEndmonth];
        self.startyear = [dict stringValueForKey:kModelFJEducationStartyear];
        self.speciality = [dict stringValueForKey:kModelFJEducationSpeciality];
        self.endyear = [dict stringValueForKey:kModelFJEducationEndyear];
        self.education = [dict stringValueForKey:kModelFJEducationEducation];
        self.pid = [dict stringValueForKey:kModelFJEducationPid];
        self.duration = [dict stringValueForKey:kModelFJEducationDuration];
        
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.iDProperty forKey:kModelFJEducationId];
    [mutableDict setValue:self.todate forKey:kModelFJEducationTodate];
    [mutableDict setValue:self.startmonth forKey:kModelFJEducationStartmonth];
    [mutableDict setValue:self.uid forKey:kModelFJEducationUid];
    [mutableDict setValue:self.school forKey:kModelFJEducationSchool];
    [mutableDict setValue:self.educationCn forKey:kModelFJEducationEducationCn];
    [mutableDict setValue:self.campusId forKey:kModelFJEducationCampusId];
    [mutableDict setValue:self.endmonth forKey:kModelFJEducationEndmonth];
    [mutableDict setValue:self.startyear forKey:kModelFJEducationStartyear];
    [mutableDict setValue:self.speciality forKey:kModelFJEducationSpeciality];
    [mutableDict setValue:self.endyear forKey:kModelFJEducationEndyear];
    [mutableDict setValue:self.education forKey:kModelFJEducationEducation];
    [mutableDict setValue:self.pid forKey:kModelFJEducationPid];
    [mutableDict setValue:self.duration forKey:kModelFJEducationDuration];
    
    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

+ (NSString *)transferYear:(NSString *)year month:(NSString *)month{
    if (isStr(year)&&isStr(month)) {
        return  [NSString stringWithFormat:@"%@-%02lld",year,month.longLongValue];
    }
    return nil;
}

@end
