//
//  WhistleDetailView.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/18.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlaceHolderTextView.h"
#import "CommentSelectView.h"
#import "YellowButton.h"
@interface WhistleDetailTopView : UIView
@property (nonatomic, strong) UILabel *problem;
@property (nonatomic, strong) UILabel *problemDetail;
@property (nonatomic, strong) UILabel *type;
@property (nonatomic, strong) UILabel *typeDetail;

@property (nonatomic, strong) UILabel *photo;

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelWhistleList *)model;

@end

@interface WhistleDetailStatusView : UIView
//属性
@property (strong, nonatomic) UILabel *title;
@property (strong, nonatomic) UIView *labelBg;
@property (strong, nonatomic) UILabel *status;
@property (strong, nonatomic) UILabel *progress;
@property (nonatomic, strong) ModelWhistleList *model;

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelWhistleList *)model;

@end

@interface WhistleDetailAddCommentView : UIView
//属性
@property (strong, nonatomic) UILabel *comment;
@property (strong, nonatomic) UILabel *satisfaction;
@property (strong, nonatomic) UILabel *content;
@property (strong, nonatomic) PlaceHolderTextView *textView;
@property (strong, nonatomic) UIView *viewBG;
@property (strong, nonatomic) CommentSelectView *starView;
@property (strong, nonatomic) YellowButton *btn;
@property (nonatomic, strong) UIImageView *lineLeft;
@property (nonatomic, strong) UIImageView *lineRight;

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelWhistleList *)model;

@end

@interface WhistleDetailCommentDetailView : UIView
//属性
@property (strong, nonatomic) UILabel *comment;
@property (strong, nonatomic) UILabel *satisfaction;
@property (strong, nonatomic) UILabel *content;
@property (strong, nonatomic) UILabel *starView;

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelWhistleList *)model;

@end
