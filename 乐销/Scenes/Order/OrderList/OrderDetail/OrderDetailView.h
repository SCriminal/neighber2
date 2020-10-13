//
//  OrderDetailView.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/4/21.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ENUM_ORDER_OPERATE) {
    ENUM_ORDER_OPERATE_PAY = 1,
    ENUM_ORDER_OPERATE_CANCEL,
    ENUM_ORDER_OPERATE_CHANGE_ADDRESS,
    ENUM_ORDER_OPERATE_REFUND,
    ENUM_ORDER_OPERATE_CONFIRM_RECEIVE,
    ENUM_ORDER_OPERATE_GOODRETURN,
    ENUM_ORDER_OPERATE_COMPLAIN,
};

@interface OrderDetailTopView : UIView
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *subTitle;
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UIImageView *BG;
@property (nonatomic, strong) ModelOrderDetail *model;

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelOrderDetail *)model;

@end

@interface OrderDetailBottomView : UIView
@property (nonatomic, strong) void (^blockClick)(ENUM_ORDER_OPERATE);
@property (nonatomic, strong) ModelOrderDetail *model;

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelOrderDetail *)model;

@end

@interface OrderDetailInfoView : UIView
@property (nonatomic, strong) ModelOrderDetail *model;

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelOrderDetail *)model;

@end


@interface OrderDetailSectionBottomView : UIView
//属性
@property (strong, nonatomic) UIView *whiteBG;
@property (nonatomic, strong) ModelTrolley *model;
@property (strong, nonatomic) UILabel *number;
@property (strong, nonatomic) UILabel *price;
@property (strong, nonatomic) UILabel *freight;
@property (strong, nonatomic) UILabel *freightPrice;
@property (strong, nonatomic) UILabel *real;
@property (strong, nonatomic) UILabel *realPrice;

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelTrolley *)model modelDetail:(ModelOrderDetail *)modelDetail;
@end
