//
//  SecurityDetailView.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/18.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlaceHolderTextView.h"
#import "CommentStarView.h"
#import "YellowButton.h"
@interface SecurityDetailTopView : UIView
@property (nonatomic, strong) UILabel *problem;
@property (nonatomic, strong) UILabel *problemDetail;
@property (nonatomic, strong) UILabel *photo;

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelCommunityServiceList *)model;

@end

@interface SecurityDetailStatusView : UIView
//属性
@property (strong, nonatomic) UILabel *title;
@property (strong, nonatomic) UIView *labelBg;
@property (strong, nonatomic) UILabel *status;
@property (strong, nonatomic) UILabel *progress;

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelCommunityServiceList *)model;

@end

@interface SecurityDetailAddCommentView : UIView
//属性
@property (strong, nonatomic) UILabel *comment;
@property (strong, nonatomic) UILabel *satisfaction;
@property (strong, nonatomic) UILabel *content;
@property (strong, nonatomic) PlaceHolderTextView *textView;
@property (strong, nonatomic) UIView *viewBG;
@property (strong, nonatomic) CommentStarView *starView;
@property (strong, nonatomic) YellowButton *btn;
@property (nonatomic, strong) UIImageView *lineLeft;
@property (nonatomic, strong) UIImageView *lineRight;

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelCommunityServiceList *)model;

@end

@interface SecurityDetailCommentDetailView : UIView
//属性
@property (strong, nonatomic) UILabel *comment;
@property (strong, nonatomic) UILabel *satisfaction;
@property (strong, nonatomic) UILabel *content;
@property (strong, nonatomic) CommentStarView *starView;

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelCommunityServiceList *)model;

@end
