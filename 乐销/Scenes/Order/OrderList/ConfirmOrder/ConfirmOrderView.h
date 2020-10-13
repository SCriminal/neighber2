//
//  ConfirmOrderView.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/4/21.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YellowButton.h"

@interface ConfirmOrderView : UIView
//属性
@property (strong, nonatomic) UILabel *price;
@property (strong, nonatomic) UILabel *all;
@property (strong, nonatomic) UILabel *num;
@property (strong, nonatomic) YellowButton *submit;
@property (nonatomic, strong) void (^blockSubmitClick)(void);

#pragma mark 刷新view
- (void)resetViewWithModel:(NSArray *)model;

@end
