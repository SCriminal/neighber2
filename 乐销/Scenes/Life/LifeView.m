//
//  LifeView.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/8/10.
//Copyright © 2020 ping. All rights reserved.
//

#import "LifeView.h"

@interface LifeFoldView ()
@property (nonatomic, strong) UILabel *title;

@end

@implementation LifeFoldView

- (UIImageView *)iconFold{
    if (!_iconFold) {
        _iconFold = [UIImageView new];
        UIImageView * iv = [UIImageView new];
        iv.backgroundColor = [UIColor clearColor];
        iv.contentMode = UIViewContentModeScaleAspectFill;
        iv.clipsToBounds = true;
        iv.highlightedImage = [UIImage imageNamed:@"arrowLifeUp"];
        iv.image = [UIImage imageNamed:@"arrowLifeDown"];
        iv.widthHeight = XY(W(12),W(12));
        _iconFold = iv;
    }
    return _iconFold;
}
- (UILabel *)title{
    if (!_title) {
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        l.textColor = COLOR_333;
        [l fitTitle:@"全部应用" variable:SCREEN_WIDTH - W(30)];
        _title = l;
    }
    return _title;
}


#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];//背景色
        self.width = SCREEN_WIDTH;//默认宽度
        [self addSubView];//添加子视图
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.title];
    [self addSubview:self.iconFold];
    //初始化页面
    [self configView];
    [self addTarget:self action:@selector(click)];
}
#pragma mark 刷新view
- (void)configView{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //重置视图坐标
    self.title.centerXTop = XY(self.width/2.0, 0);
    self.iconFold.leftCenterY = XY(self.title.right + W(7), self.title.centerY);
    self.height = self.title.bottom + W(20);
}
#pragma mark click
- (void)click{
    if (self.blockClick) {
        self.blockClick();
    }
}
- (void)resetTitle:(NSString *)title{
    [self.title fitTitle:title variable:0];
    [self configView];
}

@end
