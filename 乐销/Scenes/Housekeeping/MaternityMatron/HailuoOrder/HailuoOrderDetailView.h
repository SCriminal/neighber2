//
//  HailuoOrderDetailView.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/8/20.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HailuoOrderDetailTopView : UIView

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelHailuoOrder *)model;

@end

@interface HailuoOrderDetailOrderInfoView : UIView
@property (nonatomic, strong) ModelHailuoOrder *model;

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelHailuoOrder *)model;

@end

@interface HailuoOrderDetailPayInfoView : UIView

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelHailuoOrder *)model;

@end

@interface HailuoOrderAddressView : UIView
@property (nonatomic, strong) UIView *BG;
@property (nonatomic, strong) UIImageView *location;
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *phone;
@property (nonatomic, strong) UILabel *address;
@property (nonatomic, strong) ModelShopAddress *model;
@property (nonatomic, strong) NSString *addressDefaultAlert;


#pragma mark 刷新view
- (void)resetViewWithModel:(ModelShopAddress *)model;

@end
