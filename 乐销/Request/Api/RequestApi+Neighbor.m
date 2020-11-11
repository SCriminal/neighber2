//
//  RequestApi+Neighbor.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/13.
//  Copyright © 2020 ping. All rights reserved.
//

#import "RequestApi+Neighbor.h"
//阿里云推送
#import <CloudPushSDK/CloudPushSDK.h>


@implementation RequestApi (Neighbor)

/**
 获取验证码
 */
+(void)requestSendCodeWithCellPhone:(NSString *)cellPhone
                            smsType:(double)smsType
                           delegate:(id <RequestDelegate>)delegate
                            success:(void (^)(NSDictionary * response, id mark))success
                            failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"app":@"2",
                          @"cellphone":RequestStrKey(cellPhone),
                          @"smsType":NSNumber.dou(smsType),
                          @"scope":@1};
    [self postUrl:@"/resident/smscode/1_0_30/3" delegate:delegate parameters:dic success:success failure:failure];
}

/**
 登录(手机号自动注册)
 */
+(void)requestLoginWithCode:(NSString *)smsCode
                  cellPhone:(NSString *)cellPhone
                   delegate:(id <RequestDelegate>)delegate
                    success:(void (^)(NSDictionary * response, id mark))success
                    failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"app":@"2",
                          @"scene":@"1",
                          @"terminalType":@1,
                          @"terminalNumber":RequestStrKey([CloudPushSDK getDeviceId]),
                          @"cellphone":RequestStrKey(cellPhone),
                          @"smsCode":RequestStrKey(smsCode),
                          @"scope":@1};
    [self postUrl:@"/resident/auth/login/smscode" delegate:delegate parameters:dic success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        [GlobalData sharedInstance].GB_Key = [response stringValueForKey:@"token"];
        [self requestUserInfoWithScope:0 delegate:delegate success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
            ModelUser * model = [ModelUser modelObjectWithDictionary:response];
            [GlobalData sharedInstance].GB_UserModel = model;
            [GlobalMethod requestBindDeviceToken];
            [GlobalMethod requestHaiLuoUserInfo];
            [GlobalMethod requestFindJobUserInfo];
            [GlobalMethod requestEHomeUserInfo];
            if (success) {
                success(response,mark);
            }
        } failure:failure];
    }  failure:failure];
}

/**
 居民登录(手机号，密码)
 */
+(void)requestLoginWithAccount:(NSString *)account
                      password:(NSString *)password
                      delegate:(id <RequestDelegate>)delegate
                       success:(void (^)(NSDictionary * response, id mark))success
                       failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"app":@"2",
                          @"scene":@"1",
                          @"terminalType":@1,
                          @"account":RequestStrKey(account),
                          @"password":RequestStrKey([password base64Encode]),
                          @"terminalNumber":RequestStrKey([CloudPushSDK getDeviceId]),
                          @"scope":@1};
#ifdef DEBUG
    [GlobalMethod copyToPlte:[CloudPushSDK getDeviceId]];
#endif
    [self postUrl:@"/auth/user/login/1" delegate:delegate parameters:dic success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        [GlobalData sharedInstance].GB_Key = [response stringValueForKey:@"token"];
        [self requestUserInfoWithScope:0 delegate:delegate success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
            ModelUser * model = [ModelUser modelObjectWithDictionary:response];
            [GlobalData sharedInstance].GB_UserModel = model;
            [GlobalMethod requestBindDeviceToken];
            [GlobalMethod requestHaiLuoUserInfo];
            [GlobalMethod requestFindJobUserInfo];
            [GlobalMethod requestEHomeUserInfo];

            if (success) {
                success(response,mark);
            }
        } failure:failure];
    }  failure:failure];
}
/**
 获取忘记密码验证码
 */
+(void)requestSendForgetCodeAccount:(NSString *)account
                           delegate:(id <RequestDelegate>)delegate
                            success:(void (^)(NSDictionary * response, id mark))success
                            failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"app":@"2",
                          @"account":RequestStrKey(account),
                          @"scope":@1};
    [self postUrl:@"/auth/smscode" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 忘记密码
 */
+(void)requestResetPwdWithAccount:(NSString *)account
                         password:(NSString *)password
                          smsCode:(NSString *)smsCode
                         delegate:(id <RequestDelegate>)delegate
                          success:(void (^)(NSDictionary * response, id mark))success
                          failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"app":@"2",
                          @"account":RequestStrKey(account),
                          @"password":RequestStrKey([password base64Encode]),
                          @"smsCode":RequestStrKey(smsCode)
    };
    [self patchUrl:@"/auth/password/0" delegate:delegate parameters:dic success:success failure:failure];
}

/**
 每日签到
 */
+(void)requestSignDayWithScore:(double)score
                   description:(NSString *)description
                      delegate:(id <RequestDelegate>)delegate
                       success:(void (^)(NSDictionary * response, id mark))success
                       failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"score":NSNumber.dou(score),
                          @"description":RequestStrKey(description),
                          @"channel":@1,
                          @"scope":@4};
    [self putUrl:@"/resident/score/day" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 积分数
 */
+(void)requestIntegralTotalDelegate:(id <RequestDelegate>)delegate
                            success:(void (^)(NSDictionary * response, id mark))success
                            failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"scope":@4};
    [self getUrl:@"/resident/score" delegate:delegate parameters:dic success:success failure:failure];
}

/**
 操作记录
 */
+(void)requestIntegralRecordDelegate:(id <RequestDelegate>)delegate
                             success:(void (^)(NSDictionary * response, id mark))success
                             failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"scope":@4};
    [self getUrl:@"/resident/score/log/list/total" delegate:delegate parameters:dic success:success failure:failure];
}

/**
 查询所有省
 */
+(void)requestProvinceWithDelegate:(id <RequestDelegate>)delegate
                           success:(void (^)(NSDictionary * response, id mark))success
                           failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"scope":@4};
    [self getUrl:@"/resident/chinaarea/1/list" delegate:delegate parameters:dic success:success failure:failure];
    //    [self getUrl:@"http://112.253.1.72:10201/zhongcheyun/dict/containerarea/1/1/list" delegate:delegate parameters:dic success:success failure:failure];
    
}
/**
 根据区查询所有镇
 */
+(void)requestCityWithId:(double)identity
                delegate:(id <RequestDelegate>)delegate
                 success:(void (^)(NSDictionary * response, id mark))success
                 failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"id":NSNumber.dou(identity),
                          @"scope":@4};
    [self getUrl:@"/resident/chinaarea/2/list/{id}" delegate:delegate parameters:dic success:success failure:failure];
    //    [self getUrl:@"http://112.253.1.72:10201/zhongcheyun/dict/containerarea/1/2/list/{id}" delegate:delegate parameters:dic success:success failure:failure];
    
}
/**
 根据市查询所有区
 */
+(void)requestAreaWithId:(double)identity
                delegate:(id <RequestDelegate>)delegate
                 success:(void (^)(NSDictionary * response, id mark))success
                 failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"id":NSNumber.dou(identity),
                          @"scope":@4};
    [self getUrl:@"/resident/chinaarea/3/list/{id}" delegate:delegate parameters:dic success:success failure:failure];
    //    [self getUrl:@"http://112.253.1.72:10201/zhongcheyun/dict/containerarea/1/3/list/{id}" delegate:delegate parameters:dic success:success failure:failure];
    
}



/**
 提交申请
 */
