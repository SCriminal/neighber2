//
//  RequestApi+Neighbor.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/13.
//  Copyright © 2020 ping. All rights reserved.
//

#import "RequestApi.h"

NS_ASSUME_NONNULL_BEGIN

@interface RequestApi (Neighbor)
/**
 获取验证码
 */
+(void)requestSendCodeWithCellPhone:(NSString *)cellPhone
                            smsType:(double)smsType
                           delegate:(id <RequestDelegate>)delegate
                            success:(void (^)(NSDictionary * response, id mark))success
                            failure:(void (^)(NSString * errorStr, id mark))failure;

/**
 登录(手机号自动注册)
 */
+(void)requestLoginWithCode:(NSString *)smsCode
                  cellPhone:(NSString *)cellPhone
                   delegate:(id <RequestDelegate>)delegate
                    success:(void (^)(NSDictionary * response, id mark))success
                    failure:(void (^)(NSString * errorStr, id mark))failure;

/**
 居民登录(手机号，密码)
 */
+(void)requestLoginWithAccount:(NSString *)account
                      password:(NSString *)password
                      delegate:(id <RequestDelegate>)delegate
                       success:(void (^)(NSDictionary * response, id mark))success
                       failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 获取忘记密码验证码
 */
+(void)requestSendForgetCodeAccount:(NSString *)account
                           delegate:(id <RequestDelegate>)delegate
                            success:(void (^)(NSDictionary * response, id mark))success
                            failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 忘记密码
 */
+(void)requestResetPwdWithAccount:(NSString *)account
                         password:(NSString *)password
                          smsCode:(NSString *)smsCode
                         delegate:(id <RequestDelegate>)delegate
                          success:(void (^)(NSDictionary * response, id mark))success
                          failure:(void (^)(NSString * errorStr, id mark))failure;

/**
 每日签到
 */
+(void)requestSignDayWithScore:(double)score
                   description:(NSString *)description
                      delegate:(id <RequestDelegate>)delegate
                       success:(void (^)(NSDictionary * response, id mark))success
                       failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 积分数
 */
+(void)requestIntegralTotalDelegate:(id <RequestDelegate>)delegate
                            success:(void (^)(NSDictionary * response, id mark))success
                            failure:(void (^)(NSString * errorStr, id mark))failure;

/**
 操作记录
 */
+(void)requestIntegralRecordDelegate:(id <RequestDelegate>)delegate
                             success:(void (^)(NSDictionary * response, id mark))success
                             failure:(void (^)(NSString * errorStr, id mark))failure;


/**
 查询所有省
 */
+(void)requestProvinceWithDelegate:(id <RequestDelegate>)delegate
                           success:(void (^)(NSDictionary * response, id mark))success
                           failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 根据区查询所有镇
 */
+(void)requestCityWithId:(double)identity
                delegate:(id <RequestDelegate>)delegate
                 success:(void (^)(NSDictionary * response, id mark))success
                 failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 根据市查询所有区
 */
+(void)requestAreaWithId:(double)identity
                delegate:(id <RequestDelegate>)delegate
                 success:(void (^)(NSDictionary * response, id mark))success
                 failure:(void (^)(NSString * errorStr, id mark))failure;


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
                                  failure:(void (^)(NSString * errorStr, id mark))failure;
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
                                    failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 提交详情
 */
+(void)requestMerchantSiginDetailWithAreaId:(double)areaId
                                   delegate:(id <RequestDelegate>)delegate
                                    success:(void (^)(NSDictionary * response, id mark))success
                                    failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 联系咨询
 */
+(void)requestMerchantConnectWithContactphone:(NSString *)contactPhone
                                      contact:(NSString *)contact
                                     delegate:(id <RequestDelegate>)delegate
                                      success:(void (^)(NSDictionary * response, id mark))success
                                      failure:(void (^)(NSString * errorStr, id mark))failure;

/**
 我的成员管理
 */
