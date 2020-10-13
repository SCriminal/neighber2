//
//  SelectPaymentView.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/4/21.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YellowButton.h"
#import "PayHelper.h"
@interface SelectPaymentView : UIView
//属性
@property (strong, nonatomic) UILabel *select;
@property (strong, nonatomic) UILabel *wechat;
@property (strong, nonatomic) UILabel *ali;
@property (strong, nonatomic) UIImageView *close;
@property (strong, nonatomic) UIImageView *iconWeChat;
@property (strong, nonatomic) UIImageView *iconAli;
@property (strong, nonatomic) UIImageView *iconWeChatSelect;
@property (strong, nonatomic) UIImageView *iconAliSelect;
@property (strong, nonatomic) YellowButton *pay;
@property (nonatomic, strong) void (^blockSelected)(ENUM_PAY_TYPE);
@property (nonatomic, strong) void (^blockCancel)(void);
@property (nonatomic, assign) ENUM_PAY_TYPE index;
@property (nonatomic, strong) UIView *BG;

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model;
-(void)show;

@end
