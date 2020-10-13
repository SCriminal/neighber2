//
//  EHomeArchiveDetailVC.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/9/29.
//Copyright © 2020 ping. All rights reserved.
//

#import "BaseTableVC.h"

@interface EHomeArchiveDetailVC : BaseTableVC

@end

@interface EHomeArchiveDetailHouseView : UIView
@end

@interface EHomeArchiveDetailOwnerView : UIView
@end


@interface EHomeArchiveDetailMemberView : UIView
@end


@interface EHomeArchiveDetailCell : UITableViewCell

@property (strong, nonatomic) UIImageView *logo;
@property (strong, nonatomic) UILabel *name;
@property (strong, nonatomic) UIButton *btnConfirm;
@property (strong, nonatomic) UIButton *btnUnbind;

#pragma mark 刷新cell
- (void)resetCellWithModel:(id)model;

@end
