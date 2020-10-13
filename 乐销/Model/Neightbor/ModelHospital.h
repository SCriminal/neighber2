//
//  ModelHospital.h
//
//  Created by 林栋 隋 on 2020/3/25
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelHospital : NSObject

@property (nonatomic, strong) NSString *logoUrl;
@property (nonatomic, assign) double iDProperty;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *addr;
@property (nonatomic, strong) NSString *name;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