+(void)requestMerchantSigninWithStorename:(NSString *)storeName
                                bizNumber:(NSString *)bizNumber
                                 idNumber:(NSString *)idNumber
                                 realName:(NSString *)realName
                                   bizUrl:(NSString *)bizUrl
                            idPositiveUrl:(NSString *)idPositiveUrl
                            idNegativeUrl:(NSString *)idNegativeUrl
                             contactPhone:(NSString *)contactPhone
                              regCountyId:(double )regCountyId
                                  regAddr:(NSString *)regAddr
                                bizAreaId:(double)bizAreaId
                                  bizAddr:(NSString *)bizAddr
                                 delegate:(id <RequestDelegate>)delegate
                                  success:(void (^)(NSDictionary * response, id mark))success
                                  failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"storeName":RequestStrKey(storeName),
                          @"bizNumber":RequestStrKey(bizNumber),
                          @"idNumber":RequestStrKey(idNumber),
                          @"realName":RequestStrKey(realName),
                          @"bizUrl":RequestStrKey(bizUrl),
                          @"idPositiveUrl":RequestStrKey(idPositiveUrl),
                          @"idNegativeUrl":RequestStrKey(idNegativeUrl),
                          @"contactPhone":RequestStrKey(contactPhone),
                          @"regCountyId":NSNumber.dou(regCountyId),
                          @"regAddr":RequestStrKey(regAddr),
                          @"bizCountryId":@3,
                          @"bizAreaId":NSNumber.dou(bizAreaId),
                          @"bizAddr":RequestStrKey(bizAddr),
                          @"scope":@4};
    [self postUrl:@"/resident/store/review" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 重新提交申请
 */
+(void)requestMerchantResigninWithStorename:(NSString *)storeName
                                  bizNumber:(NSString *)bizNumber
                                   idNumber:(NSString *)idNumber
                                   realName:(NSString *)realName
                                     bizUrl:(NSString *)bizUrl
                              idPositiveUrl:(NSString *)idPositiveUrl
                              idNegativeUrl:(NSString *)idNegativeUrl
                               contactPhone:(NSString *)contactPhone
                                regCountyId:(double )regCountyId
                                    regAddr:(NSString *)regAddr
                                  bizAreaId:(double)bizAreaId
                                    bizAddr:(NSString *)bizAddr
                                   delegate:(id <RequestDelegate>)delegate
                                    success:(void (^)(NSDictionary * response, id mark))success
                                    failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"storeName":RequestStrKey(storeName),
                          @"bizNumber":RequestStrKey(bizNumber),
                          @"idNumber":RequestStrKey(idNumber),
                          @"realName":RequestStrKey(realName),
                          @"bizUrl":RequestStrKey(bizUrl),
                          @"idPositiveUrl":RequestStrKey(idPositiveUrl),
                          @"idNegativeUrl":RequestStrKey(idNegativeUrl),
                          @"contactPhone":RequestStrKey(contactPhone),
                          @"regCountyId":NSNumber.dou(regCountyId),
                          @"regAddr":RequestStrKey(regAddr),
                          @"bizAreaId":NSNumber.dou(bizAreaId),
                          @"bizAddr":RequestStrKey(bizAddr),
                          @"scope":@4};
    [self patchUrl:@"/resident/store/1_0_6/review" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 提交详情
 */
+(void)requestMerchantSiginDetailWithAreaId:(double)areaId
                                   delegate:(id <RequestDelegate>)delegate
                                    success:(void (^)(NSDictionary * response, id mark))success
                                    failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"scope":NSNumber.dou(4),
                          @"areaId":NSNumber.dou(areaId)};
    [self getUrl:@"/resident/store/review" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 联系咨询
 */
+(void)requestMerchantConnectWithContactphone:(NSString *)contactPhone
                                      contact:(NSString *)contact
                                     delegate:(id <RequestDelegate>)delegate
                                      success:(void (^)(NSDictionary * response, id mark))success
                                      failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"contactPhone":RequestStrKey(contactPhone),
                          @"contact":RequestStrKey(contact),
                          @"scope":@4};
    [self postUrl:@"/resident/store/before" delegate:delegate parameters:dic success:success failure:failure];
}

/**
 我的成员管理
 */
+(void)requestMemeberListWithPage:(double)page
                            count:(double)count
                         delegate:(id <RequestDelegate>)delegate
                          success:(void (^)(NSDictionary * response, id mark))success
                          failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"page":NSNumber.dou(page),
                          @"count":NSNumber.dou(count),
                          @"scope":@4};
    [self getUrl:@"/resident/resident/archive/member/list/total" delegate:delegate parameters:dic success:success failure:failure];
}

/**
 店铺列表
 */
+(void)requestShopListWithScopeid:(double)scopeId
                        storeName:(NSString *)storeName
                     sortDistance:(double)sortDistance
                        sortScore:(double)sortScore
                       sortAmount:(double)sortAmount
                          sortAll:(double)sortAll
                              lng:(double)lng
                              lat:(double)lat
                             page:(double)page
                            count:(double)count
                         delegate:(id <RequestDelegate>)delegate
                          success:(void (^)(NSDictionary * response, id mark))success
                          failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{
        @"areaId":NSNumber.dou(scopeId),
        @"name":RequestStrKey(storeName),
        @"sortDistance":sortDistance?NSNumber.dou(sortDistance):[NSNull null],
        @"sortScore":sortScore?NSNumber.dou(sortScore):[NSNull null],
        @"sortAmount":sortAmount?NSNumber.dou(sortAmount):[NSNull null],
        @"sortAll":sortAll?NSNumber.dou(sortAll):[NSNull null],
        @"lng":NSNumber.dou(lng),
        @"lat":NSNumber.dou(lat),
        @"page":NSNumber.dou(page),
        @"count":NSNumber.dou(count),
        @"scope":@1};
    
    [self getUrl:@"/resident/store/list/total" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 店铺列表
 */
+(void)requestMyShopListDelegate:(id <RequestDelegate>)delegate
                          success:(void (^)(NSDictionary * response, id mark))success
                          failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{
        @"scope":@2};
    [self getUrl:@"/storekeeper/store/user/list" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 店铺详情
 */
+(void)requestShopDetailWithId:(NSString *)identity
                      delegate:(id <RequestDelegate>)delegate
                       success:(void (^)(NSDictionary * response, id mark))success
                       failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"id":RequestStrKey(identity),
                          @"scope":NSNumber.dou(4),
                          @"areaId":NSNumber.dou([GlobalData sharedInstance].community.iDProperty)
    };
    [self getUrl:@"/resident/store/{id}" delegate:delegate parameters:dic success:success failure:failure];
}

/**
 根据经纬度筛选
 */
+(void)requestSelectCommunityWithLng:(double)lng
                                 lat:(double)lat
                                name:(NSString *)name
                               scope:(double)scope
                                page:(double)page
                               count:(double)count
                            delegate:(id <RequestDelegate>)delegate
                             success:(void (^)(NSDictionary * response, id mark))success
                             failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"lng":NSNumber.dou(lng),
                          @"lat":NSNumber.dou(lat),
                          @"name":RequestStrKey(name),
                          @"scope":NSNumber.dou(1),
                          @"page":NSNumber.dou(page),
                          @"count":NSNumber.dou(count)};
    [self getUrl:@"/resident/estate/list" delegate:delegate parameters:dic success:success failure:failure];
}

/**
 城市列表（首字母）[^/resident/initial/list/total$]
 */
+(void)requestCommunityCityListWithName:(NSString *)name
                                 cityId:(double)cityId
                               countyId:(double)countyId
                                   page:(double)page
                                  count:(double)count
                               delegate:(id <RequestDelegate>)delegate
                                success:(void (^)(NSDictionary * response, id mark))success
                                failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"scope":NSNumber.dou(1),
                          @"name":RequestStrKey(name),
                          @"cityId":NSNumber.dou(cityId),
                          @"countyId":NSNumber.dou(countyId),
                          @"page":NSNumber.dou(page),
                          @"count":NSNumber.dou(count)};
    [self getUrl:@"/resident/initial/list/total" delegate:delegate parameters:dic success:success failure:failure];
}

/**
 列表
 */
+(void)requestAddressListWithPage:(double)page
                            count:(double)count
                         delegate:(id <RequestDelegate>)delegate
                          success:(void (^)(NSDictionary * response, id mark))success
                          failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"page":NSNumber.dou(page),
                          @"count":NSNumber.dou(count),
                          @"scope":NSNumber.dou(4)};
    [self getUrl:@"/resident/shippingaddr/list/total" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 删除
 */
+(void)requestDeleteAddressWithId:(double)identity
                         delegate:(id <RequestDelegate>)delegate
                          success:(void (^)(NSDictionary * response, id mark))success
                          failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"id":NSNumber.dou(identity),
                          @"scope":NSNumber.dou(4)};
    [self deleteUrl:@"/resident/shippingaddr/{id}" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 新增
 */
+(void)requestAddAddressWithCountyid:(double)countyId
                              detail:(NSString *)detail
                             contact:(NSString *)contact
                        contactPhone:(NSString *)contactPhone
                                 lng:(NSString *)lng
                                 lat:(NSString *)lat
                            delegate:(id <RequestDelegate>)delegate
                             success:(void (^)(NSDictionary * response, id mark))success
                             failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"countyId":NSNumber.dou(countyId),
                          @"addrDetail":RequestStrKey(detail),
                          @"contact":RequestStrKey(contact),
                          @"contactPhone":RequestStrKey(contactPhone),
                          @"lng":RequestStrKey(lng),
                          @"lat":RequestStrKey(lat),
                          @"scope":NSNumber.dou(4)};
    [self postUrl:@"/resident/shippingaddr" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 编辑
 */
+(void)requestEditAddressWithCountyid:(double)countyId
                               detail:(NSString *)detail
                              contact:(NSString *)contact
                         contactPhone:(NSString *)contactPhone
                                  lng:(NSString *)lng
                                  lat:(NSString *)lat
id:(double)identity
delegate:(id <RequestDelegate>)delegate
success:(void (^)(NSDictionary * response, id mark))success
failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"countyId":NSNumber.dou(countyId),
                          @"addrDetail":RequestStrKey(detail),
                          @"contact":RequestStrKey(contact),
                          @"contactPhone":RequestStrKey(contactPhone),
                          @"lng":RequestStrKey(lng),
                          @"lat":RequestStrKey(lat),
                          @"id":NSNumber.dou(identity),
                          @"scope":NSNumber.dou(4)};
    [self patchUrl:@"/resident/shippingaddr/{id}" delegate:delegate parameters:dic success:success failure:failure];
}

