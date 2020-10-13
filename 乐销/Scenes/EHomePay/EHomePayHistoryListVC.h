//
//  EHomePayHistoryListVC.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/10/10.
//Copyright © 2020 ping. All rights reserved.
//

#import "BaseTableVC.h"

@interface EHomePayHistoryListVC : BaseTableVC

@end

@interface EHomePayHistoryFilterView : UIView
//属性
@property (strong, nonatomic) UILabel *filter0;
@property (strong, nonatomic) UILabel *filter1;
@property (strong, nonatomic) UILabel *filter2;
@property (strong, nonatomic) UILabel *filter3;

@property (strong, nonatomic) UIImageView *icon0;
@property (strong, nonatomic) UIImageView *icon1;
@property (strong, nonatomic) UIImageView *icon2;
@property (strong, nonatomic) UIImageView *icon3;
@property (nonatomic, strong) void (^blockIndexClick)(int);

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model;

@end


@interface EHomePayHistoryListCell : UITableViewCell

@property (strong, nonatomic) UILabel *name;
@property (strong, nonatomic) UILabel *timePay;
@property (strong, nonatomic) UILabel *price;
@property (strong, nonatomic) UILabel *person;
@property (nonatomic, strong) ModelEHomePayHistoryItem *model;

#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelEHomePayHistoryItem *)model;

@end



@interface EHomePayHistoryFilterAlertView : UIView

@property (nonatomic, strong) UIView *viewBG;
@property (nonatomic, strong) UIView *viewBlackAlpha;
@property (nonatomic, strong) UIButton *btnSearch;
@property (nonatomic, strong) UIButton *btnReset;
@property (nonatomic, strong) UILabel *selectEndTime;
@property (nonatomic, strong) UILabel *selectStartTime;
@property (nonatomic, strong) NSDate *dateStart;
@property (nonatomic, strong) NSDate *dateEnd;

@property (nonatomic, strong) void (^blockSearchClick)(NSDate*,NSDate*  );

#pragma mark 刷新view
- (void)show;

@end
