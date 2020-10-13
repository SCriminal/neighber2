//
//  ModelHailuoAunt.m
//
//  Created by 林栋 隋 on 2020/8/18
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import "ModelHailuoAunt.h"


NSString *const kModelHailuoAuntAuntId = @"aunt_id";
NSString *const kModelHailuoAuntStart = @"start";
NSString *const kModelHailuoAuntEstimatePrice = @"estimate_price";
NSString *const kModelHailuoAuntCommentCount = @"comment_count";
NSString *const kModelHailuoAuntAge = @"age";
NSString *const kModelHailuoAuntWorkingYears = @"working_years";
NSString *const kModelHailuoAuntCredit = @"credit";
NSString *const kModelHailuoAuntAddress = @"address";
NSString *const kModelHailuoAuntGood = @"good";
NSString *const kModelHailuoAuntOrderCount = @"order_count";
NSString *const kModelHailuoAuntPhoto = @"photo";
NSString *const kModelHailuoAuntName = @"name";
NSString *const kModelHailuoAuntHealth = @"health";
NSString *const kModelHailuoAuntNation = @"nation";
NSString *const kModelHailuoAuntSkill = @"skill";
NSString *const kModelHailuoAuntCheckBackground = @"check_background";
NSString *const kModelHailuoAuntEducation = @"education";
NSString *const kModelHailuoAuntShowPhoto = @"show_photo";
NSString *const kModelHailuoAuntEstimate = @"estimate";
NSString *const kModelHailuoAuntCheckIdCard = @"check_id_card";


@interface ModelHailuoAunt ()
@end

@implementation ModelHailuoAunt

@synthesize auntId = _auntId;
@synthesize start = _start;
@synthesize estimatePrice = _estimatePrice;
@synthesize commentCount = _commentCount;
@synthesize age = _age;
@synthesize workingYears = _workingYears;
@synthesize credit = _credit;
@synthesize address = _address;
@synthesize good = _good;
@synthesize orderCount = _orderCount;
@synthesize photo = _photo;
@synthesize name = _name;


#pragma mark init
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
        self.auntId = [dict doubleValueForKey:kModelHailuoAuntAuntId];
        self.start = [dict stringValueForKey:kModelHailuoAuntStart];
        self.estimatePrice = [dict doubleValueForKey:kModelHailuoAuntEstimatePrice];
        self.commentCount = [dict doubleValueForKey:kModelHailuoAuntCommentCount];
        self.age = [dict doubleValueForKey:kModelHailuoAuntAge];
        self.workingYears = [dict doubleValueForKey:kModelHailuoAuntWorkingYears];
        self.credit = [dict doubleValueForKey:kModelHailuoAuntCredit];
        self.address = [dict stringValueForKey:kModelHailuoAuntAddress];
        self.good = [dict stringValueForKey:kModelHailuoAuntGood];
        self.orderCount = [dict doubleValueForKey:kModelHailuoAuntOrderCount];
        
        self.name = [dict stringValueForKey:kModelHailuoAuntName];
        self.health = [dict doubleValueForKey:kModelHailuoAuntHealth];
        self.nation = [dict stringValueForKey:kModelHailuoAuntNation];
        self.skill = [dict doubleValueForKey:kModelHailuoAuntSkill];
        self.checkBackground = [dict doubleValueForKey:kModelHailuoAuntCheckBackground];
        self.education = [dict stringValueForKey:kModelHailuoAuntEducation];
        self.estimate = [dict stringValueForKey:kModelHailuoAuntEstimate];
        self.checkIdCard = [dict doubleValueForKey:kModelHailuoAuntCheckIdCard];
        
        self.photo = [dict stringValueForKey:kModelHailuoAuntPhoto];
        self.photo = [self.photo hailuoImage];
        
        if (self.credit == 1) {
            self.creditShow = @"信用优";
        }else if (self.credit == 2) {
            self.creditShow = @"信用差";
        }else if (self.credit == 3) {
            self.creditShow = @"信用良";
        }
        
        NSMutableArray * ary = [NSMutableArray new];
        NSArray * aryImage = [dict arrayValueForKey:kModelHailuoAuntShowPhoto];
        for (NSString * strUrl in aryImage) {
            [ary addObject:[strUrl hailuoImage]];
        }
        self.showPhoto = ary;
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.auntId] forKey:kModelHailuoAuntAuntId];
    [mutableDict setValue:self.start forKey:kModelHailuoAuntStart];
    [mutableDict setValue:[NSNumber numberWithDouble:self.estimatePrice] forKey:kModelHailuoAuntEstimatePrice];
    [mutableDict setValue:[NSNumber numberWithDouble:self.commentCount] forKey:kModelHailuoAuntCommentCount];
    [mutableDict setValue:[NSNumber numberWithDouble:self.age] forKey:kModelHailuoAuntAge];
    [mutableDict setValue:[NSNumber numberWithDouble:self.workingYears] forKey:kModelHailuoAuntWorkingYears];
    [mutableDict setValue:[NSNumber numberWithDouble:self.credit] forKey:kModelHailuoAuntCredit];
    [mutableDict setValue:self.address forKey:kModelHailuoAuntAddress];
    [mutableDict setValue:self.good forKey:kModelHailuoAuntGood];
    [mutableDict setValue:[NSNumber numberWithDouble:self.orderCount] forKey:kModelHailuoAuntOrderCount];
    [mutableDict setValue:self.photo forKey:kModelHailuoAuntPhoto];
    [mutableDict setValue:self.name forKey:kModelHailuoAuntName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.health] forKey:kModelHailuoAuntHealth];
    [mutableDict setValue:self.nation forKey:kModelHailuoAuntNation];
    [mutableDict setValue:[NSNumber numberWithDouble:self.skill] forKey:kModelHailuoAuntSkill];
    [mutableDict setValue:[NSNumber numberWithDouble:self.checkBackground] forKey:kModelHailuoAuntCheckBackground];
    [mutableDict setValue:self.education forKey:kModelHailuoAuntEducation];
    [mutableDict setValue:[GlobalMethod exchangeAryModelToAryDic:self.showPhoto] forKey:kModelHailuoAuntShowPhoto];
    [mutableDict setValue:self.estimate forKey:kModelHailuoAuntEstimate];
    [mutableDict setValue:[NSNumber numberWithDouble:self.checkIdCard] forKey:kModelHailuoAuntCheckIdCard];
    
    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
