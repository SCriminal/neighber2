//
//  RequestApi+EHomePay.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/9/27.
//  Copyright © 2020 ping. All rights reserved.
//

/*
 17685571713
 roomId:945220116612780032  房屋：1单元 1002
 floor_id:945219264628002816 楼栋2号楼
 area_id:945204103984840704 海鹰大厦
 org_id:945189037092765696 新中物业
 */

#import "RequestApi+EHomePay.h"

@implementation RequestApi (EHomePay)
/**
 接口转换[^/resident/ehome/api$]
 */
+(void)requestEHomeSwitchWithDic:(NSDictionary *)paras
                          trxCde:(NSString *)trxCde
                          apiUrl:(NSString *)apiUrl
                        delegate:(id <RequestDelegate>)delegate
                         success:(void (^)(NSDictionary * response, id mark))success
                         failure:(void (^)(NSString * errorStr, id mark))failure{
    NSMutableDictionary * para = [NSMutableDictionary dictionaryWithDictionary:paras];
    [para setObject:RequestStrKey(apiUrl) forKey:@"apiUrl"];
    [para setObject:RequestStrKey(trxCde) forKey:@"trxCde"];
    [para setObject:RequestValidStrKey([GlobalData sharedInstance].modelEHome.token) forKey:@"apiToken"];
    NSString * strUrl = @"/resident/ehome/api";
    [self postUrl:strUrl delegate:delegate parameters:para success:success failure:failure];
}
/**
 获取token[^/resident/ehome/user$]
 */
+(void)requestEHomeLoginWithPhone:(NSString *)phone
                         delegate:(id <RequestDelegate>)delegate
                          success:(void (^)(NSDictionary * response, id mark))success
                          failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"phone":[GlobalData sharedInstance].GB_UserModel.phone};
    [self postUrl:@"/resident/ehome/user" delegate:delegate parameters:dic success:success failure:failure];
}


+(void)requestEHomeNoticeListWithroomId:(NSString *)roomId
                                 areaId:(NSString *)areaId
                                   page:(double)page
                               pageSize:(double)pageSize
                               delegate:(id <RequestDelegate>)delegate
                                success:(void (^)(NSDictionary * response, id mark))success
                                failure:(void (^)(NSString * errorStr, id mark))failure{
    //        NSDictionary *dic = @{
    //                              @"reqSysId":@"WSQ",
    //                              @"reqSysCode":@"802001",
    //                              @"trxDate":@"",
    //                              @"trxTime":@"",
    //                              @"trxNo":@"",
    //                              @"roomId":@""
    //        };
    NSDictionary *dic = @{
        @"roomId":RequestStrKey(roomId),
        @"areaId":RequestStrKey(areaId),
        @"page":RequestLongKey(page),
        @"pageSize":RequestLongKey(pageSize),
    };
    [self requestEHomeSwitchWithDic:dic trxCde:@"EM0016" apiUrl:@"/ehome/mobile/getNotices.do" delegate:delegate success:success failure:failure];
}

+(void)requestEHomeWuyeInfoWithareaId:(NSString *)areaId
                             delegate:(id <RequestDelegate>)delegate
                              success:(void (^)(NSDictionary * response, id mark))success
                              failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{
        @"areaId":RequestStrKey(areaId),
    };
    [self requestEHomeSwitchWithDic:dic trxCde:@"EM0021" apiUrl:@"/ehome/mobile/getOrgInfo.do" delegate:delegate success:success failure:failure];
}

+(void)requestEHomeWaitPayListWithtelephone:(NSString *)telephone
                                     roomId:(NSString *)roomId
                                   delegate:(id <RequestDelegate>)delegate
                                    success:(void (^)(NSDictionary * response, id mark))success
                                    failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{
        @"telephone":RequestStrKey(telephone),
        @"roomId":RequestStrKey(roomId),
    };
    [self requestEHomeSwitchWithDic:dic trxCde:@"EM0009" apiUrl:@"/ehome/mobile/getAllBills.do" delegate:delegate success:success failure:failure];
}

+(void)requestEHomeWaitPayDetailWithtelephone:(NSString *)telephone
                                       roomId:(NSString *)roomId
                                     itemType:(NSString *)itemType
                                     delegate:(id <RequestDelegate>)delegate
                                      success:(void (^)(NSDictionary * response, id mark))success
                                      failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{
        @"telephone":RequestStrKey(telephone),
        @"roomId":RequestStrKey(roomId),
        @"itemType":RequestStrKey(itemType),
    };
    [self requestEHomeSwitchWithDic:dic trxCde:@"EM0010" apiUrl:@"/ehome/mobile/getBillInfo.do" delegate:delegate success:success failure:failure];
}

+(void)requestEHomePayWithtelephone:(NSString *)telephone
                            feesIds:(NSString *)feesIds
                         feeAmounts:(NSString *)feeAmounts
                            payType:(NSString *)payType
                          transType:(NSString *)transType
                           delegate:(id <RequestDelegate>)delegate
                            success:(void (^)(NSDictionary * response, id mark))success
                            failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{
        @"telephone":RequestStrKey(telephone),
        @"feesIds":RequestStrKey(feesIds),
        @"feeAmounts":RequestStrKey(feeAmounts),
        @"payType":RequestStrKey(payType),
        @"transType":RequestStrKey(transType),
    };
    [self requestEHomeSwitchWithDic:dic trxCde:@"EM0011" apiUrl:@"/ehome/mobile/billsToPay.do" delegate:delegate success:success failure:failure];
}

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
                          failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{
        @"telephone":RequestStrKey(telephone),
        @"roomId":RequestStrKey(roomId),
        @"itemType":UnPackStr(itemType),
        @"payType":UnPackStr(payType),
        @"startTime":RequestStrKey(startTime),
        @"endTime":RequestStrKey(endTime),
        @"page":RequestStrKey(page),
        @"pageSize":RequestStrKey(pageSize),
        
    };
    [self requestEHomeSwitchWithDic:dic trxCde:@"EM0013" apiUrl:@"/ehome/mobile/getHistoryBills.do" delegate:delegate success:success failure:failure];
}

+(void)requestEHomePayCert:(NSString *)telephone
                           feesId:(NSString *)feesId
                         delegate:(id <RequestDelegate>)delegate
                          success:(void (^)(NSDictionary * response, id mark))success
                          failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{
        @"telephone":RequestStrKey(telephone),
        @"feesId":RequestStrKey(feesId),
        
    };
    [self requestEHomeSwitchWithDic:dic trxCde:@"EM0014" apiUrl:@"/ehome/mobile/getHistoryBillInfo.do" delegate:delegate success:success failure:failure];
}

+(void)requestEHomeBindHomeList:(NSString *)telephone
 delegate:(id <RequestDelegate>)delegate
  success:(void (^)(NSDictionary * response, id mark))success
                        failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{
          @"telephone":RequestStrKey(telephone),
      };
      [self requestEHomeSwitchWithDic:dic trxCde:@"EM0007" apiUrl:@"/ehome/mobile/getRoomBind.do" delegate:delegate success:success failure:failure];
}
@end
