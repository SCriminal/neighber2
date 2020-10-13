

#import "WXApiManager.h"


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
    if([resp isKindOfClass:[PayResp class]]){
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

@end
