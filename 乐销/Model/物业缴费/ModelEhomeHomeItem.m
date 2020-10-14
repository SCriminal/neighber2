//
//  ModelEhomeHomeItem.m
//
//  Created by 林栋 隋 on 2020/10/14
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import "ModelEhomeHomeItem.h"


NSString *const kModelEhomeHomeItemId = @"id";
NSString *const kModelEhomeHomeItemRoomNo = @"roomNo";
NSString *const kModelEhomeHomeItemAreaId = @"areaId";
NSString *const kModelEhomeHomeItemClientId = @"clientId";
NSString *const kModelEhomeHomeItemClientName = @"clientName";
NSString *const kModelEhomeHomeItemType = @"type";
NSString *const kModelEhomeHomeItemRoomId = @"roomId";
NSString *const kModelEhomeHomeItemClientTelephone = @"clientTelephone";
NSString *const kModelEhomeHomeItemUnitNo = @"unitNo";
NSString *const kModelEhomeHomeItemFloorName = @"floorName";
NSString *const kModelEhomeHomeItemAreaName = @"areaName";
NSString *const kModelEhomeHomeItemTelephone = @"telephone";
NSString *const kModelEhomeHomeItemName = @"name";


@interface ModelEhomeHomeItem ()
@end

@implementation ModelEhomeHomeItem

@synthesize iDProperty = _iDProperty;
@synthesize roomNo = _roomNo;
@synthesize areaId = _areaId;
@synthesize clientId = _clientId;
@synthesize clientName = _clientName;
@synthesize type = _type;
@synthesize roomId = _roomId;
@synthesize clientTelephone = _clientTelephone;
@synthesize unitNo = _unitNo;
@synthesize floorName = _floorName;
@synthesize areaName = _areaName;
@synthesize telephone = _telephone;
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
            self.iDProperty = [dict stringValueForKey:kModelEhomeHomeItemId];
            self.roomNo = [dict stringValueForKey:kModelEhomeHomeItemRoomNo];
            self.areaId = [dict stringValueForKey:kModelEhomeHomeItemAreaId];
            self.clientId = [dict stringValueForKey:kModelEhomeHomeItemClientId];
            self.clientName = [dict stringValueForKey:kModelEhomeHomeItemClientName];
            self.type = [dict stringValueForKey:kModelEhomeHomeItemType];
            self.roomId = [dict stringValueForKey:kModelEhomeHomeItemRoomId];
            self.clientTelephone = [dict stringValueForKey:kModelEhomeHomeItemClientTelephone];
            self.unitNo = [dict stringValueForKey:kModelEhomeHomeItemUnitNo];
            self.floorName = [dict stringValueForKey:kModelEhomeHomeItemFloorName];
            self.areaName = [dict stringValueForKey:kModelEhomeHomeItemAreaName];
            self.telephone = [dict stringValueForKey:kModelEhomeHomeItemTelephone];
            self.name = [dict stringValueForKey:kModelEhomeHomeItemName];
        if ([self.type isEqualToString:@"1"]) {
            self.typeShow = @"业主";
        }else{
            self.typeShow = @"租户";

        }
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.iDProperty forKey:kModelEhomeHomeItemId];
    [mutableDict setValue:self.roomNo forKey:kModelEhomeHomeItemRoomNo];
    [mutableDict setValue:self.areaId forKey:kModelEhomeHomeItemAreaId];
    [mutableDict setValue:self.clientId forKey:kModelEhomeHomeItemClientId];
    [mutableDict setValue:self.clientName forKey:kModelEhomeHomeItemClientName];
    [mutableDict setValue:self.type forKey:kModelEhomeHomeItemType];
    [mutableDict setValue:self.roomId forKey:kModelEhomeHomeItemRoomId];
    [mutableDict setValue:self.clientTelephone forKey:kModelEhomeHomeItemClientTelephone];
    [mutableDict setValue:self.unitNo forKey:kModelEhomeHomeItemUnitNo];
    [mutableDict setValue:self.floorName forKey:kModelEhomeHomeItemFloorName];
    [mutableDict setValue:self.areaName forKey:kModelEhomeHomeItemAreaName];
    [mutableDict setValue:self.telephone forKey:kModelEhomeHomeItemTelephone];
    [mutableDict setValue:self.name forKey:kModelEhomeHomeItemName];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
