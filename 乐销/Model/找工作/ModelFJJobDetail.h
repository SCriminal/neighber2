//
//  ModelFJJobDetail.h
//
//  Created by 林栋 隋 on 2020/9/22
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelFJJobDetail : NSObject

@property (nonatomic, strong) NSString *maxwage;
@property (nonatomic, assign) double isApply;
@property (nonatomic, strong) NSString *jobsName;
@property (nonatomic, strong) NSString *natureCn;
@property (nonatomic, strong) NSString *amount;
@property (nonatomic, strong) ModelFJCompany *company;
@property (nonatomic, strong) NSString *refreshtimeCn;
@property (nonatomic, strong) NSString *refreshtime;
@property (nonatomic, strong) NSString *experienceCn;
@property (nonatomic, strong) NSString *educationCn;
@property (nonatomic, strong) NSString *contents;
@property (nonatomic, strong) NSString *districtCn;
@property (nonatomic, strong) NSString *iDProperty;
@property (nonatomic, strong) NSString *companyId;
@property (nonatomic, strong) NSString *department;
@property (nonatomic, strong) NSString *addtime;
@property (nonatomic, strong) NSString *minwage;
@property (nonatomic, strong) NSString *wageCn;
@property (nonatomic, strong) NSString *age;
@property (nonatomic, strong) NSString *tagCn;
@property (nonatomic, strong) NSString *companyname;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
