//
//  SelectAddressVC.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/10.
//Copyright © 2020 ping. All rights reserved.
//

#import "BaseTableVC.h"

@interface SelectAddressVC : BaseTableVC
@property (nonatomic, strong) void (^blockSelected)(ModelShopAddress *);
@property (nonatomic, assign) double integralProductID;
@end

@interface HailuoSelectAddressVC : SelectAddressVC

@end
