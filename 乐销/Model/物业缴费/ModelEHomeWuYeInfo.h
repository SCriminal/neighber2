//
//  ModelEHomeWuYeInfo.h
//
//  Created by 林栋 隋 on 2020/10/10
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelEHomeWuYeInfo : NSObject

@property (nonatomic, strong) NSString *orgNo;
@property (nonatomic, strong) NSString *serverItem;
@property (nonatomic, strong) NSString *attachName;
@property (nonatomic, strong) NSString *branchId;
@property (nonatomic, strong) NSString *businessLicense;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *legalCertNo;
@property (nonatomic, strong) NSString *indentifyCode;
@property (nonatomic, strong) NSString *contact;
@property (nonatomic, strong) NSString *legalPerson;
@property (nonatomic, assign) double state;
@property (nonatomic, strong) NSString *registerAddress;
@property (nonatomic, strong) NSString *contractId;
@property (nonatomic, strong) NSString *provinceId;
@property (nonatomic, strong) NSString *taxId;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *orgName;
@property (nonatomic, strong) NSString *createDate;
@property (nonatomic, strong) NSString *orgId;
@property (nonatomic, strong) NSString *epOrgId;
@property (nonatomic, strong) NSString *logo;
@property (nonatomic, strong) NSString *attachPath;
@property (nonatomic, strong) NSString *orgAddress;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