/**
 列表
 */
+(void)requestNewsListWithScopeid:(double)scopeId
                             page:(double)page
                            count:(double)count
                       categoryAlias:(NSString *)categoryAlias
                         delegate:(id <RequestDelegate>)delegate
                          success:(void (^)(NSDictionary * response, id mark))success
                          failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"areaId":NSNumber.dou(scopeId),
                          @"scopeId":NSNumber.dou(scopeId),
                          @"page":NSNumber.dou(page),
                          @"count":NSNumber.dou(count),
                          @"categoryAlias":RequestStrKey(categoryAlias),
                          @"scope":[GlobalMethod isLoginSuccess]?NSNumber.dou(4):NSNumber.dou(1)};
    if ([GlobalMethod isLoginSuccess]) {
        [self getUrl:@"/resident/content/list/1_3_5/area/1/total" delegate:delegate parameters:dic success:success failure:failure];
    }else{
        [self getUrl:@"/resident/content/list/1_3_5/1/total" delegate:delegate parameters:dic success:success failure:failure];

    }
}

/**
 详情
 */
+(void)requestNewsDetailWithId:(double)identity
                       scopeId:(double)scopeId
                         scope:(double)scope
                      delegate:(id <RequestDelegate>)delegate
                       success:(void (^)(NSDictionary * response, id mark))success
                       failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"id":NSNumber.dou(identity),
                          @"areaid":NSNumber.dou(scopeId),
                          @"scopeId":NSNumber.dou(scopeId),
                          @"scope":NSNumber.dou(scope)};
    [self getUrl:@"/resident/content/{id}" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 修改
 */
+(void)requestEditPersonlInfoWithHeadurl:(NSString *)headUrl
                                nickname:(NSString *)nickname
                                   phone:(NSString *)phone
                                    addr:(NSString *)addr
                                  gender:(double)gender
                                   scope:(double)scope
                                delegate:(id <RequestDelegate>)delegate
                                 success:(void (^)(NSDictionary * response, id mark))success
                                 failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"headUrl":RequestStrKey(headUrl),
                          @"nickname":RequestStrKey(nickname),
                          @"phone":RequestStrKey(phone),
                          @"addr":RequestStrKey(addr),
                          @"gender":NSNumber.dou(gender),
                          @"scope":NSNumber.dou(4)};
    [self patchUrl:@"/resident/user" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 获取
 */
+(void)requestUserInfoWithScope:(double)scope
                       delegate:(id <RequestDelegate>)delegate
                        success:(void (^)(NSDictionary * response, id mark))success
                        failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"scope":NSNumber.dou(4)};
    [self getUrl:@"/resident/user" delegate:delegate parameters:dic success:success failure:failure];
}

/**
 列表
 */
+(void)requestArchiveListWithPage:(double)page
                            count:(double)count
                         estateId:(double)estateId
                         delegate:(id <RequestDelegate>)delegate
                          success:(void (^)(NSDictionary * response, id mark))success
                          failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"page":NSNumber.dou(page),
                          @"count":NSNumber.dou(count),
                          @"estateId":RequestLongKey(estateId),
                          @"scope":NSNumber.dou(4)};
    [self getUrl:@"/resident/resident/archive/list/total" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 新增
 */
+(void)requestAddArchiveWithEstateid:(double)estateId
                            areaCode:(NSString *)areaCode
                           cellPhone:(NSString *)cellPhone
                        buildingName:(NSString *)buildingName
                            unitName:(NSString *)unitName
                            roomName:(NSString *)roomName
                                 tag:(double)tag
                                 lng:(NSString *)lng
                                 lat:(NSString *)lat
                                 job:(NSString *)job
                          enterprise:(NSString *)enterprise
                              isPart:(double)isPart
                               scope:(NSString *)scope
                            realName:(NSString *)realName
                            idNumber:(NSString *)idNumber
                         ehomeRoomId:(NSString *)ehomeRoomId
                            delegate:(id <RequestDelegate>)delegate
                             success:(void (^)(NSDictionary * response, id mark))success
                             failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"estateId":RequestDoubleKey(estateId),
                          @"areaCode":RequestStrKey(areaCode),
                          @"cellphone":RequestStrKey(cellPhone),
                          @"buildingName":RequestStrKey(buildingName),
                          @"unitName":RequestStrKey(unitName),
                          @"roomName":RequestStrKey(roomName),
                          @"realName":RequestStrKey(realName),
                          @"idNumber":RequestStrKey(idNumber),
                          @"tag":NSNumber.dou(tag),
                          @"lng":RequestStrKey(lng),
                          @"lat":RequestStrKey(lat),
                          @"job":RequestStrKey(job),
                          @"enterprise":RequestStrKey(enterprise),
                          @"isParty":NSNumber.dou(isPart),
                          @"scope":NSNumber.dou(4),
                          @"ehomeRoomId":RequestStrKey(ehomeRoomId)
                          
    };
    if (isStr(areaCode)) {
        [self postUrl:@"/resident/resident/archive/1_3_0/areacode" delegate:delegate parameters:dic success:success failure:failure];
    }else{
        [self postUrl:@"/resident/resident/archive" delegate:delegate parameters:dic success:success failure:failure];
    }
}

/**
 编辑
 */
+(void)requestEditArchiveWithEstateid:(double)estateId
                            cellPhone:(NSString *)cellPhone
                         buildingName:(NSString *)buildingName
                             unitName:(NSString *)unitName
                             roomName:(NSString *)roomName
                                  tag:(double)tag
                                  lng:(NSString *)lng
                                  lat:(NSString *)lat
                                  job:(NSString *)job
                           enterprise:(NSString *)enterprise
                               isPart:(double)isPart
                             identity:(double)identity
                                scope:(NSString *)scope
realName:(NSString *)realName
idNumber:(NSString *)idNumber
ehomeRoomId:(double)ehomeRoomId
                             delegate:(id <RequestDelegate>)delegate
                              success:(void (^)(NSDictionary * response, id mark))success
                              failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"estateId":NSNumber.dou(estateId),
                          @"cellphone":RequestStrKey(cellPhone),
                          @"buildingName":RequestStrKey(buildingName),
                          @"unitName":RequestStrKey(unitName),
                          @"roomName":RequestStrKey(roomName),
                          @"realName":RequestStrKey(realName),
                          @"idNumber":RequestStrKey(idNumber),
                          @"tag":NSNumber.dou(tag),
                          @"lng":RequestStrKey(lng),
                          @"lat":RequestStrKey(lat),
                          @"job":RequestStrKey(job),
                          @"enterprise":RequestStrKey(enterprise),
                          @"isParty":NSNumber.dou(isPart),
                          @"id":NSNumber.dou(identity),
                          @"scope":NSNumber.dou(4),
                          @"ehomeRoomId":NSNumber.dou(ehomeRoomId)
    };
    [self patchUrl:@"/resident/resident/archive/{id}" delegate:delegate parameters:dic success:success failure:failure];
}

/**
 列表
 */
+(void)requestIntegralStoreProductListWithScope:(NSString *)scope
                                       delegate:(id <RequestDelegate>)delegate
                                        success:(void (^)(NSDictionary * response, id mark))success
                                        failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"scope":@4};
    [self getUrl:@"/resident/score/sku/list/total" delegate:delegate parameters:dic success:success failure:failure];
}

/**
 详情(居民))[^/resident/sku/[a-zA-Z0-9_-]{1,64}$
 */
