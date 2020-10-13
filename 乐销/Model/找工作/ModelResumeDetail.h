//
//  ModelResumeDetail.h
//
//  Created by 林栋 隋 on 2020/9/16
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelResumeDetail : NSObject

@property (nonatomic, strong) NSString *majorCn;
@property (nonatomic, strong) NSString *sex;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *tag;
@property (nonatomic, strong) NSString *marriage;
@property (nonatomic, strong) NSString *iDProperty;
@property (nonatomic, strong) NSString *keyFull;
@property (nonatomic, strong) NSString *talent;
@property (nonatomic, strong) NSString *resumeFromPc;
@property (nonatomic, strong) NSString *photoDisplay;
@property (nonatomic, strong) NSArray *credentList;
@property (nonatomic, strong) NSString *workDuration;
@property (nonatomic, strong) NSString *mobileAudit;
@property (nonatomic, strong) NSArray *educationList;
@property (nonatomic, strong) NSString *wordResumeAddtime;
@property (nonatomic, strong) NSString *experience;
@property (nonatomic, strong) NSString *displayName;
@property (nonatomic, strong) NSString *birthdate;
@property (nonatomic, strong) NSString *completePercent;
@property (nonatomic, strong) NSString *photosrc;
@property (nonatomic, strong) NSString *qq;
@property (nonatomic, strong) NSString *residence;
@property (nonatomic, strong) NSArray *projectList;
@property (nonatomic, strong) NSString *experienceCn;
@property (nonatomic, strong) NSString *photoImg;
@property (nonatomic, strong) NSString *specialty;
@property (nonatomic, strong) NSString *def;
@property (nonatomic, strong) NSString *keyPrecise;
@property (nonatomic, assign) double favor;
@property (nonatomic, strong) NSString *entrust;
@property (nonatomic, strong) NSString *wageCn;
@property (nonatomic, strong) NSString *audit;
@property (nonatomic, strong) NSString *refreshtime;
@property (nonatomic, strong) NSString *refreshtimeCn;
@property (nonatomic, strong) NSString *education;
@property (nonatomic, strong) NSString *current;
@property (nonatomic, strong) NSString *districtCn;
@property (nonatomic, strong) NSString *weixin;
@property (nonatomic, strong) NSString *wordResume;
@property (nonatomic, strong) NSString *photo;
@property (nonatomic, assign) double labelType;
@property (nonatomic, strong) NSArray *languageList;
@property (nonatomic, strong) NSString *commentContent;
@property (nonatomic, strong) NSString *intentionJobsId;
@property (nonatomic, strong) NSString *qrcodeUrl;
@property (nonatomic, strong) NSString *wordResumeTitle;
@property (nonatomic, assign) BOOL showContact;
@property (nonatomic, strong) NSArray *trainingList;
@property (nonatomic, strong) NSString *nature;
@property (nonatomic, strong) NSString *emailNotify;
@property (nonatomic, strong) NSString *strongTag;
@property (nonatomic, strong) NSString *addtime;
@property (nonatomic, strong) NSString *educationCn;
@property (nonatomic, strong) NSString *telephone;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, assign) double ls;
@property (nonatomic, strong) NSString *likeNum;
@property (nonatomic, strong) NSString *labelResume;
@property (nonatomic, strong) NSString *householdaddress;
@property (nonatomic, strong) NSString *photoAudit;
@property (nonatomic, strong) NSArray *labelArr;
@property (nonatomic, strong) NSString *intentionJobs;
@property (nonatomic, strong) NSString *click;
@property (nonatomic, strong) NSString *trade;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) double age;
@property (nonatomic, strong) NSString *major;
@property (nonatomic, strong) NSArray *tagCn;
@property (nonatomic, strong) NSString *idcard;
@property (nonatomic, strong) NSString *sexCn;
@property (nonatomic, strong) NSString *level;
@property (nonatomic, strong) NSString *display;
@property (nonatomic, strong) NSString *fullname;
@property (nonatomic, strong) NSString *isQuick;
@property (nonatomic, assign) double labelId;
@property (nonatomic, strong) NSString *stime;
@property (nonatomic, strong) NSString *stick;
@property (nonatomic, strong) NSString *marriageCn;
@property (nonatomic, strong) NSString *natureCn;
@property (nonatomic, strong) NSString *wage;
@property (nonatomic, strong) NSString *currentCn;
@property (nonatomic, strong) NSString *height;
@property (nonatomic, strong) NSArray *workList;
@property (nonatomic, strong) NSString *tpl;
@property (nonatomic, strong) NSString *tradeCn;
@property (nonatomic, assign) double workCount;
@property (nonatomic, strong) NSArray *imgList;
@property (nonatomic, strong) NSString *district;
@property (nonatomic, strong) NSString *shanggegw;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
