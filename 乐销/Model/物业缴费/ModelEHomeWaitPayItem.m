//
//  ModelEHomeWaitPayItem.m
//
//  Created by 林栋 隋 on 2020/10/10
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import "ModelEHomeWaitPayItem.h"


NSString *const kModelEHomeWaitPayItemFeesStartDate = @"feesStartDate";
NSString *const kModelEHomeWaitPayItemDebtsAmount = @"debtsAmount";
NSString *const kModelEHomeWaitPayItemFeesEndDate = @"feesEndDate";
NSString *const kModelEHomeWaitPayItemDueFineFee = @"dueFineFee";
NSString *const kModelEHomeWaitPayItemFeesId = @"feesId";


@interface ModelEHomeWaitPayItem ()
@end

@implementation ModelEHomeWaitPayItem

@synthesize feesStartDate = _feesStartDate;
@synthesize debtsAmount = _debtsAmount;
@synthesize feesEndDate = _feesEndDate;
@synthesize dueFineFee = _dueFineFee;
@synthesize feesId = _feesId;


#pragma mark init
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.feesStartDate = [dict stringValueForKey:kModelEHomeWaitPayItemFeesStartDate];
            self.debtsAmount = [dict doubleValueForKey:kModelEHomeWaitPayItemDebtsAmount];
            self.feesEndDate = [dict stringValueForKey:kModelEHomeWaitPayItemFeesEndDate];
            self.dueFineFee = [dict doubleValueForKey:kModelEHomeWaitPayItemDueFineFee];
            self.feesId = [dict stringValueForKey:kModelEHomeWaitPayItemFeesId];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.feesStartDate forKey:kModelEHomeWaitPayItemFeesStartDate];
    [mutableDict setValue:[NSNumber numberWithDouble:self.debtsAmount] forKey:kModelEHomeWaitPayItemDebtsAmount];
    [mutableDict setValue:self.feesEndDate forKey:kModelEHomeWaitPayItemFeesEndDate];
    [mutableDict setValue:[NSNumber numberWithDouble:self.dueFineFee] forKey:kModelEHomeWaitPayItemDueFineFee];
    [mutableDict setValue:self.feesId forKey:kModelEHomeWaitPayItemFeesId];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
