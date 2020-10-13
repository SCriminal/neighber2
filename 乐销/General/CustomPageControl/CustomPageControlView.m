//
//  CustomPageControlView.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/6/17.
//Copyright © 2020 ping. All rights reserved.
//

#import "CustomPageControlView.h"

@interface CustomPageControlView ()

@end

@implementation CustomPageControlView

#pragma mark 刷新view
- (void)resetViewWithNum:(int)num{
    [self removeAllSubViews];
    CGFloat left = 0;
    for (int i = 0; i< num; i++) {
        UIView * viewItem = [UIView new];
        viewItem.frame = CGRectMake(left, 0, W(8), W(2));
        [viewItem addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:1 lineWidth:0 lineColor:[UIColor clearColor]];
        viewItem.tag = i;
        left = viewItem.right + W(3);
        [self addSubview:viewItem];
        self.width = viewItem.right;
        self.height = viewItem.height;
    }
    [self setIndex:0];
}
- (void)setIndex:(int)index{
    for (UIView * view in self.subviews) {
        view.backgroundColor = view.tag == index?COLOR_ORANGE:[UIColor colorWithHexString:@"#E7E7E7"];
    }
}
#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];//背景色
    }
    return self;
}


@end
