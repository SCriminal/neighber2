//
//  ModelEhomeWaitPayInfo.h
//
//  Created by 林栋 隋 on 2020/10/10
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelEhomeWaitPayInfo : NSObject

@property (nonatomic, strong) NSString *itemType;
@property (nonatomic, strong) NSString *roomNo;
@property (nonatomic, assign) double allDueFees;
@property (nonatomic, assign) double count;
@property (nonatomic, strong) NSString *allFees;
@property (nonatomic, strong) NSString *roomId;
@property (nonatomic, strong) NSArray *billList;
@property (nonatomic, strong) NSString *unitNo;
@property (nonatomic, strong) NSString *feeStateName;
@property (nonatomic, strong) NSString *floorName;
@property (nonatomic, strong) NSString *custName;
@property (nonatomic, strong) NSString *areaName;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
