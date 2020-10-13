//
//  ModelHailuoCompany.h
//
//  Created by 林栋 隋 on 2020/8/18
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelHailuoCompany : NSObject

@property (nonatomic, strong) NSString *companyName;
@property (nonatomic, assign) double newOrderCount;
@property (nonatomic, strong) NSString *satisfaction;
@property (nonatomic, assign) double orderCount;
@property (nonatomic, assign) double fakeCommentCount;
@property (nonatomic, assign) double companyId;
@property (nonatomic, assign) double commentCount;
@property (nonatomic, strong) NSString *companyImg;
@property (nonatomic, assign) double commentByCompany;
@property (nonatomic, assign) double fakeOrderCount;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, assign) double iDProperty;
@property (nonatomic, assign) double isCheck;
@property (nonatomic, assign) double isIdentityCheck;
@property (nonatomic, strong) NSArray *discount;
@property (nonatomic, assign) double isReal;
@property (nonatomic, strong) NSArray *companyPhoto;
@property (nonatomic, strong) NSString *tel;
@property (nonatomic, strong) NSString *charter;
@property (nonatomic, strong) NSString *isAbility;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end


@interface ModelHailuoCompanyServe : NSObject

@property (nonatomic, assign) double serveId;
@property (nonatomic, strong) NSString *img;
@property (nonatomic, strong) NSString *name;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
