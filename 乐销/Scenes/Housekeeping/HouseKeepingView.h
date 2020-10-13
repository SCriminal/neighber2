//
//  HouseKeepingView.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/8/14.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HouseKeepingTopView : UIView
//属性
@property (strong, nonatomic) UIImageView *BG;
@property (strong, nonatomic) BaseNavView *nav;
@property (strong, nonatomic) UIImageView *icon;
@property (strong, nonatomic) UILabel *runningNum;
@property (strong, nonatomic) UILabel *commentNum;
@property (strong, nonatomic) UILabel *completeNum;
@property (strong, nonatomic) UILabel *sellAfterNum;
@property (nonatomic, strong) void (^blockBack)(void);

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model;

@end

@interface HouseKeepingAuntCell : UITableViewCell

@property (strong, nonatomic) UIImageView *logo;
@property (strong, nonatomic) UILabel *name;
@property (strong, nonatomic) UILabel *age;
@property (strong, nonatomic) UILabel *rmb;
@property (strong, nonatomic) UILabel *label;
@property (strong, nonatomic) UIImageView *star;
@property (strong, nonatomic) UILabel *grade;
@property (strong, nonatomic) UILabel *comment;
@property (strong, nonatomic) UILabel *price;
@property (nonatomic, strong) ModelHailuoAunt *model;

#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelHailuoAunt *)model;

@end

@interface HouseKeepingOrganizeCell : UITableViewCell

@property (strong, nonatomic) UIImageView *logo;
@property (strong, nonatomic) UILabel *name;
@property (strong, nonatomic) UILabel *age;
@property (strong, nonatomic) UILabel *rmb;
@property (strong, nonatomic) UIImageView *star;
@property (strong, nonatomic) UILabel *grade;
@property (strong, nonatomic) UILabel *comment;
@property (strong, nonatomic) UILabel *price;
@property (nonatomic, strong) ModelHailuoCompany *model;

#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelHailuoCompany *)model;

@end
