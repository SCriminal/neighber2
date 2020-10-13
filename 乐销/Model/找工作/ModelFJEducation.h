//
//  ModelFJEducation.h
//
//  Created by 林栋 隋 on 2020/9/16
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelFJEducation : NSObject

@property (nonatomic, strong) NSString *iDProperty;
@property (nonatomic, strong) NSString *todate;
@property (nonatomic, strong) NSString *startmonth;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *school;
@property (nonatomic, strong) NSString *educationCn;
@property (nonatomic, strong) NSString *campusId;
@property (nonatomic, strong) NSString *endmonth;
@property (nonatomic, strong) NSString *startyear;
@property (nonatomic, strong) NSString *speciality;
@property (nonatomic, strong) NSString *endyear;
@property (nonatomic, strong) NSString *education;
@property (nonatomic, strong) NSString *pid;
@property (nonatomic, strong) NSString *duration;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

+ (NSString *)transferYear:(NSString *)year month:(NSString *)month;

@end
