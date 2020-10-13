//
//  HailuoAppointmentView.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/8/19.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlaceHolderTextView.h"

@interface HailuoAppointmentView : UIView<UITextViewDelegate>
@property (strong, nonatomic) PlaceHolderTextView *textView;
#pragma mark 刷新view
- (void)resetViewWithModel:(id)model;

@end
