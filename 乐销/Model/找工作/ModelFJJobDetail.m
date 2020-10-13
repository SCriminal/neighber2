//
//  ModelFJJobDetail.m
//
//  Created by 林栋 隋 on 2020/9/22
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import "ModelFJJobDetail.h"


NSString *const kModelFJJobDetailMaxwage = @"maxwage";
NSString *const kModelFJJobDetailIsApply = @"is_apply";
NSString *const kModelFJJobDetailJobsName = @"jobs_name";
NSString *const kModelFJJobDetailNatureCn = @"nature_cn";
NSString *const kModelFJJobDetailAmount = @"amount";
NSString *const kModelFJJobDetailCompany = @"company";
NSString *const kModelFJJobDetailRefreshtimeCn = @"refreshtime_cn";
NSString *const kModelFJJobDetailRefreshtime = @"refreshtime";
NSString *const kModelFJJobDetailExperienceCn = @"experience_cn";
NSString *const kModelFJJobDetailEducationCn = @"education_cn";
NSString *const kModelFJJobDetailContents = @"contents";
NSString *const kModelFJJobDetailDistrictCn = @"district_cn";
NSString *const kModelFJJobDetailId = @"id";
NSString *const kModelFJJobDetailCompanyId = @"company_id";
NSString *const kModelFJJobDetailDepartment = @"department";
NSString *const kModelFJJobDetailAddtime = @"addtime";
NSString *const kModelFJJobDetailMinwage = @"minwage";
NSString *const kModelFJJobDetailWageCn = @"wage_cn";
NSString *const kModelFJJobDetailAge = @"age";
NSString *const kModelFJJobDetailTagCn = @"tag_cn";
NSString *const kModelFJJobDetailCompanyname = @"companyname";


@interface ModelFJJobDetail ()
@end

@implementation ModelFJJobDetail

@synthesize maxwage = _maxwage;
@synthesize isApply = _isApply;
@synthesize jobsName = _jobsName;
@synthesize natureCn = _natureCn;
@synthesize amount = _amount;
@synthesize company = _company;
@synthesize refreshtimeCn = _refreshtimeCn;
@synthesize refreshtime = _refreshtime;
@synthesize experienceCn = _experienceCn;
@synthesize educationCn = _educationCn;
@synthesize contents = _contents;
@synthesize districtCn = _districtCn;
@synthesize iDProperty = _iDProperty;
@synthesize companyId = _companyId;
@synthesize department = _department;
@synthesize addtime = _addtime;
@synthesize minwage = _minwage;
@synthesize wageCn = _wageCn;
@synthesize age = _age;
@synthesize tagCn = _tagCn;
@synthesize companyname = _companyname;


#pragma mark init
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.maxwage = [dict stringValueForKey:kModelFJJobDetailMaxwage];
            self.isApply = [dict doubleValueForKey:kModelFJJobDetailIsApply];
            self.jobsName = [dict stringValueForKey:kModelFJJobDetailJobsName];
            self.natureCn = [dict stringValueForKey:kModelFJJobDetailNatureCn];
            self.amount = [dict stringValueForKey:kModelFJJobDetailAmount];
            self.company = [ModelFJCompany modelObjectWithDictionary:[dict dictionaryValueForKey:kModelFJJobDetailCompany]];
            self.refreshtimeCn = [dict stringValueForKey:kModelFJJobDetailRefreshtimeCn];
            self.refreshtime = [dict stringValueForKey:kModelFJJobDetailRefreshtime];
            self.experienceCn = [dict stringValueForKey:kModelFJJobDetailExperienceCn];
            self.educationCn = [dict stringValueForKey:kModelFJJobDetailEducationCn];
            self.contents = [dict stringValueForKey:kModelFJJobDetailContents];
            self.districtCn = [dict stringValueForKey:kModelFJJobDetailDistrictCn];
            self.iDProperty = [dict stringValueForKey:kModelFJJobDetailId];
            self.companyId = [dict stringValueForKey:kModelFJJobDetailCompanyId];
            self.department = [dict stringValueForKey:kModelFJJobDetailDepartment];
            self.addtime = [dict stringValueForKey:kModelFJJobDetailAddtime];
            self.minwage = [dict stringValueForKey:kModelFJJobDetailMinwage];
            self.wageCn = [dict stringValueForKey:kModelFJJobDetailWageCn];
            self.age = [dict stringValueForKey:kModelFJJobDetailAge];
            self.tagCn = [dict stringValueForKey:kModelFJJobDetailTagCn];
            self.companyname = [dict stringValueForKey:kModelFJJobDetailCompanyname];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.maxwage forKey:kModelFJJobDetailMaxwage];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isApply] forKey:kModelFJJobDetailIsApply];
    [mutableDict setValue:self.jobsName forKey:kModelFJJobDetailJobsName];
    [mutableDict setValue:self.natureCn forKey:kModelFJJobDetailNatureCn];
    [mutableDict setValue:self.amount forKey:kModelFJJobDetailAmount];
    [mutableDict setValue:self.company forKey:kModelFJJobDetailCompany];
    [mutableDict setValue:self.refreshtimeCn forKey:kModelFJJobDetailRefreshtimeCn];
    [mutableDict setValue:self.refreshtime forKey:kModelFJJobDetailRefreshtime];
    [mutableDict setValue:self.experienceCn forKey:kModelFJJobDetailExperienceCn];
    [mutableDict setValue:self.educationCn forKey:kModelFJJobDetailEducationCn];
    [mutableDict setValue:self.contents forKey:kModelFJJobDetailContents];
    [mutableDict setValue:self.districtCn forKey:kModelFJJobDetailDistrictCn];
    [mutableDict setValue:self.iDProperty forKey:kModelFJJobDetailId];
    [mutableDict setValue:self.companyId forKey:kModelFJJobDetailCompanyId];
    [mutableDict setValue:self.department forKey:kModelFJJobDetailDepartment];
    [mutableDict setValue:self.addtime forKey:kModelFJJobDetailAddtime];
    [mutableDict setValue:self.minwage forKey:kModelFJJobDetailMinwage];
    [mutableDict setValue:self.wageCn forKey:kModelFJJobDetailWageCn];
    [mutableDict setValue:self.age forKey:kModelFJJobDetailAge];
    [mutableDict setValue:self.tagCn forKey:kModelFJJobDetailTagCn];
    [mutableDict setValue:self.companyname forKey:kModelFJJobDetailCompanyname];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
