//
//  RequestApi+FindJob.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/9/10.
//  Copyright © 2020 ping. All rights reserved.
//www.wfrcsc.com
//www.wfrcsc.com
#import "RequestApi+FindJob.h"

@implementation RequestApi (FindJob)

+(void)requestFindJobUserDelegate:(id <RequestDelegate>)delegate
                          success:(void (^)(NSDictionary * response, id mark))success
                          failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"app":@"wsq",
                          @"key":@"Xba6nyKhE7xeCmMwiEN4OJ6OoYRg8oQRJsbdiIp1gxyUqzwoXf9xPqePmUlGaZ6f",
                          @"mobile":[GlobalData sharedInstance].GB_UserModel.phone,
//                          @"mobile":@"15263671006",

    };
    NSString * strUrl = @"http://www.wfrcsc.com/index.php?m=api&c=index&a=getMember";
    [self getUrl:strUrl delegate:delegate parameters:dic success:success failure:failure];
}
+(void)requestFJJobListDelegate:(id <RequestDelegate>)delegate
                           page:(double)page
                           type:(NSString *)type
                   citycategory:(double)citycategory
                           wage:(double)wage
                     experience:(double)experience
                         nature:(double)nature
                      education:(double)education
                         jobtag:(double)jobtag
                          settr:(double)settr
                            key:(NSString *)key
                        success:(void (^)(NSDictionary * response, id mark))success
                        failure:(void (^)(NSString * errorStr, id mark))failure{
    NSMutableDictionary *dic = @{@"page":RequestLongKey(page),
                          @"type":RequestStrKey(type),
                                 @"key":RequestStrKey(key),
                                 @"citycategory":RequestLongKey(citycategory),
                                 @"wage":RequestLongKey(wage),
                                 @"experience":RequestLongKey(experience),
                                 @"nature":RequestLongKey(nature),
                                 @"education":RequestLongKey(education),
                                 @"jobtag":RequestLongKey(jobtag),
                                 @"settr":RequestLongKey(settr),
    }.mutableCopy;
    if ([type isEqualToString:@"nearby_jobs"]) {
        ModelAddress * modelAddress = [GlobalMethod readModelForKey:LOCAL_LOCATION  modelName:@"ModelAddress" exchange:false];
        if (modelAddress.lat) {
            [dic setObject:NSNumber.dou(modelAddress.lat).stringValue forKey:@"lat"];
            [dic setObject:NSNumber.dou(modelAddress.lng).stringValue forKey:@"lng"];
        }
    }
    NSString * strUrl = @"http://www.wfrcsc.com/index.php?m=api&c=index&a=jobsList";
    [self getUrl:strUrl delegate:delegate parameters:dic success:success failure:failure];
}
+(void)requestFJJobDetail:(double)identity
delegate:(id <RequestDelegate>)delegate
                           success:(void (^)(NSDictionary * response, id mark))success
                           failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"id":RequestLongKey(identity),
                          @"uid":RequestStrKey([GlobalData sharedInstance].modelFindJob.uid),
    };
    NSString * strUrl = @"http://www.wfrcsc.com/index.php?m=api&c=index&a=jobShow";
    [self getUrl:strUrl delegate:delegate parameters:dic success:success failure:failure];
}
+(void)requestFJNewJobListDelegate:(id <RequestDelegate>)delegate
                              type:(NSString *)type
                              page:(double)page
                           success:(void (^)(NSDictionary * response, id mark))success
                           failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"page":RequestLongKey(page),
                          @"type":RequestStrKey(type),
    };
    NSString * strUrl = @"http://www.wfrcsc.com/index.php?m=api&c=index&a=jobsList";
    [self getUrl:strUrl delegate:delegate parameters:dic success:success failure:failure];
}

+(void)requestFJNetJobListDelegate:(id <RequestDelegate>)delegate
                              page:(double)page
                           success:(void (^)(NSDictionary * response, id mark))success
                           failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"page":RequestLongKey(page),
    };
    NSString * strUrl = @"http://www.wfrcsc.com/index.php?m=api&c=subject&a=subject_index";
    [self getUrl:strUrl delegate:delegate parameters:dic success:success failure:failure];
}

