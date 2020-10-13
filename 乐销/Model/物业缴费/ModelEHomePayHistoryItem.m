//
//  ModelEHomePayHistoryItem.m
//
//  Created by 林栋 隋 on 2020/10/13
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import "ModelEHomePayHistoryItem.h"


NSString *const kModelEHomePayHistoryItemFeesId = @"feesId";
NSString *const kModelEHomePayHistoryItemPayAmount = @"payAmount";
NSString *const kModelEHomePayHistoryItemPayType = @"payType";
NSString *const kModelEHomePayHistoryItemFeeStateName = @"feeStateName";
NSString *const kModelEHomePayHistoryItemPayDate = @"payDate";
NSString *const kModelEHomePayHistoryItemCustName = @"custName";
NSString *const kModelEHomePayHistoryItemCostName = @"costName";
NSString *const kModelEHomePayHistoryItemItemType = @"itemType";
NSString *const kModelEHomePayHistoryItemUnitNo = @"unitNo";
NSString *const kModelEHomePayHistoryItemRoomNo = @"roomNo";
NSString *const kModelEHomePayHistoryItemPayStatus = @"payStatus";
NSString *const kModelEHomePayHistoryItemFloorName = @"floorName";
NSString *const kModelEHomePayHistoryItemReceiveCompany = @"receiveCompany";
NSString *const kModelEHomePayHistoryItemAreaName = @"areaName";
NSString *const kModelEHomePayHistoryItemEleSignUrl = @"eleSignUrl";

@interface ModelEHomePayHistoryItem ()
@end

@implementation ModelEHomePayHistoryItem

@synthesize feesId = _feesId;
@synthesize payAmount = _payAmount;
@synthesize payType = _payType;
@synthesize feeStateName = _feeStateName;
@synthesize payDate = _payDate;
@synthesize custName = _custName;
@synthesize costName = _costName;
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
            self.feesId = [dict stringValueForKey:kModelEHomePayHistoryItemFeesId];
            self.payAmount = [dict doubleValueForKey:kModelEHomePayHistoryItemPayAmount];
            self.payType = [dict stringValueForKey:kModelEHomePayHistoryItemPayType];
            self.feeStateName = [dict stringValueForKey:kModelEHomePayHistoryItemFeeStateName];
            self.payDate = [dict stringValueForKey:kModelEHomePayHistoryItemPayDate];
            self.custName = [dict stringValueForKey:kModelEHomePayHistoryItemCustName];
            self.costName = [dict stringValueForKey:kModelEHomePayHistoryItemCostName];
            self.itemType = [dict stringValueForKey:kModelEHomePayHistoryItemItemType];
        self.unitNo = [dict stringValueForKey:kModelEHomePayHistoryItemUnitNo];
                  self.roomNo = [dict stringValueForKey:kModelEHomePayHistoryItemRoomNo];
                  self.payStatus = [dict stringValueForKey:kModelEHomePayHistoryItemPayStatus];
                  self.floorName = [dict stringValueForKey:kModelEHomePayHistoryItemFloorName];
                  self.receiveCompany = [dict stringValueForKey:kModelEHomePayHistoryItemReceiveCompany];
                  self.areaName = [dict stringValueForKey:kModelEHomePayHistoryItemAreaName];
                  self.eleSignUrl = [dict stringValueForKey:kModelEHomePayHistoryItemEleSignUrl];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.feesId forKey:kModelEHomePayHistoryItemFeesId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.payAmount] forKey:kModelEHomePayHistoryItemPayAmount];
    [mutableDict setValue:self.payType forKey:kModelEHomePayHistoryItemPayType];
    [mutableDict setValue:self.feeStateName forKey:kModelEHomePayHistoryItemFeeStateName];
    [mutableDict setValue:self.payDate forKey:kModelEHomePayHistoryItemPayDate];
    [mutableDict setValue:self.custName forKey:kModelEHomePayHistoryItemCustName];
    [mutableDict setValue:self.costName forKey:kModelEHomePayHistoryItemCostName];
    [mutableDict setValue:self.itemType forKey:kModelEHomePayHistoryItemItemType];
    [mutableDict setValue:self.unitNo forKey:kModelEHomePayHistoryItemUnitNo];
      [mutableDict setValue:self.roomNo forKey:kModelEHomePayHistoryItemRoomNo];
      [mutableDict setValue:self.payStatus forKey:kModelEHomePayHistoryItemPayStatus];
      [mutableDict setValue:self.floorName forKey:kModelEHomePayHistoryItemFloorName];
      [mutableDict setValue:self.receiveCompany forKey:kModelEHomePayHistoryItemReceiveCompany];
      [mutableDict setValue:self.areaName forKey:kModelEHomePayHistoryItemAreaName];
      [mutableDict setValue:self.eleSignUrl forKey:kModelEHomePayHistoryItemEleSignUrl];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
