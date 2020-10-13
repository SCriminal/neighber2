//
//  FJEducationVC.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/9/13.
//Copyright © 2020 ping. All rights reserved.
//

#import "BaseTableVC.h"
#import "BaseTableVC+Authority.h"
#import "ResumeSelfIntroduceView.h"
#import "YellowButton.h"
#import "ArchivePickView.h"
#import "RequestApi+FindJob.h"
#import "DatePicker.h"
#import "NSDate+YYAdd.h"

@interface FJEducationVC : BaseTableVC
@property (nonatomic, strong) ResumeSelfIntroduceView *textView;
@property (nonatomic, strong) UIView  *viewBottom;
@property (nonatomic, strong) ModelResumeDetail *modelResumeDetail;
@property (nonatomic, strong) ModelFJEducation *modelFJEducation;

@end
