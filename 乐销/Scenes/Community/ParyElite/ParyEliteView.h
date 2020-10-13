//
//  ParyEliteView.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/11.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YellowButton.h"
//switch view
#import "SwitchView.h"
#import "PlaceHolderTextView.h"

@interface ParyEliteTopView : UIView
@property (strong, nonatomic) UIView *whiteBG;

@end



@interface ParyEliteBottomView : UIView<UITextViewDelegate>
//属性
@property (strong, nonatomic) UILabel *label0;
@property (strong, nonatomic) UILabel *label1;
@property (strong, nonatomic) UILabel *label2;
@property (strong, nonatomic) PlaceHolderTextView *textView;
@property (strong, nonatomic) PlaceHolderTextView *textView1;
@property (strong, nonatomic) UIImageView *ivLeft;
@property (strong, nonatomic) UIImageView *ivRight;
@property (strong, nonatomic) UITextView *alert;
@property (strong, nonatomic) UIImageView *iconAlert;
@property (nonatomic, strong) YellowButton  *btnBottom;
@property (nonatomic, strong) UIImageView *ivSelected;

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model;

@end

@interface  ParyEliteStatusView : UIView
//属性
@property (nonatomic, strong) void (^blockResubmitClick)(void);

#pragma mark 刷新view
- (void)resetViewWithState:(int)state model:(ModelPartyElite* )model;

@end
