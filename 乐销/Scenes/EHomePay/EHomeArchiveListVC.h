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
@property (strong, nonatomic) UILabel *bind;

#pragma mark 刷新cell
- (void)resetCellWithModel:(id)model;

@end


@interface EHomeArchiveItemCell : UITableViewCell

@property (strong, nonatomic) UIImageView *iconLogo;
@property (strong, nonatomic) UIButton *btnSelected;
@property (strong, nonatomic) UILabel *name;
@property (strong, nonatomic) UILabel *address;
@property (nonatomic, strong) void (^blockBindClick)(ModelEhomeHomeItem *);
@property (nonatomic, strong) ModelEhomeHomeItem *model;

#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelEhomeHomeItem *)model;

@end
