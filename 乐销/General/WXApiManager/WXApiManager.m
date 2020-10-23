

#import "WXApiManager.h"
//model
#import "ModelWXApiReq.h"
#import <WXApi.h>

//#import <WXApi.h>
@interface WXApiManager()<WXApiDelegate>

@end

@implementation WXApiManager
+ (void)registerApp{
    //注册微信
#ifdef WECHAT_UPDATE
    [WXApi registerApp:WXAPPID universalLink:WXAPPLINK];
#else
    [WXApi registerApp:WXAPPID];
#endif
}
#pragma mark - LifeCycle
+(instancetype)sharedManager {
    static dispatch_once_t onceToken;
    static WXApiManager *instance;
    dispatch_once(&onceToken, ^{
        instance = [[WXApiManager alloc] init];
    });
    return instance;
}


#pragma mark - WXApiDelegate
- (void)onResp:(BaseResp *)resp {
    if([resp isKindOfClass:[SendAuthResp class]]){
        SendAuthResp *resp2 = (SendAuthResp *)resp;
        NSLog(@"登录成功");
        [[NSNotificationCenter defaultCenter] postNotificationName:@"wxLogin" object:resp2];
    }else if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        NSString *strMsg = [NSString stringWithFormat:@"支付结果"];
        
        switch (resp.errCode) {
            case WXSuccess:
                strMsg = @"支付结果：成功！";
                NSLog(@"支付成功－PaySuccess，retcode = %d", resp.errCode);
                break;
                
            default:
                strMsg = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
                NSLog(@"错误，retcode = %d, retstr = %@", resp.errCode,resp.errStr);
                break;
        }
        [[NSNotificationCenter defaultCenter]postNotificationName:NOTICE_WECHAT_PAY_SUCCESS object:@{@"resultStatus":NSNumber.lon(resp.errCode),@"memo":UnPackStr(resp.errStr)}];
        
    }else {
        NSLog(@"mini program");
    }
}

- (void)loginApp{
    SendAuthReq *req = [[SendAuthReq alloc] init];
    req.scope = @"snsapi_userinfo";
    req.state = @"App";
    [WXApi sendAuthReq:req viewController:GB_Nav.lastVC delegate:self completion:^(BOOL success) {
        NSLog(@"sld %d",success);
    }];
}

//- (void)wxLogin:(NSNotification*)noti{
//    //获取到code
//    SendAuthResp *resp = noti.object;
//    NSString * _code = resp.code;
//
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    NSString *url = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=%@",WXAPPID,@"",_code,@"authorization_code"];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    [manager.requestSerializer setValue:@"text/html; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//
//    NSMutableSet *mgrSet = [NSMutableSet set];
//    mgrSet.set = manager.responseSerializer.acceptableContentTypes;
//    [mgrSet addObject:@"text/html"];
//    //因为微信返回的参数是text/plain 必须加上 会进入fail方法
//    [mgrSet addObject:@"text/plain"];
//    [mgrSet addObject:@"application/json"];
//    manager.responseSerializer.acceptableContentTypes = mgrSet;
//
//    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
//
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"success");
//        NSDictionary *resp = (NSDictionary*)responseObject;
//        NSString *openid = resp[@"openid"];
//        NSString *unionid = resp[@"unionid"];
//        NSString *accessToken = resp[@"access_token"];
//        NSString *refreshToken = resp[@"refresh_token"];
//        if(accessToken && ![accessToken isEqualToString:@""] && openid && ![openid isEqualToString:@""]){
////            [[NSUserDefaults standardUserDefaults] setObject:openid forKey:WX_OPEN_ID];
////            [[NSUserDefaults standardUserDefaults] setObject:accessToken forKey:WX_ACCESS_TOKEN];
////            [[NSUserDefaults standardUserDefaults] setObject:refreshToken forKey:WX_REFRESH_TOKEN];
//            [[NSUserDefaults standardUserDefaults] synchronize];
//        }
////        [self getUserInfo];
//
//
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//    }];
//
//}
@end
