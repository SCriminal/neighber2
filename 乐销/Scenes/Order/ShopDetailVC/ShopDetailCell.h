//
//  ShopDetailCell.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/12.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopDetailLeftCell : UITableViewCell

@property (strong, nonatomic) UIView *BG;
@property (strong, nonatomic) UILabel *name;

#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelShopDetailCategory *)model;

@end

@interface ShopDetailRightCell : UITableViewCell

@property (strong, nonatomic) UIImageView *productIV;
@property (strong, nonatomic) UILabel *name;
@property (strong, nonatomic) UILabel *num;
@property (strong, nonatomic) UILabel *rmb;
@property (strong, nonatomic) UILabel *price;
@property (strong, nonatomic) UIImageView *add;
@property (strong, nonatomic) UIControl *conAdd;
@property (nonatomic, strong) void (^blockClick)(ModelShopDetailProduct *);
@property (nonatomic, strong) ModelShopDetailProduct *model;

#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelShopDetailProduct *)model;

@end
