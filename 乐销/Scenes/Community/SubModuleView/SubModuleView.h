//
//  SubModuleView.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/6/17.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger,ENUM_SUB_MODULE_TYPE){
    ENUM_SUB_MODULE_TYPE_PUBLIC_SERVICE=1,//公共服务
    ENUM_SUB_MODULE_TYPE_HOSPITAL=2,//医疗养老
    ENUM_SUB_MODULE_TYPE_HOUSEHOLD=3,//家政服务
    ENUM_SUB_MODULE_TYPE_SECURITY=4,//安全服务
    ENUM_SUB_MODULE_TYPE_GOVERMENT=5,//政务服务
    ENUM_SUB_MODULE_TYPE_PROPERTY=6,//物业服务
    ENUM_SUB_MODULE_TYPE_COMMUNITY=7,//社区服务
    ENUM_SUB_MODULE_TYPE_KUIWEN=8//奎文
};

@interface SubModuleView : UIView
@property (nonatomic, assign) ENUM_SUB_MODULE_TYPE serviceType;
- (instancetype)initWithType:(ENUM_SUB_MODULE_TYPE )type;


@end
