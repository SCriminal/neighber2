//
//  ModelFJJobList.m
//
//  Created by 林栋 隋 on 2020/9/10
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import "ModelFJJobList.h"


NSString *const kModelFJJobListAgeCn = @"age_cn";
NSString *const kModelFJJobListWageCn = @"wage_cn";
NSString *const kModelFJJobListEmergency = @"emergency";
NSString *const kModelFJJobListId = @"id";
NSString *const kModelFJJobListContents = @"contents";
NSString *const kModelFJJobListSex = @"sex";
NSString *const kModelFJJobListBriefly = @"briefly_";
NSString *const kModelFJJobListLogo = @"logo";
NSString *const kModelFJJobListNatureCn = @"nature_cn";
NSString *const kModelFJJobListCompanyId = @"company_id";
NSString *const kModelFJJobListNature = @"nature";
NSString *const kModelFJJobListRefreshtimeCn = @"refreshtime_cn";
NSString *const kModelFJJobListStick = @"stick";
NSString *const kModelFJJobListMapX = @"map_x";
NSString *const kModelFJJobListTpl = @"tpl";
NSString *const kModelFJJobListDepartment = @"department";
NSString *const kModelFJJobListExperience = @"experience";
NSString *const kModelFJJobListAddtime = @"addtime";
NSString *const kModelFJJobListMapZoom = @"map_zoom";
NSString *const kModelFJJobListClick = @"click";
NSString *const kModelFJJobListAmount = @"amount";
NSString *const kModelFJJobListNegotiable = @"negotiable";
NSString *const kModelFJJobListTradeCn = @"trade_cn";
NSString *const kModelFJJobListSexCn = @"sex_cn";
NSString *const kModelFJJobListAddress = @"address";
NSString *const kModelFJJobListRobot = @"robot";
NSString *const kModelFJJobListKeyFull = @"key_full";
NSString *const kModelFJJobListSetmealName = @"setmeal_name";
NSString *const kModelFJJobListStime = @"stime";
NSString *const kModelFJJobListLikeNumCn = @"like_num_cn";
NSString *const kModelFJJobListKeyPrecise = @"key_precise";
NSString *const kModelFJJobListCategoryCn = @"category_cn";
NSString *const kModelFJJobListDisplay = @"display";
NSString *const kModelFJJobListJobsName = @"jobs_name";
NSString *const kModelFJJobListMapY = @"map_y";
NSString *const kModelFJJobListIsCollect = @"is_collect";
NSString *const kModelFJJobListAllowanceId = @"allowance_id";
NSString *const kModelFJJobListLikeNum = @"like_num";
NSString *const kModelFJJobListCompanyname = @"companyname";
NSString *const kModelFJJobListDeadline = @"deadline";
NSString *const kModelFJJobListSubclass = @"subclass";
NSString *const kModelFJJobListUserStatus = @"user_status";
NSString *const kModelFJJobListEducation = @"education";
NSString *const kModelFJJobListTopclass = @"topclass";
NSString *const kModelFJJobListFamous = @"famous";
NSString *const kModelFJJobListCompanyAddtime = @"company_addtime";
NSString *const kModelFJJobListIsLike = @"is_like";
NSString *const kModelFJJobListScale = @"scale";
NSString *const kModelFJJobListAudit = @"audit";
NSString *const kModelFJJobListTag = @"tag";
NSString *const kModelFJJobListSetmealDeadline = @"setmeal_deadline";
NSString *const kModelFJJobListAge = @"age";
NSString *const kModelFJJobListTrade = @"trade";
NSString *const kModelFJJobListCategory = @"category";
NSString *const kModelFJJobListDistrict = @"district";
NSString *const kModelFJJobListAddMode = @"add_mode";
NSString *const kModelFJJobListExperienceCn = @"experience_cn";
NSString *const kModelFJJobListCompanyUrl = @"company_url";
NSString *const kModelFJJobListDistrictCn = @"district_cn";
NSString *const kModelFJJobListMinwage = @"minwage";
NSString *const kModelFJJobListShortName = @"short_name";
NSString *const kModelFJJobListUid = @"uid";
NSString *const kModelFJJobListJobsUrl = @"jobs_url";
NSString *const kModelFJJobListRefreshtime = @"refreshtime";
NSString *const kModelFJJobListScaleCn = @"scale_cn";
NSString *const kModelFJJobListAllowanceInfo = @"allowance_info";
NSString *const kModelFJJobListEducationCn = @"education_cn";
NSString *const kModelFJJobListCity = @"city";
NSString *const kModelFJJobListMaxwage = @"maxwage";
NSString *const kModelFJJobListSetmealId = @"setmeal_id";
NSString *const kModelFJJobListTagCn = @"tag_cn";
NSString *const kModelFJJobListCompanyAudit = @"company_audit";


