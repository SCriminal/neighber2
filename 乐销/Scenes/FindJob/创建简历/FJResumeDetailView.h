//
//  FJResumeDetailView.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/9/16.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FJResumeDetailAddView : UIView
@property (nonatomic, strong) void (^blockAdd)(void);

#pragma mark 刷新view
- (void)resetViewWithTitle:(NSString *)title iconView:(NSString *)icon;
- (void)resetViewWithTitle:(NSString *)title iconView:(NSString *)icon isEdit:(BOOL)isEdit;
@end

@interface FJResumeDetailJobintentionView : UIView
@property (nonatomic, strong) FJResumeDetailAddView *addView;
@property (nonatomic, strong) ModelResumeDetail *model;

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelResumeDetail *)model;

@end

@interface FJResumeDetailTopInfoView : UIView
@property (nonatomic, strong) ModelResumeDetail *model;
@property (nonatomic, strong) void (^blockAdd)(void);

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelResumeDetail *)model;

@end

@interface FJResumeDetailIntroduceView : UIView
@property (nonatomic, strong) FJResumeDetailAddView *addView;

@property (nonatomic, strong) ModelResumeDetail *model;

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelResumeDetail *)model;

@end
