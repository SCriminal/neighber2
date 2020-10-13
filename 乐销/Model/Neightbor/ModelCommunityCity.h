//
//  ModelCommunityCity.h
//
//  Created by 林栋 隋 on 2020/3/29
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelCommunityCity : NSObject

@property (nonatomic, strong) NSString *areaCode;
@property (nonatomic, assign) double iDProperty;
@property (nonatomic, strong) NSString *areaName;
@property (nonatomic, strong) NSString *initial;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
