//
//  RequestApi+Hailuo.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/8/18.
//  Copyright © 2020 ping. All rights reserved.
//

#import "RequestApi+Hailuo.h"
#define HAILUO_CITY @"370700"

@implementation RequestApi (Hailuo)
+(void)requestHouseKeepingDelegate:(id <RequestDelegate>)delegate
                           success:(void (^)(NSDictionary * response, id mark))success
                           failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"scope":NSNumber.dou(4),
    };
    NSString * strUrl = @"/resident/hailuoguniang/1_0_36/user";
    [self postUrl:strUrl delegate:delegate parameters:dic success:success failure:failure];
}
+(void)requestHouseKeepingSwitchWithDic:(NSDictionary *)paras
                                 apiUri:(NSString *)apiUri
                               delegate:(id <RequestDelegate>)delegate
                                success:(void (^)(NSDictionary * response, id mark))success
                                failure:(void (^)(NSString * errorStr, id mark))failure{
    NSMutableDictionary * para = [NSMutableDictionary dictionaryWithDictionary:paras];
    [para setObject:[GlobalMethod isLoginSuccess]?NSNumber.dou(4):NSNumber.dou(1) forKey:@"scope"];
    [para setObject:RequestStrKey(apiUri) forKey:@"apiUri"];
    [para setObject:RequestLongKey([GlobalData sharedInstance].modelHaiLuo.userId) forKey:@"user_id"];
    [para setObject:RequestValidStrKey([GlobalData sharedInstance].modelHaiLuo.token) forKey:@"apiToken"];

    NSString * strUrl = @"/resident/hailuoguniang/1_0_36/api";
    [self postUrl:strUrl delegate:delegate parameters:para success:success failure:failure];
}
+(void)requestHaiLuoIndexDelegate:(id <RequestDelegate>)delegate
                          success:(void (^)(NSDictionary * response, id mark))success
                          failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"page":@"1",
                          @"city_id":HAILUO_CITY};
    [self requestHouseKeepingSwitchWithDic:dic apiUri:@"/home_page/index" delegate:delegate success:[self transferHaiLuoResponse:success] failure:failure];
}
+ (void(^)(NSDictionary * _Nonnull , id  _Nonnull ))transferHaiLuoResponse:(void (^)(NSDictionary * _Nonnull , id  _Nonnull ))success{
    return ^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        NSString * strJson = [response stringValueForKey:@"jsonString"];
        if (isStr(strJson)) {
            response = [GlobalMethod exchangeStringToDic:strJson];
        }
        if (success) {
            success(response,mark);
        }
    };
}

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
                                 failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"serve_id":RequestStrKey(serve_id),
                          @"max_age":RequestStrKey(max_age),
                          @"min_age":RequestStrKey(min_age),
                          @"serve_time":RequestStrKey(serve_time),
                          @"order_status":NSNumber.lon(order_status+1),
                          @"company_id":NSNumber.lon(company_id),
                          @"page":RequestLongKey(page),
                          @"user_id":RequestLongKey([GlobalData sharedInstance].modelHaiLuo.userId),
                          @"son_serve_id":NSNumber.lon(son_serve_id),
                          @"area_id":@"370702",
                          
    };
    [self requestHouseKeepingSwitchWithDic:dic apiUri:@"/home_page/serve_info" delegate:delegate success:[self transferHaiLuoResponse:success] failure:failure];
}

+(void)requestHaiLuoResumeID:(NSString *)aunt_id
                    delegate:(id <RequestDelegate>)delegate
                     success:(void (^)(NSDictionary * response, id mark))success
                     failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"aunt_id":RequestStrKey(aunt_id),
                          @"user_id":RequestLongKey([GlobalData sharedInstance].modelHaiLuo.userId),
    };
    [self requestHouseKeepingSwitchWithDic:dic apiUri:@"/aunt/aunt_resume" delegate:delegate success:[self transferHaiLuoResponse:success] failure:failure];
}

+(void)requestHaiLuoCompanyID:(NSString *)company_id
                     delegate:(id <RequestDelegate>)delegate
                      success:(void (^)(NSDictionary * response, id mark))success
                      failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"company_id":RequestStrKey(company_id),
                          @"user_id":RequestLongKey([GlobalData sharedInstance].modelHaiLuo.userId),
    };
    [self requestHouseKeepingSwitchWithDic:dic apiUri:@"/company/company_info" delegate:delegate success:[self transferHaiLuoResponse:success] failure:failure];
}
+(void)requestHaiLuoAuntComment:(NSString *)aunt_id
                         status:(double)status
                           page:(double)page
                       delegate:(id <RequestDelegate>)delegate
                        success:(void (^)(NSDictionary * response, id mark))success
                        failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"aunt_id":RequestStrKey(aunt_id),
                          @"user_id":RequestLongKey([GlobalData sharedInstance].modelHaiLuo.userId),
                          @"status":NSNumber.lon(status),
                          @"page":NSNumber.lon(page),
    };
    [self requestHouseKeepingSwitchWithDic:dic apiUri:@"/aunt/more_comment_by_aunt" delegate:delegate success:[self transferHaiLuoResponse:success] failure:failure];
}
+(void)requestHaiLuoCompanyComment:(NSString *)company_id
                         status:(double)status
                           page:(double)page
                       delegate:(id <RequestDelegate>)delegate
                        success:(void (^)(NSDictionary * response, id mark))success
                        failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"company_id":RequestStrKey(company_id),
                          @"user_id":RequestLongKey([GlobalData sharedInstance].modelHaiLuo.userId),
                          @"status":NSNumber.lon(status),
                          @"page":NSNumber.lon(page),
    };
    [self requestHouseKeepingSwitchWithDic:dic apiUri:@"/company/more_comment" delegate:delegate success:[self transferHaiLuoResponse:success] failure:failure];
}

