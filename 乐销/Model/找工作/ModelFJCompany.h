//
//  ModelFJCompany.h
//
//  Created by 林栋 隋 on 2020/9/22
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelFJCompany : NSObject

@property (nonatomic, strong) NSString *iDProperty;
@property (nonatomic, strong) NSString *scaleCn;
@property (nonatomic, strong) NSString *natureCn;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *replyTime;
@property (nonatomic, strong) NSString *contact;
@property (nonatomic, assign) double replyRatio;
@property (nonatomic, strong) NSString *lastLoginTimeCn;
@property (nonatomic, strong) NSString *setmealId;
@property (nonatomic, strong) NSString *logo;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *audit;
@property (nonatomic, strong) NSString *landlineTel;
@property (nonatomic, strong) NSString *tradeCn;
@property (nonatomic, strong) NSString *telephone;
@property (nonatomic, strong) NSString *lastLoginTime;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
