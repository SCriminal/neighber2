//
//  FindJobMainView.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/8/27.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface FindJobNewsView : UIView

@property (nonatomic, assign) BOOL isClickValid;//is can click show big image
@property (nonatomic, strong) NSMutableArray * aryDatas;
@property int numNow;
//定时器
@property (nonatomic, strong) NSTimer * timer;
@property (nonatomic) int numTime;
//点击
@property (nonatomic, strong) void (^blockClick)(int index);

- (void)resetWithAry:(NSArray *)aryImage;

//开启定时器
- (void)timerStart;
//关闭定时器
- (void)timerStop;

@end

@interface FindJobNewsCell : UITableViewCell

@property (strong, nonatomic) UILabel *jobName;
@property (strong, nonatomic) UILabel *price;
@property (strong, nonatomic) UILabel *address;
@property (strong, nonatomic) UIImageView *logo;
@property (strong, nonatomic) UILabel *companyName;

#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelFJJobList *)model;

@end
