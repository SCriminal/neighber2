//
//  SelectFloorView.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/25.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectFloorView : UIView
@property (nonatomic, strong) void (^blockSelect)(double,double);

@end
