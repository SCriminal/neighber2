//
//  ModelHailuoAunt.h
//
//  Created by 林栋 隋 on 2020/8/18
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelHailuoAunt : NSObject

@property (nonatomic, assign) double auntId;
@property (nonatomic, strong) NSString *start;
@property (nonatomic, assign) double estimatePrice;
@property (nonatomic, assign) double commentCount;
@property (nonatomic, assign) double age;
@property (nonatomic, assign) double workingYears;
@property (nonatomic, assign) double credit;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *good;
@property (nonatomic, assign) double orderCount;
@property (nonatomic, strong) NSString *photo;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *creditShow;
@property (nonatomic, assign) double health;
@property (nonatomic, strong) NSString *nation;
@property (nonatomic, assign) double skill;
@property (nonatomic, assign) double checkBackground;
@property (nonatomic, strong) NSString *education;
@property (nonatomic, strong) NSArray *showPhoto;
@property (nonatomic, strong) NSString *estimate;
@property (nonatomic, assign) double checkIdCard;
@property (nonatomic, strong) NSArray *aryServe;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
