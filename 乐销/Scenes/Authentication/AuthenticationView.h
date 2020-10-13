//
//  AuthenticationView.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/4/22.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YellowButton.h"

@interface AuthenticationBottomView : UIView

//属性
@property (strong, nonatomic) UIImageView *identityHeadIV;
@property (strong, nonatomic) UIImageView *identityCountryIV;
@property (nonatomic, strong) YellowButton *btnBottom;
@property (nonatomic, strong) UIImageView *ivSelected;

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelAuthentication *)model;


@end

@interface AuthenticationTopView : UIView

//属性
@property (strong, nonatomic) UILabel *title;

#pragma mark 刷新view
- (void)resetViewWithTitle:(NSString *)title;


@end

@interface  AuthenticationStatusView : UIView
//属性
@property (strong, nonatomic) UIImageView *statusIcon;
@property (strong, nonatomic) UILabel *alert;

#pragma mark 刷新view
- (void)resetViewWithState:(int)state;

@end
