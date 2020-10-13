//
//  PayHelper.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/5/18.
//Copyright © 2020 ping. All rights reserved.

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSUInteger, ENUM_PAY_TYPE) {
    ENUM_PAY_ALI = 1,
    ENUM_PAY_WECHAT = 2,
};
@interface PayHelper : NSObject
@property (nonatomic, assign) ENUM_PAY_TYPE payType;
@property (nonatomic, strong) void (^blockSuccess)(NSString *);

DECLARE_SINGLETON(PayHelper)

- (void)payWithAli:(NSString *)number blockSuccsee:(void (^)(NSString *))blockSuccess;
- (void)payWithWeChat:(NSString *)content number:(NSString *)number blockSuccsee:(void (^)(NSString *))blockSuccess;
#pragma mark launch mini programm
- (void)launchMiniPro:(void (^)(void))blockFailure;
- (void)launchMiniProKey:(NSString *)key path:(NSString *)path  block:(void (^)(void))blockFailure;
@end
