//
//  RequestApi+EHomePay.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/9/27.
//  Copyright © 2020 ping. All rights reserved.
//

#import "RequestApi.h"

NS_ASSUME_NONNULL_BEGIN

@interface RequestApi (EHomePay)
/**
 获取token[^/resident/ehome/user$]
 */
+(void)requestEHomeLoginWithPhone:(NSString *)phone
                         delegate:(id <RequestDelegate>)delegate
                          success:(void (^)(NSDictionary * response, id mark))success
                          failure:(void (^)(NSString * errorStr, id mark))failure;

+(void)requestEHomeNoticeListWithroomId:(NSString *)roomId
                                 areaId:(NSString *)areaId
                                   page:(double)page
                               pageSize:(double)pageSize
                               delegate:(id <RequestDelegate>)delegate
                                success:(void (^)(NSDictionary * response, id mark))success
                                failure:(void (^)(NSString * errorStr, id mark))failure;

+(void)requestEHomeWuyeInfoWithareaId:(NSString *)areaId
                             delegate:(id <RequestDelegate>)delegate
                              success:(void (^)(NSDictionary * response, id mark))success
                              failure:(void (^)(NSString * errorStr, id mark))failure;

+(void)requestEHomeWaitPayListWithtelephone:(NSString *)telephone
                                     roomId:(NSString *)roomId
                                   delegate:(id <RequestDelegate>)delegate
                                    success:(void (^)(NSDictionary * response, id mark))success
                                    failure:(void (^)(NSString * errorStr, id mark))failure;

+(void)requestEHomeWaitPayDetailWithtelephone:(NSString *)telephone
                                       roomId:(NSString *)roomId
                                     itemType:(NSString *)itemType
                                     delegate:(id <RequestDelegate>)delegate
                                      success:(void (^)(NSDictionary * response, id mark))success
                                      failure:(void (^)(NSString * errorStr, id mark))failure;

+(void)requestEHomePayWithtelephone:(NSString *)telephone
                            feesIds:(NSString *)feesIds
                         feeAmounts:(NSString *)feeAmounts
                            payType:(NSString *)payType
                          transType:(NSString *)transType
                           delegate:(id <RequestDelegate>)delegate
                            success:(void (^)(NSDictionary * response, id mark))success
                            failure:(void (^)(NSString * errorStr, id mark))failure;

+(void)requestEHomePayHistoryList:(NSString *)telephone
                           roomId:(NSString *)roomId
                         itemType:(NSString *)itemType
                          payType:(NSString *)payType
                        startTime:(NSString *)startTime
                          endTime:(NSString *)endTime
                             page:(NSString *)page
                         pageSize:(NSString *)pageSize
                         delegate:(id <RequestDelegate>)delegate
                          success:(void (^)(NSDictionary * response, id mark))success
                          failure:(void (^)(NSString * errorStr, id mark))failure;

+(void)requestEHomePayCert:(NSString *)telephone
                    feesId:(NSString *)feesId
                  delegate:(id <RequestDelegate>)delegate
                   success:(void (^)(NSDictionary * response, id mark))success
                   failure:(void (^)(NSString * errorStr, id mark))failure;

+(void)requestEHomeBindHomeList:(NSString *)telephone
 delegate:(id <RequestDelegate>)delegate
  success:(void (^)(NSDictionary * response, id mark))success
  failure:(void (^)(NSString * errorStr, id mark))failure;

@end

NS_ASSUME_NONNULL_END