+(void)requestProductDetailWithCode:(NSString *)code
                           delegate:(id <RequestDelegate>)delegate
                            success:(void (^)(NSDictionary * response, id mark))success
                            failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"code":RequestStrKey(code),
                          @"scope":@1};
    [self getUrl:@"/resident/sku/{code}" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 详情
 */
+(void)requestIntegralProductDetailWithId:(double)identity
                                 delegate:(id <RequestDelegate>)delegate
                                  success:(void (^)(NSDictionary * response, id mark))success
                                  failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"id":NSNumber.dou(identity),
                          @"scope":NSNumber.dou(4)};
    [self getUrl:@"/resident/score/sku/{id}" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 新增(购买)
 */
+(void)requestIntegralProductExchangeWithScoreskuid:(double)scoreSkuId
                                                qty:(double)qty
                                             addrId:(double)addrId
                                           delegate:(id <RequestDelegate>)delegate
                                            success:(void (^)(NSDictionary * response, id mark))success
                                            failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"skuId":NSNumber.dou(scoreSkuId),
                          @"qty":NSNumber.dou(qty),
                          @"addrId":NSNumber.dou(addrId),
                          @"scope":NSNumber.dou(4)};
    [self postUrl:@"/resident/score/order" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 列表
 */
+(void)requestShopProductWithscopeId:(NSString *)scopeId
                             storeId:(double)storeId
                            delegate:(id <RequestDelegate>)delegate
                             success:(void (^)(NSDictionary * response, id mark))success
                             failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"scopeId":RequestStrKey(scopeId),
                          @"storeId":NSNumber.dou(storeId),
                          @"scope":NSNumber.dou(1)};
    [self getUrl:@"/resident/sku/category/list/tree" delegate:delegate parameters:dic success:success failure:failure];
}

/**
 列表(广告位组别名查询)
 community 社区
 live 生活
 procurement 采购
 */
+(void)requestADListWithGroupalias:(NSString *)groupAlias
                           scopeId:(double)scopeId
                          delegate:(id <RequestDelegate> _Nullable)delegate
                           success:(void (^)(NSDictionary * response, id mark))success
                           failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"locationAliases":RequestStrKey(groupAlias),
                          @"areaId":NSNumber.dou(scopeId),
                          @"scopeId":NSNumber.dou(scopeId),
                          @"count":NSNumber.dou(5000),
                          @"scope":NSNumber.dou(1)};
    [self getUrl:@"/resident/ad/list/location" delegate:delegate parameters:dic success:success failure:failure];
}

/**
 列表
 */
+(void)requestWhistleListWithStatus:(NSString *)status
                               page:(double)page
                              count:(double)count
                              scope:(NSString *)scope
                           delegate:(id <RequestDelegate>)delegate
                            success:(void (^)(NSDictionary * response, id mark))success
                            failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"status":RequestStrKey(status),
                          @"page":NSNumber.dou(page),
                          @"count":NSNumber.dou(count),
                          @"scope":@4};
    [self getUrl:@"/resident/whistle/list/total" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 居民发哨
 */
+(void)requestAddWhistleWithArchiveid:(double)archiveId
                          whistleTime:(NSNumber *)whistleTime
                          description:(NSString *)description
                                  url:(NSString *)url
                                scope:(NSString *)scope
                           categoryId:(double)categoryId
                               areaId:(double)areaId
                           detailAddr:(NSString *)detailAddr
                             realName:(NSString *)realName
                            cellPhone:(NSString *)cellPhone
                             delegate:(id <RequestDelegate>)delegate
                              success:(void (^)(NSDictionary * response, id mark))success
                              failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"archiveId":NSNumber.dou(archiveId),
                          @"findTime":whistleTime,
                          @"description":RequestStrKey(description),
                          @"urls":RequestStrKey(url),
                          @"categoryId":NSNumber.dou(categoryId),
                          @"areaId":NSNumber.dou(areaId),
                          @"detailAddr":RequestStrKey(detailAddr),
                          @"realName":RequestStrKey(realName),
                          @"cellPhone":RequestStrKey(cellPhone),
                          @"scope":@4};
    [self postUrl:@"/resident/whistle/1" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 评价
 */
+(void)requestCommentWhistleWithEvaluation:(NSString *)evaluation
                                     score:(double)score
id:(double)identity
scope:(NSString *)scope
delegate:(id <RequestDelegate>)delegate
success:(void (^)(NSDictionary * response, id mark))success
failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"evaluation":RequestStrKey(evaluation),
                          @"score":NSNumber.dou(score),
                          @"id":NSNumber.dou(identity),
                          @"scope":@4};
    [self putUrl:@"/resident/whistle/10/{id}" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 详情
 */
+(void)requestWhistleDetailWithId:(double)identity
                            scope:(NSString *)scope
                         delegate:(id <RequestDelegate>)delegate
                          success:(void (^)(NSDictionary * response, id mark))success
                          failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"id":NSNumber.dou(identity),
                          @"scope":@4};
    [self getUrl:@"/resident/whistle/{id}" delegate:delegate parameters:dic success:success failure:failure];
}


/**
 版本升级
 */
+(void)requestVersionWithDelegate:(_Nullable id<RequestDelegate> )delegate
                          success:(void (^)(NSDictionary * response, id mark))success
                          failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"app":@"7",
                          @"terminalType":@1,
                          @"versionNumber":[GlobalMethod getVersion]};
    [self getUrl:@"/resident/version/new" delegate:delegate parameters:dic success:success failure:failure];
}

/**
 医院列表
 */
+(void)requestHospitalListWithAreaId:(double)areaId
                                name:(NSString *)name
                                page:( double)page
                               count:( double)count
                            delegate:(id <RequestDelegate>)delegate
                             success:(void (^)(NSDictionary * response, id mark))success
                             failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"scope":@1,
                          @"areaId":NSNumber.dou(areaId),
                          @"name":RequestStrKey(name),
                          @"page":NSNumber.dou(page),
                          @"count":NSNumber.dou(count)};
    [self getUrl:@"/resident/hospital/list/total" delegate:delegate parameters:dic success:success failure:failure];
}

/**
 房屋租赁 交易板-上架
 */
+(void)requestRentUploadWithId:(NSString *)identity
                         scope:(double)scope
                      delegate:(id <RequestDelegate>)delegate
                       success:(void (^)(NSDictionary * response, id mark))success
                       failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"id":RequestStrKey(identity),
                          @"scope":NSNumber.dou(4)};
    [self patchUrl:@"/resident/bizboard/9/{id}" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 房屋租赁 交易板-下架
 */
+(void)requestRentOutWithId:(NSString *)identity
                      scope:(double)scope
                   delegate:(id <RequestDelegate>)delegate
                    success:(void (^)(NSDictionary * response, id mark))success
                    failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"id":RequestStrKey(identity),
                          @"scope":NSNumber.dou(4)};
    [self patchUrl:@"/resident/bizboard/21/{id}" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 房屋租赁 交易板-关闭
 */
+(void)requestRentCloseWithId:(NSString *)identity
                        scope:(double)scope
                     delegate:(id <RequestDelegate>)delegate
                      success:(void (^)(NSDictionary * response, id mark))success
                      failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"id":RequestStrKey(identity),
                          @"scope":NSNumber.dou(4)};
    [self patchUrl:@"/resident/bizboard/99/{id}" delegate:delegate parameters:dic success:success failure:failure];
}

/**
 提交
 */
