//
//  EHomeWaitPayView.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/9/30.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YellowButton.h"

@interface EHomeWaitPayCell : UITableViewCell

@property (strong, nonatomic) UILabel *name;
@property (strong, nonatomic) UILabel *timePay;
@property (strong, nonatomic) UILabel *price;
@property (strong, nonatomic) UILabel *numAll;
@property (strong, nonatomic) UILabel *overTime;
@property (strong, nonatomic) UILabel *overTimeFee;
@property (strong, nonatomic) UIImageView *iconSelected;
@property (nonatomic, strong) ModelEHomeWaitPayList *model;
@property (nonatomic, strong) void (^blockSelected)(ModelEHomeWaitPayList *);

#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelEHomeWaitPayList *)model;

@end


@interface EHomeWaitPayBottomView : UIView
//属性
@property (strong, nonatomic) UILabel *price;
@property (strong, nonatomic) UILabel *all;
@property (strong, nonatomic) UILabel *num;
@property (strong, nonatomic) UIImageView *ivSelected;
@property (strong, nonatomic) YellowButton *submit;
@property (nonatomic, strong) void (^blockSubmitClick)(void);
@property (nonatomic, strong) void (^blockSelectAll)(BOOL);

#pragma mark 刷新view
- (void)resetViewWithModel:(NSMutableArray *)arys;

@end
