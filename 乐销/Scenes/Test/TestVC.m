
#import "TestVC.h"
#import <ISSBankSDK/ISSBankSDK.h>

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
//    [ISSPaySDK payBankID:@"802" environmentMode:ISSBankSDKEnvironmentMode_UAT scene:ISSBankSDKUseScenePay];
    [GB_Nav pushVCName:@"EHomeMainVC" animated:true];
//    [self payWithModel:^(){
//        EHomePayWeichatInfo * model = [EHomePayWeichatInfo new];
//        model.payOrderNo = @"1315553287637958656";
//        model.fee = 123.16;
//        return model;
//    }()];
 
}
//app机构级的签约用机构号机构密钥计算签名    商户号：802201058120000       机构号：802202007210001   机构密钥：EB70B2F420266A3CA6426D82E8A7D2
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
        @"oneMerchNo" : @"802201058120000",
        @"secMerchNo" : @"",
        @"certNo" : @"",
        @"orderNo" : @"893105067997195735674",
        @"mobileNo" : @"13300110022",
        @"platlvevl" : @"null",
        @"orderAmt" : @"0.01",
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
@end