+(void)requestRentSubmitWithId:(double)identity
                         title:(NSString *)title
                      coverUrl:(NSString *)coverUrl
                   description:(NSString *)description
                         price:(double)price
                       contact:(NSString *)contact
                  contactPhone:(NSString *)contactPhone
                         floor:(double)floor
                    totalFloor:(double)totalFloor
                 layoutBedroom:(double)layoutBedroom
                  layoutParlor:(double)layoutParlor
                  layoutToilet:(double)layoutToilet
                     direction:(double)direction
                     houseMode:(double)houseMode
                           lng:(NSString *)lng
                           lat:(NSString *)lat
                      floorage:(NSString *)floorage
                        areaId:(double)areaId
                   displayMode:(double)displayMode
                          urls:(NSString *)urls
                         scope:(double)scope
                      delegate:(id <RequestDelegate>)delegate
                       success:(void (^)(NSDictionary * response, id mark))success
                       failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"id":NSNumber.dou(identity),
                          @"categoryId":NSNumber.dou(1),
                          @"title":RequestStrKey(title),
                          @"coverUrl":RequestStrKey(coverUrl),
                          @"description":RequestStrKey(description),
                          @"price":NSNumber.dou(price),
                          @"contact":RequestStrKey(contact),
                          @"contactPhone":RequestStrKey(contactPhone),
                          @"floor":NSNumber.dou(floor),
                          @"totalFloor":NSNumber.dou(totalFloor),
                          @"layoutBedroom":NSNumber.dou(layoutBedroom),
                          @"layoutParlor":NSNumber.dou(layoutParlor),
                          @"layoutToilet":NSNumber.dou(layoutToilet),
                          @"direction":NSNumber.dou(direction),
                          @"houseMode":NSNumber.dou(houseMode),
                          @"lng":RequestStrKey(lng),
                          @"lat":RequestStrKey(lat),
                          @"floorage":RequestStrKey(floorage),
                          @"areaId":NSNumber.dou(areaId),
                          @"displayMode":NSNumber.dou(displayMode),
                          @"urls":RequestStrKey(urls),
                          @"scope":NSNumber.dou(4)};
    [self patchUrl:@"/resident/bizboard/1/9" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 详情
 */
+(void)requestRentDetailWithId:(double)identity
                         scope:(double)scope
                      delegate:(id <RequestDelegate>)delegate
                       success:(void (^)(NSDictionary * response, id mark))success
                       failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"id":NSNumber.dou(identity),
                          @"scope":NSNumber.dou(4)};
    [self getUrl:@"/resident/bizboard/{id}" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 详情-发布人
 */
+(void)requestRentPersonalDetailWithId:(double)identity
                              delegate:(id <RequestDelegate>)delegate
                               success:(void (^)(NSDictionary * response, id mark))success
                               failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"id":NSNumber.dou(identity)};
    [self getUrl:@"/resident/biz/board/issuer/{id}" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 房屋租赁 交易板列表
 */
+(void)requestRentListWithLayoutbedroom:(double)layoutBedroom
                                 areaId:(double)areaId
                           layoutParlor:(double)layoutParlor
                           layoutToilet:(double)layoutToilet
                              direction:(double)direction
                              houseMode:(double)houseMode
                               minPrice:(double)minPrice
                               maxPrice:(double)maxPrice
                                   page:(double)page
                                  count:(double)count
                                  scope:(double)scope
                               delegate:(id <RequestDelegate>)delegate
                                success:(void (^)(NSDictionary * response, id mark))success
                                failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"areaId":NSNumber.dou(areaId),
                          @"layoutBedroom":NSNumber.dou(layoutBedroom),
                          @"layoutParlor":NSNumber.dou(layoutParlor),
                          @"layoutToilet":NSNumber.dou(layoutToilet),
                          @"direction":NSNumber.dou(direction),
                          @"houseMode":NSNumber.dou(houseMode),
                          @"minPrice":NSNumber.dou(minPrice),
                          @"maxPrice":NSNumber.dou(maxPrice),
                          @"page":NSNumber.dou(page),
                          @"count":NSNumber.dou(count),
                          @"scope":NSNumber.dou(4)};
    NSMutableDictionary * dicFilter = [NSMutableDictionary dictionary];
    for (NSString * key in dic.allKeys) {
        double value = [[dic objectForKey:key] doubleValue];
        if (value) {
            [dicFilter setObject:[dic objectForKey:key] forKey:key];
        }
    }
    [self getUrl:@"/resident/bizboard/list/total" delegate:delegate parameters:dicFilter success:success failure:failure];
}
/**
 房屋租赁 交易板列表(发布人看)
 */
+(void)requestRentPersonalListWithCount:(double)count
                                 areaId:(double)areaId
                                  scope:(double)scope
                                   page:(double)page
                               delegate:(id <RequestDelegate>)delegate
                                success:(void (^)(NSDictionary * response, id mark))success
                                failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"count":NSNumber.dou(count),
                          @"areaId":NSNumber.dou(areaId),
                          @"scope":NSNumber.dou(4),
                          @"page":NSNumber.dou(page)};
    [self getUrl:@"/resident/bizboard/list/publisher/total" delegate:delegate parameters:dic success:success failure:failure];
}

/**
 登出
 */
+(void)requestLogoutWithDelegate:(id <RequestDelegate>)delegate
                         success:(void (^)(NSDictionary * response, id mark))success
                         failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"app":@"2",
                          @"scene":@"1",
                          @"scope":@4};
    [self deleteUrl:@"/auth/user/logout/token" delegate:delegate parameters:dic success:^(NSDictionary * response, id mark){
        [GlobalMethod clearUserInfo];
        [GlobalMethod createRootNav];
        [GB_Nav pushVCName:@"LoginViewController" animated:false];
    } failure: ^(NSString * errorStr, id mark){
        [GlobalMethod clearUserInfo];
        [GlobalMethod createRootNav];
        [GB_Nav pushVCName:@"LoginViewController" animated:false];
    }];
}

/**
 列表
 */
+(void)requestCommunityServiceListWithType:(double)type
                                     count:(double)count
                                      page:(double)page
                                    status:(NSString *)status
                                  delegate:(id <RequestDelegate>)delegate
                                   success:(void (^)(NSDictionary * response, id mark))success
                                   failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"scope":NSNumber.dou(4),
                          @"type":NSNumber.dou(type),
                          @"count":NSNumber.dou(count),
                          @"page":NSNumber.dou(page),
                          @"statuses":RequestStrKey(status)};
    [self getUrl:@"/resident/estateservice/list/total" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 新增
 */
+(void)requestAddCommunityServiceWithArchiveid:(double)archiveId
                                   serviceType:(double)type
                                   description:(NSString *)description
                                      findTime:(double)findTime
                                          urls:(NSString *)urls
                                      delegate:(id <RequestDelegate>)delegate
                                       success:(void (^)(NSDictionary * response, id mark))success
                                       failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"archiveId":NSNumber.dou(archiveId),
                          @"type":NSNumber.lon(type),
                          @"description":RequestStrKey(description),
                          @"findTime":NSNumber.lon(findTime),
                          @"urls":RequestStrKey(urls),
                          @"scope":NSNumber.dou(4)};
    [self postUrl:@"/resident/estateservice/1" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 评价
 */
+(void)requestCommunityServiceCommentWithScore:(double)score
                                    evaluation:(NSString *)evaluation
id:(double)identity
delegate:(id <RequestDelegate>)delegate
success:(void (^)(NSDictionary * response, id mark))success
failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"score":NSNumber.dou(score),
                          @"evaluation":RequestStrKey(evaluation),
                          @"id":NSNumber.dou(identity),
                          @"scope":NSNumber.dou(4)};
    [self patchUrl:@"/resident/estateservice/10/{id}" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 详情
 */
+(void)requestCommunityServiceDetailWithId:(double)identity
                                     scope:(double)scope
                                  delegate:(id <RequestDelegate>)delegate
                                   success:(void (^)(NSDictionary * response, id mark))success
                                   failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"id":NSNumber.dou(identity),
                          @"scope":NSNumber.dou(scope)};
    [self getUrl:@"/resident/estateservice/{id}" delegate:delegate parameters:dic success:success failure:failure];
}

/**
 详情
 */
+(void)requestHelpDetailWithId:(double)identity
                        areaId:(double)areaId
                      delegate:(id <RequestDelegate>)delegate
                       success:(void (^)(NSDictionary * response, id mark))success
                       failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"id":NSNumber.dou(identity),
                          @"areaId":NSNumber.dou(areaId),
                          @"scope":@4};
    [self getUrl:@"/resident/lovehelp/{id}" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 列表
 */
+(void)requestHelpListWithAreaId:(double)areaId
                        delegate:(id <RequestDelegate>)delegate
                         success:(void (^)(NSDictionary * response, id mark))success
                         failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"scope":@4,
                          @"areaId":NSNumber.dou(areaId)};
    [self getUrl:@"/resident/lovehelp/list/total" delegate:delegate parameters:dic success:success failure:failure];
}

/**
 - 绑定设备
 */
+(void)requestBindDeviceIdWithDeviceID:(NSString *)device_id
                              delegate:(_Nullable id <RequestDelegate>)delegate
                               success:(void (^)(NSDictionary * response, id mark))success
                               failure:(void (^)(NSString * errorStr, id mark))failure{
    NSString * deviceID = [CloudPushSDK getDeviceId];
    if (!isStr(deviceID)) {
        return;
    }
    NSDictionary *dic = @{@"app":@"2",
                          @"scene":@"1",
                          @"type":@1,
                          @"scope":@4,
                          @"number":deviceID};
    [self patchUrl:@"/auth/user/terminal/number" delegate:delegate parameters:dic success:success failure:failure];
    
}

/**
 token登录/时效延长
 */
