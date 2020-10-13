//
//  HailuoOrderListCell.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/8/19.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HailuoOrderListCell : UITableViewCell

@property (strong, nonatomic) UIView *BG;
@property (strong, nonatomic) UILabel *status;
@property (strong, nonatomic) UIImageView *logo;
@property (strong, nonatomic) UILabel *serveName;
@property (strong, nonatomic) UILabel *serveTime;
@property (strong, nonatomic) UILabel *companyName;
@property (strong, nonatomic) UILabel *phone;
@property (nonatomic, strong) ModelHailuoOrder *model;
@property (nonatomic, strong) UIButton *btnDismiss;
@property (nonatomic, strong) void (^blockDismiss)(ModelHailuoOrder *);

#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelHailuoOrder *)model;

@end

