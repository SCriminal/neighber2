//
//  ModelHaiLuo.h
//
//  Created by 林栋 隋 on 2020/8/17
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelHaiLuo : NSObject

@property (nonatomic, assign) double cityId;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, assign) double haveClass;
@property (nonatomic, strong) NSString *header;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, assign) double userId;
@property (nonatomic, strong) NSString *token;
@property (nonatomic, assign) double sex;
@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *areaId;
@property (nonatomic, strong) NSString *roomId;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
