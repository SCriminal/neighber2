//
//  HailuoAppointmentView.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/8/15.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentStarView.h"


@interface HailuoAuntResumeView : UIView

@property (strong, nonatomic) UIImageView *logo;
@property (strong, nonatomic) UILabel *name;
@property (strong, nonatomic) UILabel *age;
@property (strong, nonatomic) UILabel *rmb;
@property (strong, nonatomic) UILabel *label;
@property (strong, nonatomic) UIImageView *star;
@property (strong, nonatomic) UILabel *grade;
@property (strong, nonatomic) UILabel *comment;
@property (strong, nonatomic) UILabel *price;

#pragma mark 刷新cell
- (void)resetViewWithModel:(ModelHailuoAunt *)model;

@end

@interface HailuoAppointmentQualificationView : UIView
- (void)resetViewWithModel:(ModelHailuoAunt *)model;
@end

@interface HailuoAppointmentCommentView : UIView
@property (nonatomic, strong) UILabel *comment;

#pragma mark 刷新cell
- (void)resetViewWithModel:(ModelHailuoAunt *)model;

@end

@interface HailuoAppointmentCommentLabelView : UIView
@property (nonatomic, strong) UILabel *comment;
- (void)resetViewWithModel:(ModelHailuoAunt *)model;
@end

@interface HailuoAppointmentMoreView : UIView
@property (nonatomic, strong) UIButton *more;
@property (nonatomic, assign) BOOL isShowAll;
@property (nonatomic, strong) void (^blockMoreClick)(BOOL);

@end

@interface HailuoAppointmentCell : UITableViewCell

@property (strong, nonatomic) UIImageView *head;
@property (strong, nonatomic) UILabel *phone;
@property (strong, nonatomic) CommentStarView *starView;
@property (strong, nonatomic) UILabel *date;
@property (strong, nonatomic) UILabel *comment;
@property (nonatomic, strong) ModelHailuoComment *model;

#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelHailuoComment *)model;

@end

@interface HailuoAppointmentTraningView : UIView
@property (nonatomic, strong) NSArray *ary;

#pragma mark 刷新cell
- (void)resetViewWithAry:(NSArray *)ary;

@end
