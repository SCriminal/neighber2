//
//  RequestApi+Hailuo.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/8/18.
//  Copyright © 2020 ping. All rights reserved.
//

#import "RequestApi.h"

NS_ASSUME_NONNULL_BEGIN

@interface RequestApi (Hailuo)
+(void)requestHouseKeepingDelegate:(id <RequestDelegate>)delegate
success:(void (^)(NSDictionary * response, id mark))success
                           failure:(void (^)(NSString * errorStr, id mark))failure;

+(void)requestHaiLuoIndexDelegate:(id <RequestDelegate>)delegate
success:(void (^)(NSDictionary * response, id mark))success
                          failure:(void (^)(NSString * errorStr, id mark))failure;
+(void)requestHaiLuoServiceListServiceID:(NSString *)serve_id
                                 max_age:(NSString *)max_age
                                 min_age:(NSString *)min_age
                              serve_time:(NSString *)serve_time
                            order_status:(double)order_status
                              company_id:(double)company_id
                                    page:(double)page
                            son_serve_id:(double)son_serve_id
                                delegate:(id <RequestDelegate>)delegate
                                    success:(void (^)(NSDictionary * response, id mark))success
                                 failure:(void (^)(NSString * errorStr, id mark))failure;

+(void)requestHaiLuoResumeID:(NSString *)aunt_id
delegate:(id <RequestDelegate>)delegate
    success:(void (^)(NSDictionary * response, id mark))success
                     failure:(void (^)(NSString * errorStr, id mark))failure;

+(void)requestHaiLuoCompanyID:(NSString *)company_id
                     delegate:(id <RequestDelegate>)delegate
                      success:(void (^)(NSDictionary * response, id mark))success
                      failure:(void (^)(NSString * errorStr, id mark))failure;

+(void)requestHaiLuoAuntComment:(NSString *)aunt_id
status:(double)status
  page:(double)page
       delegate:(id <RequestDelegate>)delegate
           success:(void (^)(NSDictionary * response, id mark))success
                        failure:(void (^)(NSString * errorStr, id mark))failure;

+(void)requestHaiLuoCompanyComment:(NSString *)company_id
  status:(double)status
    page:(double)page
delegate:(id <RequestDelegate>)delegate
 success:(void (^)(NSDictionary * response, id mark))success
                           failure:(void (^)(NSString * errorStr, id mark))failure;

+(void)requestHaiLuoCompanyListWithAuntID:(NSString *)aunt_id
company_id:(NSString *)company_id
       delegate:(id <RequestDelegate>)delegate
           success:(void (^)(NSDictionary * response, id mark))success
                                  failure:(void (^)(NSString * errorStr, id mark))failure;

+(void)requestHaiLuoAppointmentWithCity_id:(NSString *)city_id
company_id:(NSString *)company_id
address_id:(double)address_id
   aunt_id:(NSString *)aunt_id
begin_time:(NSString *)begin_time
  serve_id:(double)serve_id
need:(NSString *)need
  delegate:(id <RequestDelegate>)delegate
   success:(void (^)(NSDictionary * response, id mark))success
                                   failure:(void (^)(NSString * errorStr, id mark))failure;
+(void)requestHailuoAddressListWithPage:(double)page
   count:(double)count
delegate:(id <RequestDelegate>)delegate
 success:(void (^)(NSDictionary * response, id mark))success
                                failure:(void (^)(NSString * errorStr, id mark))failure;
//order/order_list
+(void)requestHaiLuoOrderListWithStatus:(NSString *)status
                               page:(NSString *)page
                                 delegate:(id <RequestDelegate>)delegate
                                  success:(void (^)(NSDictionary * response, id mark))success
                                failure:(void (^)(NSString * errorStr, id mark))failure;

+(void)requestHaiLuoDismissOrderListWithOrder_id:(NSString *)order_id
cancel_content:(NSString *)cancel_content
  delegate:(id <RequestDelegate>)delegate
   success:(void (^)(NSDictionary * response, id mark))success
                                         failure:(void (^)(NSString * errorStr, id mark))failure;

+(void)requestHaiLuoOrderDetailWithOrder_id:(NSString *)order_id
delegate:(id <RequestDelegate>)delegate
 success:(void (^)(NSDictionary * response, id mark))success
                                    failure:(void (^)(NSString * errorStr, id mark))failure;
@end

NS_ASSUME_NONNULL_END