+(void)requestHaiLuoCompanyListWithAuntID:(NSString *)aunt_id
                               company_id:(NSString *)company_id
                                 delegate:(id <RequestDelegate>)delegate
                                  success:(void (^)(NSDictionary * response, id mark))success
                                  failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"aunt_id":RequestStrKey(aunt_id),
                          @"user_id":RequestLongKey([GlobalData sharedInstance].modelHaiLuo.userId),
                          @"company_id":RequestStrKey(company_id),
    };
    [self requestHouseKeepingSwitchWithDic:dic apiUri:@"/order/return_company" delegate:delegate success:[self transferHaiLuoResponse:success] failure:failure];
}

+(void)requestHaiLuoAppointmentWithCity_id:(NSString *)city_id
                                company_id:(NSString *)company_id
                                address_id:(double)address_id
                                   aunt_id:(NSString *)aunt_id
                                begin_time:(NSString *)begin_time
                                  serve_id:(double)serve_id
                                      need:(NSString *)need
                                  delegate:(id <RequestDelegate>)delegate
                                   success:(void (^)(NSDictionary * response, id mark))success
                                   failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{
        @"need":UnPackStr(need),
        @"city_id":HAILUO_CITY,
        @"address_id":RequestLongKey(address_id),
        @"begin_time":RequestStrKey(begin_time),
        @"aunt_id":RequestStrKey(aunt_id),
        @"serve_id":RequestLongKey(serve_id),
        @"user_id":RequestLongKey([GlobalData sharedInstance].modelHaiLuo.userId),
        @"company_id":RequestStrKey(company_id),
    };
    [self requestHouseKeepingSwitchWithDic:dic apiUri:@"/order/order" delegate:delegate success:[self transferHaiLuoResponse:success] failure:failure];
}

+(void)requestHailuoAddressListWithPage:(double)page
                            count:(double)count
                         delegate:(id <RequestDelegate>)delegate
                          success:(void (^)(NSDictionary * response, id mark))success
                          failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"page":NSNumber.dou(page),
                          @"apiUserId":RequestLongKey([GlobalData sharedInstance].modelHaiLuo.userId),
                          @"apiToken":RequestStrKey([GlobalData sharedInstance].modelHaiLuo.token),
                          @"count":NSNumber.dou(count),
                          @"scope":NSNumber.dou(4)};
    [self getUrl:@"/resident/hailuoguniang/1_0_36/shippingaddr/list/total" delegate:delegate parameters:dic success:success failure:failure];
}

//order/order_list
+(void)requestHaiLuoOrderListWithStatus:(NSString *)status
                               page:(NSString *)page
                                 delegate:(id <RequestDelegate>)delegate
                                  success:(void (^)(NSDictionary * response, id mark))success
                                  failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"status":RequestStrKey(status),
                          @"page":RequestStrKey(page),
    };
    [self requestHouseKeepingSwitchWithDic:dic apiUri:@"/order/order_list" delegate:delegate success:[self transferHaiLuoResponse:success] failure:failure];
}

+(void)requestHaiLuoDismissOrderListWithOrder_id:(NSString *)order_id
                               cancel_content:(NSString *)cancel_content
                                 delegate:(id <RequestDelegate>)delegate
                                  success:(void (^)(NSDictionary * response, id mark))success
                                  failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"order_id":RequestStrKey(order_id),
                          @"cancel_content":RequestStrKey(cancel_content),
    };
    [self requestHouseKeepingSwitchWithDic:dic apiUri:@"/order/cancel_order" delegate:delegate success:[self transferHaiLuoResponse:success] failure:failure];
}

+(void)requestHaiLuoOrderDetailWithOrder_id:(NSString *)order_id
                                 delegate:(id <RequestDelegate>)delegate
                                  success:(void (^)(NSDictionary * response, id mark))success
                                  failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"order_id":RequestStrKey(order_id),
    };
    [self requestHouseKeepingSwitchWithDic:dic apiUri:@"/order/order_info" delegate:delegate success:[self transferHaiLuoResponse:success] failure:failure];
}


@end
