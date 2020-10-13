//
//  HailuoCompanyView.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/8/15.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentStarView.h"


@interface HailuoCompanyInfoView : UIView

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
- (void)resetViewWithModel:(ModelHailuoCompany *)model;

@end

@interface HailuoCompanyQualificationView : UIView
- (void)resetViewWithModel:(ModelHailuoCompany *)model;
@end

@interface HailuoCompanyAddressView : UIView
@property (nonatomic, strong) UILabel *address;
@property (nonatomic, strong) UILabel *phone;
@property (nonatomic, strong) UIImageView *iconPhone;
@property (nonatomic, strong) UIImageView *iconAddress;

#pragma mark 刷新cell
- (void)resetViewWithModel:(ModelHailuoCompany *)model;

@end

@interface HailuoCompanyServeView : UIView
@property (nonatomic, strong) NSArray *aryModels;
@property (nonatomic, strong) void (^blockServeClick)(ModelHailuoCompanyServe *);

#pragma mark 刷新cell
- (void)resetViewWithModel:(NSArray *)aryModels;

@end

@interface HailuoCompanyCell : UITableViewCell

@property (strong, nonatomic) UIImageView *head;
@property (strong, nonatomic) UILabel *phone;
@property (strong, nonatomic) CommentStarView *starView;
@property (strong, nonatomic) UILabel *date;
@property (strong, nonatomic) UILabel *comment;
@property (nonatomic, strong) ModelHailuoComment *model;

#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelHailuoComment *)model;

@end


