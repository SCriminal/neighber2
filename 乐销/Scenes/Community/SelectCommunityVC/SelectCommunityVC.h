//
//  SelectCommunityVC.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/12.
//Copyright © 2020 ping. All rights reserved.
//

#import "BaseTableVC.h"

@interface SelectCommunityVC : BaseTableVC
@property (nonatomic, strong) void (^blockSelectCommunity)(ModelCommunity *);

@end
