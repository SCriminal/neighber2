//
//  ManualSelectCommunityVC.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/23.
//Copyright © 2020 ping. All rights reserved.
//

#import "BaseTableVC.h"

@interface ManualSelectCommunityVC : BaseTableVC
@property (nonatomic, strong) ModelCommunityCity *model;
@property (nonatomic, strong) void (^blockSelectCommunity)(ModelCommunity *);

@end
