//
//  GlobalMethod+Request.m
//中车运
//
//  Created by 隋林栋 on 2017/2/21.
//  Copyright © 2017年 ping. All rights reserved.
//

#import "GlobalMethod+Request.h"
#import "VersionUpView.h"
//阿里云推送
#import <CloudPushSDK/CloudPushSDK.h>
#import "ModelVersionUp.h"
//request
#import "RequestApi+Neighbor.h"
#import "RequestApi+Hailuo.h"
#import "RequestApi+FindJob.h"
#import "RequestApi+EHomePay.h"

@implementation GlobalMethod (Request)
#pragma mark read Local data
+ (NSDictionary *)readLocalRequestData:(NSString *)key
{
    NSString * strPath = [[NSBundle mainBundle]pathForResource:key ofType:@".json"];
    return [NSJSONSerialization JSONObjectWithData:[[NSData alloc]initWithContentsOfFile:strPath] options:NSJSONReadingMutableContainers error:nil];
}
#pragma mark request

//请求bind device token
+ (void)requestBindDeviceToken{
    if ([self isLoginSuccess]) {
        __block BOOL isSuccess = NO;
        if (!isSuccess) {
            [CloudPushSDK bindAccount:UnPackStr([GlobalData sharedInstance].GB_UserModel.phone) withCallback:^(CloudPushCallbackResult *res) {
                if (res.success) {
                    isSuccess = YES;
                }
            }];
        }
        [RequestApi requestBindDeviceIdWithDeviceID:nil delegate:nil success:nil failure:nil];
    }
    
}

//request version
+ (void)requestVersion:(void(^)(void))blockSuccess{
    [RequestApi requestVersionWithDelegate:nil success:^(NSDictionary *response, id mark) {
        ModelVersionUp * modelVersion = [GlobalMethod exchangeDicToModel:response modelName:@"ModelVersionUp"];
        if (modelVersion.versionNumber.doubleValue) {
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            VersionUpView *view = [VersionUpView sharedInstance];
            [view resetViewWithModel:modelVersion];
            view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
            [window addSubview:view];
        }else{
            if (blockSuccess) {
                blockSuccess();
            }
        }
    } failure:^(NSString *errorStr, id mark) {
        
    }];
}


+(void)requestHaiLuoUserInfo{
    [RequestApi requestHouseKeepingDelegate:nil success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
               [GlobalData sharedInstance].modelHaiLuo = [ModelHaiLuo modelObjectWithDictionary:response];
           } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
               
           }];
}

+(void)requestFindJobUserInfo{
    [RequestApi requestFindJobUserDelegate:nil success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        [GlobalData sharedInstance].modelFindJob = [ModelHaiLuo modelObjectWithDictionary:response];

    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}

+(void)requestEHomeUserInfo{
    [RequestApi requestEHomeLoginWithPhone:nil delegate:nil success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        [GlobalData sharedInstance].modelEHome = [ModelHaiLuo modelObjectWithDictionary:response];

    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
   
}

@end
