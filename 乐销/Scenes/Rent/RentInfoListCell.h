//
//  RentInfoListCell.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/21.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RentInfoListCell : UITableViewCell
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *info;
@property (nonatomic, strong) UILabel *square;
@property (nonatomic, strong) UILabel *direction;
@property (nonatomic, strong) UILabel *price;
@property (nonatomic, strong) UILabel *unit;
@property (nonatomic, strong) ModelRentInfo *model;

#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelRentInfo *)model;

@end