+(void)requestFJNetJobDetailDelegate:(id <RequestDelegate>)delegate
                            identity:(double)identity
                             success:(void (^)(NSDictionary * response, id mark))success
                             failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"id":RequestLongKey(identity),
    };
    NSString * strUrl = @"http://www.wfrcsc.com/index.php?m=api&c=subject&a=subject_show";
    [self getUrl:strUrl delegate:delegate parameters:dic success:success failure:failure];
}

+(void)requestFJNewsListDelegate:(id <RequestDelegate>)delegate
                            page:(double)page
                            type:(NSString *)type
                         success:(void (^)(NSDictionary * response, id mark))success
                         failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"page":RequestLongKey(page),
                          @"type":RequestStrKey(type),
    };
    NSString * strUrl = @"http://www.wfrcsc.com/index.php?m=api&c=news&a=news_index";
    [self getUrl:strUrl delegate:delegate parameters:dic success:success failure:failure];
}

+(void)requestFJMainNewsListDelegate:(id <RequestDelegate>)delegate
                                page:(double)page
                             success:(void (^)(NSDictionary * response, id mark))success
                             failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"page":RequestLongKey(page),
    };
    NSString * strUrl = @"http://www.wfrcsc.com/index.php?m=api&c=notice&a=notice_index";
    [self getUrl:strUrl delegate:delegate parameters:dic success:success failure:failure];
}

