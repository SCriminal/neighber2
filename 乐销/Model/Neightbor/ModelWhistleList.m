//
//  ModelWhistleList.m
//
//  Created by 林栋 隋 on 2020/3/18
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import "ModelWhistleList.h"


NSString *const kModelWhistleListStatus = @"status";
NSString *const kModelWhistleListId = @"id";
NSString *const kModelWhistleListWhistleTime = @"whistleTime";
NSString *const kModelWhistleListDescription = @"description";
NSString *const kModelWhistleListCategoryName = @"categoryName";
NSString *const kModelWhistleListUrls = @"urls";
NSString *const kModelWhistleListScore = @"score";
NSString *const kModelWhistleListEvaluation = @"evaluation";
NSString *const kModelWhistleListSolutionResult = @"solutionResult";
NSString *const kModelWhistleListResults = @"results";
NSString *const kModelWhistleListHandleTime = @"handleTime";
NSString *const kModelWhistleListPushTime = @"pushTime";
NSString *const kModelWhistleListEvaluateTime = @"evaluateTime";

@interface ModelWhistleList ()
@end

@implementation ModelWhistleList

@synthesize status = _status;
@synthesize iDProperty = _iDProperty;
@synthesize whistleTime = _whistleTime;
@synthesize iDPropertyDescription = _iDPropertyDescription;
@synthesize categoryName = _categoryName;


#pragma mark init
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.status = [dict doubleValueForKey:kModelWhistleListStatus];
            self.iDProperty = [dict doubleValueForKey:kModelWhistleListId];
            self.whistleTime = [dict doubleValueForKey:kModelWhistleListWhistleTime];
            self.iDPropertyDescription = [dict stringValueForKey:kModelWhistleListDescription];
            self.categoryName = [dict stringValueForKey:kModelWhistleListCategoryName];
        self.urls =  [dict arrayValueForKey:kModelWhistleListUrls];
        self.score = [dict doubleValueForKey:kModelWhistleListScore];
        self.evaluation = [dict stringValueForKey:kModelWhistleListEvaluation];
        self.solutionResult = [dict stringValueForKey:kModelWhistleListSolutionResult];
        self.results = [GlobalMethod exchangeDic:[dict arrayValueForKey:kModelWhistleListResults] toAryWithModelName:@"ModelWhistleProgress"] ;
        self.handleTime = [dict doubleValueForKey:kModelWhistleListHandleTime];
        self.pushTime = [dict doubleValueForKey:kModelWhistleListPushTime];
        self.evaluateTime = [dict doubleValueForKey:kModelWhistleListEvaluateTime];
//1已发哨 3已吹哨 6已处理 9已处理 10已评价
        switch ((int)self.status) {
            case 1:
            {
                self.statusShow = @"已发哨";
                self.statusColorShow = COLOR_ORANGE;
            }
                break;
            case 3:
            {
                self.statusShow = @"已吹哨";
                self.statusColorShow = COLOR_ORANGE;
            }
                break;
            case 6:
            {
                self.statusShow = @"已处理";
                self.statusColorShow = COLOR_GREEN;

            }
                break;
            case 9:
            {
                self.statusShow = @"已处理";
                self.statusColorShow = COLOR_GREEN;
            }
                break;
            case 10:
            {
                self.statusShow = @"已评价";
                self.statusColorShow = [UIColor colorWithHexString:@"35B2FF"];
            }
                break;
            default:
                break;
        }
        self.aryImages = [NSMutableArray new];
        for (NSString * strURL in self.urls) {
            ModelImage * model = [ModelImage new];
            model.url = strURL;
            [self.aryImages addObject:model];
        }
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.status] forKey:kModelWhistleListStatus];
    [mutableDict setValue:[NSNumber numberWithDouble:self.iDProperty] forKey:kModelWhistleListId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.whistleTime] forKey:kModelWhistleListWhistleTime];
    [mutableDict setValue:self.iDPropertyDescription forKey:kModelWhistleListDescription];
    [mutableDict setValue:self.categoryName forKey:kModelWhistleListCategoryName];
    [mutableDict setValue:[GlobalMethod exchangeAryModelToAryDic:self.urls] forKey:kModelWhistleListUrls];
    [mutableDict setValue:[NSNumber numberWithDouble:self.score] forKey:kModelWhistleListScore];
    [mutableDict setValue:self.evaluation forKey:kModelWhistleListEvaluation];
    [mutableDict setValue:self.solutionResult forKey:kModelWhistleListSolutionResult];
    [mutableDict setValue:[GlobalMethod exchangeAryModelToAryDic:self.results] forKey:kModelWhistleListResults];
    [mutableDict setValue:[NSNumber numberWithDouble:self.handleTime] forKey:kModelWhistleListHandleTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.pushTime] forKey:kModelWhistleListPushTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.evaluateTime] forKey:kModelWhistleListEvaluateTime];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
