//
//  HailuoView.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/8/15.
//Copyright © 2020 ping. All rights reserved.
//

#import "HailuoServiceListView.h"

@implementation HailuoFilterView
#pragma mark 懒加载
- (UILabel *)filter0{
    if (_filter0 == nil) {
        _filter0 = [UILabel new];
        _filter0.textColor = COLOR_333;
        _filter0.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        [_filter0 fitTitle:@"订单数" variable:0];
    }
    return _filter0;
}
- (UILabel *)filter1{
    if (_filter1 == nil) {
        _filter1 = [UILabel new];
        _filter1.textColor = COLOR_333;
        _filter1.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        [_filter1 fitTitle:@"满意度" variable:0];

    }
    return _filter1;
}
- (UIImageView *)icon0{
    if (_icon0 == nil) {
        _icon0 = [UIImageView new];
        _icon0.image = [UIImage imageNamed:@"arrow_down_default"];
        _icon0.highlightedImage = [UIImage imageNamed:@"arrow_down_selected"];
        _icon0.widthHeight = XY(W(15),W(15));
    }
    return _icon0;
}
- (UIImageView *)icon1{
    if (_icon1 == nil) {
        _icon1 = [UIImageView new];
        _icon1.image = [UIImage imageNamed:@"arrow_down_default"];
        _icon1.highlightedImage = [UIImage imageNamed:@"arrow_down_selected"];
        _icon1.widthHeight = XY(W(15),W(15));
    }
    return _icon1;
}


#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.width = SCREEN_WIDTH;
        [self addSubView];
    }
    return self;
}
//添加subview
- (void)addSubView{
        [self addSubview:self.filter0];
    [self addSubview:self.filter1];
        [self addSubview:self.icon0];
    [self addSubview:self.icon1];
    self.filter0.leftTop = XY(W(15),W(20));
    self.icon0.leftCenterY = XY(self.filter0.right + W(2), self.filter0.centerY);
      
    self.filter1.leftCenterY = XY(self.icon0.right + W(30),self.filter0.centerY);
    self.icon1.leftCenterY = XY(self.filter1.right + W(2), self.filter0.centerY);

    UIImageView * iv = [UIImageView new];
    iv.backgroundColor = [UIColor clearColor];
    iv.contentMode = UIViewContentModeScaleAspectFill;
    iv.clipsToBounds = true;
    iv.image = [UIImage imageNamed:@"houseKeeping_filter"];
    iv.widthHeight = XY(W(15),W(15));
    iv.rightCenterY = XY(SCREEN_WIDTH - W(15),self.filter0.centerY);
    [self addSubview:iv];
    
    UILabel * l = [UILabel new];
    l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
    l.textColor = COLOR_333;
    l.backgroundColor = [UIColor clearColor];
    l.numberOfLines = 0;
    l.lineSpace = W(0);
    [l fitTitle:@"筛选" variable:SCREEN_WIDTH - W(30)];
    l.rightCenterY = XY(iv.left - W(2), iv.centerY);
    [self addSubview:l];
    


    //设置总高度
    self.height = self.filter0.bottom + W(15);
    [self addControlFrame:CGRectMake(0, 0, self.icon0.right + W(15), self.height) target:self action:@selector(leftClick)];
    [self addControlFrame:CGRectMake(self.filter1.left - W(15), 0, self.icon0.right + W(15), self.height) target:self action:@selector(rightClick)];
    [self addControlFrame:CGRectMake(SCREEN_WIDTH - W(80), 0,  W(80), self.height) target:self action:@selector(filterClick)];

    [self leftClick];
}

#pragma mark click
- (void)leftClick{
    self.filter0.textColor = COLOR_333;
    self.filter0.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightMedium];
    self.icon0.highlighted = true;
    self.filter1.textColor = COLOR_666;
    self.filter1.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
    self.icon1.highlighted = false;
    if (self.blockIndexClick) {
        self.blockIndexClick(0);
    }
}
- (void)rightClick{
    self.filter1.textColor = COLOR_333;
    self.filter1.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightMedium];
    self.icon1.highlighted = true;
    self.filter0.textColor = COLOR_666;
    self.filter0.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
    self.icon0.highlighted = false;

    if (self.blockIndexClick) {
        self.blockIndexClick(1);
    }
}
- (void)filterClick{
    if (self.blockFilterClick) {
        self.blockFilterClick();
    }
}
#pragma mark 刷新view
- (void)resetViewWithModel:(id)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view

    
}

@end


@implementation HailuoLabelView
#pragma mark 懒加载
- (UIScrollView *)scAll{
    if (!_scAll) {
        _scAll = [UIScrollView new];
               _scAll.showsVerticalScrollIndicator = false;
               _scAll.showsHorizontalScrollIndicator = false;
               _scAll.backgroundColor = [UIColor clearColor];
        _scAll.widthHeight = XY(SCREEN_WIDTH, self.height);
        
    }
    return _scAll;
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.width = SCREEN_WIDTH;
        self.height = W(37);
        [self addSubView];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.scAll];

    
}
- (void)viewClick:(UITapGestureRecognizer *)tap{
    [self viewSelected:(int)tap.view.tag-200];
    if (self.blockIndexClick) {
        ModelIntegralProduct * model = self.aryDatas[tap.view.tag-200];
        self.blockIndexClick(model.iDProperty);
    }
}
- (void)viewSelected:(int)tag{
    for (int i = 0; i<10; i++) {
        UILabel * label = [self.scAll viewWithTag:100+i];
        if (label && [label isKindOfClass:[UILabel class]]) {
            label.textColor = COLOR_999;
        }
        UIView * view = [self.scAll viewWithTag:200+i];
        if (view && [view isKindOfClass:[UIView class]]) {
            view.backgroundColor  = [UIColor colorWithHexString:@"#FCFCFC"];
            [view removeCorner];
            [view addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:5 lineWidth:0 lineColor:[UIColor colorWithHexString:@"#EFF2F1"]];
        }
    }
    
    UILabel * label = [self.scAll viewWithTag:100+tag];
           if (label && [label isKindOfClass:[UILabel class]]) {
               label.textColor = COLOR_ORANGE;
           }
           UIView * view = [self.scAll viewWithTag:200+tag];
           if (view && [view isKindOfClass:[UIView class]]) {
               view.backgroundColor  = [UIColor colorWithHexString:@"#FDF9F0"];
               [view removeCorner];
               [view addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:5 lineWidth:0 lineColor:COLOR_ORANGE];
           }
}

#pragma mark 刷新view
- (void)resetViewWithAry:(NSArray *)aryDatas{
    self.aryDatas = aryDatas;
    
    CGFloat left = 0;
    for (int i = 0; i<aryDatas.count; i++) {
        ModelIntegralProduct * model = aryDatas[i];
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
        l.textColor = COLOR_ORANGE;
        l.backgroundColor = [UIColor clearColor];
        [l fitTitle:UnPackStr(model.name) variable:0];
        l.tag = 100+i;
        [self.scAll addSubview:l];

        UIView * view = [UIView new];
        view.widthHeight = XY(l.width + W(40), W(37));
        view.leftTop = XY(left + W(15), 0);
        l.center = view.center;
        [self.scAll insertSubview:view belowSubview:l];
        view.tag = 200+i;
        [view addTarget:self action:@selector(viewClick:)];
        left = l.right;
    }
    self.scAll.contentSize = CGSizeMake(left+ W(20), 0);
    [self viewSelected:0];
}

@end

