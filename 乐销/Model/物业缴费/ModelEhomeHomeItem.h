//
//  ModelEhomeHomeItem.h
//
//  Created by 林栋 隋 on 2020/10/14
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelEhomeHomeItem : NSObject

@property (nonatomic, strong) NSString *iDProperty;
@property (nonatomic, strong) NSString *roomNo;
@property (nonatomic, strong) NSString *areaId;
@property (nonatomic, strong) NSString *clientId;
@property (nonatomic, strong) NSString *clientName;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *roomId;
@property (nonatomic, strong) NSString *clientTelephone;
@property (nonatomic, strong) NSString *unitNo;
@property (nonatomic, strong) NSString *floorName;
@property (nonatomic, strong) NSString *areaName;
@property (nonatomic, strong) NSString *telephone;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *typeShow;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
