//
//  ModelHailuoOrder.m
//
//  Created by 林栋 隋 on 2020/8/20
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import "ModelHailuoOrder.h"


NSString *const kModelHailuoOrderId = @"id";
NSString *const kModelHailuoOrderChangeAunt = @"change_aunt";
NSString *const kModelHailuoOrderEarnestPrice = @"earnest_price";
NSString *const kModelHailuoOrderCompanyId = @"company_id";
NSString *const kModelHailuoOrderServeId = @"serve_id";
NSString *const kModelHailuoOrderAnew = @"anew";
NSString *const kModelHailuoOrderCompanyName = @"company_name";
NSString *const kModelHailuoOrderPrice = @"price";
NSString *const kModelHailuoOrderOrderStatus = @"order_status";
NSString *const kModelHailuoOrderStatusMessage = @"status_message";
NSString *const kModelHailuoOrderTel = @"tel";
NSString *const kModelHailuoOrderCreateTime = @"create_time";
NSString *const kModelHailuoOrderServePrice = @"serve_price";
NSString *const kModelHailuoOrderName = @"name";
NSString *const kModelHailuoOrderBeginTime = @"begin_time";
NSString *const kModelHailuoOrderRenewCount = @"renew_count";
NSString *const kModelHailuoOrderOrderNumber = @"order_number";
NSString *const kModelHailuoOrderServeTime = @"serve_time";
NSString *const kModelHailuoOrderOrderId = @"order_id";
NSString *const kModelHailuoOrderDiscountPrice = @"discount_price";
NSString *const kModelHailuoOrderComplaintTel = @"complaint_tel";
NSString *const kModelHailuoOrderCompany = @"company";
NSString *const kModelHailuoOrderRealServePrice = @"real_serve_price";
NSString *const kModelHailuoOrderCompanyTel = @"company_tel";
NSString *const kModelHailuoOrderServeName = @"serve_name";
NSString *const kModelHailuoOrderRealEarnestPrice = @"real_earnest_price";
NSString *const kModelHailuoOrderRefund = @"refund";


@interface ModelHailuoOrder ()
@end

@implementation ModelHailuoOrder

@synthesize iDProperty = _iDProperty;
@synthesize changeAunt = _changeAunt;
@synthesize earnestPrice = _earnestPrice;
@synthesize companyId = _companyId;
@synthesize serveId = _serveId;
@synthesize anew = _anew;
@synthesize companyName = _companyName;
@synthesize price = _price;
@synthesize orderStatus = _orderStatus;
@synthesize statusMessage = _statusMessage;
@synthesize tel = _tel;
@synthesize createTime = _createTime;
@synthesize servePrice = _servePrice;
@synthesize name = _name;
@synthesize beginTime = _beginTime;