+(void)requestFJDistrictDataListDelegate:(id <RequestDelegate>)delegate
                                 success:(void (^)(NSDictionary * response, id mark))success
                                 failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{};
    NSString * strUrl = @"http://www.wfrcsc.com/index.php?m=api&c=base&a=cate_district_list";
    [self getUrl:strUrl delegate:delegate parameters:dic success:success failure:failure];
}
+(void)requestFJWageDataListDelegate:(id <RequestDelegate>)delegate
                             success:(void (^)(NSDictionary * response, id mark))success
                             failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{};
    NSString * strUrl = @"http://www.wfrcsc.com/index.php?m=api&c=base&a=cate_wage_list";
    [self getUrl:strUrl delegate:delegate parameters:dic success:success failure:failure];
}
+(void)requestFJExperienceDataListDelegate:(id <RequestDelegate>)delegate
                                   success:(void (^)(NSDictionary * response, id mark))success
                                   failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{};
    NSString * strUrl = @"http://www.wfrcsc.com/index.php?m=api&c=base&a=cate_experience_list";
    [self getUrl:strUrl delegate:delegate parameters:dic success:success failure:failure];
}
+(void)requestFJEducationDataListDelegate:(id <RequestDelegate>)delegate
                                  success:(void (^)(NSDictionary * response, id mark))success
                                  failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{};
    NSString * strUrl = @"http://www.wfrcsc.com/index.php?m=api&c=base&a=cate_education_list";
    [self getUrl:strUrl delegate:delegate parameters:dic success:success failure:failure];
}
+(void)requestFJWellfareDataListDelegate:(id <RequestDelegate>)delegate
                                 success:(void (^)(NSDictionary * response, id mark))success
                                 failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{};
    NSString * strUrl = @"http://www.wfrcsc.com/index.php?m=api&c=base&a=cate_tag_list";
    [self getUrl:strUrl delegate:delegate parameters:dic success:success failure:failure];
}
+(void)requestFJJobNatureDataListDelegate:(id <RequestDelegate>)delegate
                                     success:(void (^)(NSDictionary * response, id mark))success
                                     failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{};
    NSString * strUrl = @"http://www.wfrcsc.com/index.php?m=api&c=base&a=cate_nature_list";
    [self getUrl:strUrl delegate:delegate parameters:dic success:success failure:failure];
}
+(void)requestFJRefreshDataListDelegate:(id <RequestDelegate>)delegate
                                success:(void (^)(NSDictionary * response, id mark))success
                                failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{};
    NSString * strUrl = @"http://www.wfrcsc.com/index.php?m=api&c=base&a=cate_fresh_list";
    [self getUrl:strUrl delegate:delegate parameters:dic success:success failure:failure];
}
+(void)requestFJProfessionalDataListDelegate:(id <RequestDelegate>)delegate
                                     success:(void (^)(NSDictionary * response, id mark))success
                                     failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{};
    NSString * strUrl = @"http://www.wfrcsc.com/index.php?m=api&c=base&a=cate_major_list";
    [self getUrl:strUrl delegate:delegate parameters:dic success:success failure:failure];
}
+(void)requestFJTradeDataListDelegate:(id <RequestDelegate>)delegate
                               success:(void (^)(NSDictionary * response, id mark))success
                               failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{};
    NSString * strUrl = @"http://www.wfrcsc.com/index.php?m=api&c=base&a=cate_trade_list";
    [self getUrl:strUrl delegate:delegate parameters:dic success:success failure:failure];
}
+(void)requestFJIntentionJobDataListDelegate:(id <RequestDelegate>)delegate
                               success:(void (^)(NSDictionary * response, id mark))success
                               failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{};
    NSString * strUrl = @"http://www.wfrcsc.com/index.php?m=api&c=base&a=cate_job_list";
    [self getUrl:strUrl delegate:delegate parameters:dic success:success failure:failure];
}
+(void)requestFJCompanyTypeDataListDelegate:(id <RequestDelegate>)delegate
                                    success:(void (^)(NSDictionary * response, id mark))success
                                    failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{};
    NSString * strUrl = @"http://www.wfrcsc.com/index.php?m=api&c=base&a=cate_company_list";
    [self getUrl:strUrl delegate:delegate parameters:dic success:success failure:failure];
}
+(void)requestFJLaguageDataListDelegate:(id <RequestDelegate>)delegate
                                success:(void (^)(NSDictionary * response, id mark))success
                                failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{};
    NSString * strUrl = @"http://www.wfrcsc.com/index.php?m=api&c=base&a=cate_language_list";
    [self getUrl:strUrl delegate:delegate parameters:dic success:success failure:failure];
}
+(void)requestFJLaguageLevelDataListDelegate:(id <RequestDelegate>)delegate
                                success:(void (^)(NSDictionary * response, id mark))success
                                failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{};
    NSString * strUrl = @"http://www.wfrcsc.com/index.php?m=api&c=base&a=cate_language_level";
    [self getUrl:strUrl delegate:delegate parameters:dic success:success failure:failure];
}
+(void)requestFJNowStateDataListDelegate:(id <RequestDelegate>)delegate
                                 success:(void (^)(NSDictionary * response, id mark))success
                                 failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{};
    NSString * strUrl = @"http://www.wfrcsc.com/index.php?m=api&c=base&a=cate_current_list";
    [self getUrl:strUrl delegate:delegate parameters:dic success:success failure:failure];
}
+(void)requestFJCreateResumeDistrict:(double)district
                                 sex:(double)sex
                           birthdate:(NSString *)birthdate
                               major:(double)major
                          experience:(double)experience
                              nature:(double)nature
                             current:(double)current
                                wage:(double)wage
                           telephone:(NSString *)telephone
                            fullname:(NSString *)fullname
                               email:(NSString *)email
                   intention_jobs_id:(NSString *)intention_jobs_id
                               trade:(double)trade
                            marriage:(double)marriage
                    householdaddress:(NSString *)householdaddress
                           residence:(NSString *)residence
                                  qq:(NSString *)qq
                              weixin:(NSString *)weixin
                           education:(double)education
                            delegate:(id <RequestDelegate>)delegate
                             success:(void (^)(NSDictionary * response, id mark))success
                             failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"app":@"wsq",
                          @"key":@"Xba6nyKhE7xeCmMwiEN4OJ6OoYRg8oQRJsbdiIp1gxyUqzwoXf9xPqePmUlGaZ6f",
                          @"uid":RequestStrKey([GlobalData sharedInstance].modelFindJob.uid),
                          @"district":RequestLongKey(district),
                          @"sex":RequestLongKey(sex),
                          @"birthdate":RequestStrKey(birthdate),
                          @"major":RequestLongKey(major),
                          @"experience":RequestLongKey(experience),
                          @"nature":RequestLongKey(nature),
                          @"current":RequestLongKey(current),
                          @"wage":RequestLongKey(wage),
                          @"telephone":RequestStrKey(telephone),
                          @"fullname":RequestStrKey(fullname),
                          @"email":RequestStrKey(email),
                          @"intention_jobs_id":RequestStrKey(intention_jobs_id),
                          @"trade":RequestLongKey(trade),
                          @"marriage":RequestLongKey(marriage),
                          @"householdaddress":RequestStrKey(householdaddress),
                          @"residence":RequestStrKey(residence),
                          @"qq":RequestStrKey(qq),
                          @"weixin":RequestStrKey(weixin),
                          @"education":RequestLongKey(education)
    };
    NSString * strUrl = @"http://www.wfrcsc.com/index.php?m=api&c=user&a=resumeAdd";
    [self postUrl:strUrl delegate:delegate parameters:dic success:success failure:failure];
}

