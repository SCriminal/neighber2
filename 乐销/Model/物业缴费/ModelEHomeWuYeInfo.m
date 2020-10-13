//
//  ModelEHomeWuYeInfo.m
//
//  Created by 林栋 隋 on 2020/10/10
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import "ModelEHomeWuYeInfo.h"


NSString *const kModelEHomeWuYeInfoOrgNo = @"orgNo";
NSString *const kModelEHomeWuYeInfoServerItem = @"serverItem";
NSString *const kModelEHomeWuYeInfoAttachName = @"attachName";
NSString *const kModelEHomeWuYeInfoBranchId = @"branchId";
NSString *const kModelEHomeWuYeInfoBusinessLicense = @"businessLicense";
NSString *const kModelEHomeWuYeInfoImage = @"image";
NSString *const kModelEHomeWuYeInfoLegalCertNo = @"legalCertNo";
NSString *const kModelEHomeWuYeInfoIndentifyCode = @"indentifyCode";
NSString *const kModelEHomeWuYeInfoContact = @"contact";
NSString *const kModelEHomeWuYeInfoLegalPerson = @"legalPerson";
NSString *const kModelEHomeWuYeInfoState = @"state";
NSString *const kModelEHomeWuYeInfoRegisterAddress = @"registerAddress";
NSString *const kModelEHomeWuYeInfoContractId = @"contractId";
NSString *const kModelEHomeWuYeInfoProvinceId = @"provinceId";
NSString *const kModelEHomeWuYeInfoTaxId = @"taxId";
NSString *const kModelEHomeWuYeInfoPhone = @"phone";
NSString *const kModelEHomeWuYeInfoOrgName = @"orgName";
NSString *const kModelEHomeWuYeInfoCreateDate = @"createDate";
NSString *const kModelEHomeWuYeInfoOrgId = @"orgId";
NSString *const kModelEHomeWuYeInfoEpOrgId = @"epOrgId";
NSString *const kModelEHomeWuYeInfoLogo = @"logo";
NSString *const kModelEHomeWuYeInfoAttachPath = @"attachPath";
NSString *const kModelEHomeWuYeInfoOrgAddress = @"orgAddress";


@interface ModelEHomeWuYeInfo ()
@end

@implementation ModelEHomeWuYeInfo

@synthesize orgNo = _orgNo;
@synthesize serverItem = _serverItem;
@synthesize attachName = _attachName;
@synthesize branchId = _branchId;
@synthesize businessLicense = _businessLicense;
@synthesize image = _image;
@synthesize legalCertNo = _legalCertNo;
@synthesize indentifyCode = _indentifyCode;
@synthesize contact = _contact;
@synthesize legalPerson = _legalPerson;
@synthesize state = _state;
@synthesize registerAddress = _registerAddress;
@synthesize contractId = _contractId;
@synthesize provinceId = _provinceId;
@synthesize taxId = _taxId;
@synthesize phone = _phone;
@synthesize orgName = _orgName;
@synthesize createDate = _createDate;
@synthesize orgId = _orgId;
@synthesize epOrgId = _epOrgId;
@synthesize logo = _logo;
@synthesize attachPath = _attachPath;
@synthesize orgAddress = _orgAddress;


