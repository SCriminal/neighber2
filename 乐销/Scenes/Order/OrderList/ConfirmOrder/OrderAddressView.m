//
//  OrderAddressView.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/4/21.
//Copyright © 2020 ping. All rights reserved.
//

#import "OrderAddressView.h"

@interface OrderAddressView ()

@end

@implementation OrderAddressView
#pragma mark 懒加载
- (UIImageView *)location{
    if (_location == nil) {
        _location = [UIImageView new];
        _location.image = [UIImage imageNamed:@"order_location"];
        _location.widthHeight = XY(W(15),W(15));
    }
    return _location;
}
- (UILabel *)name{
    if (_name == nil) {
        _name = [UILabel new];
        _name.textColor = COLOR_333;
        _name.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightMedium];
    }
    return _name;
}
- (UILabel *)phone{
    if (_phone == nil) {
        _phone = [UILabel new];
        _phone.textColor = COLOR_333;
        _phone.font =  [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
    }
    return _phone;
}
- (UILabel *)address{
    if (_address == nil) {
        _address = [UILabel new];
        _address.textColor = COLOR_333;
        _address.font =  [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
        _address.numberOfLines = 0;
        _address.lineSpace = W(4);

    }
    return _address;
}
- (UIImageView *)arrowRight{
    if (_arrowRight == nil) {
        _arrowRight = [UIImageView new];
        _arrowRight.image = [UIImage imageNamed:@"arrow_right"];
        _arrowRight.widthHeight = XY(W(15),W(15));
    }
    return _arrowRight;
}
- (UIView *)BG{
    if (!_BG) {
        _BG = [UIView new];
        _BG.backgroundColor = [UIColor whiteColor];
    }
    return _BG;
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.width = SCREEN_WIDTH;
        [self addSubView];
        [self addTarget:self action:@selector(click)];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.BG];
    [self addSubview:self.location];
    [self addSubview:self.name];
    [self addSubview:self.phone];
    [self addSubview:self.address];
    [self addSubview:self.arrowRight];

}

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelShopAddress *)model{
    self.model = model;
    if (!model) {
        [self showSelectAddress];
        return;
    }
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    self.location.leftTop = XY(self.isOrderDetail?W(25):W(30) ,W(14));
    [self.name fitTitle:UnPackStr(model.contact) variable:W(150)];
    self.name.leftCenterY = XY(self.location.right + W(7),self.location.centerY);
    [self.phone fitTitle:UnPackStr(model.phone) variable:W(150)];
    self.phone.leftBottom = XY(self.name.right+ W(8),self.name.bottom);
    [self.address fitTitle:UnPackStr(model.addressDetailShow) variable:self.isClickAvailable?W(274):W(300)];
    self.address.leftTop = XY(self.name.left,self.location.bottom+W(11));

    self.height = self.address.bottom + W(15);

    self.arrowRight.rightCenterY = XY(SCREEN_WIDTH - W(30),self.height/2.0);
    self.arrowRight.hidden = !self.isClickAvailable;
    
    self.BG.widthHeight = XY(self.isOrderDetail?W(355):W(345), self.height);
    self.BG.centerXTop = XY(SCREEN_WIDTH/2.0, 0);
    [self.BG removeCorner];
    [self.BG addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:10 lineWidth:0 lineColor:[UIColor clearColor]];
}
- (void)showSelectAddress{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    self.location.leftTop = XY(W(25),W(14));
    [self.name fitTitle:isStr(self.addressDefaultAlert)?self.addressDefaultAlert: @"请选择收货地址" variable:W(150)];
    self.name.leftCenterY = XY(self.location.right + W(7),self.location.centerY);

    self.height = self.location.bottom + W(15);

    self.arrowRight.rightCenterY = XY(SCREEN_WIDTH - W(30),self.height/2.0);
    self.arrowRight.hidden = !self.isClickAvailable;
    
    self.BG.frame = CGRectMake(W(15), 0, SCREEN_WIDTH - W(30), self.height);
    [self.BG removeCorner];
    [self.BG addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:10 lineWidth:0 lineColor:[UIColor clearColor]];
}

#pragma mark click
- (void)click{
    if (self.blockClick) {
        self.blockClick();
    }
}
@end
