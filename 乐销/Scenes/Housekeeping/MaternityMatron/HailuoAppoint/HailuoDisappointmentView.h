//
//  HailuoDisappointmentView.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/8/17.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HailuoDisappointmentView : UIView<UITextFieldDelegate>
@property (strong, nonatomic) UIView *viewBG;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UIImageView *close;
@property (strong, nonatomic) UIButton *btn;
@property (nonatomic, assign) int indexSelected;
@property (nonatomic, strong) void (^blockConfirmClick)(NSString *);

@end
