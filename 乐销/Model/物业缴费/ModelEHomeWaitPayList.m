//
//  ModelEHomeWaitPayList.m
//
//  Created by 林栋 隋 on 2020/10/10
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import "ModelEHomeWaitPayList.h"


NSString *const kModelEHomeWaitPayListItemId = @"itemId";
NSString *const kModelEHomeWaitPayListRoomId = @"roomId";
NSString *const kModelEHomeWaitPayListFeesEndDate = @"feesEndDate";
NSString *const kModelEHomeWaitPayListFeesIds = @"feesIds";
NSString *const kModelEHomeWaitPayListDebtsAmount = @"debtsAmount";
NSString *const kModelEHomeWaitPayListFeeStateName = @"feeStateName";
NSString *const kModelEHomeWaitPayListFeesStartDate = @"feesStartDate";
NSString *const kModelEHomeWaitPayListBillCount = @"billCount";
NSString *const kModelEHomeWaitPayListDueFineFee = @"dueFineFee";
NSString *const kModelEHomeWaitPayListItemType = @"itemType";


@interface ModelEHomeWaitPayList ()
@end

@implementation ModelEHomeWaitPayList

@synthesize itemId = _itemId;
@synthesize roomId = _roomId;
@synthesize feesEndDate = _feesEndDate;
@synthesize feesIds = _feesIds;
@synthesize debtsAmount = _debtsAmount;
@synthesize feeStateName = _feeStateName;
@synthesize feesStartDate = _feesStartDate;
@synthesize billCount = _billCount;
@synthesize dueFineFee = _dueFineFee;
@synthesize itemType = _itemType;


#pragma mark init
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.itemId = [dict stringValueForKey:kModelEHomeWaitPayListItemId];
            self.roomId = [dict stringValueForKey:kModelEHomeWaitPayListRoomId];
            self.feesEndDate = [dict stringValueForKey:kModelEHomeWaitPayListFeesEndDate];
        self.feesIds =  [dict arrayValueForKey:kModelEHomeWaitPayListFeesIds];
            self.debtsAmount = [dict doubleValueForKey:kModelEHomeWaitPayListDebtsAmount];
            self.feeStateName = [dict stringValueForKey:kModelEHomeWaitPayListFeeStateName];
            self.feesStartDate = [dict stringValueForKey:kModelEHomeWaitPayListFeesStartDate];
            self.billCount = [dict stringValueForKey:kModelEHomeWaitPayListBillCount];
            self.dueFineFee = [dict doubleValueForKey:kModelEHomeWaitPayListDueFineFee];
            self.itemType = [dict stringValueForKey:kModelEHomeWaitPayListItemType];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.itemId forKey:kModelEHomeWaitPayListItemId];
    [mutableDict setValue:self.roomId forKey:kModelEHomeWaitPayListRoomId];
    [mutableDict setValue:self.feesEndDate forKey:kModelEHomeWaitPayListFeesEndDate];
    [mutableDict setValue:self.feesIds forKey:kModelEHomeWaitPayListFeesIds];
    [mutableDict setValue:[NSNumber numberWithDouble:self.debtsAmount] forKey:kModelEHomeWaitPayListDebtsAmount];
    [mutableDict setValue:self.feeStateName forKey:kModelEHomeWaitPayListFeeStateName];
    [mutableDict setValue:self.feesStartDate forKey:kModelEHomeWaitPayListFeesStartDate];
    [mutableDict setValue:self.billCount forKey:kModelEHomeWaitPayListBillCount];
    [mutableDict setValue:[NSNumber numberWithDouble:self.dueFineFee] forKey:kModelEHomeWaitPayListDueFineFee];
    [mutableDict setValue:self.itemType forKey:kModelEHomeWaitPayListItemType];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
