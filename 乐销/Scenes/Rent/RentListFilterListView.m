//
//  RentListFilterListView.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/30.
//Copyright © 2020 ping. All rights reserved.
//

#import "RentListFilterListView.h"

@interface RentListFilterListView ()

@end

@implementation RentListFilterListView
- (UIScrollView *)scView{
    if (!_scView) {
         _scView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
               _scView.showsHorizontalScrollIndicator = NO;
               _scView.showsVerticalScrollIndicator = NO;
               _scView.backgroundColor = [UIColor clearColor];
               _scView.bounces = NO;
               _scView.contentSize = CGSizeMake(CGRectGetWidth(self.frame)*3, 0);
    }
    return _scView;
}
#pragma mark 刷新view
- (void)resetViewWithArys:(NSArray *)aryDatas top:(CGFloat)top{
    [self.scView removeAllSubViews];
    self.scView.top = top;
    self.scView.widthHeight = XY(SCREEN_WIDTH, SCREEN_HEIGHT - top-iphoneXBottomInterval);
    CGFloat y = 0;

    WEAKSELF
    for (int i = 0;i<aryDatas.count;i++) {
        NSString * strTitle = aryDatas[i];
        RentListFilterListItemView * item = [RentListFilterListItemView new];
        [item resetViewWithTitle:strTitle top:y];
        if (i == 0) {
            [item addLineFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
        }
        item.tag = i;
        item.blockSelected = ^(int index) {
            [weakSelf selectIndex:index];
            if (weakSelf.blockSelected) {
                weakSelf.blockSelected(index);
            }
            [weakSelf removeFromSuperview];
        };
        [self.scView addSubview:item];
        y = item.bottom;
    }
    [self selectIndex:0];
    self.scView.contentSize = CGSizeMake(0, y);
}
- (void)selectIndex:(int)index{
    for (RentListFilterListItemView * subView in self.scView.subviews) {
        if ([subView isKindOfClass:RentListFilterListItemView.class]) {
            [subView configSelected:subView.tag == index];
        }
    }
}
#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];//背景色
        self.width = SCREEN_WIDTH;//默认宽度
        self.height = SCREEN_HEIGHT;
        [self addSubview:self.scView];
        [self addTarget:self action:@selector(hideClick)];
    }
    return self;
}

#pragma mark click
- (void)hideClick{
    [self removeFromSuperview];
}


@end



@implementation RentListFilterListItemView
#pragma mark 懒加载
- (UILabel *)title{
    if (_title == nil) {
        _title = [UILabel new];
        _title.textColor = COLOR_333;
        _title.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
    }
    return _title;
}
- (UIImageView *)iconSelected{
    if (_iconSelected == nil) {
        _iconSelected = [UIImageView new];
        _iconSelected.image = [UIImage imageNamed:@"select_default"];
        _iconSelected.highlightedImage = [UIImage imageNamed:@"select_highlighted"];

        _iconSelected.widthHeight = XY(W(19),W(19));
    }
    return _iconSelected;
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.width = SCREEN_WIDTH;
        [self addSubView];
        [self addTarget:self action:@selector(click)];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.title];
    [self addSubview:self.iconSelected];
    
}

#pragma mark 刷新view
- (void)resetViewWithTitle:(NSString *)title top:(CGFloat)top{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    [self.title fitTitle:title variable:0];
    self.top = top;
    self.title.leftTop = XY(W(25),W(18));
    

    self.iconSelected.rightCenterY = XY(SCREEN_WIDTH - W(25),self.title.centerY);
    
    //设置总高度
    self.height = self.title.bottom + self.title.top;
    [self addLineFrame:CGRectMake(0, self.height - 1, SCREEN_WIDTH, 1)];
}
#pragma mark click
- (void)click{
    if (self.blockSelected) {
        self.blockSelected((int)self.tag);
    }
}
- (void)configSelected:(BOOL)selected{
    self.iconSelected.highlighted = selected;
    self.title.textColor = selected?COLOR_ORANGE:COLOR_333;
}

@end
