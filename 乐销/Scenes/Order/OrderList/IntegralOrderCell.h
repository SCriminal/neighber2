//
//  IntegralOrderCell.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/4/26.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IntegralOrderCell : UITableViewCell
@property (strong, nonatomic) UIImageView *productImage;
@property (strong, nonatomic) UILabel *name;
@property (strong, nonatomic) UILabel *score;
@property (strong, nonatomic) UILabel *time;
@property (strong, nonatomic) UILabel *status;
@property (strong, nonatomic) UILabel *num;
@property (nonatomic, strong) ModelIntegralOrder *model;

#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelIntegralOrder *)model;

@end
