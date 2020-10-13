//
//  HospitalListView.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/21.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HospitalListCell : UITableViewCell

@property (strong, nonatomic) UIImageView *logo;
@property (strong, nonatomic) UIImageView *iconPhone;
@property (strong, nonatomic) UILabel *name;
@property (strong, nonatomic) UILabel *phone;
@property (strong, nonatomic) UILabel *address;
@property (strong, nonatomic) UIButton *btnPhone;
@property (nonatomic, strong) ModelHospital *model;

#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelHospital *)model;

@end
