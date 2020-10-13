//
//  ModelResumeDetail.m
//
//  Created by 林栋 隋 on 2020/9/16
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import "ModelResumeDetail.h"


NSString *const kModelResumeDetailMajorCn = @"major_cn";
NSString *const kModelResumeDetailSex = @"sex";
NSString *const kModelResumeDetailUid = @"uid";
NSString *const kModelResumeDetailTag = @"tag";
NSString *const kModelResumeDetailMarriage = @"marriage";
NSString *const kModelResumeDetailId = @"id";
NSString *const kModelResumeDetailKeyFull = @"key_full";
NSString *const kModelResumeDetailTalent = @"talent";
NSString *const kModelResumeDetailResumeFromPc = @"resume_from_pc";
NSString *const kModelResumeDetailPhotoDisplay = @"photo_display";
NSString *const kModelResumeDetailCredentList = @"credent_list";
NSString *const kModelResumeDetailWorkDuration = @"work_duration";
NSString *const kModelResumeDetailMobileAudit = @"mobile_audit";
NSString *const kModelResumeDetailEducationList = @"education_list";
NSString *const kModelResumeDetailWordResumeAddtime = @"word_resume_addtime";
NSString *const kModelResumeDetailExperience = @"experience";
NSString *const kModelResumeDetailDisplayName = @"display_name";
NSString *const kModelResumeDetailBirthdate = @"birthdate";
NSString *const kModelResumeDetailCompletePercent = @"complete_percent";
NSString *const kModelResumeDetailPhotosrc = @"photosrc";
NSString *const kModelResumeDetailQq = @"qq";
NSString *const kModelResumeDetailResidence = @"residence";
NSString *const kModelResumeDetailProjectList = @"project_list";
NSString *const kModelResumeDetailExperienceCn = @"experience_cn";
NSString *const kModelResumeDetailPhotoImg = @"photo_img";
NSString *const kModelResumeDetailSpecialty = @"specialty";
NSString *const kModelResumeDetailDef = @"def";
NSString *const kModelResumeDetailKeyPrecise = @"key_precise";
NSString *const kModelResumeDetailFavor = @"favor";
NSString *const kModelResumeDetailEntrust = @"entrust";
NSString *const kModelResumeDetailWageCn = @"wage_cn";
NSString *const kModelResumeDetailAudit = @"audit";
NSString *const kModelResumeDetailRefreshtime = @"refreshtime";
NSString *const kModelResumeDetailRefreshtimeCn = @"refreshtime_cn";
NSString *const kModelResumeDetailEducation = @"education";
NSString *const kModelResumeDetailCurrent = @"current";
NSString *const kModelResumeDetailDistrictCn = @"district_cn";
NSString *const kModelResumeDetailWeixin = @"weixin";
NSString *const kModelResumeDetailWordResume = @"word_resume";
NSString *const kModelResumeDetailPhoto = @"photo";
NSString *const kModelResumeDetailLabelType = @"label_type";
NSString *const kModelResumeDetailLanguageList = @"language_list";
NSString *const kModelResumeDetailCommentContent = @"comment_content";
NSString *const kModelResumeDetailIntentionJobsId = @"intention_jobs_id";
NSString *const kModelResumeDetailQrcodeUrl = @"qrcode_url";
NSString *const kModelResumeDetailWordResumeTitle = @"word_resume_title";
NSString *const kModelResumeDetailShowContact = @"show_contact";
NSString *const kModelResumeDetailTrainingList = @"training_list";
NSString *const kModelResumeDetailNature = @"nature";
NSString *const kModelResumeDetailEmailNotify = @"email_notify";
NSString *const kModelResumeDetailStrongTag = @"strong_tag";
NSString *const kModelResumeDetailAddtime = @"addtime";
NSString *const kModelResumeDetailEducationCn = @"education_cn";
NSString *const kModelResumeDetailEmail = @"email";
NSString *const kModelResumeDetailTelephone = @"telephone";
NSString *const kModelResumeDetailLs = @"ls";
NSString *const kModelResumeDetailFullname = @"fullname";
NSString *const kModelResumeDetailLikeNum = @"like_num";
NSString *const kModelResumeDetailLabelResume = @"label_resume";
NSString *const kModelResumeDetailHouseholdaddress = @"householdaddress";
NSString *const kModelResumeDetailPhotoAudit = @"photo_audit";
NSString *const kModelResumeDetailLabelArr = @"label_arr";
NSString *const kModelResumeDetailIntentionJobs = @"intention_jobs";
NSString *const kModelResumeDetailClick = @"click";
NSString *const kModelResumeDetailTrade = @"trade";
NSString *const kModelResumeDetailTitle = @"title";
NSString *const kModelResumeDetailAge = @"age";
NSString *const kModelResumeDetailMajor = @"major";
NSString *const kModelResumeDetailTagCn = @"tag_cn";
NSString *const kModelResumeDetailIdcard = @"idcard";
NSString *const kModelResumeDetailSexCn = @"sex_cn";
NSString *const kModelResumeDetailLevel = @"level";
NSString *const kModelResumeDetailDisplay = @"display";
NSString *const kModelResumeDetailIsQuick = @"is_quick";
NSString *const kModelResumeDetailLabelId = @"label_id";
NSString *const kModelResumeDetailStime = @"stime";
NSString *const kModelResumeDetailStick = @"stick";
NSString *const kModelResumeDetailMarriageCn = @"marriage_cn";
NSString *const kModelResumeDetailNatureCn = @"nature_cn";
NSString *const kModelResumeDetailWage = @"wage";
NSString *const kModelResumeDetailCurrentCn = @"current_cn";
NSString *const kModelResumeDetailHeight = @"height";
NSString *const kModelResumeDetailWorkList = @"work_list";
NSString *const kModelResumeDetailTpl = @"tpl";
NSString *const kModelResumeDetailTradeCn = @"trade_cn";
NSString *const kModelResumeDetailWorkCount = @"work_count";
NSString *const kModelResumeDetailImgList = @"img_list";
NSString *const kModelResumeDetailDistrict = @"district";


