//
//  ModelFJWorkExperience.h
//
//  Created by 林栋 隋 on 2020/9/16
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelFJWorkExperience : NSObject

@property (nonatomic, strong) NSString *iDProperty;
@property (nonatomic, strong) NSString *todate;
@property (nonatomic, strong) NSString *startmonth;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *jobs;
@property (nonatomic, strong) NSString *startyear;
@property (nonatomic, strong) NSString *endmonth;
@property (nonatomic, strong) NSString *endyear;
@property (nonatomic, strong) NSString *duration;
@property (nonatomic, strong) NSString *companyname;
@property (nonatomic, strong) NSString *achievements;
@property (nonatomic, strong) NSString *pid;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
