//
//  SelectPaymentView.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/4/21.
//Copyright © 2020 ping. All rights reserved.
//

#import "SelectPaymentView.h"

@interface SelectPaymentView ()

@end

@implementation SelectPaymentView
#pragma mark 懒加载
- (UIView *)BG{
    if (!_BG) {
        _BG = [UIView new];
        _BG.backgroundColor = [UIColor whiteColor];
    }
    return _BG;
}
- (UILabel *)select{
    if (_select == nil) {
        _select = [UILabel new];
        _select.textColor = COLOR_333;
        _select.font =  [UIFont systemFontOfSize:F(17) weight:UIFontWeightMedium];
        [_select fitTitle:@"选择支付方式" variable:0];
    }
    return _select;
}
- (UILabel *)wechat{
    if (_wechat == nil) {
        _wechat = [UILabel new];
        _wechat.textColor = COLOR_333;
        _wechat.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        [_wechat fitTitle:@"微信支付" variable:0];
    }
    return _wechat;
}
- (UILabel *)ali{
    if (_ali == nil) {
        _ali = [UILabel new];
        _ali.textColor = COLOR_333;
        _ali.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        [_ali fitTitle:@"支付宝支付" variable:0];

    }
    return _ali;
}
- (UIImageView *)close{
    if (_close == nil) {
        _close = [UIImageView new];
        _close.image = [UIImage imageNamed:@"inputClose"];
        _close.widthHeight = XY(W(25),W(25));
    }
    return _close;
}
- (UIImageView *)iconWeChat{
    if (_iconWeChat == nil) {
        _iconWeChat = [UIImageView new];
        _iconWeChat.image = [UIImage imageNamed:@"payment_wechat"];
        _iconWeChat.widthHeight = XY(W(17),W(17));
    }
    return _iconWeChat;
}
- (UIImageView *)iconAli{
    if (_iconAli == nil) {
        _iconAli = [UIImageView new];
        _iconAli.image = [UIImage imageNamed:@"payment_ali"];
        _iconAli.widthHeight = XY(W(17),W(17));
    }
    return _iconAli;
}
- (UIImageView *)iconWeChatSelect{
    if (_iconWeChatSelect == nil) {
        _iconWeChatSelect = [UIImageView new];
        _iconWeChatSelect.image = [UIImage imageNamed:@"select_default"];
        _iconWeChatSelect.highlightedImage = [UIImage imageNamed:@"select_highlighted"];
        _iconWeChatSelect.highlighted = true;
        _iconWeChatSelect.widthHeight = XY(W(15),W(15));
    }
    return _iconWeChatSelect;
}
- (UIImageView *)iconAliSelect{
    if (_iconAliSelect == nil) {
        _iconAliSelect = [UIImageView new];
        _iconAliSelect.image = [UIImage imageNamed:@"select_default"];
        _iconAliSelect.highlightedImage = [UIImage imageNamed:@"select_highlighted"];
        _iconAliSelect.widthHeight = XY(W(15),W(15));
    }
    return _iconAliSelect;
}
- (YellowButton *)pay{
    if (!_pay) {
        _pay = [YellowButton new];
        [_pay resetViewWithWidth:W(335) :W(45) :@"立即支付"];
        WEAKSELF
        _pay.blockClick = ^{
            if (weakSelf.blockSelected) {
                weakSelf.blockSelected(weakSelf.index);
            }
            [weakSelf removeFromSuperview];
        };
    }
    return _pay;
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        self.width = SCREEN_WIDTH;
        self.height = SCREEN_HEIGHT;
        self.index = ENUM_PAY_WECHAT;
        [self addSubView];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.BG];
    [self.BG addSubview:self.select];
    [self.BG addSubview:self.wechat];
    [self.BG addSubview:self.ali];
    [self.BG addSubview:self.close];
    [self.BG addSubview:self.iconWeChat];
    [self.BG addSubview:self.iconAli];
    [self.BG addSubview:self.pay];
    [self.BG addSubview:self.iconWeChatSelect];
    [self.BG addSubview:self.iconAliSelect];
    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    self.select.leftTop = XY(W(20),W(20));

    self.iconWeChat.leftTop = XY(W(25),self.select.bottom+W(39));

    self.iconAli.leftTop = XY(W(25),self.iconWeChat.bottom+W(38));

    self.wechat.leftCenterY = XY(self.iconWeChat.right + W(15),self.iconWeChat.centerY);

    self.ali.leftCenterY = XY(self.iconAli.right+W(15),self.iconAli.centerY);

    self.iconWeChatSelect.rightCenterY = XY(SCREEN_WIDTH- W(20), self.iconWeChat.centerY);
    self.iconAliSelect.rightCenterY = XY(SCREEN_WIDTH- W(20), self.iconAli.centerY);

    self.close.rightCenterY = XY(SCREEN_WIDTH - W(15),self.select.centerY);

    self.pay.centerXTop = XY(SCREEN_WIDTH/2.0,W(192));

    self.BG.widthHeight = XY(SCREEN_WIDTH, self.pay.bottom + W(18)+iphoneXBottomInterval);
    [self.BG removeCorner];
    [self.BG addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight radius:10 lineWidth:0 lineColor:[UIColor clearColor]];
    
    self.BG.bottom = SCREEN_HEIGHT;
    
    [self addControlFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.BG.top+W(50))  target:self action:@selector(closeClick)];

    [self.BG addControlFrame:CGRectMake(0, self.iconWeChat.top - W(10), SCREEN_WIDTH, self.iconWeChat.height+W(20)) belowView:self.iconWeChat target:self action:@selector(wechatClick)];
    [self.BG addControlFrame:CGRectMake(0, self.iconAli.top - W(10), SCREEN_WIDTH, self.iconAli.height+W(20)) belowView:self.iconAli target:self action:@selector(aliClick)];

}
-(void)show{
    [GB_Nav.lastVC.view addSubview:self];
    self.BG.top = SCREEN_HEIGHT;
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        self.BG.bottom = SCREEN_HEIGHT;
    }];
}

#pragma mark click
- (void)wechatClick{
    self.index = ENUM_PAY_WECHAT;
    self.iconWeChatSelect.highlighted = true;
    self.iconAliSelect.highlighted = false;
}
- (void)aliClick{
    self.index = ENUM_PAY_ALI;
    self.iconWeChatSelect.highlighted = false;
    self.iconAliSelect.highlighted = true;
}
- (void)closeClick{
    if (self.blockCancel) {
        self.blockCancel();
    }
    [self removeFromSuperview];
}
@end