+(void)requestFJEditInfopid:(double)pid
                            fullname:(NSString *)fullname
                                 sex:(double)sex
                           birthdate:(NSString *)birthdate
                           residence:(NSString *)residence
                           education:(double)education
                          experience:(double)experience
                           telephone:(NSString *)telephone
                               email:(NSString *)email
                               major:(double)major
                              height:(double)height
                    householdaddress:(NSString *)householdaddress
                             marriage:(double)marriage
                                  qq:(NSString *)qq
                              weixin:(NSString *)weixin
                                idcard:(NSString *)idcard
                   shanggegw:(NSString *)shanggegw
                            delegate:(id <RequestDelegate>)delegate
                             success:(void (^)(NSDictionary * response, id mark))success
                             failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"app":@"wsq",
                          @"key":@"Xba6nyKhE7xeCmMwiEN4OJ6OoYRg8oQRJsbdiIp1gxyUqzwoXf9xPqePmUlGaZ6f",
                          @"uid":RequestStrKey([GlobalData sharedInstance].modelFindJob.uid),
                          @"pid":RequestLongKey(pid),
                          @"sex":RequestLongKey(sex),
                          @"birthdate":RequestStrKey(birthdate),
                          @"major":RequestLongKey(major),
                          @"experience":RequestLongKey(experience),
                          @"height":RequestLongKey(height),
                          @"marriage":RequestLongKey(marriage),
                          @"idcard":RequestStrKey(idcard),
                          @"telephone":RequestStrKey(telephone),
                          @"fullname":RequestStrKey(fullname),
                          @"email":RequestStrKey(email),
                          @"shanggegw":RequestStrKey(shanggegw),
                          @"marriage":RequestLongKey(marriage),
                          @"householdaddress":RequestStrKey(householdaddress),
                          @"residence":RequestStrKey(residence),
                          @"qq":RequestStrKey(qq),
                          @"weixin":RequestStrKey(weixin),
                          @"education":RequestLongKey(education)
    };
    NSString * strUrl = @"http://www.wfrcsc.com/index.php?m=api&c=user&a=resumeEditBasis";
    [self postUrl:strUrl delegate:delegate parameters:dic success:success failure:failure];
}

