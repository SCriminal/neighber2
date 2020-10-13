//
//  HailuoAppointmentSuccessView.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/8/17.
//Copyright © 2020 ping. All rights reserved.
//

#import "HailuoAppointmentSuccessView.h"

@interface HailuoAppointmentSuccessView ()

@end


@implementation HailuoAppointmentSuccessView
#pragma mark 懒加载
- (UILabel *)title{
    if (!_title) {
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(17) weight:UIFontWeightRegular];
        l.textColor = COLOR_333;
        l.backgroundColor = [UIColor clearColor];
        [l fitTitle:@"预约成功" variable:0];
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
        [_btn setTitle:@"查看订单" forState:UIControlStateNormal];
        [_btn setTitleColor:COLOR_ORANGE forState:UIControlStateNormal];
        [_btn addTarget:self action:@selector(confirmClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _btn;
}
- (UIView *)viewBG{
    if (!_viewBG) {
        _viewBG = [UIView new];
        _viewBG.backgroundColor = [UIColor whiteColor];
        _viewBG.widthHeight = XY(W(290), W(210));
        _viewBG.centerXCenterY = XY(SCREEN_WIDTH/2.0, SCREEN_HEIGHT/2.0);
        [_viewBG addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:10 lineWidth:1 lineColor:[UIColor clearColor]];
    }
    return _viewBG;
}
#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = COLOR_BLACK_ALPHA_PER60;
        [self addTarget:self action:@selector(hideKeyboard)];
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

  
            
    CGFloat top = self.viewBG.top + W(77);
    {
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        l.textColor = COLOR_333;
        l.backgroundColor = [UIColor clearColor];
        l.numberOfLines = 0;
        l.lineSpace = W(10);
        [l fitTitle:@"您的订单已经提交给商家，商家稍后将尽快和您联系，请耐心等待" variable:W(230)];
        l.centerXTop = XY(SCREEN_WIDTH/2.0, top );
        [self addSubview:l];
        top = l.bottom;
    }
    
    
    self.btn.centerXBottom = XY(SCREEN_WIDTH/2.0,self.viewBG.bottom );
    [self addLineFrame:CGRectMake(self.viewBG.left, self.btn.top, self.viewBG.width, 1)];
}

- (void)closeClick{
    [GlobalMethod endEditing];
    [GB_Nav popViewControllerAnimated:true];
}
- (void)confirmClick{
    if (self.blockConfirmClick) {
        self.blockConfirmClick();
    }
}
@end

