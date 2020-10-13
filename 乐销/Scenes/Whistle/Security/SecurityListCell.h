//
//  WhistleListCell.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/17.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecurityListCell : UITableViewCell
@property (strong, nonatomic) UILabel *problem;
@property (strong, nonatomic) UIView *labelBg;
@property (strong, nonatomic) UILabel *status;
@property (strong, nonatomic) UILabel *time;
@property (nonatomic, strong) ModelCommunityServiceList *model;


#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelCommunityServiceList *)model;

@end
