//
//  ModelModule.m
//
//  Created by 林栋 隋 on 2020/4/9
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import "ModelModule.h"
//web vc
#import "WebVC.h"
#import "PayHelper.h"
#import "CertificateDealListVC.h"
//request
#import "RequestApi+Neighbor.h"
#import "RequestApi+FindJob.h"
#import "RequestApi+EHomePay.h"

#import "SubModuleView.h"
#import "CustomTabBarController.h"
#import "JournalismListVC.h"
#import "CommunityVC.h"
#import "HailuoServiceListVC.h"
#import "FindJobListVC.h"
#import "FJResumeDetailVC.h"
//request
NSString *const kModelModuleIconUrl = @"iconUrl";
NSString *const kModelModuleModuleName = @"moduleName";
NSString *const kModelModuleUrl = @"url";
NSString *const kModelModuleGoMode = @"goMode";
NSString *const kModelModuleAndroid = @"android";
NSString *const kModelModuleIos = @"ios";
NSString *const kModelModuleIsLogin = @"isLogin";
NSString *const kModelModuleID= @"id";


@interface ModelModule ()
@end

@implementation ModelModule

@synthesize iconUrl = _iconUrl;
@synthesize moduleName = _moduleName;
@synthesize url = _url;
@synthesize goMode = _goMode;


#pragma mark init
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
        self.iconUrl = [dict stringValueForKey:kModelModuleIconUrl];
        self.moduleName = [dict stringValueForKey:kModelModuleModuleName];
        self.url = [dict stringValueForKey:kModelModuleUrl];
        self.goMode = [dict doubleValueForKey:kModelModuleGoMode];
        self.android = [dict stringValueForKey:kModelModuleAndroid];
        self.ios = [dict stringValueForKey:kModelModuleIos];
        self.isLogin = [dict doubleValueForKey:kModelModuleIsLogin];
        self.iDProperty = [dict doubleValueForKey:kModelModuleID];
        if (!isStr(self.moduleName)) {
            self.moduleName = [dict stringValueForKey:@"name"];
        }
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.iconUrl forKey:kModelModuleIconUrl];
    [mutableDict setValue:self.moduleName forKey:kModelModuleModuleName];
    [mutableDict setValue:self.url forKey:kModelModuleUrl];
    [mutableDict setValue:[NSNumber numberWithDouble:self.goMode] forKey:kModelModuleGoMode];
    [mutableDict setValue:self.android forKey:kModelModuleAndroid];
    [mutableDict setValue:self.ios forKey:kModelModuleIos];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isLogin] forKey:kModelModuleIsLogin];
    [mutableDict setValue:[NSNumber numberWithDouble:self.iDProperty] forKey:kModelModuleID];
    
    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