+(void)requestMemeberListWithPage:(double)page
                            count:(double)count
                         delegate:(id <RequestDelegate>)delegate
                          success:(void (^)(NSDictionary * response, id mark))success
                          failure:(void (^)(NSString * errorStr, id mark))failure;

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
                          failure:(void (^)(NSString * errorStr, id mark))failure;

/**
 店铺列表
 */
+(void)requestMyShopListDelegate:(id <RequestDelegate>)delegate
                          success:(void (^)(NSDictionary * response, id mark))success
                         failure:(void (^)(NSString * errorStr, id mark))failure;

+(void)requestSelectCommunityWithLng:(double)lng
                                 lat:(double)lat
                                name:(NSString *)name
                               scope:(double)scope
                                page:(double)page
                               count:(double)count
                            delegate:(id <RequestDelegate>)delegate
                             success:(void (^)(NSDictionary * response, id mark))success
                             failure:(void (^)(NSString * errorStr, id mark))failure;
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
                                failure:(void (^)(NSString * errorStr, id mark))failure;

/**
 店铺详情
 */
+(void)requestShopDetailWithId:(NSString *)id
delegate:(id <RequestDelegate>)delegate
success:(void (^)(NSDictionary * response, id mark))success
failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 列表
 */
+(void)requestAddressListWithPage:(double)page
                            count:(double)count
                         delegate:(id <RequestDelegate>)delegate
                          success:(void (^)(NSDictionary * response, id mark))success
                          failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 删除
 */
+(void)requestDeleteAddressWithId:(double)identity
                         delegate:(id <RequestDelegate>)delegate
                          success:(void (^)(NSDictionary * response, id mark))success
                          failure:(void (^)(NSString * errorStr, id mark))failure;
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
                             failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 编辑
 */
+(void)requestEditAddressWithCountyid:(double)countyId
                               detail:(NSString *)detail
                              contact:(NSString *)contact
                         contactPhone:(NSString *)contactPhone
                                  lng:(NSString *)lng
                                  lat:(NSString *)lat
id:(double)id
delegate:(id <RequestDelegate>)delegate
success:(void (^)(NSDictionary * response, id mark))success
failure:(void (^)(NSString * errorStr, id mark))failure;

/**
 列表
 */
+(void)requestNewsListWithScopeid:(double)scopeId
                             page:(double)page
                            count:(double)count
                    categoryAlias:(NSString *)categoryAlias
                         delegate:(id <RequestDelegate>)delegate
                          success:(void (^)(NSDictionary * response, id mark))success
                          failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 详情
 */
+(void)requestNewsDetailWithId:(double)identity
                       scopeId:(double)scopeId
                         scope:(double)scope
                      delegate:(id <RequestDelegate>)delegate
                       success:(void (^)(NSDictionary * response, id mark))success
                       failure:(void (^)(NSString * errorStr, id mark))failure;
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
                                 failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 获取
 */
+(void)requestUserInfoWithScope:(double)scope
                       delegate:(id <RequestDelegate>)delegate
                        success:(void (^)(NSDictionary * response, id mark))success
                        failure:(void (^)(NSString * errorStr, id mark))failure;

/**
 列表
 */
+(void)requestArchiveListWithPage:(double)page
                            count:(double)count
                         estateId:(double)estateId
                         delegate:(id <RequestDelegate>)delegate
                          success:(void (^)(NSDictionary * response, id mark))success
                          failure:(void (^)(NSString * errorStr, id mark))failure;
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
                             failure:(void (^)(NSString * errorStr, id mark))failure;
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
                              failure:(void (^)(NSString * errorStr, id mark))failure;

/**
 列表
 */
