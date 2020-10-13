//
//  HailuoView.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/8/15.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HailuoFilterView : UIView
//属性
@property (strong, nonatomic) UILabel *filter0;
@property (strong, nonatomic) UILabel *filter1;
@property (strong, nonatomic) UIImageView *icon0;
@property (strong, nonatomic) UIImageView *icon1;
@property (nonatomic, assign) int indexSelected;
@property (nonatomic, strong) void (^blockIndexClick)(int);
@property (nonatomic, strong) void (^blockFilterClick)(void);

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model;

@end

@interface HailuoLabelView : UIView
//属性
@property (nonatomic, strong) UIScrollView *scAll;

@property (nonatomic, strong) void (^blockIndexClick)(int);
@property (nonatomic, strong) NSArray *aryDatas;

#pragma mark 刷新view
- (void)resetViewWithAry:(NSArray *)aryDatas;

@end
