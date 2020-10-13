//
//  ModelEhomeWaitPayInfo.m
//
//  Created by 林栋 隋 on 2020/10/10
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import "ModelEhomeWaitPayInfo.h"


NSString *const kModelEhomeWaitPayInfoItemType = @"itemType";
NSString *const kModelEhomeWaitPayInfoRoomNo = @"roomNo";
NSString *const kModelEhomeWaitPayInfoAllDueFees = @"allDueFees";
NSString *const kModelEhomeWaitPayInfoCount = @"count";
NSString *const kModelEhomeWaitPayInfoAllFees = @"allFees";
NSString *const kModelEhomeWaitPayInfoRoomId = @"roomId";
NSString *const kModelEhomeWaitPayInfoBillList = @"billList";
NSString *const kModelEhomeWaitPayInfoUnitNo = @"unitNo";
NSString *const kModelEhomeWaitPayInfoFeeStateName = @"feeStateName";
NSString *const kModelEhomeWaitPayInfoFloorName = @"floorName";
NSString *const kModelEhomeWaitPayInfoCustName = @"custName";
NSString *const kModelEhomeWaitPayInfoAreaName = @"areaName";


@interface ModelEhomeWaitPayInfo ()
@end

@implementation ModelEhomeWaitPayInfo

@synthesize itemType = _itemType;
@synthesize roomNo = _roomNo;
@synthesize allDueFees = _allDueFees;
@synthesize count = _count;
@synthesize allFees = _allFees;
@synthesize roomId = _roomId;
@synthesize billList = _billList;
@synthesize unitNo = _unitNo;
@synthesize feeStateName = _feeStateName;
@synthesize floorName = _floorName;
@synthesize custName = _custName;
@synthesize areaName = _areaName;


#pragma mark init
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.itemType = [dict stringValueForKey:kModelEhomeWaitPayInfoItemType];
            self.roomNo = [dict stringValueForKey:kModelEhomeWaitPayInfoRoomNo];
            self.allDueFees = [dict doubleValueForKey:kModelEhomeWaitPayInfoAllDueFees];
            self.count = [dict doubleValueForKey:kModelEhomeWaitPayInfoCount];
            self.allFees = [dict stringValueForKey:kModelEhomeWaitPayInfoAllFees];
            self.roomId = [dict stringValueForKey:kModelEhomeWaitPayInfoRoomId];
        self.billList = [GlobalMethod exchangeDic:[dict objectForKey:kModelEhomeWaitPayInfoBillList] toAryWithModelName:NSStringFromClass(ModelEHomeWaitPayItem.class)];
            self.unitNo = [dict stringValueForKey:kModelEhomeWaitPayInfoUnitNo];
            self.feeStateName = [dict stringValueForKey:kModelEhomeWaitPayInfoFeeStateName];
            self.floorName = [dict stringValueForKey:kModelEhomeWaitPayInfoFloorName];
            self.custName = [dict stringValueForKey:kModelEhomeWaitPayInfoCustName];
            self.areaName = [dict stringValueForKey:kModelEhomeWaitPayInfoAreaName];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.itemType forKey:kModelEhomeWaitPayInfoItemType];
    [mutableDict setValue:self.roomNo forKey:kModelEhomeWaitPayInfoRoomNo];
    [mutableDict setValue:[NSNumber numberWithDouble:self.allDueFees] forKey:kModelEhomeWaitPayInfoAllDueFees];
    [mutableDict setValue:[NSNumber numberWithDouble:self.count] forKey:kModelEhomeWaitPayInfoCount];
    [mutableDict setValue:self.allFees forKey:kModelEhomeWaitPayInfoAllFees];
    [mutableDict setValue:self.roomId forKey:kModelEhomeWaitPayInfoRoomId];
    [mutableDict setValue:[GlobalMethod exchangeAryModelToAryDic:self.billList] forKey:kModelEhomeWaitPayInfoBillList];
    [mutableDict setValue:self.unitNo forKey:kModelEhomeWaitPayInfoUnitNo];
    [mutableDict setValue:self.feeStateName forKey:kModelEhomeWaitPayInfoFeeStateName];
    [mutableDict setValue:self.floorName forKey:kModelEhomeWaitPayInfoFloorName];
    [mutableDict setValue:self.custName forKey:kModelEhomeWaitPayInfoCustName];
    [mutableDict setValue:self.areaName forKey:kModelEhomeWaitPayInfoAreaName];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
