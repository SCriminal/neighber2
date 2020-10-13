//
//  MessageCenterVC.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/10.
//Copyright © 2020 ping. All rights reserved.
//

#import "BaseTableVC.h"

typedef NS_ENUM(NSUInteger, ENUM_MSG_TYPE) {
    ENUM_MSG_SYSTEM = 1,
    ENUM_MSG_RENT = 2,
    ENUM_MSG_ORDER = 3,
    ENUM_MSG_INTEGRAL = 4,
};

@interface MessageCenterVC : BaseTableVC
@property (nonatomic, assign) ENUM_MSG_TYPE type;
@end