#pragma mark init
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.orgNo = [dict stringValueForKey:kModelEHomeWuYeInfoOrgNo];
            self.serverItem = [dict stringValueForKey:kModelEHomeWuYeInfoServerItem];
            self.attachName = [dict stringValueForKey:kModelEHomeWuYeInfoAttachName];
            self.branchId = [dict stringValueForKey:kModelEHomeWuYeInfoBranchId];
            self.businessLicense = [dict stringValueForKey:kModelEHomeWuYeInfoBusinessLicense];
            self.image = [dict stringValueForKey:kModelEHomeWuYeInfoImage];
            self.legalCertNo = [dict stringValueForKey:kModelEHomeWuYeInfoLegalCertNo];
            self.indentifyCode = [dict stringValueForKey:kModelEHomeWuYeInfoIndentifyCode];
            self.contact = [dict stringValueForKey:kModelEHomeWuYeInfoContact];
            self.legalPerson = [dict stringValueForKey:kModelEHomeWuYeInfoLegalPerson];
            self.state = [dict doubleValueForKey:kModelEHomeWuYeInfoState];
            self.registerAddress = [dict stringValueForKey:kModelEHomeWuYeInfoRegisterAddress];
            self.contractId = [dict stringValueForKey:kModelEHomeWuYeInfoContractId];
            self.provinceId = [dict stringValueForKey:kModelEHomeWuYeInfoProvinceId];
            self.taxId = [dict stringValueForKey:kModelEHomeWuYeInfoTaxId];
            self.phone = [dict stringValueForKey:kModelEHomeWuYeInfoPhone];
            self.orgName = [dict stringValueForKey:kModelEHomeWuYeInfoOrgName];
            self.createDate = [dict stringValueForKey:kModelEHomeWuYeInfoCreateDate];
            self.orgId = [dict stringValueForKey:kModelEHomeWuYeInfoOrgId];
            self.epOrgId = [dict stringValueForKey:kModelEHomeWuYeInfoEpOrgId];
            self.logo = [dict stringValueForKey:kModelEHomeWuYeInfoLogo];
            self.attachPath = [dict stringValueForKey:kModelEHomeWuYeInfoAttachPath];
            self.orgAddress = [dict stringValueForKey:kModelEHomeWuYeInfoOrgAddress];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.orgNo forKey:kModelEHomeWuYeInfoOrgNo];
    [mutableDict setValue:self.serverItem forKey:kModelEHomeWuYeInfoServerItem];
    [mutableDict setValue:self.attachName forKey:kModelEHomeWuYeInfoAttachName];
    [mutableDict setValue:self.branchId forKey:kModelEHomeWuYeInfoBranchId];
    [mutableDict setValue:self.businessLicense forKey:kModelEHomeWuYeInfoBusinessLicense];
    [mutableDict setValue:self.image forKey:kModelEHomeWuYeInfoImage];
    [mutableDict setValue:self.legalCertNo forKey:kModelEHomeWuYeInfoLegalCertNo];
    [mutableDict setValue:self.indentifyCode forKey:kModelEHomeWuYeInfoIndentifyCode];
    [mutableDict setValue:self.contact forKey:kModelEHomeWuYeInfoContact];
    [mutableDict setValue:self.legalPerson forKey:kModelEHomeWuYeInfoLegalPerson];
    [mutableDict setValue:[NSNumber numberWithDouble:self.state] forKey:kModelEHomeWuYeInfoState];
    [mutableDict setValue:self.registerAddress forKey:kModelEHomeWuYeInfoRegisterAddress];
    [mutableDict setValue:self.contractId forKey:kModelEHomeWuYeInfoContractId];
    [mutableDict setValue:self.provinceId forKey:kModelEHomeWuYeInfoProvinceId];
    [mutableDict setValue:self.taxId forKey:kModelEHomeWuYeInfoTaxId];
    [mutableDict setValue:self.phone forKey:kModelEHomeWuYeInfoPhone];
    [mutableDict setValue:self.orgName forKey:kModelEHomeWuYeInfoOrgName];
    [mutableDict setValue:self.createDate forKey:kModelEHomeWuYeInfoCreateDate];
    [mutableDict setValue:self.orgId forKey:kModelEHomeWuYeInfoOrgId];
    [mutableDict setValue:self.epOrgId forKey:kModelEHomeWuYeInfoEpOrgId];
    [mutableDict setValue:self.logo forKey:kModelEHomeWuYeInfoLogo];
    [mutableDict setValue:self.attachPath forKey:kModelEHomeWuYeInfoAttachPath];
    [mutableDict setValue:self.orgAddress forKey:kModelEHomeWuYeInfoOrgAddress];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
