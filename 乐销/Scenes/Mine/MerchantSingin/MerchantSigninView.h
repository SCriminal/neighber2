//
//  MerchantSigninView.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/11.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YellowButton.h"
//switch view
#import "SwitchView.h"

@interface MerchantSigninTopView : UIView
@property (strong, nonatomic) SwitchView *switchView;
@property (strong, nonatomic) UIView *whiteBG;
@property (nonatomic, strong) void (^blockClick)(int);

@end



@interface MerchantSigninBottomView : UIView
//属性
@property (strong, nonatomic) UILabel *businessLicense;
@property (strong, nonatomic) UILabel *identity;
@property (strong, nonatomic) UIImageView *businessLicenseIV;
@property (strong, nonatomic) UIImageView *identityHeadIV;
@property (strong, nonatomic) UIImageView *identityCountryIV;
@property (strong, nonatomic) UILabel *alert;
@property (strong, nonatomic) UIImageView *iconAlert;
@property (nonatomic, strong) YellowButton  *btnBottom;
@property (nonatomic, strong) UIImageView *ivSelected;

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model;

@end

@interface MerchantConnectBottomView : UIView
//属性
@property (strong, nonatomic) UILabel *hotline;
@property (nonatomic, strong) YellowButton  *btnBottom;

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model;

@end


@interface  MerchantSigninStatusView : UIView
//属性
@property (strong, nonatomic) UIImageView *statusIcon;
@property (strong, nonatomic) UILabel *alert;
@property (strong, nonatomic) UILabel *alert1;
@property (nonatomic, strong) YellowButton *btnBottom;

#pragma mark 刷新view
- (void)resetViewWithState:(int)state;

@end