@interface ModelResumeDetail ()
@end

@implementation ModelResumeDetail

@synthesize majorCn = _majorCn;
@synthesize sex = _sex;
@synthesize uid = _uid;
@synthesize tag = _tag;
@synthesize marriage = _marriage;
@synthesize iDProperty = _iDProperty;
@synthesize keyFull = _keyFull;
@synthesize talent = _talent;
@synthesize resumeFromPc = _resumeFromPc;
@synthesize photoDisplay = _photoDisplay;
@synthesize credentList = _credentList;
@synthesize workDuration = _workDuration;
@synthesize mobileAudit = _mobileAudit;
@synthesize educationList = _educationList;
@synthesize wordResumeAddtime = _wordResumeAddtime;
@synthesize experience = _experience;
@synthesize displayName = _displayName;
@synthesize birthdate = _birthdate;
@synthesize completePercent = _completePercent;
@synthesize photosrc = _photosrc;
@synthesize qq = _qq;
@synthesize residence = _residence;
@synthesize projectList = _projectList;
@synthesize experienceCn = _experienceCn;
@synthesize photoImg = _photoImg;
@synthesize specialty = _specialty;
@synthesize def = _def;
@synthesize keyPrecise = _keyPrecise;
@synthesize favor = _favor;
@synthesize entrust = _entrust;
@synthesize wageCn = _wageCn;
@synthesize audit = _audit;
@synthesize refreshtime = _refreshtime;
@synthesize refreshtimeCn = _refreshtimeCn;
@synthesize education = _education;
@synthesize current = _current;
@synthesize districtCn = _districtCn;
@synthesize weixin = _weixin;
@synthesize wordResume = _wordResume;
@synthesize photo = _photo;
@synthesize labelType = _labelType;
@synthesize languageList = _languageList;
@synthesize commentContent = _commentContent;
@synthesize intentionJobsId = _intentionJobsId;
@synthesize qrcodeUrl = _qrcodeUrl;
@synthesize wordResumeTitle = _wordResumeTitle;
@synthesize showContact = _showContact;
@synthesize trainingList = _trainingList;
@synthesize nature = _nature;
@synthesize emailNotify = _emailNotify;
@synthesize strongTag = _strongTag;
@synthesize addtime = _addtime;
@synthesize educationCn = _educationCn;
@synthesize telephone = _telephone;
@synthesize email = _email;
@synthesize ls = _ls;
@synthesize fullname = _fullname;
@synthesize likeNum = _likeNum;
@synthesize labelResume = _labelResume;
@synthesize householdaddress = _householdaddress;
@synthesize photoAudit = _photoAudit;
@synthesize labelArr = _labelArr;
@synthesize intentionJobs = _intentionJobs;
@synthesize click = _click;
@synthesize trade = _trade;
@synthesize title = _title;
@synthesize age = _age;
@synthesize major = _major;
@synthesize tagCn = _tagCn;
@synthesize idcard = _idcard;
@synthesize sexCn = _sexCn;
@synthesize level = _level;
@synthesize display = _display;
@synthesize isQuick = _isQuick;
@synthesize labelId = _labelId;
@synthesize stime = _stime;
@synthesize stick = _stick;
@synthesize marriageCn = _marriageCn;
@synthesize natureCn = _natureCn;
@synthesize wage = _wage;
@synthesize currentCn = _currentCn;
@synthesize height = _height;
@synthesize workList = _workList;
@synthesize tpl = _tpl;
@synthesize tradeCn = _tradeCn;
@synthesize workCount = _workCount;
@synthesize imgList = _imgList;
@synthesize district = _district;