+(void)requestFJResumeInfoDelegate:(id <RequestDelegate>)delegate
success:(void (^)(NSDictionary * response, id mark))success
                           failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"app":@"wsq",
        @"key":@"Xba6nyKhE7xeCmMwiEN4OJ6OoYRg8oQRJsbdiIp1gxyUqzwoXf9xPqePmUlGaZ6f",
        @"uid":RequestStrKey([GlobalData sharedInstance].modelFindJob.uid)};
       NSString * strUrl = @"http://www.wfrcsc.com/index.php?m=api&c=user&a=resumeShow";
       [self getUrl:strUrl delegate:delegate parameters:dic success:success failure:failure];
}
+(void)requestFJSubmitResume:(double)jobId
delegate:(id <RequestDelegate>)delegate
success:(void (^)(NSDictionary * response, id mark))success
                           failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"app":@"wsq",
        @"key":@"Xba6nyKhE7xeCmMwiEN4OJ6OoYRg8oQRJsbdiIp1gxyUqzwoXf9xPqePmUlGaZ6f",
        @"uid":RequestStrKey([GlobalData sharedInstance].modelFindJob.uid),
                          @"jobId":RequestLongKey(jobId)
    };
       NSString * strUrl = @"http://www.wfrcsc.com/index.php?m=api&c=user&a=resumeApply";
       [self postUrl:strUrl delegate:delegate parameters:dic success:success failure:failure];
}

+(void)requestFJResumeEducationpid:(double)pid
                          identity:(double)identity
                            school:(NSString *)school
                           speciality:(NSString *)speciality
                           startyear:(double)startyear
                          startmonth:(double)startmonth
                               endyear:(double)endyear
                              endmonth:(double)endmonth
                             education:(double)education
                            delegate:(id <RequestDelegate>)delegate
                             success:(void (^)(NSDictionary * response, id mark))success
                             failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"app":@"wsq",
                          @"key":@"Xba6nyKhE7xeCmMwiEN4OJ6OoYRg8oQRJsbdiIp1gxyUqzwoXf9xPqePmUlGaZ6f",
                          @"uid":RequestStrKey([GlobalData sharedInstance].modelFindJob.uid),
                          @"pid":RequestLongKey(pid),
                          @"id":RequestLongKey(identity),
                          @"school":RequestStrKey(school),
                          @"speciality":RequestStrKey(speciality),
                          @"startyear":RequestLongKey(startyear),
                          @"startmonth":RequestLongKey(startmonth),
                          @"endyear":RequestLongKey(endyear),
                          @"endmonth":RequestLongKey(endmonth),
                          @"education":RequestLongKey(education)
    };
    NSString * strUrl = @"http://www.wfrcsc.com/index.php?m=api&c=user&a=resumeEditEdu";
    [self postUrl:strUrl delegate:delegate parameters:dic success:success failure:failure];
}

