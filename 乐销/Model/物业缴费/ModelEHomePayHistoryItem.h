//
//  ModelEHomePayHistoryItem.h
//
//  Created by 林栋 隋 on 2020/10/13
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelEHomePayHistoryItem : NSObject

@property (nonatomic, strong) NSString *feesId;
@property (nonatomic, assign) double payAmount;
@property (nonatomic, strong) NSString *payType;
@property (nonatomic, strong) NSString *feeStateName;
@property (nonatomic, strong) NSString *payDate;
@property (nonatomic, strong) NSString *custName;
@property (nonatomic, strong) NSString *costName;
@property (nonatomic, strong) NSString *itemType;
@property (nonatomic, strong) NSString *unitNo;
@property (nonatomic, strong) NSString *roomNo;
@property (nonatomic, strong) NSString *payStatus;
@property (nonatomic, strong) NSString *floorName;
@property (nonatomic, strong) NSString *receiveCompany;
@property (nonatomic, strong) NSString *areaName;
@property (nonatomic, strong) NSString *eleSignUrl;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
