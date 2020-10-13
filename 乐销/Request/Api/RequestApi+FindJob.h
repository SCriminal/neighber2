//
//  RequestApi+FindJob.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/9/10.
//  Copyright © 2020 ping. All rights reserved.
//172.16.1.103:8882
//www.wfrcsc.com

#import "RequestApi.h"

NS_ASSUME_NONNULL_BEGIN

@interface RequestApi (FindJob)
+(void)requestFindJobUserDelegate:(id <RequestDelegate>)delegate
                          success:(void (^)(NSDictionary * response, id mark))success
                          failure:(void (^)(NSString * errorStr, id mark))failure;

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
                        failure:(void (^)(NSString * errorStr, id mark))failure;

+(void)requestFJJobDetail:(double)identity
delegate:(id <RequestDelegate>)delegate
                           success:(void (^)(NSDictionary * response, id mark))success
                  failure:(void (^)(NSString * errorStr, id mark))failure;

+(void)requestFJNewJobListDelegate:(id <RequestDelegate>)delegate
   type:(NSString *)type
   page:(double)page
success:(void (^)(NSDictionary * response, id mark))success
failure:(void (^)(NSString * errorStr, id mark))failure;

+(void)requestFJNetJobListDelegate:(id <RequestDelegate>)delegate
                              page:(double)page
                           success:(void (^)(NSDictionary * response, id mark))success
                           failure:(void (^)(NSString * errorStr, id mark))failure;

+(void)requestFJNetJobDetailDelegate:(id <RequestDelegate>)delegate
                            identity:(double)identity
                             success:(void (^)(NSDictionary * response, id mark))success
                             failure:(void (^)(NSString * errorStr, id mark))failure;

+(void)requestFJNewsListDelegate:(id <RequestDelegate>)delegate
                            page:(double)page
                            type:(NSString *)type
                         success:(void (^)(NSDictionary * response, id mark))success
                         failure:(void (^)(NSString * errorStr, id mark))failure;

+(void)requestFJMainNewsListDelegate:(id <RequestDelegate>)delegate
                                page:(double)page
                             success:(void (^)(NSDictionary * response, id mark))success
                             failure:(void (^)(NSString * errorStr, id mark))failure;

+(void)requestFJDistrictDataListDelegate:(id <RequestDelegate>)delegate
                                 success:(void (^)(NSDictionary * response, id mark))success
                                 failure:(void (^)(NSString * errorStr, id mark))failure;
+(void)requestFJWageDataListDelegate:(id <RequestDelegate>)delegate
                             success:(void (^)(NSDictionary * response, id mark))success
                             failure:(void (^)(NSString * errorStr, id mark))failure;
+(void)requestFJExperienceDataListDelegate:(id <RequestDelegate>)delegate
                                   success:(void (^)(NSDictionary * response, id mark))success
                                   failure:(void (^)(NSString * errorStr, id mark))failure;
+(void)requestFJEducationDataListDelegate:(id <RequestDelegate>)delegate
                                  success:(void (^)(NSDictionary * response, id mark))success
                                  failure:(void (^)(NSString * errorStr, id mark))failure;
+(void)requestFJWellfareDataListDelegate:(id <RequestDelegate>)delegate
                                 success:(void (^)(NSDictionary * response, id mark))success
                                 failure:(void (^)(NSString * errorStr, id mark))failure;
+(void)requestFJJobNatureDataListDelegate:(id <RequestDelegate>)delegate
                                     success:(void (^)(NSDictionary * response, id mark))success
                                     failure:(void (^)(NSString * errorStr, id mark))failure;
+(void)requestFJRefreshDataListDelegate:(id <RequestDelegate>)delegate
                                success:(void (^)(NSDictionary * response, id mark))success
                                failure:(void (^)(NSString * errorStr, id mark))failure;
+(void)requestFJProfessionalDataListDelegate:(id <RequestDelegate>)delegate
                                     success:(void (^)(NSDictionary * response, id mark))success
                                     failure:(void (^)(NSString * errorStr, id mark))failure;
