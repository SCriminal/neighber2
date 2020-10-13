//
//  FJResumeDetailListView.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/9/16.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FJResumeDetailView.h"

@interface FJResumeDetailEducationView : UIView
@property (nonatomic, strong) FJResumeDetailAddView *addView;
@property (nonatomic, strong) ModelResumeDetail *model;
@property (nonatomic, strong) void (^blockEdit)(ModelFJEducation *);
@property (nonatomic, strong) void (^blockDelete)(ModelFJEducation *);

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelResumeDetail *)model;

@end

@interface FJResumeDetailWorkView : UIView
@property (nonatomic, strong) FJResumeDetailAddView *addView;
@property (nonatomic, strong) ModelResumeDetail *model;
@property (nonatomic, strong) void (^blockEdit)(ModelFJWorkExperience *);
@property (nonatomic, strong) void (^blockDelete)(ModelFJWorkExperience *);

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelResumeDetail *)model;

@end

@interface FJResumeDetailTrainView : UIView
@property (nonatomic, strong) FJResumeDetailAddView *addView;
@property (nonatomic, strong) ModelResumeDetail *model;
@property (nonatomic, strong) void (^blockEdit)(ModelJFTrainexperience *);
@property (nonatomic, strong) void (^blockDelete)(ModelJFTrainexperience *);

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelResumeDetail *)model;

@end

@interface FJResumeDetailProjectView : UIView
@property (nonatomic, strong) FJResumeDetailAddView *addView;
@property (nonatomic, strong) ModelResumeDetail *model;
@property (nonatomic, strong) void (^blockEdit)(ModelFJProjectExp *);
@property (nonatomic, strong) void (^blockDelete)(ModelFJProjectExp *);

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelResumeDetail *)model;

@end

@interface FJResumeDetailCredientView : UIView
@property (nonatomic, strong) FJResumeDetailAddView *addView;
@property (nonatomic, strong) ModelResumeDetail *model;
@property (nonatomic, strong) void (^blockEdit)(ModelFJCredentExp *);
@property (nonatomic, strong) void (^blockDelete)(ModelFJCredentExp *);

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelResumeDetail *)model;

@end

@interface FJResumeDetailLanguageView : UIView
@property (nonatomic, strong) FJResumeDetailAddView *addView;
@property (nonatomic, strong) ModelResumeDetail *model;
@property (nonatomic, strong) void (^blockEdit)(ModelFJLanguageExp *);
@property (nonatomic, strong) void (^blockDelete)(ModelFJLanguageExp *);

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelResumeDetail *)model;

@end
