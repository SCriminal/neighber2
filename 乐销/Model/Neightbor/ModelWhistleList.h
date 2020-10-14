//
//  ModelWhistleList.h
//
//  Created by 林栋 隋 on 2020/3/18
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelWhistleList : NSObject

@property (nonatomic, assign) double status;
@property (nonatomic, assign) double iDProperty;
@property (nonatomic, assign) double whistleTime;
@property (nonatomic, strong) NSString *iDPropertyDescription;
@property (nonatomic, strong) NSString *categoryName;
@property (nonatomic, strong) NSArray *urls;
@property (nonatomic, strong) NSArray *photo9Urls;

@property (nonatomic, assign) double score;
@property (nonatomic, strong) NSString *evaluation;
@property (nonatomic, strong) NSString *solutionResult;
@property (nonatomic, strong) NSArray *results;
@property (nonatomic, assign) double handleTime;
@property (nonatomic, assign) double pushTime;
@property (nonatomic, assign) double evaluateTime;
//logical
@property (nonatomic, strong) NSString *statusShow;
@property (nonatomic, strong) UIColor *statusColorShow;
@property (nonatomic, strong) NSMutableArray *aryImages;
@property (nonatomic, strong) NSMutableArray *ary9UrlImages;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