+(void)requestFJTradeDataListDelegate:(id <RequestDelegate>)delegate
                               success:(void (^)(NSDictionary * response, id mark))success
                               failure:(void (^)(NSString * errorStr, id mark))failure;
+(void)requestFJIntentionJobDataListDelegate:(id <RequestDelegate>)delegate
success:(void (^)(NSDictionary * response, id mark))success
                                     failure:(void (^)(NSString * errorStr, id mark))failure;
+(void)requestFJCompanyTypeDataListDelegate:(id <RequestDelegate>)delegate
                                    success:(void (^)(NSDictionary * response, id mark))success
                                    failure:(void (^)(NSString * errorStr, id mark))failure;
+(void)requestFJLaguageDataListDelegate:(id <RequestDelegate>)delegate
                                success:(void (^)(NSDictionary * response, id mark))success
                                failure:(void (^)(NSString * errorStr, id mark))failure;
+(void)requestFJLaguageLevelDataListDelegate:(id <RequestDelegate>)delegate
success:(void (^)(NSDictionary * response, id mark))success
                                     failure:(void (^)(NSString * errorStr, id mark))failure;
+(void)requestFJNowStateDataListDelegate:(id <RequestDelegate>)delegate
                                 success:(void (^)(NSDictionary * response, id mark))success
                                 failure:(void (^)(NSString * errorStr, id mark))failure;

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
                             failure:(void (^)(NSString * errorStr, id mark))failure;

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
                    failure:(void (^)(NSString * errorStr, id mark))failure;

+(void)requestFJResumeInfoDelegate:(id <RequestDelegate>)delegate
success:(void (^)(NSDictionary * response, id mark))success
failure:(void (^)(NSString * errorStr, id mark))failure;

+(void)requestFJSubmitResume:(double)jobId
delegate:(id <RequestDelegate>)delegate
success:(void (^)(NSDictionary * response, id mark))success
                     failure:(void (^)(NSString * errorStr, id mark))failure;

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
                           failure:(void (^)(NSString * errorStr, id mark))failure;

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
                      failure:(void (^)(NSString * errorStr, id mark))failure;

+(void)requestFJDeletepid:(double)pid
identity:(double)identity
  type:(NSString *)type
  delegate:(id <RequestDelegate>)delegate
   success:(void (^)(NSDictionary * response, id mark))success
                  failure:(void (^)(NSString * errorStr, id mark))failure;

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
                         failure:(void (^)(NSString * errorStr, id mark))failure;

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
                       failure:(void (^)(NSString * errorStr, id mark))failure;

+(void)requestFJResumeCertificatepid:(double)pid
identity:(double)identity
  name:(NSString *)name
 year:(double)year
month:(double)month
  delegate:(id <RequestDelegate>)delegate
   success:(void (^)(NSDictionary * response, id mark))success
                             failure:(void (^)(NSString * errorStr, id mark))failure;

+(void)requestFJResumeLanguagepid:(double)pid
identity:(double)identity
 language:(double)language
level:(double)level
  delegate:(id <RequestDelegate>)delegate
   success:(void (^)(NSDictionary * response, id mark))success
                          failure:(void (^)(NSString * errorStr, id mark))failure;

+(void)requestFJResumeIntentionpid:(double)pid
                          current:(double)current
                           nature:(double)nature
                          trade:(double)trade
intention_jobs_id:(NSString *)intention_jobs_id
                          district:(double)district
                         wage:(double)wage
                            delegate:(id <RequestDelegate>)delegate
                             success:(void (^)(NSDictionary * response, id mark))success
                           failure:(void (^)(NSString * errorStr, id mark))failure;

+(void)requestFJResumeIntroducepid:(double)pid
specialty:(NSString *)specialty
  delegate:(id <RequestDelegate>)delegate
   success:(void (^)(NSDictionary * response, id mark))success
                           failure:(void (^)(NSString * errorStr, id mark))failure;
@end

NS_ASSUME_NONNULL_END
