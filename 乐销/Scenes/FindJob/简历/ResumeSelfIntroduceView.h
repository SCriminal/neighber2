//
//  ResumeSelfIntroduceView.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/9/13.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlaceHolderTextView.h"

@interface ResumeSelfIntroduceView : UIView<UITextViewDelegate>
@property (strong, nonatomic) PlaceHolderTextView *textView;
@property (strong, nonatomic) UILabel *problemDescription;


@end
