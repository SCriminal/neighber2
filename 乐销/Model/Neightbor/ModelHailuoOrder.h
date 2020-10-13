//
//  ModelHailuoOrder.h
//
//  Created by 林栋 隋 on 2020/8/20
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelHailuoOrder : NSObject

@property (nonatomic, assign) double iDProperty;
@property (nonatomic, assign) double changeAunt;
@property (nonatomic, strong) NSString *earnestPrice;
@property (nonatomic, assign) double companyId;
@property (nonatomic, assign) double serveId;
@property (nonatomic, assign) double anew;
@property (nonatomic, strong) NSString *companyName;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, assign) double orderStatus;
@property (nonatomic, strong) NSString *statusMessage;
@property (nonatomic, strong) NSString *tel;
@property (nonatomic, assign) double createTime;
@property (nonatomic, strong) NSString *servePrice;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *beginTime;
@property (nonatomic, strong) NSString *statusShow;
@property (nonatomic, strong) UIColor *statusColorShow;
@property (nonatomic, assign) double renewCount;
@property (nonatomic, strong) NSString *orderNumber;
@property (nonatomic, strong) NSString *serveTime;
@property (nonatomic, assign) double orderId;
@property (nonatomic, assign) double discountPrice;
@property (nonatomic, assign) double complaintTel;
@property (nonatomic, strong) NSString *company;
@property (nonatomic, assign) double realServePrice;
@property (nonatomic, strong) NSString *companyTel;
@property (nonatomic, strong) NSString *serveName;
@property (nonatomic, assign) double realEarnestPrice;
@property (nonatomic, assign) double refund;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
