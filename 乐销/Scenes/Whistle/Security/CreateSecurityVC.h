//
//  CreateWhistleVC.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/17.
//Copyright © 2020 ping. All rights reserved.
//

#import "BaseTableVC.h"
#import "ENUM_COMMUNITY_SERVICE.h"

@interface CreateSecurityVC : BaseTableVC
@property (nonatomic, strong) void (^blockRequestSuccess)(void);
@property (nonatomic, assign) ENUM_COMMUNITY_SERVICE_TYPE serviceType;

@end