+(void)requestExtendTokenSuccess:(void (^)(NSDictionary * response, id mark))success
                         failure:(void (^)(NSString * errorStr, id mark))failure{
    if (![GlobalMethod isLoginSuccess]) {
        failure(@"",nil);
        return;
    }
    NSDictionary *dic = @{@"app":@"2",
                          @"scope":@1,
                          @"scene":@"1",
                          @"token":[GlobalData sharedInstance].GB_Key
    };
    [self postUrl:@"/auth/user/login/token" delegate:nil parameters:dic success:success failure:failure];
}
/**
 报名
 */
+(void)requestParticipateActivityWithEventid:(double)eventId
                                   archiveId:(double)archiveId
                                    delegate:(id <RequestDelegate>)delegate
                                     success:(void (^)(NSDictionary * response, id mark))success
                                     failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"eventId":NSNumber.dou(eventId),
                          @"archiveId":NSNumber.dou(archiveId),
                          @"scope":@4};
    [self postUrl:@"/resident/event/participant" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 列表
 */
+(void)requestActivityListWithAreaId:(double)areaId
                                page:(double)page
                               count:(double)count
                            delegate:(id <RequestDelegate>)delegate
                             success:(void (^)(NSDictionary * response, id mark))success
                             failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"scope":@4,
                          @"areaId":NSNumber.dou(areaId), @"page":NSNumber.dou(page),
                          @"count":NSNumber.dou(count)};
    [self getUrl:@"/resident/event/list/total" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 详情
 */
+(void)requestActivityDetailWithId:(double)identity
                          delegate:(id <RequestDelegate>)delegate
                           success:(void (^)(NSDictionary * response, id mark))success
                           failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"id":NSNumber.dou(identity),
                          @"scope":@4};
    [self getUrl:@"/resident/event/{id}" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 详情
 */
+(void)requestAssociationDetailWithId:(double)identity
                             delegate:(id <RequestDelegate>)delegate
                              success:(void (^)(NSDictionary * response, id mark))success
                              failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"id":NSNumber.dou(identity),
                          @"scope":@4};
    [self getUrl:@"/resident/team/{id}" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 根据位置获取模块
 */
+(void)requestModuleWithLocationaliases:(NSString *)locationAliases
                                 areaId:(double)areaId
                               delegate:(id <RequestDelegate>) delegate
                                success:(void (^)(NSDictionary * response, id mark))success
                                failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"locationAliases":RequestStrKey(locationAliases),
                          @"areaId":NSNumber.dou(areaId),
                          @"scope":@1,
                          @"isIos":@1
    };
    [self getUrl:@"/resident/module/list/location" delegate:delegate parameters:dic success:success failure:failure];
}

+(void)requestPersonalModuleWithDelegate:(id <RequestDelegate>) delegate
                                success:(void (^)(NSDictionary * response, id mark))success
                                failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"page":@1,
                          @"count":@400,
                          @"scope":@4,
                          @"isIos":@1
    };
    [self getUrl:@"/resident/user/module/list/1_0_40/total" delegate:delegate parameters:dic success:success failure:failure];
}


+(void)requestCustomizePersonalModuleWithModules:(NSString *)json
                                        delegate:(id <RequestDelegate>) delegate
                                         success:(void (^)(NSDictionary * response, id mark))success
                                         failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"modules":RequestStrKey(json),
                             @"scope":@4,
       };
       [self patchUrl:@"/resident/user/module/list/1_0_40" delegate:delegate parameters:dic success:success failure:failure];
    
}
/**
 新增(参与)
 */
+(void)requestParticipateQuestionairWithArchiveid:(double)archiveId
                                          content:(NSString *)content
id:(double)identity
delegate:(id <RequestDelegate>)delegate
success:(void (^)(NSDictionary * response, id mark))success
failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"archiveId":NSNumber.dou(archiveId),
                          @"content":RequestStrKey(content),
                          @"id":NSNumber.dou(identity),
                          @"scope":@4
    };
    [self postUrl:@"/resident/questionnaire/participant/{id}" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 详情
 */
+(void)requestQuestionairDetailWithId:(double)identity
                             delegate:(id <RequestDelegate>)delegate
                              success:(void (^)(NSDictionary * response, id mark))success
                              failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"id":NSNumber.dou(identity),
                          @"scope":@4};
    [self getUrl:@"/resident/questionnaire/{id}" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 列表
 */
+(void)requestQuestionairListWithAreaid:(double)areaId
                                   page:(double)page
                                  count:(double)count
                               delegate:(id <RequestDelegate>)delegate
                                success:(void (^)(NSDictionary * response, id mark))success
                                failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"areaId":NSNumber.dou(areaId),
                          @"page":NSNumber.dou(page),
                          @"count":NSNumber.dou(count),
                          @"scope":@4};
    [self getUrl:@"/resident/questionnaire/list/total" delegate:delegate parameters:dic success:success failure:failure];
}

/**
 清空
 */
+(void)requestClearTrolleyWithDelegate:(id <RequestDelegate>)delegate
                               success:(void (^)(NSDictionary * response, id mark))success
                               failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"scope":@4};
    [self deleteUrl:@"/resident/cart/list" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 修改(数量)
 */
+(void)requestChangeTrolleyNumWithId:(NSString *)identity
                                 qty:(double)qty
                            delegate:(id <RequestDelegate>)delegate
                             success:(void (^)(NSDictionary * response, id mark))success
                             failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"code":RequestStrKey(identity),
                          @"qty":NSNumber.dou(qty),
                          @"scope":@4};
    [self patchUrl:@"/resident/cart/sku/list" delegate:delegate parameters:dic success:^(NSDictionary * response, id mark){
        [[NSNotificationCenter defaultCenter]postNotificationName:NOTICE_TROLLEY_EXCHANGE object:nil];
        if (success) {
            success(response,mark);
        }
    } failure:failure];
}
/**
 新增(加入购物车)
 */
+(void)requestAddTrolleyWithId:(NSString *)identity
                           qty:(double)qty
                         scope:(NSString *)scope
                      delegate:(id <RequestDelegate>)delegate
                       success:(void (^)(NSDictionary * response, id mark))success
                       failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"code":RequestStrKey(identity),
                          @"qty":NSNumber.dou(qty),
                          @"scope":@(4)};
    [self postUrl:@"/resident/cart/sku/list" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 删除商品[^/resident/cart/sku/list$]
 */
+(void)requestDeleteTrolleyWithIds:(NSString *)ids
                             scope:(NSString *)scope
                          delegate:(id <RequestDelegate>)delegate
                           success:(void (^)(NSDictionary * response, id mark))success
                           failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"codes":RequestStrKey(ids),
                          @"scope":@(4)};
    [self deleteUrl:@"/resident/cart/sku/list" delegate:delegate parameters:dic success:^(NSDictionary * response, id mark){
        [[NSNotificationCenter defaultCenter]postNotificationName:NOTICE_TROLLEY_EXCHANGE object:nil];
        if (success) {
            success(response,mark);
        }
    } failure:failure];
}
/**
 详情[^/resident/cart/store/list$]
 */
+(void)requestTrolleyDetailWithDelegate:(id <RequestDelegate>)delegate
                                success:(void (^)(NSDictionary * response, id mark))success
                                failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"scope":@(4)};
    [self getUrl:@"/resident/cart/store/list" delegate:delegate parameters:dic success:success failure:failure];
}

/**
 提交
 */
+(void)requestAddAuthenticationWithIdnumber:(NSString *)idNumber
                                   realName:(NSString *)realName
                                 idPortrait:(NSString *)idPortrait
                                   idEmblem:(NSString *)idEmblem
                                   delegate:(id <RequestDelegate>)delegate
                                    success:(void (^)(NSDictionary * response, id mark))success
                                    failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"idNumber":RequestStrKey(idNumber),
                          @"realName":RequestStrKey(realName),
                          @"idPortrait":RequestStrKey(idPortrait),
                          @"idEmblem":RequestStrKey(idEmblem),
                          @"scope":@4
    };
    [self postUrl:@"/resident/user/review" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 详情
 */
+(void)requestAuthenticationDetailWithDelegate:(id <RequestDelegate>)delegate
                                       success:(void (^)(NSDictionary * response, id mark))success
                                       failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"scope":@4};
    [self getUrl:@"/resident/user/review" delegate:delegate parameters:dic success:success failure:failure];
}

/**
 根据建档信息筛选
 */
+(void)requestCommunityListWithArchiveDelegate:(id <RequestDelegate>)delegate
                                       success:(void (^)(NSDictionary * response, id mark))success
                                       failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"scope":@4};
    [self getUrl:@"/resident/resident/archive/estate/list" delegate:delegate parameters:dic success:success failure:failure];
}

/**
 下单
 */
