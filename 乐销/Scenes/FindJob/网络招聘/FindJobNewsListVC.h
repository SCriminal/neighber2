//
//  FindJobNewsListVC.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/9/11.
//Copyright © 2020 ping. All rights reserved.
//

#import "BaseTableVC.h"

@interface FindJobNewsListVC : BaseTableVC
@property (nonatomic, assign) int type;

@end

@interface FindJobNewsListCell : UITableViewCell

@property (strong, nonatomic) UILabel *title;
@property (strong, nonatomic) UILabel *time;
@property (strong, nonatomic) UIImageView *icon;

#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelFJNet *)model;

@end
