//
//  PerCenterView.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/8/14.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PerCenterTopView : UIView
//属性
@property (strong, nonatomic) UIImageView *bg;
@property (strong, nonatomic) UIImageView *head;
@property (strong, nonatomic) UIImageView *vertification;
@property (strong, nonatomic) UIImageView *setting;
@property (strong, nonatomic) UIImageView *msg;
@property (strong, nonatomic) UILabel *msgNum;

@property (strong, nonatomic) UILabel *name;

- (void)requestMsgNum;
- (void)requestCertificate;


@end

@interface PerCenterSignView : UIView
//属性
@property (strong, nonatomic) UILabel *integralNum;
@property (strong, nonatomic) UILabel *integral;
@property (nonatomic, strong) void (^blockIntegralClick)(void);
@property (nonatomic, strong) void (^blockSignClick)(void);

- (void)requestIntegralNum;

@end

@interface PerCenterOrderView : UIView
//属性
@property (strong, nonatomic) UILabel *integralOrderNum;
@property (strong, nonatomic) UILabel *orderNum;
@property (nonatomic, strong) void (^blockIntegralOrderClick)(void);
@property (nonatomic, strong) void (^blockOrderClick)(void);
- (void)requestOrderNum;
@end

@interface PerCenterDealView : UIView
//属性
@property (strong, nonatomic) UILabel *num0;
@property (strong, nonatomic) UILabel *num1;
@property (strong, nonatomic) UILabel *num2;

@property (nonatomic, strong) void (^blockLeftClick)(void);
@property (nonatomic, strong) void (^blockMiddleClick)(void);
@property (nonatomic, strong) void (^blockRightClick)(void);
- (void)requestNum;
@end


@interface PerCenterBtnView : UIView

@end

@interface PerCenterShopView : UIView
//属性
@property (strong, nonatomic) UIView *bg;
@property (strong, nonatomic) UIImageView *logo;
@property (strong, nonatomic) UILabel *name;
@property (strong, nonatomic) UIImageView *star;
@property (strong, nonatomic) UILabel *score;
@property (strong, nonatomic) UILabel *overturn;
@property (strong, nonatomic) UIImageView *ad;
@property (strong, nonatomic) UIImageView *arrow;
@property (nonatomic, strong) ModelShopList *model;

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelShopList *)model;
- (void)requestShop;
@end

@interface PerCenterTitleAlertView : UIView
@property (nonatomic, strong) UILabel *title;
- (void)changeTitle:(NSString *)title;
@end


@interface PerCenterUsView : UIView

@end