+(void)requestSubmitOrderWithSkus:(NSString *)skus
                           addrId:(double)addrId
                      description:(NSString *)description
                         delegate:(id <RequestDelegate>)delegate
                          success:(void (^)(NSDictionary * response, id mark))success
                          failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"skus":RequestStrKey(skus),
                          @"addrId":NSNumber.dou(addrId),
                          @"description":RequestStrKey(description),
                          @"scope":@(4)};
    [self postUrl:@"/resident/order/1" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 付款
 */
+(void)requestPayOrderWithNumbers:(NSString *)numbers
                       payChannel:(double)payChannel
                         delegate:(id <RequestDelegate>)delegate
                          success:(void (^)(NSDictionary * response, id mark))success
                          failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"numbers":RequestStrKey(numbers),
                          @"payChannel":NSNumber.dou(payChannel),
                          @"scope":@(4)};
    [self patchUrl:@"/resident/order/5" delegate:delegate parameters:dic success:success failure:failure];
}

/**
 取消
 */
+(void)requestCancelOrderWithNumbers:(NSString *)numbers
                            delegate:(id <RequestDelegate>)delegate
                             success:(void (^)(NSDictionary * response, id mark))success
                             failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"numbers":RequestStrKey(numbers),
                          @"scope":@(4)};
    [self patchUrl:@"/resident/order/99" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 收货
 */
+(void)requestReceiveOrderWithNumbers:(NSString *)numbers
                             delegate:(id <RequestDelegate>)delegate
                              success:(void (^)(NSDictionary * response, id mark))success
                              failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"numbers":RequestStrKey(numbers),
                          @"scope":@4};
    [self patchUrl:@"/resident/order/10" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 列表（买家）
 */
+(void)requestOrderListWithStatuses:(NSString *)statuses
                               page:(double)page
                              count:(double)count
                           delegate:(id <RequestDelegate>)delegate
                            success:(void (^)(NSDictionary * response, id mark))success
                            failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"page":NSNumber.dou(page),
                          @"count":NSNumber.dou(count),
                          @"scope":@4,
                          @"statuses":RequestStrKey(statuses)};
    [self getUrl:@"/resident/order/list/user/total" delegate:delegate parameters:dic success:success failure:failure];
}

/**
 详情（买家）[^/resident/order/user$]
 */
+(void)requestOrderDetailWithNumber:(NSString *)number
                           delegate:(id <RequestDelegate>)delegate
                            success:(void (^)(NSDictionary * response, id mark))success
                            failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"scope":@4,
                          @"number":RequestStrKey(number)};
    [self getUrl:@"/resident/order/user" delegate:delegate parameters:dic success:success failure:failure];
}

/**
 修改地址[^/resident/order/addr$]
 */
+(void)requestRemedyAddressWithAddrid:(double)addrId
                              numbers:(NSString *)numbers
                             delegate:(id <RequestDelegate>)delegate
                              success:(void (^)(NSDictionary * response, id mark))success
                              failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"addrId":NSNumber.dou(addrId),
                          @"numbers":RequestStrKey(numbers),
                          @"scope":@4};
    [self patchUrl:@"/resident/order/addr" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 列表
 */
+(void)requestIntetralOrderListWithId:(double)identity
                                 page:(double)page
                                count:(double)count
                             delegate:(id <RequestDelegate>)delegate
                              success:(void (^)(NSDictionary * response, id mark))success
                              failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"id":NSNumber.dou(identity),
                          @"page":NSNumber.dou(page),
                          @"count":NSNumber.dou(count),
                          @"scope":@4};
    [self getUrl:@"/resident/score/order/list/total" delegate:delegate parameters:dic success:success failure:failure];
}


/**
 支付
 */
+(void)requestAliPayWithNumber:(NSString *)number
                      delegate:(id <RequestDelegate>)delegate
                       success:(void (^)(NSDictionary * response, id mark))success
                       failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"number":RequestStrKey(number),
                          @"scope":NSNumber.dou(4)};
    [self putUrl:@"/resident/order/pay/ali/1_0_6" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 支付完成
 */
+(void)requestAliPaySuccessWithContent:(NSString *)content
                              delegate:(id <RequestDelegate>)delegate
                               success:(void (^)(NSDictionary * response, id mark))success
                               failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"content":RequestStrKey(content),
                          @"scope":NSNumber.dou(4)};
    [self putUrl:@"/resident/order/pay/ali/1_0_6/result" delegate:delegate parameters:dic success:success failure:failure];
}

/**
 支付[^/resident/order/wechat/pay/1_0_6$]
 */
+(void)requestWechatPayWithNumber:(NSString *)number
                         delegate:(id <RequestDelegate>)delegate
                          success:(void (^)(NSDictionary * response, id mark))success
                          failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"number":RequestStrKey(number),
                          @"scope":@(4)};
    [self postUrl:@"/resident/order/pay/wechat/1_0_6" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 支付完成[^/resident/order/wechat/pay/1_0_6/finish$]
 */
+(void)requestWechatPaySuccessWithNumber:(NSString *)number
                                delegate:(id <RequestDelegate>)delegate
                                 success:(void (^)(NSDictionary * response, id mark))success
                                 failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"number":RequestStrKey(number),
                          @"scope":@(4)};
    [self putUrl:@"/resident/order/pay/wechat/1_0_6/result" delegate:delegate parameters:dic success:success failure:failure];
}
/**
列表
*/
+(void)requestMsgListWithCategories:(NSString *)categories
                page:(double)page
                count:(double)count
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                failure:(void (^)(NSString * errorStr, id mark))failure{
        NSDictionary *dic = @{@"categories":RequestStrKey(categories),
                           @"page":NSNumber.dou(page),
                           @"count":NSNumber.dou(count),
                              @"scope":@(4)
        };
        [self getUrl:@"/resident/push/log/1_0_10/list/total" delegate:delegate parameters:dic success:success failure:failure];
}
/**
列表
*/
+(void)requestCertificateDealCategoryListWithCategoryalias:(NSString *)categoryAlias
                areaId:(double)areaId
                page:(double)page
                count:(double)count
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                failure:(void (^)(NSString * errorStr, id mark))failure{
        NSDictionary *dic = @{@"categoryAlias":RequestStrKey(categoryAlias),
                           @"areaId":NSNumber.dou(areaId),
                           @"page":NSNumber.dou(page),
                           @"count":NSNumber.dou(count),
                              @"scope":@4
        };
        [self getUrl:@"/resident/onekey/1_0_10/list/total" delegate:delegate parameters:dic success:success failure:failure];
}

/**
详情
*/
+(void)requestCertificateContentWithId:(double)identity
                areaId:(double)areaId
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                failure:(void (^)(NSString * errorStr, id mark))failure{
        NSDictionary *dic = @{@"id":NSNumber.dou(identity),
                           @"areaId":NSNumber.dou(areaId),
                              @"scope":@4
        };
        [self getUrl:@"/resident/onekey/1_0_10/{id}" delegate:delegate parameters:dic success:success failure:failure];
}

/**
提交
*/
+(void)requestSubmitCertificateWithRealname:(NSString *)realName
                idNumber:(NSString *)idNumber
                content:(NSString *)content
                areaId:(double)areaId
                identity:(double)identity
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                failure:(void (^)(NSString * errorStr, id mark))failure{
        NSDictionary *dic = @{@"realName":RequestStrKey(realName),
                           @"idNumber":RequestStrKey(idNumber),
                           @"content":RequestStrKey(content),
                           @"areaId":NSNumber.dou(areaId),
                           @"id":NSNumber.dou(identity),
                              @"scope":@4
        };
        [self postUrl:@"/resident/onekey/participant/1_0_10/{id}" delegate:delegate parameters:dic success:success failure:failure];
}

/**
重新提交
*/
+(void)requestResubmitCertificateWithNumber:(NSString *)number
                content:(NSString *)content
                realName:(NSString *)realName
                idNumber:(NSString *)idNumber
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                failure:(void (^)(NSString * errorStr, id mark))failure{
        NSDictionary *dic = @{@"number":RequestStrKey(number),
                           @"content":RequestStrKey(content),
                           @"realName":RequestStrKey(realName),
                           @"idNumber":RequestStrKey(idNumber),
                              @"scope":@4
        };
        [self patchUrl:@"/resident/onekey/participant/1_0_10" delegate:delegate parameters:dic success:success failure:failure];
}

