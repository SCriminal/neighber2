//
//  EhomeBindAlertView.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/11/9.
//Copyright © 2020 ping. All rights reserved.
//

#import "EhomeBindAlertView.h"

@interface EhomeBindAlertView ()

@end

@implementation EhomeBindAlertView
#pragma mark 懒加载
- (UILabel *)title{
    if (!_title) {
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(17) weight:UIFontWeightRegular];
        l.textColor = COLOR_333;
        l.backgroundColor = [UIColor clearColor];
        [l fitTitle:@"房屋绑定" variable:0];
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
        _btn.widthHeight = XY(W(290)/2.0, W(55));
        [_btn setBackgroundColor:[UIColor clearColor]];
        _btn.titleLabel.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        [_btn setTitle:@"同意" forState:UIControlStateNormal];
        [_btn setTitleColor:COLOR_ORANGE forState:UIControlStateNormal];
        [_btn addTarget:self action:@selector(confirmClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _btn;
}
- (UIButton *)btnClose{
    if (!_btnClose) {
        _btnClose = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnClose.widthHeight = XY(W(290)/2.0, W(55));
        [_btnClose setBackgroundColor:[UIColor clearColor]];
        _btnClose.titleLabel.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        [_btnClose setTitle:@"错失服务" forState:UIControlStateNormal];
        [_btnClose setTitleColor:COLOR_999 forState:UIControlStateNormal];
        [_btnClose addTarget:self action:@selector(closeClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnClose;
}
- (UIView *)viewBG{
    if (!_viewBG) {
        _viewBG = [UIView new];
        _viewBG.backgroundColor = [UIColor whiteColor];
        _viewBG.widthHeight = XY(W(290), W(210));
        _viewBG.centerXCenterY = XY(SCREEN_WIDTH/2.0, SCREEN_HEIGHT/2.0);
        [GlobalMethod setRoundView:_viewBG color:[UIColor clearColor] numRound:10 width:0];
    }
    return _viewBG;
}
#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
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
    [self.viewBG addSubview:self.title];
//    [self.viewBG addSubview:self.close];
    [self.viewBG addSubview:self.btn];
    [self.viewBG addSubview:self.btnClose];
    //初始化页面
}
#pragma mark 刷新view
- (void)resetViewWithModel:(ModelEhomeHomeItem *)model{
    self.model = model;
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    
    self.title.centerXTop = XY(self.width/2.0,  W(25));
    
//    self.close.rightTop = XY(SCREEN_WIDTH - W(58.5), self.viewBG.top + W(21));
//    [self addControlFrame:CGRectInset(self.close.frame, -W(10), -W(10)) belowView:self.close target:self action:@selector(closeClick)];

  
            
    CGFloat top = W(77);
    {
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        l.textColor = COLOR_333;
        l.backgroundColor = [UIColor clearColor];
        l.numberOfLines = 0;
        l.lineSpace = W(10);
        [l fitTitle:[NSString stringWithFormat:@"%@%@%@单元%@",model.areaName,model.floorName,model.unitNo,model.roomNo] variable:W(230)];
        l.centerXTop = XY(self.viewBG.width/2.0, top );
        [self.viewBG addSubview:l];
        top = l.bottom;
    }
    top = [self.viewBG addLineFrame:CGRectMake(W(30), top + W(20), self.viewBG.width - W(60), 1)] + W(19);
     {
           UILabel * l = [UILabel new];
           l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
           l.textColor = COLOR_333;
           l.backgroundColor = [UIColor clearColor];
           l.numberOfLines = 0;
           l.lineSpace = W(10);
           [l fitTitle:[NSString stringWithFormat:@"尊敬的%@业主，为了方便您通过潍社区实现获取物业服务，您是否同意获取并绑定房屋信息档案？",model.clientName] variable:W(230)];
         l.centerXTop = XY(self.viewBG.width/2.0, top );
         [self.viewBG addSubview:l];
           top = l.bottom;
       }
    self.viewBG.height = top + W(91);
    
    self.btnClose.leftBottom = XY(0,self.viewBG.height );
    self.btn.rightBottom = XY(self.viewBG.width, self.viewBG.height);
    [self.viewBG addLineFrame:CGRectMake(self.viewBG.left, self.btn.top, self.viewBG.width, 1)];
    [self.viewBG addLineFrame:CGRectMake(self.btn.right, self.btn.top + W(17.5), 1, W(20))];

}

- (void)closeClick{
    [GlobalMethod endEditing];
    [self removeFromSuperview];
}
- (void)confirmClick{
    if (self.blockConfirmClick) {
        self.blockConfirmClick(self.model);
    }
    [self removeFromSuperview];

}
@end
