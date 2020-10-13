//
//  InputNumView.h
//  Driver
//
//  Created by 隋林栋 on 2019/4/17.
//Copyright © 2019 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectArchiveAlertView : UIView
@property (nonatomic, strong) UIView *viewBG;
@property (nonatomic, strong) UILabel *labelInput;
@property (nonatomic, strong) UIImageView *ivClose;
@property (nonatomic, strong) UIView *viewBorder;
@property (nonatomic, strong) UIButton *btnSubmit;
@property (nonatomic, strong) void (^blockComplete)(ModelArchiveList *);
@property (nonatomic, strong) ModelArchiveList *packageSelect;

@property (nonatomic, strong) UIImageView *ivDown;
@property (nonatomic, strong) UIView *viewDownBorder;
@property (nonatomic, strong) UILabel *labelTitle;
@property (nonatomic, strong) NSArray *aryDatas;

#pragma mark 刷新view
- (void)showWithAry:(NSArray *)ary;
@end

