//
//  HailuoDisappointmentView.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/8/17.
//Copyright © 2020 ping. All rights reserved.
//

#import "HailuoDisappointmentView.h"

@interface HailuoDisappointmentView ()
@property (nonatomic, strong) NSArray *aryTitles;

@end

@implementation HailuoDisappointmentView
#pragma mark 懒加载
- (UILabel *)title{
    if (!_title) {
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(17) weight:UIFontWeightRegular];
        l.textColor = COLOR_333;
        l.backgroundColor = [UIColor clearColor];
        [l fitTitle:@"申请取消" variable:0];
        _title = l;
    }
    return _title;
}
- (UIImageView *)close{
    if (!_close) {
        UIImageView * iv = [UIImageView new];
        iv.backgroundColor = [UIColor clearColor];
        iv.image = [UIImage imageNamed:@"inputClose"];
        iv.widthHeight = XY(W(25),W(25));
        _close = iv;
    }
    return _close;
}
- (UIButton *)btn{
    if (!_btn) {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.widthHeight = XY(W(290), W(55));
        [_btn setBackgroundColor:[UIColor clearColor]];
        _btn.titleLabel.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        [_btn setTitle:@"确认取消" forState:UIControlStateNormal];
        [_btn setTitleColor:COLOR_ORANGE forState:UIControlStateNormal];
        [_btn addTarget:self action:@selector(confirmClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _btn;
}
- (UIView *)viewBG{
    if (!_viewBG) {
        _viewBG = [UIView new];
        _viewBG.backgroundColor = [UIColor whiteColor];
        _viewBG.widthHeight = XY(W(290), W(367));
        _viewBG.centerXCenterY = XY(SCREEN_WIDTH/2.0, SCREEN_HEIGHT/2.0);
        [_viewBG addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:10 lineWidth:1 lineColor:[UIColor clearColor]];
    }
    return _viewBG;
}
#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.aryTitles =      @[@"我不想买了",@"信息填写错误，重新下单",@"订单无人处理",@"重复下单",@"其他原因"];
        self.backgroundColor = COLOR_BLACK_ALPHA_PER60;
        self.width = SCREEN_WIDTH;
        self.height = SCREEN_HEIGHT;
        [self addSubView];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.viewBG];
    [self addSubview:self.title];
    [self addSubview:self.close];
    [self addSubview:self.btn];
    //初始化页面
    [self resetViewWithModel:nil];
}
#pragma mark 刷新view
- (void)resetViewWithModel:(id)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    
    self.title.centerXTop = XY(SCREEN_WIDTH/2.0, self.viewBG.top + W(25));
    
    self.close.rightTop = XY(SCREEN_WIDTH - W(58.5), self.viewBG.top + W(21));
    [self addControlFrame:CGRectInset(self.close.frame, -W(10), -W(10)) belowView:self.close target:self action:@selector(closeClick)];

  
            
    CGFloat top = self.viewBG.top + W(62);
   
    for (int i = 0; i<self.aryTitles.count; i++) {
        UIView * view = [self addControlFrame:CGRectMake(self.viewBG.left, top, self.viewBG.width, W(45)) target:self action:@selector(reasonClick:)];
        view.tag = 100+i;
        
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        l.textColor = COLOR_333;
        l.backgroundColor = [UIColor clearColor];
        [l fitTitle:self.aryTitles[i] variable:SCREEN_WIDTH - W(30)];
        l.leftCenterY = XY(self.viewBG.left + W(25), view.centerY);
        [self addSubview:l];
        top = view.bottom;
        
        UIImageView * iv = [UIImageView new];
        iv.backgroundColor = [UIColor clearColor];
        iv.contentMode = UIViewContentModeScaleAspectFill;
        iv.clipsToBounds = true;
        iv.image = [UIImage imageNamed:@"select_default"];
        iv.highlightedImage = [UIImage imageNamed:@"select_highlighted"];
        iv.widthHeight = XY(W(15),W(15));
        iv.rightCenterY = XY(self.viewBG.right - W(25),view.centerY);
        iv.tag = 200 + i;
        [self addSubview:iv];
        top = view.bottom;
    }
    
    
    self.btn.centerXBottom = XY(SCREEN_WIDTH/2.0,self.viewBG.bottom );
    [self addLineFrame:CGRectMake(self.viewBG.left, self.btn.top, self.viewBG.width, 1)];
}

-(void)reasonClick:(UIView *)view{
    self.indexSelected = view.tag - 100;
    for (int i = 0; i<5; i++) {
        UIImageView * iv = [self viewWithTag:200+i];
           if ([iv isKindOfClass:UIImageView.class]) {
               iv.highlighted = false;
           }
    }
    UIImageView * iv = [self viewWithTag:view.tag + 100];
    if ([iv isKindOfClass:UIImageView.class]) {
        iv.highlighted = true;
    }
}
- (void)closeClick{
    [GlobalMethod endEditing];
    [self removeFromSuperview];
}
- (void)confirmClick{
    if (self.blockConfirmClick) {
        self.blockConfirmClick(self.aryTitles[self.indexSelected]);
    }
    [self removeFromSuperview];
}
@end

