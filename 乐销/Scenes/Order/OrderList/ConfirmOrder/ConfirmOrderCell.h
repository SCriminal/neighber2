//
//  ConfirmOrderCell.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/4/26.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConfirmOrderSectionTopView : UIView
//属性
@property (strong, nonatomic) UIView *whiteBG;
@property (strong, nonatomic) UILabel *name;
@property (strong, nonatomic) UIImageView *arrow;
@property (nonatomic, strong) ModelTrolley *model;
@property (nonatomic, assign) BOOL isOrderDetail;

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelTrolley *)model;

@end

@interface ConfirmOrderSectionBottomView : UIView
//属性
@property (strong, nonatomic) UIView *whiteBG;
@property (nonatomic, strong) ModelTrolley *model;
@property (strong, nonatomic) UILabel *number;
@property (strong, nonatomic) UILabel *price;
@property (nonatomic, assign) BOOL isOrderDetail;

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelTrolley *)model;

@end


@interface ConfirmOrderCell : UITableViewCell

@property (strong, nonatomic) UIImageView *productIV;
@property (strong, nonatomic) UILabel *name;
@property (strong, nonatomic) UILabel *number;
@property (strong, nonatomic) UILabel *rmb;
@property (strong, nonatomic) UILabel *price;
@property (strong, nonatomic) UIImageView *add;
@property (strong, nonatomic) UIView *whiteBG;
@property (nonatomic, strong) ModelIntegralProduct *modelProduct;
@property (nonatomic, assign) BOOL isOrderDetail;
#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelIntegralProduct *)model;

@end