@interface ModelFJJobList ()
@end

@implementation ModelFJJobList

@synthesize ageCn = _ageCn;
@synthesize wageCn = _wageCn;
@synthesize emergency = _emergency;
@synthesize iDProperty = _iDProperty;
@synthesize contents = _contents;
@synthesize sex = _sex;
@synthesize briefly = _briefly;
@synthesize logo = _logo;
@synthesize natureCn = _natureCn;
@synthesize companyId = _companyId;
@synthesize nature = _nature;
@synthesize refreshtimeCn = _refreshtimeCn;
@synthesize stick = _stick;
@synthesize mapX = _mapX;
@synthesize tpl = _tpl;
@synthesize department = _department;
@synthesize experience = _experience;
@synthesize addtime = _addtime;
@synthesize mapZoom = _mapZoom;
@synthesize click = _click;
@synthesize amount = _amount;
@synthesize negotiable = _negotiable;
@synthesize tradeCn = _tradeCn;
@synthesize sexCn = _sexCn;
@synthesize address = _address;
@synthesize robot = _robot;
@synthesize keyFull = _keyFull;
@synthesize setmealName = _setmealName;
@synthesize stime = _stime;
@synthesize likeNumCn = _likeNumCn;
@synthesize keyPrecise = _keyPrecise;
@synthesize categoryCn = _categoryCn;
@synthesize display = _display;
@synthesize jobsName = _jobsName;
@synthesize mapY = _mapY;
@synthesize isCollect = _isCollect;
@synthesize allowanceId = _allowanceId;
@synthesize likeNum = _likeNum;
@synthesize companyname = _companyname;
@synthesize deadline = _deadline;
@synthesize subclass = _subclass;
@synthesize userStatus = _userStatus;
@synthesize education = _education;
@synthesize topclass = _topclass;
@synthesize famous = _famous;
@synthesize companyAddtime = _companyAddtime;
@synthesize isLike = _isLike;
@synthesize scale = _scale;
@synthesize audit = _audit;
@synthesize tag = _tag;
@synthesize setmealDeadline = _setmealDeadline;
@synthesize age = _age;
@synthesize trade = _trade;
@synthesize category = _category;
@synthesize district = _district;
@synthesize addMode = _addMode;
@synthesize experienceCn = _experienceCn;
@synthesize companyUrl = _companyUrl;
@synthesize districtCn = _districtCn;
@synthesize minwage = _minwage;
@synthesize shortName = _shortName;
@synthesize uid = _uid;
@synthesize jobsUrl = _jobsUrl;
@synthesize refreshtime = _refreshtime;
@synthesize scaleCn = _scaleCn;
@synthesize allowanceInfo = _allowanceInfo;
@synthesize educationCn = _educationCn;
@synthesize city = _city;
@synthesize maxwage = _maxwage;
@synthesize setmealId = _setmealId;
@synthesize tagCn = _tagCn;
@synthesize companyAudit = _companyAudit;


