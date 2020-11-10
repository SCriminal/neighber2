
#import "TestVC.h"
#import <ISSBankSDK/ISSBankSDK.h>
#import "WXApiManager.h"
//request
#import "RequestApi+EHomePay.h"
@interface TestVC ()

@end

@implementation TestVC
/*

 */

#pragma mark view did load
- (void)viewDidLoad{
    [super viewDidLoad];
    
    WEAKSELF
    [self.view addSubview:[BaseNavView initNavBackTitle:@"1" rightTitle:@"2" rightBlock:^{
        [weakSelf jump];
    }]];
    
    return;
}
#pragma mark nav right click
- (void)jump{
//    [[WXApiManager sharedManager]loginApp];
    [GB_Nav pushVCName:@"EHomeMainVC" animated:true];
//    [self payWithMode2:^(){
//        EHomePayWeichatInfo * model = [EHomePayWeichatInfo new];
//        model.payOrderNo = @"1323494611456495616";
//        model.fee = 0.1;
//        return model;
//    }()];
//    [self reqeustKey];
}
//app机构级的签约用机构号机构密钥计算签名    商户号：802200958120003       机构号：802202007210001   机构密钥：EB70B2F420266A3CA6426D82E8A7D2
//商户号：802200958120003    密钥：C9F983293AA603DC06832B3CB08BEA   用这个@S_Criminal

/*
 1319464011712036864 15866500771
 1319464011712036864 13026558787
 1319464010868981760 13026558787
 1319038067000082432 18911315048
 1319464011712036864 18911315048
 1321355008037486592 15866500771
 1321355008037486592 15866500771
 1321355008037486592 13026558787
 1319038067000082432 13105369318
 1319038067000082432 18766863553
 1319038067000082432 13854851931
 1319077580166529024 18766863553
 1319464010785095680 13580394528
 */
- (void)payWithModel:(EHomePayWeichatInfo *)model{
    NSDictionary * requestHeader = @{
        @"opId": @"ebus_PYOrderDealApp",
        @"rqId": @"Z6",
    };
    NSDictionary * requestData = @{
        @"bkId" : @"802",
        @"orderIP" : @"60.208.131.66",
        @"orderDesc" : @"海之宝鲜海带",
        @"branchId" : @"802202007210001",
        @"returnURL" : @"",
        @"notifyURL" : @"",
        @"currency" : @"CNY",
        @"signFlag" : @"01",
        @"oneMerchNo" : @"802200958120003",
        @"secMerchNo" : @"",
        @"certNo" : @"",
        @"orderNo" : @"1323494611456495616",
        @"mobileNo" : @"13300110022",
        @"platlvevl" : @"null",
        @"orderAmt" : @"0.1",
        @"mac" : @"5633F7FA3154E31BB54910C067B9D6CB3603879D",
        @"transType" : @"JNLIFE",
        @"userName" : @"",
        @"orderTime" : @"20201013164816",
        @"orderTitle" : @"海之宝鲜海带"    };
    ISSPaySDK *paySDK = [ISSPaySDK payBankID:@"802" environmentMode:ISSBankSDKEnvironmentMode_ST scene:ISSBankSDKUseScenePay];
    [paySDK showPayAddedTo:self url:@"PYOrderDeal.do" channelID:@"B2" requestHeader:requestHeader requestData:requestData success:^{
        NSLog(@"%s", __func__);
    } failure:^(NSString *message) {
        NSLog(@"%s", __func__);
    } cancel:^(id result) {
        NSLog(@"%s", __func__);
    }];
    
    
}
- (void)payWithMode2:(EHomePayWeichatInfo *)model{
    NSDictionary * requestHeader = @{
        @"opId": @"ebus_PYOrderDealApp",
        @"rqId": @"Z6",
    };
    NSDictionary * requestData = @{
        @"orderNo": model.payOrderNo,
        @"orderAmt": NSNumber.dou(model.fee).stringValue,
        @"oneMerchNo" : @"802200958120003",
//        @"epiKey":@"C9F983293AA603DC06832B3CB08BEA"
    };
    ISSPaySDK *paySDK = [ISSPaySDK payBankID:@"802" environmentMode:ISSBankSDKEnvironmentMode_ST scene:ISSBankSDKUseScenePay];
    [paySDK showPayAddedTo:self url:@"PYOrderDeal.do" channelID:@"B2" requestHeader:requestHeader requestData:requestData success:^{

        NSLog(@"%s", __func__);
        
    } failure:^(NSString *message) {
        
        NSLog(@"%s", __func__);
        
    } cancel:^(id result) {
        NSLog(@"%s", __func__);

    }];
    
    
}
- (void)reqeustKey{
    [RequestApi requestEpiKey:@"04f262784fc1c21c32d2aa4f564e928500c19bc939a59f4ebd11a27b633dce6396542fa58e55992490120c1fdd07cfc454abd0ca5042e4f02b6a821be0582d329da6b957ec9642dc60e2c2f276bcf72ce2ffbf3212d3495fc7235dee2e5b5dd13d587a4971719287ff8c02234ccec5f1b7b6d1386cad6beadf61fd241c1f6a8883b8202538e4e31a4c" delegate:nil success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        NSString * epi = [response stringValueForKey:@"plaintext"];
        NSLog(@"%@",epi);
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
@end



