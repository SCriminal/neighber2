//
//  OrderListCell.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/10.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderListCell : UITableViewCell
@property (strong, nonatomic) UIImageView *productImage;
@property (strong, nonatomic) UIImageView *arrow;
@property (strong, nonatomic) UILabel *shop;
@property (strong, nonatomic) UILabel *name;
@property (strong, nonatomic) UILabel *price;
@property (strong, nonatomic) UILabel *time;
@property (strong, nonatomic) UILabel *status;
@property (strong, nonatomic) UILabel *num;
@property (nonatomic, strong) ModelOrderDetail *model;

#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelOrderDetail *)model;

@end

@interface OrderListMultiImageCell : UITableViewCell
@property (strong, nonatomic) UIImageView *productImage;
@property (strong, nonatomic) UIImageView *productImage1;
@property (strong, nonatomic) UIImageView *productImage2;
@property (strong, nonatomic) UIImageView *productImage3;
@property (strong, nonatomic) UIImageView *more;
@property (strong, nonatomic) UIImageView *arrow;
@property (strong, nonatomic) UILabel *shop;
@property (strong, nonatomic) UILabel *name;
@property (strong, nonatomic) UILabel *price;
@property (strong, nonatomic) UILabel *time;
@property (strong, nonatomic) UILabel *status;
@property (strong, nonatomic) UILabel *num;
@property (nonatomic, strong) ModelOrderDetail *model;

#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelOrderDetail *)model;

@end
