//
//  PersonalRentListCell.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/26.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalRentListCell : UITableViewCell
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *info;
@property (nonatomic, strong) UILabel *square;
@property (nonatomic, strong) UILabel *direction;
@property (nonatomic, strong) UILabel *price;
@property (nonatomic, strong) UILabel *unit;
@property (nonatomic, strong) ModelRentInfo *model;
@property (nonatomic, strong) UIButton *btnUpDown;
@property (nonatomic, strong) UIButton *btnEdit;
@property (nonatomic, strong) UIButton *btnDelete;
@property (nonatomic, strong) void (^blockUpDown)(ModelRentInfo *);
@property (nonatomic, strong) void (^blockEdit)(ModelRentInfo *);
@property (nonatomic, strong) void (^blockDelete)(ModelRentInfo *);

#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelRentInfo *)model;

@end