#pragma mark init
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
        self.ageCn = [dict stringValueForKey:kModelFJJobListAgeCn];
        self.wageCn = [dict stringValueForKey:kModelFJJobListWageCn];
        self.emergency = [dict stringValueForKey:kModelFJJobListEmergency];
        self.iDProperty = [dict stringValueForKey:kModelFJJobListId];
        self.contents = [dict stringValueForKey:kModelFJJobListContents];
        self.sex = [dict stringValueForKey:kModelFJJobListSex];
        self.logo = [dict stringValueForKey:kModelFJJobListLogo];
        self.natureCn = [dict stringValueForKey:kModelFJJobListNatureCn];
        self.companyId = [dict stringValueForKey:kModelFJJobListCompanyId];
        self.nature = [dict stringValueForKey:kModelFJJobListNature];
        self.refreshtimeCn = [dict stringValueForKey:kModelFJJobListRefreshtimeCn];
        self.briefly = [dict stringValueForKey:kModelFJJobListBriefly];
        self.stick = [dict stringValueForKey:kModelFJJobListStick];
        self.mapX = [dict stringValueForKey:kModelFJJobListMapX];
        self.tpl = [dict stringValueForKey:kModelFJJobListTpl];
        self.department = [dict stringValueForKey:kModelFJJobListDepartment];
        self.experience = [dict stringValueForKey:kModelFJJobListExperience];
        self.addtime = [dict stringValueForKey:kModelFJJobListAddtime];
        self.mapZoom = [dict stringValueForKey:kModelFJJobListMapZoom];
        self.click = [dict stringValueForKey:kModelFJJobListClick];
        self.amount = [dict stringValueForKey:kModelFJJobListAmount];
        self.negotiable = [dict stringValueForKey:kModelFJJobListNegotiable];
        self.tradeCn = [dict stringValueForKey:kModelFJJobListTradeCn];
        self.sexCn = [dict stringValueForKey:kModelFJJobListSexCn];
        self.address = [dict stringValueForKey:kModelFJJobListAddress];
        self.robot = [dict stringValueForKey:kModelFJJobListRobot];
        self.keyFull = [dict stringValueForKey:kModelFJJobListKeyFull];
        self.setmealName = [dict stringValueForKey:kModelFJJobListSetmealName];
        self.stime = [dict stringValueForKey:kModelFJJobListStime];
        self.likeNumCn = [dict stringValueForKey:kModelFJJobListLikeNumCn];
        self.keyPrecise = [dict stringValueForKey:kModelFJJobListKeyPrecise];
        self.categoryCn = [dict stringValueForKey:kModelFJJobListCategoryCn];
        self.display = [dict stringValueForKey:kModelFJJobListDisplay];
        self.jobsName = [dict stringValueForKey:kModelFJJobListJobsName];
        self.mapY = [dict stringValueForKey:kModelFJJobListMapY];
        self.isCollect = [dict doubleValueForKey:kModelFJJobListIsCollect];
        self.allowanceId = [dict doubleValueForKey:kModelFJJobListAllowanceId];
        self.likeNum = [dict stringValueForKey:kModelFJJobListLikeNum];
        self.companyname = [dict stringValueForKey:kModelFJJobListCompanyname];
        self.deadline = [dict stringValueForKey:kModelFJJobListDeadline];
        self.subclass = [dict stringValueForKey:kModelFJJobListSubclass];
        self.userStatus = [dict stringValueForKey:kModelFJJobListUserStatus];
        self.education = [dict stringValueForKey:kModelFJJobListEducation];
        self.topclass = [dict stringValueForKey:kModelFJJobListTopclass];
        self.famous = [dict stringValueForKey:kModelFJJobListFamous];
        self.companyAddtime = [dict stringValueForKey:kModelFJJobListCompanyAddtime];
        self.isLike = [dict doubleValueForKey:kModelFJJobListIsLike];
        self.scale = [dict stringValueForKey:kModelFJJobListScale];
        self.audit = [dict stringValueForKey:kModelFJJobListAudit];
        self.tag = [dict stringValueForKey:kModelFJJobListTag];
        self.setmealDeadline = [dict stringValueForKey:kModelFJJobListSetmealDeadline];
        self.age = [dict stringValueForKey:kModelFJJobListAge];
        self.trade = [dict stringValueForKey:kModelFJJobListTrade];
        self.category = [dict stringValueForKey:kModelFJJobListCategory];
        self.district = [dict stringValueForKey:kModelFJJobListDistrict];
        self.addMode = [dict stringValueForKey:kModelFJJobListAddMode];
        self.experienceCn = [dict stringValueForKey:kModelFJJobListExperienceCn];
        self.companyUrl = [dict stringValueForKey:kModelFJJobListCompanyUrl];
        self.districtCn = [dict stringValueForKey:kModelFJJobListDistrictCn];
        self.minwage = [dict stringValueForKey:kModelFJJobListMinwage];
        self.shortName = [dict stringValueForKey:kModelFJJobListShortName];
        self.uid = [dict stringValueForKey:kModelFJJobListUid];
        self.jobsUrl = [dict stringValueForKey:kModelFJJobListJobsUrl];
        self.refreshtime = [dict stringValueForKey:kModelFJJobListRefreshtime];
        self.scaleCn = [dict stringValueForKey:kModelFJJobListScaleCn];
        self.allowanceInfo =  [dict arrayValueForKey:kModelFJJobListAllowanceInfo];
        self.educationCn = [dict stringValueForKey:kModelFJJobListEducationCn];
        self.city = [dict stringValueForKey:kModelFJJobListCity];
        self.maxwage = [dict stringValueForKey:kModelFJJobListMaxwage];
        self.setmealId = [dict stringValueForKey:kModelFJJobListSetmealId];
        self.tagCn =  [dict arrayValueForKey:kModelFJJobListTagCn];
        self.companyAudit = [dict stringValueForKey:kModelFJJobListCompanyAudit];
        
        NSDictionary * dicCompany = [dict dictionaryValueForKey:@"company"];
        if (isDic(dicCompany)) {
            if (!isStr(self.logo)) {
                self.logo = [dicCompany stringValueForKey:@"logo"];
                self.logo = [self.logo findJobLogo];
            }
        }
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.ageCn forKey:kModelFJJobListAgeCn];
    [mutableDict setValue:self.wageCn forKey:kModelFJJobListWageCn];
    [mutableDict setValue:self.emergency forKey:kModelFJJobListEmergency];
    [mutableDict setValue:self.iDProperty forKey:kModelFJJobListId];
    [mutableDict setValue:self.contents forKey:kModelFJJobListContents];
    [mutableDict setValue:self.sex forKey:kModelFJJobListSex];
    [mutableDict setValue:self.briefly forKey:kModelFJJobListBriefly];
    [mutableDict setValue:self.logo forKey:kModelFJJobListLogo];
    [mutableDict setValue:self.natureCn forKey:kModelFJJobListNatureCn];
    [mutableDict setValue:self.companyId forKey:kModelFJJobListCompanyId];
    [mutableDict setValue:self.nature forKey:kModelFJJobListNature];
    [mutableDict setValue:self.refreshtimeCn forKey:kModelFJJobListRefreshtimeCn];
    [mutableDict setValue:self.stick forKey:kModelFJJobListStick];
    [mutableDict setValue:self.mapX forKey:kModelFJJobListMapX];
    [mutableDict setValue:self.tpl forKey:kModelFJJobListTpl];
    [mutableDict setValue:self.department forKey:kModelFJJobListDepartment];
    [mutableDict setValue:self.experience forKey:kModelFJJobListExperience];
    [mutableDict setValue:self.addtime forKey:kModelFJJobListAddtime];
    [mutableDict setValue:self.mapZoom forKey:kModelFJJobListMapZoom];
    [mutableDict setValue:self.click forKey:kModelFJJobListClick];
    [mutableDict setValue:self.amount forKey:kModelFJJobListAmount];
    [mutableDict setValue:self.negotiable forKey:kModelFJJobListNegotiable];
    [mutableDict setValue:self.tradeCn forKey:kModelFJJobListTradeCn];
    [mutableDict setValue:self.sexCn forKey:kModelFJJobListSexCn];
    [mutableDict setValue:self.address forKey:kModelFJJobListAddress];
    [mutableDict setValue:self.robot forKey:kModelFJJobListRobot];
    [mutableDict setValue:self.keyFull forKey:kModelFJJobListKeyFull];
    [mutableDict setValue:self.setmealName forKey:kModelFJJobListSetmealName];
    [mutableDict setValue:self.stime forKey:kModelFJJobListStime];
    [mutableDict setValue:self.likeNumCn forKey:kModelFJJobListLikeNumCn];
    [mutableDict setValue:self.keyPrecise forKey:kModelFJJobListKeyPrecise];
    [mutableDict setValue:self.categoryCn forKey:kModelFJJobListCategoryCn];
    [mutableDict setValue:self.display forKey:kModelFJJobListDisplay];
    [mutableDict setValue:self.mapY forKey:kModelFJJobListMapY];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isCollect] forKey:kModelFJJobListIsCollect];
    [mutableDict setValue:[NSNumber numberWithDouble:self.allowanceId] forKey:kModelFJJobListAllowanceId];
    [mutableDict setValue:self.likeNum forKey:kModelFJJobListLikeNum];
    [mutableDict setValue:self.companyname forKey:kModelFJJobListCompanyname];
    [mutableDict setValue:self.deadline forKey:kModelFJJobListDeadline];
    [mutableDict setValue:self.subclass forKey:kModelFJJobListSubclass];
    [mutableDict setValue:self.userStatus forKey:kModelFJJobListUserStatus];
    [mutableDict setValue:self.education forKey:kModelFJJobListEducation];
    [mutableDict setValue:self.topclass forKey:kModelFJJobListTopclass];
    [mutableDict setValue:self.jobsName forKey:kModelFJJobListJobsName];
    [mutableDict setValue:self.famous forKey:kModelFJJobListFamous];
    [mutableDict setValue:self.companyAddtime forKey:kModelFJJobListCompanyAddtime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isLike] forKey:kModelFJJobListIsLike];
    [mutableDict setValue:self.scale forKey:kModelFJJobListScale];
    [mutableDict setValue:self.audit forKey:kModelFJJobListAudit];
    [mutableDict setValue:self.tag forKey:kModelFJJobListTag];
    [mutableDict setValue:self.setmealDeadline forKey:kModelFJJobListSetmealDeadline];
    [mutableDict setValue:self.age forKey:kModelFJJobListAge];
    [mutableDict setValue:self.trade forKey:kModelFJJobListTrade];
    [mutableDict setValue:self.category forKey:kModelFJJobListCategory];
    [mutableDict setValue:self.district forKey:kModelFJJobListDistrict];
    [mutableDict setValue:self.addMode forKey:kModelFJJobListAddMode];
    [mutableDict setValue:self.experienceCn forKey:kModelFJJobListExperienceCn];
    [mutableDict setValue:self.companyUrl forKey:kModelFJJobListCompanyUrl];
    [mutableDict setValue:self.districtCn forKey:kModelFJJobListDistrictCn];
    [mutableDict setValue:self.minwage forKey:kModelFJJobListMinwage];
    [mutableDict setValue:self.shortName forKey:kModelFJJobListShortName];
    [mutableDict setValue:self.uid forKey:kModelFJJobListUid];
    [mutableDict setValue:self.jobsUrl forKey:kModelFJJobListJobsUrl];
    [mutableDict setValue:self.refreshtime forKey:kModelFJJobListRefreshtime];
    [mutableDict setValue:self.scaleCn forKey:kModelFJJobListScaleCn];
    [mutableDict setValue:[GlobalMethod exchangeAryModelToAryDic:self.allowanceInfo] forKey:kModelFJJobListAllowanceInfo];
    [mutableDict setValue:self.educationCn forKey:kModelFJJobListEducationCn];
    [mutableDict setValue:self.city forKey:kModelFJJobListCity];
    [mutableDict setValue:self.maxwage forKey:kModelFJJobListMaxwage];
    [mutableDict setValue:self.setmealId forKey:kModelFJJobListSetmealId];
    [mutableDict setValue:[GlobalMethod exchangeAryModelToAryDic:self.tagCn] forKey:kModelFJJobListTagCn];
    [mutableDict setValue:self.companyAudit forKey:kModelFJJobListCompanyAudit];
    
    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
