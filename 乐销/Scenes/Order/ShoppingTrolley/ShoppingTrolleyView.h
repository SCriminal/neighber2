//
//  ShoppingTrolleyView.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/12.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YellowButton.h"

@interface ShoppingTrolleySectionTopView : UIView
//属性
@property (strong, nonatomic) UIImageView *iconSelected;
@property (strong, nonatomic) UIView *whiteBG;
@property (strong, nonatomic) UILabel *name;
@property (strong, nonatomic) UIImageView *arrow;
@property (strong, nonatomic) UIControl *conSelect;
@property (nonatomic, strong) void (^blockSelect)(BOOL,ModelTrolley*);
@property (nonatomic, strong) ModelTrolley *model;

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelTrolley *)model;

@end

@interface ShoppingTrolleySectionBottomView : UIView
//属性
@property (strong, nonatomic) UIView *whiteBG;

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model;

@end


@interface ShoppingTrolleyCell : UITableViewCell

@property (strong, nonatomic) UIImageView *productIV;
@property (strong, nonatomic) UILabel *name;
@property (strong, nonatomic) UILabel *number;
@property (strong, nonatomic) UILabel *rmb;
@property (strong, nonatomic) UILabel *price;
@property (strong, nonatomic) UIImageView *add;
@property (strong, nonatomic) UIImageView *iconSelected;
@property (strong, nonatomic) UIView *whiteBG;
@property (nonatomic, strong) ModelIntegralProduct *modelProduct;
@property (strong, nonatomic) UIControl *conAdd;
@property (strong, nonatomic) UIControl *conMinus;
@property (strong, nonatomic) UIControl *conSelect;
@property (nonatomic, strong) void (^blockAddClick)(ModelIntegralProduct *);
@property (nonatomic, strong) void (^blockMinusClick)(ModelIntegralProduct *);
@property (nonatomic, strong) void (^blockSelected)(ModelIntegralProduct *);

#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelIntegralProduct *)model;

@end


@interface ShoppingTrolleyBottomView : UIView
//属性
@property (strong, nonatomic) UILabel *price;
@property (strong, nonatomic) UILabel *all;
@property (strong, nonatomic) UILabel *num;
@property (strong, nonatomic) UIImageView *ivSelected;
@property (strong, nonatomic) YellowButton *submit;
@property (nonatomic, strong) void (^blockSubmitClick)(void);
@property (nonatomic, strong) void (^blockSelectAll)(BOOL);

#pragma mark 刷新view
- (void)resetViewWithModel:(NSMutableArray *)arys;

@end
