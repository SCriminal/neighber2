//
//  ModelEHomeWaitPayItem.h
//
//  Created by 林栋 隋 on 2020/10/10
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelEHomeWaitPayItem : NSObject

@property (nonatomic, strong) NSString *feesStartDate;
@property (nonatomic, assign) double debtsAmount;
@property (nonatomic, strong) NSString *feesEndDate;
@property (nonatomic, assign) double dueFineFee;
@property (nonatomic, strong) NSString *feesId;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
