#import "AppDelegate.h"
//地图api
#import <AMapFoundationKit/AMapFoundationKit.h>
//全局方法
#import "GlobalMethod+Version.h"
//UNUserNotification
#import <UserNotifications/UserNotifications.h>
//微信
#import "WXApi.h"
//微博
#import "WeiboSDK.h"
//阿里云推送
#import <CloudPushSDK/CloudPushSDK.h>
//Wechat
#import "WXApiManager.h"
#import "ModelApns.h"
//top alert view
#import "TopAlertView.h"
//flash login
#import <CL_ShanYanSDK/CL_ShanYanSDK.h>
//bug
#import <Bugly/Bugly.h>
//ali
#import <AlipaySDK/AlipaySDK.h>
//bank
#import <ISSBankSDK/ISSBankSDK.h>
//unit login
#import <WXJSSDK/WXJSSDK.h>
#import <JISSDK/JISSDK.h>
#import "NoticeAlertView.h"

@interface AppDelegate ()<UIAlertViewDelegate,UNUserNotificationCenterDelegate,WXApiDelegate,WeiboSDKDelegate>{

}

@end

@implementation AppDelegate
#define SYSTEM_VERSION_GRATERTHAN_OR_EQUALTO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //create root nav
    [GlobalMethod createRootNav];
    //注册通知
    [self registerForRemoteNotification];
    //配置 app id
    [self configureAPIKey];

    return YES;
}

//注册通知
-(void)registerForRemoteNotification {
    
    if (NSClassFromString(@"UNUserNotificationCenter")) {
        [UNUserNotificationCenter currentNotificationCenter].delegate = self;
    }
    if(SYSTEM_VERSION_GRATERTHAN_OR_EQUALTO(@"10.0")){
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge) completionHandler:^(BOOL granted, NSError * _Nullable error){
            if( !error ){
                [GlobalMethod mainQueueBlock:^{
                    [[UIApplication sharedApplication] registerForRemoteNotifications];
                }];
            }
        }];
    }else{
        if (isIOS8) {
            UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeSound|UIRemoteNotificationTypeAlert) categories:nil];
            [[UIApplication sharedApplication] registerForRemoteNotifications];
            [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        }
       
      }
}

#pragma mark 配置appid
- (void)configureAPIKey
{
    //地图
    [AMapServices sharedServices].apiKey = MAPID;
    //注册微信ID
    [WXApiManager registerApp];
    [self registerMessageReceive];
    //配置阿里推送
    //阿里云推送zaishuo
    [CloudPushSDK autoInit:^(CloudPushCallbackResult *res) {
      
        NSLog(@"sld");
        if (res.success) {
            NSLog(@"Push SDK init success, deviceId: %@", [CloudPushSDK getDeviceId]);
            [GlobalMethod requestBindDeviceToken];
        } else {
            NSLog(@"Push SDK init failed, error: %@", res.error);
        }
    }];
    //bug
    [Bugly startWithAppId:@"76cec8e771"];
    //(SDK内部会根据传入的环境类型选择对应的环境地址) 联调环境说明，其中包含IT开发环境，ST环境，SIT环境（准生产）以及UAT环境和PRD环境（生产环境）
//#if DEBUG
    [ISSPaySDK payBankID:@"802" environmentMode:ISSBankSDKEnvironmentMode_ST scene:ISSBankSDKUseScenePay];
//#else
//    [ISSPaySDK payBankID:@"802" environmentMode:ISSBankSDKEnvironmentMode_ST scene:ISSBankSDKUseScenePay];
//#endif
    [DHJSSDKManager registerApp];
}

#pragma mark 推
// 将得到的deviceToken传给SDK
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSString * strToken =[[[[deviceToken description]stringByReplacingOccurrencesOfString:@"<" withString:@""]stringByReplacingOccurrencesOfString:@">" withString:@""]stringByReplacingOccurrencesOfString:@" "withString:@""];;
    NSLog(@"strToken:%@",strToken);
    [CloudPushSDK registerDevice:deviceToken withCallback:^(CloudPushCallbackResult *res) {
        if (res.success) {
            [GlobalMethod requestBindDeviceToken];
            NSLog(@"Register deviceToken success.");
        } else {
            NSLog(@"Register deviceToken failed, error: %@", res.error);
        }
    }];
   
    
}

