//
//  RentListFilterListView.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/30.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RentListFilterListView : UIView
@property (nonatomic, strong) UIScrollView *scView;

@property (nonatomic, strong) void (^blockSelected)(int);

#pragma mark 刷新view
- (void)resetViewWithArys:(NSArray *)aryDatas top:(CGFloat)top;
- (void)selectIndex:(int)index;
@end

@interface RentListFilterListItemView : UIView
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UIImageView *iconSelected;
@property (nonatomic, strong) void (^blockSelected)(int);


#pragma mark 刷新view
- (void)resetViewWithTitle:(NSString *)title top:(CGFloat)top;
- (void)configSelected:(BOOL)selected;
@end