#pragma mark init
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
        self.iDProperty = [dict doubleValueForKey:kModelHailuoOrderId];
        self.changeAunt = [dict doubleValueForKey:kModelHailuoOrderChangeAunt];
        self.earnestPrice = [dict stringValueForKey:kModelHailuoOrderEarnestPrice];
        self.companyId = [dict doubleValueForKey:kModelHailuoOrderCompanyId];
        self.serveId = [dict doubleValueForKey:kModelHailuoOrderServeId];
        self.anew = [dict doubleValueForKey:kModelHailuoOrderAnew];
        self.companyName = [dict stringValueForKey:kModelHailuoOrderCompanyName];
        self.price = [dict stringValueForKey:kModelHailuoOrderPrice];
        self.orderStatus = [dict doubleValueForKey:kModelHailuoOrderOrderStatus];
        self.statusMessage = [dict stringValueForKey:kModelHailuoOrderStatusMessage];
        self.tel = [dict stringValueForKey:kModelHailuoOrderTel];
        self.createTime = [dict doubleValueForKey:kModelHailuoOrderCreateTime];
        self.servePrice = [dict stringValueForKey:kModelHailuoOrderServePrice];
        self.name = [dict stringValueForKey:kModelHailuoOrderName];
        self.beginTime = [dict stringValueForKey:kModelHailuoOrderBeginTime];
        self.renewCount = [dict doubleValueForKey:kModelHailuoOrderRenewCount];
        self.orderNumber = [dict stringValueForKey:kModelHailuoOrderOrderNumber];
        self.serveTime = [dict stringValueForKey:kModelHailuoOrderServeTime];
        self.orderId = [dict doubleValueForKey:kModelHailuoOrderOrderId];
        self.discountPrice = [dict doubleValueForKey:kModelHailuoOrderDiscountPrice];
        self.complaintTel = [dict doubleValueForKey:kModelHailuoOrderComplaintTel];
        self.company = [dict stringValueForKey:kModelHailuoOrderCompany];
        self.realServePrice = [dict doubleValueForKey:kModelHailuoOrderRealServePrice];
        self.companyTel = [dict stringValueForKey:kModelHailuoOrderCompanyTel];
        self.serveName = [dict stringValueForKey:kModelHailuoOrderServeName];
        self.realEarnestPrice = [dict doubleValueForKey:kModelHailuoOrderRealEarnestPrice];
        self.refund = [dict doubleValueForKey:kModelHailuoOrderRefund];
        /*
         0           商家未接单
         1           确定阿姨中
         2           协商价格中
         3           支付定金
         4           支付尾款
         5           服务中
         6           申请取消中
         7           已取消
         8           待服务
         9           续费
         10           待评价
         11           完成
         */
        switch ((int)self.orderStatus) {
            case 0:
                self.statusShow = @"未接单";
                self.statusColorShow = COLOR_ORANGE;
                break;
            case 1:
                self.statusShow = @"确定阿姨中";
                self.statusColorShow = COLOR_ORANGE;
                break;
            case 2:
                self.statusShow = @"协商价格中";
                self.statusColorShow = COLOR_ORANGE;
                break;
            case 3:
                self.statusShow = @"支付定金";
                self.statusColorShow = COLOR_ORANGE;
                break;
            case 4:
                self.statusShow = @"支付尾款";
                self.statusColorShow = COLOR_ORANGE;
                break;
            case 5:
                self.statusShow = @"服务中";
                self.statusColorShow = COLOR_ORANGE;
                break;
            case 6:
                self.statusShow = @"申请取消中";
                self.statusColorShow = COLOR_ORANGE;
                break;
            case 7:
                self.statusShow = @"已取消";
                self.statusColorShow = COLOR_999;
                break;
            case 8:
                self.statusShow = @"待服务";
                self.statusColorShow = COLOR_ORANGE;
                break;
            case 9:
                self.statusShow = @"续费";
                self.statusColorShow = COLOR_ORANGE;
                break;
            case 10:
                self.statusShow = @"待评价";
                self.statusColorShow = COLOR_BLUE;
                break;
            case 11:
                self.statusShow = @"完成";
                self.statusColorShow = COLOR_GREEN;
                break;
            default:
                break;
        }
        
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.iDProperty] forKey:kModelHailuoOrderId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.changeAunt] forKey:kModelHailuoOrderChangeAunt];
    [mutableDict setValue:self.earnestPrice forKey:kModelHailuoOrderEarnestPrice];
    [mutableDict setValue:[NSNumber numberWithDouble:self.companyId] forKey:kModelHailuoOrderCompanyId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.serveId] forKey:kModelHailuoOrderServeId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.anew] forKey:kModelHailuoOrderAnew];
    [mutableDict setValue:self.companyName forKey:kModelHailuoOrderCompanyName];
    [mutableDict setValue:self.price forKey:kModelHailuoOrderPrice];
    [mutableDict setValue:[NSNumber numberWithDouble:self.orderStatus] forKey:kModelHailuoOrderOrderStatus];
    [mutableDict setValue:self.statusMessage forKey:kModelHailuoOrderStatusMessage];
    [mutableDict setValue:self.tel forKey:kModelHailuoOrderTel];
    [mutableDict setValue:[NSNumber numberWithDouble:self.createTime] forKey:kModelHailuoOrderCreateTime];
    [mutableDict setValue:self.servePrice forKey:kModelHailuoOrderServePrice];
    [mutableDict setValue:self.name forKey:kModelHailuoOrderName];
    [mutableDict setValue:self.beginTime forKey:kModelHailuoOrderBeginTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.renewCount] forKey:kModelHailuoOrderRenewCount];
      [mutableDict setValue:self.orderNumber forKey:kModelHailuoOrderOrderNumber];
      [mutableDict setValue:self.serveTime forKey:kModelHailuoOrderServeTime];
      [mutableDict setValue:[NSNumber numberWithDouble:self.orderId] forKey:kModelHailuoOrderOrderId];
      [mutableDict setValue:[NSNumber numberWithDouble:self.discountPrice] forKey:kModelHailuoOrderDiscountPrice];
      [mutableDict setValue:[NSNumber numberWithDouble:self.complaintTel] forKey:kModelHailuoOrderComplaintTel];
      [mutableDict setValue:self.company forKey:kModelHailuoOrderCompany];
      [mutableDict setValue:[NSNumber numberWithDouble:self.realServePrice] forKey:kModelHailuoOrderRealServePrice];
      [mutableDict setValue:self.companyTel forKey:kModelHailuoOrderCompanyTel];
      [mutableDict setValue:self.serveName forKey:kModelHailuoOrderServeName];
      [mutableDict setValue:[NSNumber numberWithDouble:self.realEarnestPrice] forKey:kModelHailuoOrderRealEarnestPrice];
      [mutableDict setValue:[NSNumber numberWithDouble:self.refund] forKey:kModelHailuoOrderRefund];
    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