#pragma mark 微信
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    if ([url.host isEqualToString:@"weixin"]||[url.host isEqualToString:@"wechat"]) {
        return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
    }
    return [WeiboSDK handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    if ([url.host isEqualToString:@"weixin"]||[url.host isEqualToString:@"wechat"]) {
        return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
    }
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            [[NSNotificationCenter defaultCenter]postNotificationName:NOTICE_ALI_PAY_SUCCESS object:resultDic];
        }];
    }
    return [WeiboSDK handleOpenURL:url delegate:self];
}

//9.0后的方法
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options{
    //这里判断是否发起的请求为微信支付，如果是的话，用WXApi的方法调起微信客户端的支付页面（://pay 之前的那串字符串就是你的APPID，）
    if ([url.host isEqualToString:@"safepay"]) {
           //跳转支付宝钱包进行支付，处理支付结果
           [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
               NSLog(@"result = %@",resultDic);
               [[NSNotificationCenter defaultCenter]postNotificationName:NOTICE_ALI_PAY_SUCCESS object:resultDic];
           }];
    }
    if ([url.host isEqualToString:@"weixin"]||[url.host isEqualToString:@"wechat"]) {
        return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
    }
    return  false;
}


#pragma mark推送
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    NSLog(@"didReceiveRemoteNotification ");

    [self easemobApplication:application didReceiveRemoteNotification:userInfo];
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
    NSLog(@"didReceiveRemoteNotification fetchCompletionHandler");
    [self easemobApplication:application didReceiveRemoteNotification:userInfo];
}

#pragma mark app 状态
- (void)applicationWillResignActive:(UIApplication *)application {
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    //record inter background time
    [GlobalMethod writeStr:[GlobalMethod exchangeDate:[NSDate date] formatter:TIME_MIN_SHOW] forKey:LOCAL_ENTER_BACK_GROUND];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    //请求版本
    [GlobalMethod requestVersion:nil];
    //清空角标
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
}

#pragma mark APNS
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
//    if (_mainController) {
//        [_mainController didReceiveLocalNotification:notification];
//    }
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler
{
    NSDictionary *userInfo = notification.request.content.userInfo;
    [self easemobApplication:[UIApplication sharedApplication] didReceiveRemoteNotification:userInfo];
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler
{
    //消息进入 直接跳转
    ModelApns * model = [ModelApns modelObjectWithDictionary:response.notification.request.content.userInfo];
    TopAlertView * top = [TopAlertView sharedInstance];
    top.model = model;
    [top btnClick];

    completionHandler();
}

- (void)easemobApplication:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    //阿里回执
    [CloudPushSDK sendNotificationAck:userInfo];
    
    //    NSString * strJson = [GlobalMethod exchangeDicToJson:userInfo];
    ModelApns * model = [ModelApns modelObjectWithDictionary:userInfo];
    [[NSNotificationCenter defaultCenter]postNotificationName:NOTICE_MSG_REFERSH object:nil];
    if (model.type == 5||model.type == 6) {
        [[NSNotificationCenter defaultCenter]postNotificationName:NOTICE_ORDER_REFERSH object:nil];
    }
    if (model.type == 11) {
        TopAlertView * top = [TopAlertView sharedInstance];
           top.model = model;
           [top btnClick];
        return;
    }
    [[TopAlertView sharedInstance]showWithModel:model];

}

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler{
    [WXApi handleOpenUniversalLink:userActivity delegate:[WXApiManager sharedManager]];
    return true;
}

- (void) registerMessageReceive {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onMessageReceived:)
                                                 name:@"CCPDidReceiveMessageNotification"
                                               object:nil];
}
- (void)onMessageReceived:(NSNotification *)notification {
    CCPSysMessage *message = [notification object];
    NSString *title = [[NSString alloc] initWithData:message.title encoding:NSUTF8StringEncoding];
    NSString *body = [[NSString alloc] initWithData:message.body encoding:NSUTF8StringEncoding];
    NSLog(@"Receive message title: %@, content: %@.", title, body);
    static NoticeAlertView * alertView = nil;
       if (alertView == nil) {
           alertView = [NoticeAlertView new];
       }
       [alertView resetViewWithModel:body];
       [self.window addSubview:alertView];
}
@end
