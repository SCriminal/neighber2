//
//  FindJobListView.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/8/31.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FindJobListCell : UITableViewCell
@property (strong, nonatomic) UIImageView *logo;
@property (strong, nonatomic) UILabel *jobName;
@property (strong, nonatomic) UILabel *price;
@property (strong, nonatomic) UILabel *companyName;
@property (strong, nonatomic) UILabel *detail;
@property (nonatomic, strong) UIView *label;
@property (nonatomic, strong) UIView *btn;

#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelFJJobList *)model;

@end


@interface FindJobFilterView : UIView
//属性
@property (strong, nonatomic) UILabel *filter0;
@property (strong, nonatomic) UILabel *filter1;
@property (strong, nonatomic) UILabel *filter2;
@property (strong, nonatomic) UIImageView *icon0;
@property (strong, nonatomic) UIImageView *icon1;
@property (strong, nonatomic) UIImageView *icon2;
@property (nonatomic, strong) void (^blockIndexClick)(int);
@property (nonatomic, strong) void (^blockFilterClick)(void);

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model;

@end


@interface FindJobFilterAllView : UIView

@property (nonatomic, strong) UIView *viewBG;
@property (nonatomic, strong) UIView *viewBlackAlpha;
@property (nonatomic, strong) UIButton *btnSearch;
@property (nonatomic, strong) UIButton *btnReset;
@property (nonatomic, strong) UILabel *select0;
@property (nonatomic, strong) UILabel *select1;
@property (nonatomic, strong) UILabel *select2;
@property (nonatomic, strong) UILabel *select3;
@property (nonatomic, strong) ModelBaseData *modelWorkProperty;
@property (nonatomic, strong) ModelBaseData *modelEducation;
@property (nonatomic, strong) ModelBaseData *modelWelfare;
@property (nonatomic, strong) ModelBaseData *modelRefreshDate;

@property (nonatomic, strong) void (^blockSelected)(int,int,int,int);
@property (nonatomic, assign) CGFloat viewTopHeight;
#pragma mark 刷新view
- (void)show;
- (void)configView;
@end
