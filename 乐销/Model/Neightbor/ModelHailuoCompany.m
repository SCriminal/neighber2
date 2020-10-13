//
//  ModelHailuoCompany.m
//
//  Created by 林栋 隋 on 2020/8/18
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import "ModelHailuoCompany.h"


NSString *const kModelHailuoCompanyCompanyName = @"company_name";
NSString *const kModelHailuoCompanyNewOrderCount = @"new_order_count";
NSString *const kModelHailuoCompanySatisfaction = @"satisfaction";
NSString *const kModelHailuoCompanyOrderCount = @"order_count";
NSString *const kModelHailuoCompanyFakeCommentCount = @"fake_comment_count";
NSString *const kModelHailuoCompanyCompanyId = @"company_id";
NSString *const kModelHailuoCompanyCommentCount = @"comment_count";
NSString *const kModelHailuoCompanyCompanyImg = @"company_img";
NSString *const kModelHailuoCompanyCommentByCompany = @"comment_by_company";
NSString *const kModelHailuoCompanyFakeOrderCount = @"fake_order_count";
NSString *const kModelHailuoCompanyAddress = @"address";
NSString *const kModelHailuoCompanyId = @"id";
NSString *const kModelHailuoCompanyIsCheck = @"is_check";
NSString *const kModelHailuoCompanyIsIdentityCheck = @"is_identity_check";
NSString *const kModelHailuoCompanyDiscount = @"discount";
NSString *const kModelHailuoCompanyIsReal = @"is_real";
NSString *const kModelHailuoCompanyCompanyPhoto = @"company_photo";
NSString *const kModelHailuoCompanyTel = @"tel";
NSString *const kModelHailuoCompanyCharter = @"charter";
NSString *const kModelHailuoCompanyIsAbility = @"is_ability";


@interface ModelHailuoCompany ()
@end

@implementation ModelHailuoCompany

@synthesize companyName = _companyName;
@synthesize newOrderCount = _newOrderCount;
@synthesize satisfaction = _satisfaction;
@synthesize orderCount = _orderCount;
@synthesize fakeCommentCount = _fakeCommentCount;
@synthesize companyId = _companyId;
@synthesize commentCount = _commentCount;
@synthesize companyImg = _companyImg;
@synthesize commentByCompany = _commentByCompany;
@synthesize fakeOrderCount = _fakeOrderCount;


#pragma mark init
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.companyName = [dict stringValueForKey:kModelHailuoCompanyCompanyName];
            self.newOrderCount = [dict doubleValueForKey:kModelHailuoCompanyNewOrderCount];
            self.satisfaction = [dict stringValueForKey:kModelHailuoCompanySatisfaction];
            self.orderCount = [dict doubleValueForKey:kModelHailuoCompanyOrderCount];
            self.fakeCommentCount = [dict doubleValueForKey:kModelHailuoCompanyFakeCommentCount];
            self.companyId = [dict doubleValueForKey:kModelHailuoCompanyCompanyId];
            self.commentCount = [dict doubleValueForKey:kModelHailuoCompanyCommentCount];
            self.companyImg = [dict stringValueForKey:kModelHailuoCompanyCompanyImg];
        self.companyImg = [self.companyImg hailuoImage];
            self.commentByCompany = [dict doubleValueForKey:kModelHailuoCompanyCommentByCompany];
            self.fakeOrderCount = [dict doubleValueForKey:kModelHailuoCompanyFakeOrderCount];
        self.address = [dict stringValueForKey:kModelHailuoCompanyAddress];
        self.iDProperty = [dict doubleValueForKey:kModelHailuoCompanyId];
        self.isCheck = [dict doubleValueForKey:kModelHailuoCompanyIsCheck];
        self.isIdentityCheck = [dict doubleValueForKey:kModelHailuoCompanyIsIdentityCheck];
//        self.discount =  [GlobalMethod exchangeDic:[dict objectForKey:kModelHailuoCompanyDiscount] toAryWithModelName:<#(NSString *)#>];
        self.isReal = [dict doubleValueForKey:kModelHailuoCompanyIsReal];
        self.tel = [dict stringValueForKey:kModelHailuoCompanyTel];
        self.charter = [dict stringValueForKey:kModelHailuoCompanyCharter];
        self.isAbility = [dict stringValueForKey:kModelHailuoCompanyIsAbility];

        NSMutableArray * ary = [NSMutableArray new];
        NSArray * aryImage = [dict arrayValueForKey:kModelHailuoCompanyCompanyPhoto];
        for (NSString * strUrl in aryImage) {
            [ary addObject:[strUrl hailuoImage]];
        }
        self.companyPhoto = ary;
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.companyName forKey:kModelHailuoCompanyCompanyName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.newOrderCount] forKey:kModelHailuoCompanyNewOrderCount];
    [mutableDict setValue:self.satisfaction forKey:kModelHailuoCompanySatisfaction];
    [mutableDict setValue:[NSNumber numberWithDouble:self.orderCount] forKey:kModelHailuoCompanyOrderCount];
    [mutableDict setValue:[NSNumber numberWithDouble:self.fakeCommentCount] forKey:kModelHailuoCompanyFakeCommentCount];
    [mutableDict setValue:[NSNumber numberWithDouble:self.companyId] forKey:kModelHailuoCompanyCompanyId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.commentCount] forKey:kModelHailuoCompanyCommentCount];
    [mutableDict setValue:self.companyImg forKey:kModelHailuoCompanyCompanyImg];
    [mutableDict setValue:[NSNumber numberWithDouble:self.commentByCompany] forKey:kModelHailuoCompanyCommentByCompany];
    [mutableDict setValue:[NSNumber numberWithDouble:self.fakeOrderCount] forKey:kModelHailuoCompanyFakeOrderCount];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end



NSString *const kModelHailuoCompanyServeServeId = @"serve_id";
NSString *const kModelHailuoCompanyServeImg = @"img";
NSString *const kModelHailuoCompanyServeName = @"name";


@interface ModelHailuoCompanyServe ()
@end

@implementation ModelHailuoCompanyServe

@synthesize serveId = _serveId;
@synthesize img = _img;
@synthesize name = _name;


#pragma mark init
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.serveId = [dict doubleValueForKey:kModelHailuoCompanyServeServeId];
            self.img = [dict stringValueForKey:kModelHailuoCompanyServeImg];
            self.name = [dict stringValueForKey:kModelHailuoCompanyServeName];
        self.img = [self.img hailuoImage];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.serveId] forKey:kModelHailuoCompanyServeServeId];
    [mutableDict setValue:self.img forKey:kModelHailuoCompanyServeImg];
    [mutableDict setValue:self.name forKey:kModelHailuoCompanyServeName];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
