//
//  WhistleTabVC.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/17.
//Copyright © 2020 ping. All rights reserved.
//

#import "BaseVC.h"
#import "ENUM_COMMUNITY_SERVICE.h"

@interface SecurityTabVC : BaseVC
@property (nonatomic, assign) ENUM_COMMUNITY_SERVICE_TYPE serviceType;

@end

@interface MaintainTabVC : SecurityTabVC
@end

@interface ArgueTabVC : SecurityTabVC
@end

@interface CleanTabVC : SecurityTabVC
@end