+(void)requestFJResumeWorkpid:(double)pid
                          identity:(double)identity
                            companyname:(NSString *)companyname
                           jobs:(NSString *)jobs
                           startyear:(double)startyear
                          startmonth:(double)startmonth
                               endyear:(double)endyear
                              endmonth:(double)endmonth
                 achievements:(NSString *)achievements
                            delegate:(id <RequestDelegate>)delegate
                             success:(void (^)(NSDictionary * response, id mark))success
                             failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"app":@"wsq",
                          @"key":@"Xba6nyKhE7xeCmMwiEN4OJ6OoYRg8oQRJsbdiIp1gxyUqzwoXf9xPqePmUlGaZ6f",
                          @"uid":RequestStrKey([GlobalData sharedInstance].modelFindJob.uid),
                          @"pid":RequestLongKey(pid),
                          @"id":RequestLongKey(identity),
                          @"companyname":RequestStrKey(companyname),
                          @"jobs":RequestStrKey(jobs),
                          @"startyear":RequestLongKey(startyear),
                          @"startmonth":RequestLongKey(startmonth),
                          @"endyear":RequestLongKey(endyear),
                          @"endmonth":RequestLongKey(endmonth),
                          @"achievements":RequestStrKey(achievements)
    };
    NSString * strUrl = @"http://www.wfrcsc.com/index.php?m=api&c=user&a=resumeEditWork";
    [self postUrl:strUrl delegate:delegate parameters:dic success:success failure:failure];
}
+(void)requestFJResumeProjectpid:(double)pid
                          identity:(double)identity
                            projectname:(NSString *)projectname
                           role:(NSString *)role
                           startyear:(double)startyear
                          startmonth:(double)startmonth
                               endyear:(double)endyear
                              endmonth:(double)endmonth
                     description:(NSString *)description
                            delegate:(id <RequestDelegate>)delegate
                             success:(void (^)(NSDictionary * response, id mark))success
                             failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"app":@"wsq",
                          @"key":@"Xba6nyKhE7xeCmMwiEN4OJ6OoYRg8oQRJsbdiIp1gxyUqzwoXf9xPqePmUlGaZ6f",
                          @"uid":RequestStrKey([GlobalData sharedInstance].modelFindJob.uid),
                          @"pid":RequestLongKey(pid),
                          @"id":RequestLongKey(identity),
                          @"projectname":RequestStrKey(projectname),
                          @"role":RequestStrKey(role),
                          @"startyear":RequestLongKey(startyear),
                          @"startmonth":RequestLongKey(startmonth),
                          @"endyear":RequestLongKey(endyear),
                          @"endmonth":RequestLongKey(endmonth),
                          @"description":RequestStrKey(description)

    };
    NSString * strUrl = @"http://www.wfrcsc.com/index.php?m=api&c=user&a=resumeEditProject";
    [self postUrl:strUrl delegate:delegate parameters:dic success:success failure:failure];
}
+(void)requestFJResumeTrainpid:(double)pid
                          identity:(double)identity
                            agency:(NSString *)agency
                           course:(NSString *)course
                           startyear:(double)startyear
                          startmonth:(double)startmonth
                               endyear:(double)endyear
                              endmonth:(double)endmonth
                             description:(NSString *)description
                            delegate:(id <RequestDelegate>)delegate
                             success:(void (^)(NSDictionary * response, id mark))success
                             failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"app":@"wsq",
                          @"key":@"Xba6nyKhE7xeCmMwiEN4OJ6OoYRg8oQRJsbdiIp1gxyUqzwoXf9xPqePmUlGaZ6f",
                          @"uid":RequestStrKey([GlobalData sharedInstance].modelFindJob.uid),
                          @"pid":RequestLongKey(pid),
                          @"id":RequestLongKey(identity),
                          @"agency":RequestStrKey(agency),
                          @"course":RequestStrKey(course),
                          @"startyear":RequestLongKey(startyear),
                          @"startmonth":RequestLongKey(startmonth),
                          @"endyear":RequestLongKey(endyear),
                          @"endmonth":RequestLongKey(endmonth),
                          @"description":RequestStrKey(description)
    };
    NSString * strUrl = @"http://www.wfrcsc.com/index.php?m=api&c=user&a=resumeEditTrain";
    [self postUrl:strUrl delegate:delegate parameters:dic success:success failure:failure];
}
+(void)requestFJResumeCertificatepid:(double)pid
                          identity:(double)identity
                            name:(NSString *)name
                           year:(double)year
                          month:(double)month
                            delegate:(id <RequestDelegate>)delegate
                             success:(void (^)(NSDictionary * response, id mark))success
                             failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"app":@"wsq",
                          @"key":@"Xba6nyKhE7xeCmMwiEN4OJ6OoYRg8oQRJsbdiIp1gxyUqzwoXf9xPqePmUlGaZ6f",
                          @"uid":RequestStrKey([GlobalData sharedInstance].modelFindJob.uid),
                          @"pid":RequestLongKey(pid),
                          @"id":RequestLongKey(identity),
                          @"name":RequestStrKey(name),
                          @"year":RequestLongKey(year),
                          @"month":RequestLongKey(month),
    };
    NSString * strUrl = @"http://www.wfrcsc.com/index.php?m=api&c=user&a=resumeEditCertificate";
    [self postUrl:strUrl delegate:delegate parameters:dic success:success failure:failure];
}
+(void)requestFJResumeLanguagepid:(double)pid
                          identity:(double)identity
                           language:(double)language
                          level:(double)level
                            delegate:(id <RequestDelegate>)delegate
                             success:(void (^)(NSDictionary * response, id mark))success
                             failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"app":@"wsq",
                          @"key":@"Xba6nyKhE7xeCmMwiEN4OJ6OoYRg8oQRJsbdiIp1gxyUqzwoXf9xPqePmUlGaZ6f",
                          @"uid":RequestStrKey([GlobalData sharedInstance].modelFindJob.uid),
                          @"pid":RequestLongKey(pid),
                          @"id":RequestLongKey(identity),
                          @"language":RequestLongKey(language),
                          @"level":RequestLongKey(level),
    };
    NSString * strUrl = @"http://www.wfrcsc.com/index.php?m=api&c=user&a=resumeEditLang";
    [self postUrl:strUrl delegate:delegate parameters:dic success:success failure:failure];
}
+(void)requestFJDeletepid:(double)pid
identity:(double)identity
  type:(NSString *)type
  delegate:(id <RequestDelegate>)delegate
   success:(void (^)(NSDictionary * response, id mark))success
                  failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"app":@"wsq",
                            @"key":@"Xba6nyKhE7xeCmMwiEN4OJ6OoYRg8oQRJsbdiIp1gxyUqzwoXf9xPqePmUlGaZ6f",
                            @"uid":RequestStrKey([GlobalData sharedInstance].modelFindJob.uid),
                            @"pid":RequestLongKey(pid),
                            @"id":RequestLongKey(identity),
                            @"type":RequestStrKey(type),
      };
      NSString * strUrl = @"http://www.wfrcsc.com/index.php?m=api&c=user&a=delData";
      [self postUrl:strUrl delegate:delegate parameters:dic success:success failure:failure];
}