+ (void)jumpWithModule:(ModelModule *)model{
    if (model.isLogin && ![GlobalMethod isLoginSuccess]) {
        [GB_Nav pushVCName:@"LoginViewController" animated:true];
        return;
    }
    if ([GlobalMethod isLoginSuccess]&&model.iDProperty) {
        [RequestApi requestModuleUseWithId:strDotF(model.iDProperty) delegate:nil success:nil failure:nil];
    }
    if (model.goMode == 3) {//tag
        if ([model.ios hasPrefix:@"TabVC"]) {
            int suffixNum = [[model.ios substringFromIndex:5] doubleValue];
            if (suffixNum>=0 && suffixNum<=4) {
                UITabBarController * tab =  GB_Nav.viewControllers.firstObject;
                tab.selectedIndex = suffixNum;
            }
            return;
        }
        if ([model.ios hasPrefix:@"CertificateDealListVC"]) {
            CertificateDealListVC * vc = [CertificateDealListVC new];
            vc.navTitle = model.moduleName;
            vc.requestAlias = [model.ios substringFromIndex:@"CertificateDealListVC".length];
            [GB_Nav pushViewController:vc animated:true];
            return;
        }
        if ([model.ios hasPrefix:@"SubCommunity"]) {
            SubModuleView * v = [[SubModuleView alloc]initWithType:(int)[model.ios substringFromIndex:@"SubCommunity".length].intValue];
            CustomTabBarController * tabBar = GB_Nav.viewControllers.firstObject;
            
            [tabBar.viewControllers.firstObject.view addSubview:v];
            return;
        }
        if ([model.ios hasPrefix:@"EHomeMainVC"]) {
            [RequestApi requestEHomeLoginWithPhone:@"" delegate:(BaseVC *)GB_Nav.lastRequestDelegateVC success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
                [GlobalData sharedInstance].modelEHome = [ModelHaiLuo modelObjectWithDictionary:response];
                [GB_Nav pushVCName:@"EHomeMainVC" animated:true];
            } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
                
            }];
            return;
        }
        if ([model.ios hasPrefix:@"HouseKeepingVC"]) {
#ifdef SLD_TEST
            [GB_Nav pushVCName:@"TestVC" animated:false];
            return;
#endif
            CustomTabBarController * tabBar = GB_Nav.viewControllers.firstObject;
            CommunityVC * communityVC = tabBar.viewControllers.firstObject;
            if ([communityVC isKindOfClass:CommunityVC.class]) {
                [communityVC.view addSubview:communityVC.houseKeepingVC.view];
                return;
            }
        }
        
        if ([model.ios hasPrefix:@"CallPolice"]) {
            //police
            if (isStr([GlobalData sharedInstance].community.policePhone)) {
                NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel://%@",[GlobalData sharedInstance].community.policePhone];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
            }else{
                [GlobalMethod showAlert:@"该小区暂未配置社区片警"];
            }
            return;
        }
        if ([model.ios hasPrefix:@"CallManager"]) {
            if (isStr([GlobalData sharedInstance].community.managerPhone)) {
                NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel://%@",[GlobalData sharedInstance].community.managerPhone];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
            }else{
                [GlobalMethod showAlert:@"该小区暂未配置社区网格员"];
            }
            return;
        }
        if ([model.ios hasPrefix:@"InvokeMiniWechat"]) {
            NSArray * ary = [model.ios componentsSeparatedByString:@"&&"];
            NSString * strKey = ary.count>1?ary[1]:@"";
            NSString * strPath = ary.count>2?ary[2]:@"";
            [[PayHelper sharedInstance] launchMiniProKey:strKey path:strPath block:^{
                [GB_Nav pushVCName:@"DevelopVC" animated:true];
            }];
            return;
        }
        if ([model.ios hasPrefix:@"FJResumeDetailVC"]) {
            if (!isStr([GlobalData sharedInstance].modelFindJob.uid)) {
                [GB_Nav pushVCName:@"LoginViewController" animated:true];
                return;
            }
            [GlobalMethod judgeLoginState:^{
                [RequestApi requestFJResumeInfoDelegate:(BaseVC *)GB_Nav.lastRequestDelegateVC success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
                    ModelResumeDetail *modelDetail = [ModelResumeDetail modelObjectWithDictionary:response];
                    if (modelDetail.iDProperty.doubleValue) {
                        [GB_Nav pushVCName:@"FJResumeDetailVC" animated:true];
                    }else{
                        [GB_Nav pushVCName:@"CreateFJResumeVC" animated:true];
                    }
                    
                } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
                    [GB_Nav pushVCName:@"CreateFJResumeVC" animated:true];
                }];
            }];
            
            return;
        }
        
        if ([model.ios containsString:@"=NeighborPhone"]) {
            WebVC * vc = [WebVC new];
            vc.navTitle = model.moduleName;
            vc.url =  [model.ios stringByReplacingOccurrencesOfString:@"NeighborPhone" withString:[GlobalData sharedInstance].GB_UserModel.phone];
            [GB_Nav pushViewController:vc animated:true];
            return;
        }
        if ([model.ios hasPrefix:@"JournalismListVC"]) {
            
            NSArray * ary = [model.ios componentsSeparatedByString:@"&&"];
            NSString * strType = ary.count>1?ary[1]:@"";
            JournalismListVC * vc = [JournalismListVC new];
            vc.type = strType.doubleValue;
            [GB_Nav pushViewController:vc animated:true];
            return;
        }
        if ([model.ios hasPrefix:@"FindJobListVC"]) {
            NSArray * ary = [model.ios componentsSeparatedByString:@"&&"];
            NSString * strType = ary.count>1?ary[1]:@"";
            FindJobListVC * vc = [FindJobListVC new];
            vc.type = strType.doubleValue;
            [GB_Nav pushViewController:vc animated:true];
            return;
        }
        if ([model.ios hasPrefix:@"HailuoServiceListVC"]) {
            NSArray * ary = [model.ios componentsSeparatedByString:@"&&"];
            NSString * strType = ary.count>1?ary[1]:@"";
            HailuoServiceListVC * vc = [HailuoServiceListVC new];
            vc.navTitle = model.moduleName;
            vc.type = strType.intValue;
            [GB_Nav pushViewController:vc animated:true];
            return;
        }
        
        if ([model.ios hasPrefix:@"InvokeAPP"]) {
            NSArray * ary = [model.ios componentsSeparatedByString:@"&&"];
            NSString * strKey = ary.count>1?ary[1]:@"";
            NSURL *url = [NSURL URLWithString:strKey];
            UIApplication * app = [UIApplication sharedApplication];
            if ([app canOpenURL:url]) {
                [app openURL:url];
            }else{
                [GlobalMethod showAlert:[NSString stringWithFormat:@"请先安装%@",model.moduleName]];
            }
            return;
        }
        UIViewController * vc = [NSClassFromString(model.ios) new];
        if (vc) {
            [GB_Nav pushViewController:vc animated:true];
        }else{
            [GB_Nav pushVCName:@"DevelopVC" animated:true];
        }
    }else if (model.goMode == 1){//link
        if ([model.url containsString:@"wsq.hongjiafu.cn/shop/1532"]) {
            [[PayHelper sharedInstance] launchMiniPro:^{
                WebVC * vc = [WebVC new];
                vc.navTitle = model.moduleName;
                vc.url = model.url;
                [GB_Nav pushViewController:vc animated:true];
            }];
            return;
        }
        WebVC * vc = [WebVC new];
        vc.navTitle = model.moduleName;
        vc.url = model.url;
        [GB_Nav pushViewController:vc animated:true];
    }
}
@end