#pragma mark init
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.majorCn = [dict stringValueForKey:kModelResumeDetailMajorCn];
            self.sex = [dict stringValueForKey:kModelResumeDetailSex];
            self.uid = [dict stringValueForKey:kModelResumeDetailUid];
            self.tag = [dict stringValueForKey:kModelResumeDetailTag];
            self.marriage = [dict stringValueForKey:kModelResumeDetailMarriage];
            self.iDProperty = [dict stringValueForKey:kModelResumeDetailId];
            self.keyFull = [dict stringValueForKey:kModelResumeDetailKeyFull];
            self.talent = [dict stringValueForKey:kModelResumeDetailTalent];
            self.resumeFromPc = [dict stringValueForKey:kModelResumeDetailResumeFromPc];
            self.photoDisplay = [dict stringValueForKey:kModelResumeDetailPhotoDisplay];
            self.workDuration = [dict stringValueForKey:kModelResumeDetailWorkDuration];
            self.mobileAudit = [dict stringValueForKey:kModelResumeDetailMobileAudit];

            self.wordResumeAddtime = [dict stringValueForKey:kModelResumeDetailWordResumeAddtime];
            self.experience = [dict stringValueForKey:kModelResumeDetailExperience];
            self.displayName = [dict stringValueForKey:kModelResumeDetailDisplayName];
            self.birthdate = [dict stringValueForKey:kModelResumeDetailBirthdate];
            self.completePercent = [dict stringValueForKey:kModelResumeDetailCompletePercent];
            self.photosrc = [dict stringValueForKey:kModelResumeDetailPhotosrc];
            self.qq = [dict stringValueForKey:kModelResumeDetailQq];
            self.residence = [dict stringValueForKey:kModelResumeDetailResidence];
            self.experienceCn = [dict stringValueForKey:kModelResumeDetailExperienceCn];
            self.photoImg = [dict stringValueForKey:kModelResumeDetailPhotoImg];
            self.specialty = [dict stringValueForKey:kModelResumeDetailSpecialty];
            self.def = [dict stringValueForKey:kModelResumeDetailDef];
            self.keyPrecise = [dict stringValueForKey:kModelResumeDetailKeyPrecise];
            self.favor = [dict doubleValueForKey:kModelResumeDetailFavor];
            self.entrust = [dict stringValueForKey:kModelResumeDetailEntrust];
            self.wageCn = [dict stringValueForKey:kModelResumeDetailWageCn];
            self.audit = [dict stringValueForKey:kModelResumeDetailAudit];
            self.refreshtime = [dict stringValueForKey:kModelResumeDetailRefreshtime];
            self.refreshtimeCn = [dict stringValueForKey:kModelResumeDetailRefreshtimeCn];
            self.education = [dict stringValueForKey:kModelResumeDetailEducation];
            self.current = [dict stringValueForKey:kModelResumeDetailCurrent];
            self.districtCn = [dict stringValueForKey:kModelResumeDetailDistrictCn];
            self.weixin = [dict stringValueForKey:kModelResumeDetailWeixin];
            self.wordResume = [dict stringValueForKey:kModelResumeDetailWordResume];
            self.photo = [dict stringValueForKey:kModelResumeDetailPhoto];
            self.labelType = [dict doubleValueForKey:kModelResumeDetailLabelType];
            self.commentContent = [dict stringValueForKey:kModelResumeDetailCommentContent];
            self.intentionJobsId = [dict stringValueForKey:kModelResumeDetailIntentionJobsId];
            self.qrcodeUrl = [dict stringValueForKey:kModelResumeDetailQrcodeUrl];
            self.wordResumeTitle = [dict stringValueForKey:kModelResumeDetailWordResumeTitle];
            self.showContact = [dict boolValueForKey:kModelResumeDetailShowContact];
            self.nature = [dict stringValueForKey:kModelResumeDetailNature];
            self.emailNotify = [dict stringValueForKey:kModelResumeDetailEmailNotify];
            self.strongTag = [dict stringValueForKey:kModelResumeDetailStrongTag];
            self.addtime = [dict stringValueForKey:kModelResumeDetailAddtime];
            self.educationCn = [dict stringValueForKey:kModelResumeDetailEducationCn];
            self.telephone = [dict stringValueForKey:kModelResumeDetailTelephone];
            self.email = [dict stringValueForKey:kModelResumeDetailEmail];
            self.telephone = [dict stringValueForKey:kModelResumeDetailTelephone];
            self.ls = [dict doubleValueForKey:kModelResumeDetailLs];
            self.fullname = [dict stringValueForKey:kModelResumeDetailFullname];
            self.likeNum = [dict stringValueForKey:kModelResumeDetailLikeNum];
            self.labelResume = [dict stringValueForKey:kModelResumeDetailLabelResume];
            self.email = [dict stringValueForKey:kModelResumeDetailEmail];
            self.householdaddress = [dict stringValueForKey:kModelResumeDetailHouseholdaddress];
            self.photoAudit = [dict stringValueForKey:kModelResumeDetailPhotoAudit];
            self.intentionJobs = [dict stringValueForKey:kModelResumeDetailIntentionJobs];
            self.click = [dict stringValueForKey:kModelResumeDetailClick];
            self.trade = [dict stringValueForKey:kModelResumeDetailTrade];
            self.title = [dict stringValueForKey:kModelResumeDetailTitle];
            self.age = [dict doubleValueForKey:kModelResumeDetailAge];
            self.major = [dict stringValueForKey:kModelResumeDetailMajor];
            self.idcard = [dict stringValueForKey:kModelResumeDetailIdcard];
            self.sexCn = [dict stringValueForKey:kModelResumeDetailSexCn];
            self.level = [dict stringValueForKey:kModelResumeDetailLevel];
            self.display = [dict stringValueForKey:kModelResumeDetailDisplay];
            self.fullname = [dict stringValueForKey:kModelResumeDetailFullname];
            self.isQuick = [dict stringValueForKey:kModelResumeDetailIsQuick];
            self.labelId = [dict doubleValueForKey:kModelResumeDetailLabelId];
            self.stime = [dict stringValueForKey:kModelResumeDetailStime];
            self.stick = [dict stringValueForKey:kModelResumeDetailStick];
            self.marriageCn = [dict stringValueForKey:kModelResumeDetailMarriageCn];
            self.natureCn = [dict stringValueForKey:kModelResumeDetailNatureCn];
            self.wage = [dict stringValueForKey:kModelResumeDetailWage];
            self.currentCn = [dict stringValueForKey:kModelResumeDetailCurrentCn];
            self.height = [dict stringValueForKey:kModelResumeDetailHeight];
            self.tpl = [dict stringValueForKey:kModelResumeDetailTpl];
            self.tradeCn = [dict stringValueForKey:kModelResumeDetailTradeCn];
            self.workCount = [dict doubleValueForKey:kModelResumeDetailWorkCount];
            self.district = [dict stringValueForKey:kModelResumeDetailDistrict];
        if ([self.district containsString:@"."]) {
            self.district = [self.district componentsSeparatedByString:@"."].lastObject;
        }
        
        self.workList =  [GlobalMethod exchangeDic:[dict objectForKey:kModelResumeDetailWorkList] toAryWithModelName:@"ModelFJWorkExperience"];

        self.imgList =  [GlobalMethod exchangeDic:[dict objectForKey:kModelResumeDetailImgList] toAryWithModelName:@"sld"];
        self.tagCn =  [GlobalMethod exchangeDic:[dict objectForKey:kModelResumeDetailTagCn] toAryWithModelName:@"sld"];
        self.trainingList =  [GlobalMethod exchangeDic:[dict objectForKey:kModelResumeDetailTrainingList] toAryWithModelName:@"ModelJFTrainexperience"];
        self.languageList =  [GlobalMethod exchangeDic:[dict objectForKey:kModelResumeDetailLanguageList] toAryWithModelName:@"ModelFJLanguageExp"];
            self.educationList =  [GlobalMethod exchangeDic:[dict objectForKey:kModelResumeDetailEducationList] toAryWithModelName:@"ModelFJEducation"];
        self.projectList =  [GlobalMethod exchangeDic:[dict objectForKey:kModelResumeDetailProjectList] toAryWithModelName:@"ModelFJProjectExp"];
        self.credentList =  [GlobalMethod exchangeDic:[dict objectForKey:kModelResumeDetailCredentList] toAryWithModelName:@"ModelFJCredentExp"];
        self.labelArr =  [GlobalMethod exchangeDic:[dict objectForKey:kModelResumeDetailLabelArr] toAryWithModelName:@"sld"];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.majorCn forKey:kModelResumeDetailMajorCn];
    [mutableDict setValue:self.sex forKey:kModelResumeDetailSex];
    [mutableDict setValue:self.uid forKey:kModelResumeDetailUid];
    [mutableDict setValue:self.tag forKey:kModelResumeDetailTag];
    [mutableDict setValue:self.marriage forKey:kModelResumeDetailMarriage];
    [mutableDict setValue:self.iDProperty forKey:kModelResumeDetailId];
    [mutableDict setValue:self.keyFull forKey:kModelResumeDetailKeyFull];
    [mutableDict setValue:self.talent forKey:kModelResumeDetailTalent];
    [mutableDict setValue:self.resumeFromPc forKey:kModelResumeDetailResumeFromPc];
    [mutableDict setValue:self.photoDisplay forKey:kModelResumeDetailPhotoDisplay];
    [mutableDict setValue:[GlobalMethod exchangeAryModelToAryDic:self.credentList] forKey:kModelResumeDetailCredentList];
    [mutableDict setValue:self.workDuration forKey:kModelResumeDetailWorkDuration];
    [mutableDict setValue:self.mobileAudit forKey:kModelResumeDetailMobileAudit];
    [mutableDict setValue:[GlobalMethod exchangeAryModelToAryDic:self.educationList] forKey:kModelResumeDetailEducationList];
    [mutableDict setValue:self.wordResumeAddtime forKey:kModelResumeDetailWordResumeAddtime];
    [mutableDict setValue:self.experience forKey:kModelResumeDetailExperience];
    [mutableDict setValue:self.displayName forKey:kModelResumeDetailDisplayName];
    [mutableDict setValue:self.birthdate forKey:kModelResumeDetailBirthdate];
    [mutableDict setValue:self.completePercent forKey:kModelResumeDetailCompletePercent];
    [mutableDict setValue:self.photosrc forKey:kModelResumeDetailPhotosrc];
    [mutableDict setValue:self.qq forKey:kModelResumeDetailQq];
    [mutableDict setValue:self.residence forKey:kModelResumeDetailResidence];
    [mutableDict setValue:[GlobalMethod exchangeAryModelToAryDic:self.projectList] forKey:kModelResumeDetailProjectList];
    [mutableDict setValue:self.experienceCn forKey:kModelResumeDetailExperienceCn];
    [mutableDict setValue:self.photoImg forKey:kModelResumeDetailPhotoImg];
    [mutableDict setValue:self.specialty forKey:kModelResumeDetailSpecialty];
    [mutableDict setValue:self.def forKey:kModelResumeDetailDef];
    [mutableDict setValue:self.keyPrecise forKey:kModelResumeDetailKeyPrecise];
    [mutableDict setValue:[NSNumber numberWithDouble:self.favor] forKey:kModelResumeDetailFavor];
    [mutableDict setValue:self.entrust forKey:kModelResumeDetailEntrust];
    [mutableDict setValue:self.wageCn forKey:kModelResumeDetailWageCn];
    [mutableDict setValue:self.audit forKey:kModelResumeDetailAudit];
    [mutableDict setValue:self.refreshtime forKey:kModelResumeDetailRefreshtime];
    [mutableDict setValue:self.refreshtimeCn forKey:kModelResumeDetailRefreshtimeCn];
    [mutableDict setValue:self.education forKey:kModelResumeDetailEducation];
    [mutableDict setValue:self.current forKey:kModelResumeDetailCurrent];
    [mutableDict setValue:self.districtCn forKey:kModelResumeDetailDistrictCn];
    [mutableDict setValue:self.weixin forKey:kModelResumeDetailWeixin];
    [mutableDict setValue:self.wordResume forKey:kModelResumeDetailWordResume];
    [mutableDict setValue:self.photo forKey:kModelResumeDetailPhoto];
    [mutableDict setValue:[NSNumber numberWithDouble:self.labelType] forKey:kModelResumeDetailLabelType];
    [mutableDict setValue:[GlobalMethod exchangeAryModelToAryDic:self.languageList] forKey:kModelResumeDetailLanguageList];
    [mutableDict setValue:self.commentContent forKey:kModelResumeDetailCommentContent];
    [mutableDict setValue:self.intentionJobsId forKey:kModelResumeDetailIntentionJobsId];
    [mutableDict setValue:self.qrcodeUrl forKey:kModelResumeDetailQrcodeUrl];
    [mutableDict setValue:self.wordResumeTitle forKey:kModelResumeDetailWordResumeTitle];
    [mutableDict setValue:[NSNumber numberWithBool:self.showContact] forKey:kModelResumeDetailShowContact];
    [mutableDict setValue:[GlobalMethod exchangeAryModelToAryDic:self.trainingList] forKey:kModelResumeDetailTrainingList];
    [mutableDict setValue:self.nature forKey:kModelResumeDetailNature];
    [mutableDict setValue:self.emailNotify forKey:kModelResumeDetailEmailNotify];
    [mutableDict setValue:self.strongTag forKey:kModelResumeDetailStrongTag];
    [mutableDict setValue:self.addtime forKey:kModelResumeDetailAddtime];
    [mutableDict setValue:self.educationCn forKey:kModelResumeDetailEducationCn];
    [mutableDict setValue:self.telephone forKey:kModelResumeDetailTelephone];
    [mutableDict setValue:self.email forKey:kModelResumeDetailEmail];
    [mutableDict setValue:self.telephone forKey:kModelResumeDetailTelephone];
    [mutableDict setValue:[NSNumber numberWithDouble:self.ls] forKey:kModelResumeDetailLs];
    [mutableDict setValue:self.fullname forKey:kModelResumeDetailFullname];
    [mutableDict setValue:self.likeNum forKey:kModelResumeDetailLikeNum];
    [mutableDict setValue:self.labelResume forKey:kModelResumeDetailLabelResume];
    [mutableDict setValue:self.email forKey:kModelResumeDetailEmail];
    [mutableDict setValue:self.householdaddress forKey:kModelResumeDetailHouseholdaddress];
    [mutableDict setValue:self.photoAudit forKey:kModelResumeDetailPhotoAudit];
    [mutableDict setValue:[GlobalMethod exchangeAryModelToAryDic:self.labelArr] forKey:kModelResumeDetailLabelArr];
    [mutableDict setValue:self.intentionJobs forKey:kModelResumeDetailIntentionJobs];
    [mutableDict setValue:self.click forKey:kModelResumeDetailClick];
    [mutableDict setValue:self.trade forKey:kModelResumeDetailTrade];
    [mutableDict setValue:self.title forKey:kModelResumeDetailTitle];
    [mutableDict setValue:[NSNumber numberWithDouble:self.age] forKey:kModelResumeDetailAge];
    [mutableDict setValue:self.major forKey:kModelResumeDetailMajor];
    [mutableDict setValue:[GlobalMethod exchangeAryModelToAryDic:self.tagCn] forKey:kModelResumeDetailTagCn];
    [mutableDict setValue:self.idcard forKey:kModelResumeDetailIdcard];
    [mutableDict setValue:self.sexCn forKey:kModelResumeDetailSexCn];
    [mutableDict setValue:self.level forKey:kModelResumeDetailLevel];
    [mutableDict setValue:self.display forKey:kModelResumeDetailDisplay];
    [mutableDict setValue:self.fullname forKey:kModelResumeDetailFullname];
    [mutableDict setValue:self.isQuick forKey:kModelResumeDetailIsQuick];
    [mutableDict setValue:[NSNumber numberWithDouble:self.labelId] forKey:kModelResumeDetailLabelId];
    [mutableDict setValue:self.stime forKey:kModelResumeDetailStime];
    [mutableDict setValue:self.stick forKey:kModelResumeDetailStick];
    [mutableDict setValue:self.marriageCn forKey:kModelResumeDetailMarriageCn];
    [mutableDict setValue:self.natureCn forKey:kModelResumeDetailNatureCn];
    [mutableDict setValue:self.wage forKey:kModelResumeDetailWage];
    [mutableDict setValue:self.currentCn forKey:kModelResumeDetailCurrentCn];
    [mutableDict setValue:self.height forKey:kModelResumeDetailHeight];
    [mutableDict setValue:[GlobalMethod exchangeAryModelToAryDic:self.workList] forKey:kModelResumeDetailWorkList];
    [mutableDict setValue:self.tpl forKey:kModelResumeDetailTpl];
    [mutableDict setValue:self.tradeCn forKey:kModelResumeDetailTradeCn];
    [mutableDict setValue:[NSNumber numberWithDouble:self.workCount] forKey:kModelResumeDetailWorkCount];
    [mutableDict setValue:[GlobalMethod exchangeAryModelToAryDic:self.imgList] forKey:kModelResumeDetailImgList];
    [mutableDict setValue:self.district forKey:kModelResumeDetailDistrict];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