+(void)requestFJResumeIntentionpid:(double)pid
                          current:(double)current
                           nature:(double)nature
                          trade:(double)trade
intention_jobs_id:(NSString *)intention_jobs_id
                          district:(double)district
                         wage:(double)wage
                            delegate:(id <RequestDelegate>)delegate
                             success:(void (^)(NSDictionary * response, id mark))success
                             failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"app":@"wsq",
                          @"key":@"Xba6nyKhE7xeCmMwiEN4OJ6OoYRg8oQRJsbdiIp1gxyUqzwoXf9xPqePmUlGaZ6f",
                          @"uid":RequestStrKey([GlobalData sharedInstance].modelFindJob.uid),
                          @"pid":RequestLongKey(pid),
                          @"current":RequestLongKey(current),
                          @"nature":RequestLongKey(nature),
                          @"trade":RequestLongKey(trade),
                          @"intention_jobs_id":RequestStrKey(intention_jobs_id),
                                                   @"district":RequestLongKey(district),
                                                   @"wage":RequestLongKey(wage),
    };
    NSString * strUrl = @"http://www.wfrcsc.com/index.php?m=api&c=user&a=resumeEditIntent";
    [self postUrl:strUrl delegate:delegate parameters:dic success:success failure:failure];
}
+(void)requestFJResumeIntroducepid:(double)pid
                          specialty:(NSString *)specialty
                            delegate:(id <RequestDelegate>)delegate
                             success:(void (^)(NSDictionary * response, id mark))success
                             failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"app":@"wsq",
                          @"key":@"Xba6nyKhE7xeCmMwiEN4OJ6OoYRg8oQRJsbdiIp1gxyUqzwoXf9xPqePmUlGaZ6f",
                          @"uid":RequestStrKey([GlobalData sharedInstance].modelFindJob.uid),
                          @"pid":RequestLongKey(pid),
                          @"specialty":RequestStrKey(specialty),
    };
    NSString * strUrl = @"http://www.wfrcsc.com/index.php?m=api&c=user&a=resumeEditDescription";
    [self postUrl:strUrl delegate:delegate parameters:dic success:success failure:failure];
}
@end
