//
//  SelectCommunityCityView.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/23.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>




@interface SelectCommunityCityCell : UITableViewCell

@property (strong, nonatomic) UILabel *name;
@property (nonatomic, strong) ModelCommunityCity *model;

#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelCommunityCity *)model;

@end
