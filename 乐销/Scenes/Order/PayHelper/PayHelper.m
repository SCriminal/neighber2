//
//  PayHelper.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/5/18.
//Copyright © 2020 ping. All rights reserved.
//

#import "PayHelper.h"
#import <AlipaySDK/AlipaySDK.h>
//request
#import "RequestApi+Neighbor.h"
#import "WXApi.h"

@interface PayHelper ()
@property (nonatomic, strong) NSString *orderNumber;

@end
@implementation PayHelper
SYNTHESIZE_SINGLETONE_FOR_CLASS(PayHelper)
- (instancetype)init{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(aliPayNotice:) name:NOTICE_ALI_PAY_SUCCESS object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(wechatPayNotice:) name:NOTICE_WECHAT_PAY_SUCCESS object:nil];
        
    }
    return self;
}
#pragma mark =======Code Here
- (void)payWithAli:(NSString *)content blockSuccsee:(void (^)(NSString *))blockSuccess{
    self.orderNumber = content;
    self.payType = ENUM_PAY_ALI;
    self.blockSuccess = blockSuccess;
    [[AlipaySDK defaultService] payOrder:content fromScheme:@"hjfNeighbor" callback:^(NSDictionary *resultDic) {
        [self aliPaySuccess:resultDic];
    }];
}
- (void)payWithWeChat:(NSString *)content number:(NSString *)number blockSuccsee:(void (^)(NSString *))blockSuccess{
    self.orderNumber = number;
    self.payType = ENUM_PAY_WECHAT;
    self.blockSuccess = blockSuccess;
    NSDictionary *dict = [GlobalMethod exchangeStringToDic:content];
    PayReq* req             = [[PayReq alloc] init];
    req.partnerId           = [dict stringValueForKey:@"partnerid"];
    req.prepayId            = [dict stringValueForKey:@"prepayid"];
    req.nonceStr            = [dict stringValueForKey:@"noncestr"];
    req.timeStamp           = [dict intValueForKey:@"timestamp"];
    req.package             = [dict stringValueForKey:@"package"];
    req.sign                = [dict stringValueForKey:@"sign"];
    [WXApi sendReq:req completion:^(BOOL success) {
        if (!success) {
            [GlobalMethod showAlert:@"调用微信支付失败"];
        }
    }];
}

- (void)aliPayNotice:(NSNotification *)notice{
    NSDictionary * dicResponse = [notice object];
    if (!isDic(dicResponse)) {
        return;
    }
    [self aliPaySuccess:dicResponse];
}

- (void)aliPaySuccess:(NSDictionary *)response{
    if ([response doubleValueForKey:@"resultStatus"]== 9000) {
        [RequestApi requestAliPaySuccessWithContent:[GlobalMethod exchangeDicToJson:response] delegate:(BaseVC *)[GB_Nav lastVC] success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
            [[NSNotificationCenter defaultCenter]postNotificationName:NOTICE_ORDER_REFERSH object:nil];
            if (self.blockSuccess) {
                self.blockSuccess(@"");
            }
        } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
            [[NSNotificationCenter defaultCenter]postNotificationName:NOTICE_ORDER_REFERSH object:nil];
        }];
    }else{
        [GlobalMethod showAlert:[response stringValueForKey:@"memo"]];
    }
    
}
- (void)wechatPayNotice:(NSNotification *)notice{
      NSDictionary * dicResponse = [notice object];
     if (!isDic(dicResponse)) {
         return;
     }
     [self wechatPaySuccess:dicResponse];
}

- (void)wechatPaySuccess:(NSDictionary *)response{
    if ([response doubleValueForKey:@"resultStatus"]== 0) {
        [RequestApi requestWechatPaySuccessWithNumber:self.orderNumber delegate:(BaseVC *)[GB_Nav lastVC] success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
            [[NSNotificationCenter defaultCenter]postNotificationName:NOTICE_ORDER_REFERSH object:nil];
            if (self.blockSuccess) {
                           self.blockSuccess(@"");
                       }
        } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
            
        }];
       
    }else{
        [GlobalMethod showAlert:[response stringValueForKey:@"memo"]];
        
    }
}
#pragma mark launch mini programm
- (void)launchMiniProKey:(NSString *)key path:(NSString *)path  block:(void (^)(void))blockFailure{
    WXLaunchMiniProgramReq *launchMiniProgramReq = [WXLaunchMiniProgramReq object];
    launchMiniProgramReq.userName = key;  //拉起的小程序的username
    launchMiniProgramReq.path = UnPackStr(path);    ////拉起小程序页面的可带参路径，不填默认拉起小程序首页，对于小游戏，可以只传入 query 部分，来实现传参效果，如：传入 "?foo=bar"。
    launchMiniProgramReq.miniProgramType = WXMiniProgramTypeRelease; //拉起小程序的类型
    [WXApi sendReq:launchMiniProgramReq completion:^(BOOL success) {
        if (!success && blockFailure) {
            blockFailure();
        }
    }];
}
- (void)launchMiniPro:(void (^)(void))blockFailure{
    [self launchMiniProKey:@"gh_c07029bf80ef" path:nil block:blockFailure];
}
#pragma mark 销毁
- (void)dealloc{
    NSLog(@"%s  %@",__func__,self.class);
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end
