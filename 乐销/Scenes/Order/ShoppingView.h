//
//  ShoppingView.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/9.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>
//page control
#import "SLPageControl.h"

@interface ShoppingShopView : UIView
//属性
@property (strong, nonatomic) UIScrollView *scrollView;
@property (nonatomic, strong) SLPageControl * pageControl;

#pragma mark 刷新view
- (void)resetViewWithModels:(NSArray *)ary;

@end


@interface ShopItemView : UIView
//属性
@property (strong, nonatomic) UIImageView *logo;
@property (strong, nonatomic) UILabel *name;
@property (strong, nonatomic) UILabel *time;
@property (strong, nonatomic) UIButton *enter;
@property (strong, nonatomic) UIImageView *bg;

#pragma mark 刷新view
- (void)resetViewWithModels:(NSArray *)ary;

@end

@interface ShoppingProductItemView : UIView
//属性
@property (strong, nonatomic) UIImageView *icon;
@property (strong, nonatomic) UILabel *price;

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model;

@end


@interface ShoppingShopCell : UITableViewCell

@property (strong, nonatomic) UIImageView *logo;
@property (strong, nonatomic) UILabel *name;
@property (strong, nonatomic) UILabel *time;
@property (strong, nonatomic) UIImageView *star;
@property (strong, nonatomic) UILabel *score;
@property (strong, nonatomic) UILabel *overturn;
@property (strong, nonatomic) UILabel *distance;
@property (nonatomic, strong) ModelShopList *model;

#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelShopList *)model;

@end
