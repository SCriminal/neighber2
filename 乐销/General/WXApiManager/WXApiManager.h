

#import <Foundation/Foundation.h>


@interface WXApiManager : NSObject
//单例
+ (instancetype)sharedManager;
//注册
+ (void)registerApp;
- (void)loginApp;
@end
