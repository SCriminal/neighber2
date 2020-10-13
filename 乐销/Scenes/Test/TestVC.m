
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
    [GB_Nav pushVCName:@"EHomePayHistoryListVC" animated:true];
//    [self payWithModel:^(){
//        EHomePayWeichatInfo * model = [EHomePayWeichatInfo new];
//        model.payOrderNo = @"1315553287637958656";
//        model.fee = 123.16;
//        return model;
//    }()];
 
}

- (void)payWithModel:(EHomePayWeichatInfo *)model{
    NSDictionary * requestHeader = @{
        @"opId": @"ebus_PYOrderDealApp",
        @"rqId": @"Z6",
    };
    NSDictionary * requestData = @{
        @"orderNo": @"1315553287637958656",
        @"orderAmt": NSNumber.dou(123.16).stringValue
    };
    ISSPaySDK *paySDK = [ISSPaySDK payBankID:@"866" environmentMode:ISSBankSDKEnvironmentMode_UAT scene:ISSBankSDKUseScenePay];
    [paySDK showPayAddedTo:self url:@"PYOrderDeal.do" channelID:@"B2" requestHeader:requestHeader requestData:requestData success:^{
        NSLog(@"%s", __func__);
    } failure:^(NSString *message) {
        NSLog(@"%s", __func__);
    } cancel:^(id result) {
        NSLog(@"%s", __func__);
    }];
    
    
}
@end



