//
//  RentListFilterView.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/27.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RentListFilterView : UIView
@property (nonatomic, strong) ModelRentInfo *modelFilter;
@property (nonatomic, strong) void (^blockClick)(int );
- (void)reconfigView;
@end
