//
//  HailuoFilterAlertView.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/8/15.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HailuoFilterAlertView : UIView

@property (nonatomic, strong) UIView *viewBG;
@property (nonatomic, strong) UIView *viewBlackAlpha;
@property (nonatomic, strong) UIButton *btnSearch;
@property (nonatomic, strong) UIButton *btnReset;
@property (nonatomic, strong) UITextField *tfAgeStart;
@property (nonatomic, strong) UITextField *tfAgeEnd;
@property (nonatomic, strong) UILabel *selectAddress;
@property (nonatomic, strong) UILabel *selectStartTime;
@property (nonatomic, strong) NSDate *dateStart;
@property (nonatomic, assign) long addressID;

@property (nonatomic, strong) void (^blockSearchClick)(long,NSDate* ,int ,int );

#pragma mark 刷新view
- (void)show;

@end