+(void)requestIntegralStoreProductListWithScope:(NSString *)scope
                                       delegate:(id <RequestDelegate>)delegate
                                        success:(void (^)(NSDictionary * response, id mark))success
                                        failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 详情(居民))[^/resident/sku/[a-zA-Z0-9_-]{1,64}$
 */
+(void)requestProductDetailWithCode:(NSString *)code
                           delegate:(id <RequestDelegate>)delegate
                            success:(void (^)(NSDictionary * response, id mark))success
                            failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 详情
 */
+(void)requestIntegralProductDetailWithId:(double)identity
                                 delegate:(id <RequestDelegate>)delegate
                                  success:(void (^)(NSDictionary * response, id mark))success
                                  failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 新增(购买)
 */
+(void)requestIntegralProductExchangeWithScoreskuid:(double)scoreSkuId
                                                qty:(double)qty
                                             addrId:(double)addrId
                                           delegate:(id <RequestDelegate>)delegate
                                            success:(void (^)(NSDictionary * response, id mark))success
                                            failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 列表
 */
+(void)requestShopProductWithscopeId:(NSString *)scopeId
                             storeId:(double)storeId
                            delegate:(id <RequestDelegate>)delegate
                             success:(void (^)(NSDictionary * response, id mark))success
                             failure:(void (^)(NSString * errorStr, id mark))failure;

/**
 列表(广告位组别名查询)
 */
+(void)requestADListWithGroupalias:(NSString *)groupAlias
                           scopeId:(double)scopeId
                          delegate:(id <RequestDelegate> _Nullable)delegate
                           success:(void (^)(NSDictionary * response, id mark))success
                           failure:(void (^)(NSString * errorStr, id mark))failure;


/**
 列表
 */
+(void)requestWhistleListWithStatus:(NSString *)status
                               page:(double)page
                              count:(double)count
                              scope:(NSString *)scope
                           delegate:(id <RequestDelegate>)delegate
                            success:(void (^)(NSDictionary * response, id mark))success
                            failure:(void (^)(NSString * errorStr, id mark))failure;
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
                              failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 评价
 */
+(void)requestCommentWhistleWithEvaluation:(NSString *)evaluation
                                     score:(double )score
id:(double)identity
scope:(NSString *)scope
delegate:(id <RequestDelegate>)delegate
success:(void (^)(NSDictionary * response, id mark))success
failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 详情
 */
+(void)requestWhistleDetailWithId:(double)identity
                            scope:(NSString *)scope
                         delegate:(id <RequestDelegate>)delegate
                          success:(void (^)(NSDictionary * response, id mark))success
                          failure:(void (^)(NSString * errorStr, id mark))failure;

/**
 版本升级
 */
+(void)requestVersionWithDelegate:(_Nullable id<RequestDelegate> )delegate
                          success:(void (^)(NSDictionary * response, id mark))success
                          failure:(void (^)(NSString * errorStr, id mark))failure;

/**
 列表
 */
+(void)requestHospitalListWithAreaId:(double)areaId
                                name:(NSString *)name
                                page:( double)page
                               count:( double)count
                            delegate:(id <RequestDelegate>)delegate
                             success:(void (^)(NSDictionary * response, id mark))success
                             failure:(void (^)(NSString * errorStr, id mark))failure;


/**
 房屋租赁 交易板-上架
 */
+(void)requestRentUploadWithId:(NSString *)identity
                         scope:(double)scope
                      delegate:(id <RequestDelegate>)delegate
                       success:(void (^)(NSDictionary * response, id mark))success
                       failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 房屋租赁 交易板-下架
 */
+(void)requestRentOutWithId:(NSString *)identity
                      scope:(double)scope
                   delegate:(id <RequestDelegate>)delegate
                    success:(void (^)(NSDictionary * response, id mark))success
                    failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 房屋租赁 交易板-关闭
 */
+(void)requestRentCloseWithId:(NSString *)identity
                        scope:(double)scope
                     delegate:(id <RequestDelegate>)delegate
                      success:(void (^)(NSDictionary * response, id mark))success
                      failure:(void (^)(NSString * errorStr, id mark))failure;

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
                         floor:(double )floor
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
                       failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 详情
 */
+(void)requestRentDetailWithId:(double)identity
                         scope:(double)scope
                      delegate:(id <RequestDelegate>)delegate
                       success:(void (^)(NSDictionary * response, id mark))success
                       failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 详情-发布人
 */
+(void)requestRentPersonalDetailWithId:(double)identity
                              delegate:(id <RequestDelegate>)delegate
                               success:(void (^)(NSDictionary * response, id mark))success
                               failure:(void (^)(NSString * errorStr, id mark))failure;
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
                                failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 房屋租赁 交易板列表(发布人看)
 */
+(void)requestRentPersonalListWithCount:(double)count
                                 areaId:(double)areaId
                                  scope:(double)scope
                                   page:(double)page
                               delegate:(id <RequestDelegate>)delegate
                                success:(void (^)(NSDictionary * response, id mark))success
                                failure:(void (^)(NSString * errorStr, id mark))failure;

/**
 登出
 */
+(void)requestLogoutWithDelegate:(id <RequestDelegate>)delegate
                         success:(void (^)(NSDictionary * response, id mark))success
                         failure:(void (^)(NSString * errorStr, id mark))failure;

/**
 列表
 */
+(void)requestCommunityServiceListWithType:(double)type
                                     count:(double)count
                                      page:(double)page
                                    status:(NSString *)status
                                  delegate:(id <RequestDelegate>)delegate
                                   success:(void (^)(NSDictionary * response, id mark))success
                                   failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 新增
 */
+(void)requestAddCommunityServiceWithArchiveid:(double)archiveId
                                   serviceType:(double)serviceType
                                   description:(NSString *)description
                                      findTime:(double)findTime
                                          urls:(NSString *)urls
                                      delegate:(id <RequestDelegate>)delegate
                                       success:(void (^)(NSDictionary * response, id mark))success
                                       failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 评价
 */
+(void)requestCommunityServiceCommentWithScore:(double)score
                                    evaluation:(NSString *)evaluation
id:(double)identity
delegate:(id <RequestDelegate>)delegate
success:(void (^)(NSDictionary * response, id mark))success
failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 详情
 */
+(void)requestCommunityServiceDetailWithId:(double)identity
                                     scope:(double)scope
                                  delegate:(id <RequestDelegate>)delegate
                                   success:(void (^)(NSDictionary * response, id mark))success
                                   failure:(void (^)(NSString * errorStr, id mark))failure;

/**
 详情
 */
+(void)requestHelpDetailWithId:(double)identity
                        areaId:(double)areaId
                      delegate:(id <RequestDelegate>)delegate
                       success:(void (^)(NSDictionary * response, id mark))success
                       failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 列表
 */
+(void)requestHelpListWithAreaId:(double)areaId
                        delegate:(id <RequestDelegate>)delegate
                         success:(void (^)(NSDictionary * response, id mark))success
                         failure:(void (^)(NSString * errorStr, id mark))failure;

/**
 - 绑定设备
 */
+(void)requestBindDeviceIdWithDeviceID:(NSString *)device_id
                              delegate:(_Nullable id <RequestDelegate>)delegate
                               success:(void (^)(NSDictionary * response, id mark))success
                               failure:(void (^)(NSString * errorStr, id mark))failure;

/**
 token登录/时效延长
 */
+(void)requestExtendTokenSuccess:(void (^)(NSDictionary * response, id mark))success
                         failure:(void (^)(NSString * errorStr, id mark))failure;

/**
 报名
 */
+(void)requestParticipateActivityWithEventid:(double)eventId
                                   archiveId:(double)archiveId
                                    delegate:(id <RequestDelegate>)delegate
                                     success:(void (^)(NSDictionary * response, id mark))success
                                     failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 列表
 */
+(void)requestActivityListWithAreaId:(double)areaId
                                page:(double)page
                               count:(double)count
                            delegate:(id <RequestDelegate>)delegate
                             success:(void (^)(NSDictionary * response, id mark))success
                             failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 详情
 */
+(void)requestActivityDetailWithId:(double)identity
                          delegate:(id <RequestDelegate>)delegate
                           success:(void (^)(NSDictionary * response, id mark))success
                           failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 详情
 */
+(void)requestAssociationDetailWithId:(double)identity
                             delegate:(id <RequestDelegate>)delegate
                              success:(void (^)(NSDictionary * response, id mark))success
                              failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 根据位置获取模块
 */
+(void)requestModuleWithLocationaliases:(NSString *)locationAliases
                                 areaId:(double)areaId
                               delegate:(id <RequestDelegate>)delegate
                                success:(void (^)(NSDictionary * response, id mark))success
                                failure:(void (^)(NSString * errorStr, id mark))failure;

+(void)requestPersonalModuleWithDelegate:(id <RequestDelegate>) delegate
                                 success:(void (^)(NSDictionary * response, id mark))success
                                 failure:(void (^)(NSString * errorStr, id mark))failure;

+(void)requestCustomizePersonalModuleWithModules:(NSString *)json
                                        delegate:(id <RequestDelegate>) delegate
                                         success:(void (^)(NSDictionary * response, id mark))success
                                         failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 新增(参与)
 */
+(void)requestParticipateQuestionairWithArchiveid:(double)archiveId
                                          content:(NSString *)content
id:(double)id
delegate:(id <RequestDelegate>)delegate
success:(void (^)(NSDictionary * response, id mark))success
failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 详情
 */
+(void)requestQuestionairDetailWithId:(double)identity
                             delegate:(id <RequestDelegate>)delegate
                              success:(void (^)(NSDictionary * response, id mark))success
                              failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 列表
 */
+(void)requestQuestionairListWithAreaid:(double)areaId
                                   page:(double)page
                                  count:(double)count
                               delegate:(id <RequestDelegate>)delegate
                                success:(void (^)(NSDictionary * response, id mark))success
                                failure:(void (^)(NSString * errorStr, id mark))failure;


/**
 清空
 */
+(void)requestClearTrolleyWithDelegate:(id <RequestDelegate>)delegate
                               success:(void (^)(NSDictionary * response, id mark))success
                               failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 修改(数量)
 */
+(void)requestChangeTrolleyNumWithId:(NSString *)identity
                                 qty:(double)qty
                            delegate:(id <RequestDelegate>)delegate
                             success:(void (^)(NSDictionary * response, id mark))success
                             failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 新增(加入购物车)
 */
+(void)requestAddTrolleyWithId:(NSString *)identity
                           qty:(double)qty
                         scope:(NSString *)scope
                      delegate:(id <RequestDelegate>)delegate
                       success:(void (^)(NSDictionary * response, id mark))success
                       failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 删除商品[^/resident/cart/sku/list$]
 */
+(void)requestDeleteTrolleyWithIds:(NSString *)ids
                             scope:(NSString *)scope
                          delegate:(id <RequestDelegate>)delegate
                           success:(void (^)(NSDictionary * response, id mark))success
                           failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 详情[^/resident/cart/store/list$]
 */
+(void)requestTrolleyDetailWithDelegate:(id <RequestDelegate>)delegate
                                success:(void (^)(NSDictionary * response, id mark))success
                                failure:(void (^)(NSString * errorStr, id mark))failure;

/**
 提交
 */
+(void)requestAddAuthenticationWithIdnumber:(NSString *)idNumber
                                   realName:(NSString *)realName
                                 idPortrait:(NSString *)idPortrait
                                   idEmblem:(NSString *)idEmblem
                                   delegate:(id <RequestDelegate>)delegate
                                    success:(void (^)(NSDictionary * response, id mark))success
                                    failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 详情
 */
+(void)requestAuthenticationDetailWithDelegate:(id <RequestDelegate>)delegate
                                       success:(void (^)(NSDictionary * response, id mark))success
                                       failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 根据建档信息筛选[^/resident/resident/archive/estate/list$]
 */
+(void)requestCommunityListWithArchiveDelegate:(id <RequestDelegate>)delegate
                                       success:(void (^)(NSDictionary * response, id mark))success
                                       failure:(void (^)(NSString * errorStr, id mark))failure;


/**
 下单
 */
+(void)requestSubmitOrderWithSkus:(NSString *)skus
                           addrId:(double)addrId
                      description:(NSString *)description
                         delegate:(id <RequestDelegate>)delegate
                          success:(void (^)(NSDictionary * response, id mark))success
                          failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 付款
 */
+(void)requestPayOrderWithNumbers:(NSString *)numbers
                       payChannel:(double)payChannel
                         delegate:(id <RequestDelegate>)delegate
                          success:(void (^)(NSDictionary * response, id mark))success
                          failure:(void (^)(NSString * errorStr, id mark))failure;

/**
 取消
 */
+(void)requestCancelOrderWithNumbers:(NSString *)numbers
                            delegate:(id <RequestDelegate>)delegate
                             success:(void (^)(NSDictionary * response, id mark))success
                             failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 收货
 */
+(void)requestReceiveOrderWithNumbers:(NSString *)numbers
                             delegate:(id <RequestDelegate>)delegate
                              success:(void (^)(NSDictionary * response, id mark))success
                              failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 列表（买家）[^/resident/order/user/list/total$]
 */
+(void)requestOrderListWithStatuses:(NSString *)statuses
                               page:(double)page
                              count:(double)count
                           delegate:(id <RequestDelegate>)delegate
                            success:(void (^)(NSDictionary * response, id mark))success
                            failure:(void (^)(NSString * errorStr, id mark))failure;

/**
 详情（买家）[^/resident/order/user$]
 */
+(void)requestOrderDetailWithNumber:(NSString *)number
                           delegate:(id <RequestDelegate>)delegate
                            success:(void (^)(NSDictionary * response, id mark))success
                            failure:(void (^)(NSString * errorStr, id mark))failure;

/**
 修改地址[^/resident/order/addr$]
 */
+(void)requestRemedyAddressWithAddrid:(double)addrId
                              numbers:(NSString *)numbers
                             delegate:(id <RequestDelegate>)delegate
                              success:(void (^)(NSDictionary * response, id mark))success
                              failure:(void (^)(NSString * errorStr, id mark))failure;

/**
 列表
 */
+(void)requestIntetralOrderListWithId:(double)identity
                                 page:(double)page
                                count:(double)count
                             delegate:(id <RequestDelegate>)delegate
                              success:(void (^)(NSDictionary * response, id mark))success
                              failure:(void (^)(NSString * errorStr, id mark))failure;



/**
 支付
 */
+(void)requestAliPayWithNumber:(NSString *)number
                      delegate:(id <RequestDelegate>)delegate
                       success:(void (^)(NSDictionary * response, id mark))success
                       failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 支付完成
 */
+(void)requestAliPaySuccessWithContent:(NSString *)content
                              delegate:(id <RequestDelegate>)delegate
                               success:(void (^)(NSDictionary * response, id mark))success
                               failure:(void (^)(NSString * errorStr, id mark))failure;


/**
 支付[^/resident/order/wechat/pay/1_0_6$]
 */
+(void)requestWechatPayWithNumber:(NSString *)number
                         delegate:(id <RequestDelegate>)delegate
                          success:(void (^)(NSDictionary * response, id mark))success
                          failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 支付完成[^/resident/order/wechat/pay/1_0_6/finish$]
 */
+(void)requestWechatPaySuccessWithNumber:(NSString *)number
                                delegate:(id <RequestDelegate>)delegate
                                 success:(void (^)(NSDictionary * response, id mark))success
                                 failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 列表
 */
+(void)requestMsgListWithCategories:(NSString *)categories
                               page:(double)page
                              count:(double)count
                           delegate:(id <RequestDelegate>)delegate
                            success:(void (^)(NSDictionary * response, id mark))success
                            failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 列表
 */
+(void)requestCertificateDealCategoryListWithCategoryalias:(NSString *)categoryAlias
                                                    areaId:(double)areaId
                                                      page:(double)page
                                                     count:(double)count
                                                  delegate:(id <RequestDelegate>)delegate
                                                   success:(void (^)(NSDictionary * response, id mark))success
                                                   failure:(void (^)(NSString * errorStr, id mark))failure;

/**
 详情
 */
+(void)requestCertificateContentWithId:(double)identity
                                areaId:(double)areaId
                              delegate:(id <RequestDelegate>)delegate
                               success:(void (^)(NSDictionary * response, id mark))success
                               failure:(void (^)(NSString * errorStr, id mark))failure;

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
                                    failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 重新提交
 */
+(void)requestResubmitCertificateWithNumber:(NSString *)number
                                    content:(NSString *)content
                                   realName:(NSString *)realName
                                   idNumber:(NSString *)idNumber
                                   delegate:(id <RequestDelegate>)delegate
                                    success:(void (^)(NSDictionary * response, id mark))success
                                    failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 列表
 */
+(void)requestCertificateDealResultWithStatuses:(NSString *)statuses
                                           page:(double)page
                                          count:(double)count
                                       delegate:(id <RequestDelegate>)delegate
                                        success:(void (^)(NSDictionary * response, id mark))success
                                        failure:(void (^)(NSString * errorStr, id mark))failure;

/**
 详情
 */
+(void)requestCertificateDealResultDetailWithNumber:(NSString *)number
                                           delegate:(id <RequestDelegate>)delegate
                                            success:(void (^)(NSDictionary * response, id mark))success
                                            failure:(void (^)(NSString * errorStr, id mark))failure;

+(void)requestWhistleTypeDelegate:(id <RequestDelegate>)delegate
                          success:(void (^)(NSDictionary * response, id mark))success
                          failure:(void (^)(NSString * errorStr, id mark))failure;

/**
 用户使用[^/resident/module/1_0_18/user$]
 */
+(void)requestModuleUseWithId:(NSString *)identity
                     delegate:(id <RequestDelegate> _Nullable)delegate
                      success:(void (^)(NSDictionary * response, id mark))success
                      failure:(void (^)(NSString * errorStr, id mark))failure;

/**
 列表-用户使用次数[^/resident/module/list/1_0_18/total$]
 */
+(void)requestModuleHotListWithAreaid:(double)areaId
                                 page:(double)page
                                count:(double)count
                             delegate:(id <RequestDelegate> _Nullable)delegate
                              success:(void (^)(NSDictionary * response, id mark))success
                              failure:(void (^)(NSString * errorStr, id mark))failure;
+(void)requestModuleListWithAreaid:(double)areaId
                 name:(NSString *)name
page:(double)page
count:(double)count
delegate:(id <RequestDelegate>)delegate
success:(void (^)(NSDictionary * response, id mark))success
                           failure:(void (^)(NSString * errorStr, id mark))failure;
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
                       failure:(void (^)(NSString * errorStr, id mark))failure;


/**
 详情
 */
+(void)requestPartyEliteDetailWithId:(double)identity
                            delegate:(id <RequestDelegate>)delegate
                             success:(void (^)(NSDictionary * response, id mark))success
                             failure:(void (^)(NSString * errorStr, id mark))failure;

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
                                  failure:(void (^)(NSString * errorStr, id mark))failure;

/**
 获取
 */
+(void)requestAreaWithDelegate:(id <RequestDelegate>)delegate
                       success:(void (^)(NSDictionary * response, id mark))success
                       failure:(void (^)(NSString * errorStr, id mark))failure;

+(void)requestStreetWithID:(double)identity
                  delegate:(id <RequestDelegate>)delegate
                   success:(void (^)(NSDictionary * response, id mark))success
                   failure:(void (^)(NSString * errorStr, id mark))failure;

+(void)requestCommunityWithID:(double)identity
                     delegate:(id <RequestDelegate>)delegate
                      success:(void (^)(NSDictionary * response, id mark))success
                      failure:(void (^)(NSString * errorStr, id mark))failure;

+(void)requestArchiveCode:(NSString *)iden
delegate:(id <RequestDelegate>)delegate
success:(void (^)(NSDictionary * response, id mark))success
                  failure:(void (^)(NSString * errorStr, id mark))failure;
@end

NS_ASSUME_NONNULL_END
