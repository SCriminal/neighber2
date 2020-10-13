//
//  SearchModuleVC.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/8/10.
//Copyright © 2020 ping. All rights reserved.
//

#import "BaseTableVC.h"

@interface SearchModuleVC : BaseTableVC


@end

@interface SearchModuleCell : UITableViewCell

@property (strong, nonatomic) UIImageView *icon;
@property (strong, nonatomic) UILabel *name;
@property (nonatomic, strong) ModelModule *model;

#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelModule *)model;

@end
