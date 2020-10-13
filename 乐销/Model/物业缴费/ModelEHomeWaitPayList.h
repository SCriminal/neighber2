//
//  ModelEHomeWaitPayList.h
//
//  Created by 林栋 隋 on 2020/10/10
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelEHomeWaitPayList : NSObject

@property (nonatomic, strong) NSString *itemId;
@property (nonatomic, strong) NSString *roomId;
@property (nonatomic, strong) NSString *feesEndDate;
@property (nonatomic, strong) NSArray *feesIds;
@property (nonatomic, assign) double debtsAmount;
@property (nonatomic, strong) NSString *feeStateName;
@property (nonatomic, strong) NSString *feesStartDate;
@property (nonatomic, strong) NSString *billCount;
@property (nonatomic, assign) double dueFineFee;
@property (nonatomic, strong) NSString *itemType;
@property (nonatomic, assign) bool selected;
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
