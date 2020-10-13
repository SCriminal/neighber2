//
//  SwitchArchiveView.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/4/22.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SwitchArchiveView : UIView
@property (nonatomic, strong) void (^blockSelected)(int);
@property (nonatomic, strong) void (^blockCancel)(void);

#pragma mark 刷新view
- (void)resetViewWithArys:(NSArray *)model;

@end


@interface SwitchArchiveCell : UITableViewCell

@property (strong, nonatomic) UILabel *name;

#pragma mark 刷新cell
- (void)resetCellWithModel:(id)model;

@end
