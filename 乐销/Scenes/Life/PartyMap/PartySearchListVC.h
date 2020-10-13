//
//  PartySearchListVC.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/6/30.
//Copyright © 2020 ping. All rights reserved.
//

#import "BaseTableVC.h"

@interface PartySearchListVC : BaseTableVC
@property (nonatomic, strong) void (^blockSelected)(ModelParty *);

@end
