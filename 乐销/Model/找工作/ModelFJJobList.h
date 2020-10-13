//
//  ModelFJJobList.h
//
//  Created by 林栋 隋 on 2020/9/10
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelFJJobList : NSObject

@property (nonatomic, strong) NSString *ageCn;
@property (nonatomic, strong) NSString *wageCn;
@property (nonatomic, strong) NSString *emergency;
@property (nonatomic, strong) NSString *iDProperty;
@property (nonatomic, strong) NSString *contents;
@property (nonatomic, strong) NSString *sex;
@property (nonatomic, strong) NSString *briefly;
@property (nonatomic, strong) NSString *logo;
@property (nonatomic, strong) NSString *natureCn;
@property (nonatomic, strong) NSString *companyId;
@property (nonatomic, strong) NSString *nature;
@property (nonatomic, strong) NSString *refreshtimeCn;
@property (nonatomic, strong) NSString *stick;
@property (nonatomic, strong) NSString *mapX;
@property (nonatomic, strong) NSString *tpl;
@property (nonatomic, strong) NSString *department;
@property (nonatomic, strong) NSString *experience;
@property (nonatomic, strong) NSString *addtime;
@property (nonatomic, strong) NSString *mapZoom;
@property (nonatomic, strong) NSString *click;
@property (nonatomic, strong) NSString *amount;
@property (nonatomic, strong) NSString *negotiable;
@property (nonatomic, strong) NSString *tradeCn;
@property (nonatomic, strong) NSString *sexCn;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *robot;
@property (nonatomic, strong) NSString *keyFull;
@property (nonatomic, strong) NSString *setmealName;
@property (nonatomic, strong) NSString *stime;
@property (nonatomic, strong) NSString *likeNumCn;
@property (nonatomic, strong) NSString *keyPrecise;
@property (nonatomic, strong) NSString *categoryCn;
@property (nonatomic, strong) NSString *display;
@property (nonatomic, strong) NSString *jobsName;
@property (nonatomic, strong) NSString *mapY;
@property (nonatomic, assign) double isCollect;
@property (nonatomic, assign) double allowanceId;
@property (nonatomic, strong) NSString *likeNum;
@property (nonatomic, strong) NSString *companyname;
@property (nonatomic, strong) NSString *deadline;
@property (nonatomic, strong) NSString *subclass;
@property (nonatomic, strong) NSString *userStatus;
@property (nonatomic, strong) NSString *education;
@property (nonatomic, strong) NSString *topclass;
@property (nonatomic, strong) NSString *famous;
@property (nonatomic, strong) NSString *companyAddtime;
@property (nonatomic, assign) double isLike;
@property (nonatomic, strong) NSString *scale;
@property (nonatomic, strong) NSString *audit;
@property (nonatomic, strong) NSString *tag;
@property (nonatomic, strong) NSString *setmealDeadline;
@property (nonatomic, strong) NSString *age;
@property (nonatomic, strong) NSString *trade;
@property (nonatomic, strong) NSString *category;
@property (nonatomic, strong) NSString *district;
@property (nonatomic, strong) NSString *addMode;
@property (nonatomic, strong) NSString *experienceCn;
@property (nonatomic, strong) NSString *companyUrl;
@property (nonatomic, strong) NSString *districtCn;
@property (nonatomic, strong) NSString *minwage;
@property (nonatomic, strong) NSString *shortName;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *jobsUrl;
@property (nonatomic, strong) NSString *refreshtime;
@property (nonatomic, strong) NSString *scaleCn;
@property (nonatomic, strong) NSArray *allowanceInfo;
@property (nonatomic, strong) NSString *educationCn;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *maxwage;
@property (nonatomic, strong) NSString *setmealId;
@property (nonatomic, strong) NSArray *tagCn;
@property (nonatomic, strong) NSString *companyAudit;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