/**
列表
*/
+(void)requestCertificateDealResultWithStatuses:(NSString *)statuses
                page:(double)page
                count:(double)count
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                failure:(void (^)(NSString * errorStr, id mark))failure{
        NSDictionary *dic = @{@"statuses":RequestStrKey(statuses),
                           @"page":NSNumber.dou(page),
                           @"count":NSNumber.dou(count),
                              @"scope":@4
        };
        [self getUrl:@"/resident/onekey/participant/1_0_10/list/total" delegate:delegate parameters:dic success:success failure:failure];
}

/**
详情
*/
+(void)requestCertificateDealResultDetailWithNumber:(NSString *)number
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                failure:(void (^)(NSString * errorStr, id mark))failure{
        NSDictionary *dic = @{@"number":RequestStrKey(number),
                              @"scope":@4
        };
        [self getUrl:@"/resident/onekey/participant/1_0_10/{number}" delegate:delegate parameters:dic success:success failure:failure];
}


+(void)requestWhistleTypeDelegate:(id <RequestDelegate>)delegate
                          success:(void (^)(NSDictionary * response, id mark))success
                          failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"count":NSNumber.dou(5000),
                          @"page":NSNumber.dou(1),
                          @"scope":@4};
    [self getUrl:@"/resident/whistle/category/list/1_0_15/total" delegate:delegate parameters:dic success:success failure:failure];
}

/**
用户使用[^/resident/module/1_0_18/user$]
*/
+(void)requestModuleUseWithId:(NSString *)identity
                delegate:(id <RequestDelegate> _Nullable)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                failure:(void (^)(NSString * errorStr, id mark))failure{
        NSDictionary *dic = @{@"id":RequestStrKey(identity),
                           @"scope":@4};
        [self postUrl:@"/resident/module/1_0_18/user/{id}" delegate:delegate parameters:dic success:success failure:failure];
}

/**
列表-用户使用次数[^/resident/module/list/1_0_18/total$]
*/
+(void)requestModuleHotListWithAreaid:(double)areaId
                page:(double)page
                count:(double)count
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"areaId":NSNumber.dou(areaId),
    @"scope":[GlobalMethod isLoginSuccess]?@4:@1,
       @"isIos":@1,
       @"page":RequestLongKey (page),
                          @"count":RequestLongKey(count)};
    [self getUrl:[GlobalMethod isLoginSuccess]?@"/resident/module/list/1_0_18/hot/total":@"/resident/module/list/1_0_18/total" delegate:delegate parameters:dic success:success failure:failure];
}
+(void)requestModuleListWithAreaid:(double)areaId
                                 name:(NSString *)name
                page:(double)page
                count:(double)count
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"areaId":NSNumber.dou(areaId),
    @"scope":@1,
       @"isIos":@1,
       @"page":RequestLongKey (page),
                          @"name":RequestStrKey(name),
                          @"count":RequestLongKey(count)};
    [self getUrl:@"/resident/module/list/1_0_18/total" delegate:delegate parameters:dic success:success failure:failure];
}

/**
列表
*/
+(void)requestPartyListWithLat:(double)lat
                lng:(double)lng
                radius:(double)radius
                name:(NSString *)name
                page:(double)page
                count:(double)count
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                failure:(void (^)(NSString * errorStr, id mark))failure{
        NSDictionary *dic = @{@"lat":NSNumber.dou(lat),
                           @"lng":NSNumber.dou(lng),
//                           @"radius":NSNumber.dou(radius),
                           @"name":RequestStrKey(name),
                           @"page":NSNumber.dou(page),
                           @"count":NSNumber.dou(count)};
        [self getUrl:@"/resident/partyservicecenter/list/1_0_25/total" delegate:delegate parameters:dic success:success failure:failure];
}


/**
详情
*/
+(void)requestPartyEliteDetailWithId:(double)identity
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                failure:(void (^)(NSString * errorStr, id mark))failure{
        NSDictionary *dic = @{
                           @"scope":@(4)};
        [self getUrl:@"/resident/partyent/1_0_35" delegate:delegate parameters:dic success:success failure:failure];
}
/**
重新提交
*/
+(void)requestSubmitPartyEliteWithEntname:(NSString *)entName
                legalPersonName:(NSString *)legalPersonName
                joinDate:(double)joinDate
                contactPhone:(NSString *)contactPhone
                addr:(NSString *)addr
                foundDate:(double)foundDate
                partyBranch:(NSString *)partyBranch
                areaId:(double)areaId
                introduction:(NSString *)introduction
                description:(NSString *)description
                bizUrl:(NSString *)bizUrl
                commitmentUrl:(NSString *)commitmentUrl
                identity:(double)identity
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                failure:(void (^)(NSString * errorStr, id mark))failure{
        NSDictionary *dic = @{@"entName":RequestStrKey(entName),
                           @"legalPersonName":RequestStrKey(legalPersonName),
                           @"joinDate":NSNumber.dou(joinDate),
                           @"contactPhone":RequestStrKey(contactPhone),
                           @"addr":RequestStrKey(addr),
                           @"foundDate":NSNumber.dou(foundDate),
                           @"partyBranch":RequestStrKey(partyBranch),
                           @"areaId":NSNumber.dou(areaId),
                           @"introduction":RequestStrKey(introduction),
                           @"description":RequestStrKey(description),
                           @"bizUrl":RequestStrKey(bizUrl),
                           @"commitmentUrl":RequestStrKey(commitmentUrl),
                           @"id":RequestLongKey(identity),
                           @"scope":@(4)};
                    if(identity){
                        [self patchUrl:@"/resident/partyent/1_0_35/{id}" delegate:delegate parameters:dic success:success failure:failure];
                    }else{
                        [self postUrl:@"/resident/partyent/1_0_35" delegate:delegate parameters:dic success:success failure:failure];
                    }

}

/**
 获取
 */
+(void)requestAreaWithDelegate:(id <RequestDelegate>)delegate
                                    success:(void (^)(NSDictionary * response, id mark))success
                                    failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"scope":NSNumber.dou(4)
    };
    NSString * strUrl = @"/resident/area/4/list/5";
    [self getUrl:strUrl delegate:delegate parameters:dic success:success failure:failure];
}
+(void)requestStreetWithID:(double)identity
                  delegate:(id <RequestDelegate>)delegate
                                    success:(void (^)(NSDictionary * response, id mark))success
                                    failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"scope":NSNumber.dou(4),
                          @"id":NSNumber.dou(identity)
    };
    NSString * strUrl = @"/resident/area/5/list/{id}";
    [self getUrl:strUrl delegate:delegate parameters:dic success:success failure:failure];
}
+(void)requestCommunityWithID:(double)identity
                  delegate:(id <RequestDelegate>)delegate
                                    success:(void (^)(NSDictionary * response, id mark))success
                                    failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"scope":NSNumber.dou(4),
                          @"id":NSNumber.dou(identity)
    };
    NSString * strUrl = @"/resident/area/6/list/{id}";
    [self getUrl:strUrl delegate:delegate parameters:dic success:success failure:failure];
}

/**
山东省统一身份认证(绑定登录)
*/
+(void)requestUnitAuthorBindWithTicket:(NSString *)ticket
                scene:(NSString *)scene
                terminalType:(double)terminalType
                terminalNumber:(NSString *)terminalNumber
                app:(NSString *)app
                cellphone:(NSString *)cellphone
                smsCode:(NSString *)smsCode
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                failure:(void (^)(NSString * errorStr, id mark))failure{
        NSDictionary *dic = @{@"ticket":RequestStrKey(ticket),
                           @"scene":RequestStrKey(scene),
                           @"terminalType":NSNumber.dou(terminalType),
                           @"terminalNumber":RequestStrKey(terminalNumber),
                           @"app":RequestStrKey(app),
                           @"cellphone":RequestStrKey(cellphone),
                           @"smsCode":RequestStrKey(smsCode)};
        [self postUrl:@"/resident/login3/shandong/1_1_5/link" delegate:delegate parameters:dic success:success failure:failure];
}

/**
山东省统一身份认证(认证登录)
*/
+(void)requestUnitAuthorJudgeWithTicket:(NSString *)ticket
                scene:(NSString *)scene
                terminalType:(double)terminalType
                terminalNumber:(NSString *)terminalNumber
                app:(NSString *)app
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                failure:(void (^)(NSString * errorStr, id mark))failure{
        NSDictionary *dic = @{@"ticket":RequestStrKey(ticket),
                           @"scene":RequestStrKey(scene),
                           @"terminalType":NSNumber.dou(terminalType),
                           @"terminalNumber":RequestStrKey(terminalNumber),
                           @"app":RequestStrKey(app)};
        [self postUrl:@"/resident/login3/shandong/1_1_0" delegate:delegate parameters:dic success:success failure:failure];
}

@end
