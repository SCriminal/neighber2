//
//  WhistleDetailVC.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/18.
//Copyright © 2020 ping. All rights reserved.
//

#import "BaseTableVC.h"
#import "ENUM_COMMUNITY_SERVICE.h"

@interface SecurityDetailVC : BaseTableVC
@property (nonatomic, strong) ModelCommunityServiceList *modelList;
@property (nonatomic, assign) ENUM_COMMUNITY_SERVICE_TYPE serviceType;
@end
