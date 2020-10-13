//
//  OrderAddressView.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/4/21.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderAddressView : UIView
@property (nonatomic, strong) UIView *BG;
@property (nonatomic, strong) UIImageView *location;
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *phone;
@property (nonatomic, strong) UILabel *address;
@property (nonatomic, strong) UIImageView *arrowRight;
@property (nonatomic, assign) BOOL isClickAvailable;
@property (nonatomic, strong) ModelShopAddress *model;
@property (nonatomic, strong) void (^blockClick)(void);
@property (nonatomic, assign) BOOL isOrderDetail;
@property (nonatomic, strong) NSString *addressDefaultAlert;


#pragma mark 刷新view
- (void)resetViewWithModel:(ModelShopAddress *)model;

@end
