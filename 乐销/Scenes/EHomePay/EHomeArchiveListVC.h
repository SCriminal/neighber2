//
//  EHomeArchiveListVC.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/9/29.
//Copyright © 2020 ping. All rights reserved.
//

#import "BaseTableVC.h"

@interface EHomeArchiveListVC : BaseTableVC

@end

@interface EHomeArchiveListCell : UITableViewCell

@property (strong, nonatomic) UIImageView *iconLogo;
@property (strong, nonatomic) UIImageView *iconSelected;
@property (strong, nonatomic) UILabel *name;
@property (strong, nonatomic) UILabel *address;

#pragma mark 刷新cell
- (void)resetCellWithModel:(id)model;

@end
