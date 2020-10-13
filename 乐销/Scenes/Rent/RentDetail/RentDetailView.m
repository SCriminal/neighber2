//
//  RentDetailView.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/26.
//Copyright © 2020 ping. All rights reserved.
//

#import "RentDetailView.h"

@interface RentDetailView ()

@end

@implementation RentDetailView
#pragma mark 懒加载
- (UIView *)viewBG{
    if (_viewBG == nil) {
        _viewBG = [UIView new];
        _viewBG.backgroundColor = [UIColor whiteColor];
    }
    return _viewBG;
}
- (UILabel *)price{
    if (_price == nil) {
        _price = [UILabel new];
        _price.textColor = COLOR_RED;
        _price.font =  [UIFont systemFontOfSize:F(25) weight:UIFontWeightMedium];
    }
    return _price;
}
- (UILabel *)priceUnit{
    if (_priceUnit == nil) {
        _priceUnit = [UILabel new];
        _priceUnit.textColor = COLOR_RED;
        _priceUnit.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightMedium];
    }
    return _priceUnit;
}
- (UILabel *)title{
    if (_title == nil) {
        _title = [UILabel new];
        _title.textColor = COLOR_333;
        _title.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightMedium];
        _title.numberOfLines = 0;
        _title.lineSpace = W(8);
    }
    return _title;
}
- (UILabel *)houseMode{
    if (_houseMode == nil) {
        _houseMode = [UILabel new];
        _houseMode.textColor = COLOR_666;
        _houseMode.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        [_houseMode fitTitle:@"户型" variable:0];
    }
    return _houseMode;
}
- (UILabel *)floorage{
    if (_floorage == nil) {
        _floorage = [UILabel new];
        _floorage.textColor = COLOR_666;
        _floorage.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        [_floorage fitTitle:@"面积" variable:0];

    }
    return _floorage;
}
- (UILabel *)direction{
    if (_direction == nil) {
        _direction = [UILabel new];
        _direction.textColor = COLOR_666;
        _direction.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        [_direction fitTitle:@"朝向" variable:0];

    }
    return _direction;
}
- (UILabel *)floor{
    if (_floor == nil) {
        _floor = [UILabel new];
        _floor.textColor = COLOR_666;
        _floor.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        [_floor fitTitle:@"楼层" variable:0];

    }
    return _floor;
}
- (UILabel *)houseModeDetail{
    if (_houseModeDetail == nil) {
        _houseModeDetail = [UILabel new];
        _houseModeDetail.textColor = COLOR_333;
        _houseModeDetail.font =  [UIFont systemFontOfSize:F(14) weight:UIFontWeightMedium];
    }
    return _houseModeDetail;
}
- (UILabel *)floorageDetail{
    if (_floorageDetail == nil) {
        _floorageDetail = [UILabel new];
        _floorageDetail.textColor = COLOR_333;
        _floorageDetail.font =  [UIFont systemFontOfSize:F(14) weight:UIFontWeightMedium];
    }
    return _floorageDetail;
}
- (UILabel *)directionDetail{
    if (_directionDetail == nil) {
        _directionDetail = [UILabel new];
        _directionDetail.textColor = COLOR_333;
        _directionDetail.font =  [UIFont systemFontOfSize:F(14) weight:UIFontWeightMedium];
    }
    return _directionDetail;
}
- (UILabel *)floorDetail{
    if (_floorDetail == nil) {
        _floorDetail = [UILabel new];
        _floorDetail.textColor = COLOR_333;
        _floorDetail.font =  [UIFont systemFontOfSize:F(14) weight:UIFontWeightMedium];
    }
    return _floorDetail;
}
- (UILabel *)remark{
    if (_remark == nil) {
        _remark = [UILabel new];
        _remark.textColor = COLOR_333;
        _remark.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightMedium];
        [_remark fitTitle:@"备注" variable:0];

    }
    return _remark;
}
- (UILabel *)remarkDetail{
    if (_remarkDetail == nil) {
        _remarkDetail = [UILabel new];
        _remarkDetail.textColor = COLOR_333;
        _remarkDetail.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _remarkDetail.numberOfLines = 0;
        _remarkDetail.lineSpace = W(8);
    }
    return _remarkDetail;
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
    [self addSubview:self.viewBG];
    [self addSubview:self.price];
    [self addSubview:self.priceUnit];
    [self addSubview:self.title];
    [self addSubview:self.houseMode];
    [self addSubview:self.floorage];
    [self addSubview:self.direction];
    [self addSubview:self.floor];
    [self addSubview:self.houseModeDetail];
    [self addSubview:self.floorageDetail];
    [self addSubview:self.directionDetail];
    [self addSubview:self.floorDetail];
    [self addSubview:self.remark];
    [self addSubview:self.remarkDetail];
    
    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelRentInfo *)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    [self.price fitTitle:NSNumber.price(model.price).stringValue  variable:0];
    self.price.leftTop = XY(W(20),W(20));
    [self.priceUnit fitTitle:model.rentPriceUnitShow variable:0];
    self.priceUnit.leftCenterY = XY(self.price.right+ W(7),self.price.centerY+W(3));
    [self.title fitTitle:[NSString stringWithFormat:@"%@ | %@ %@",model.rentModeShow,UnPackStr(model.estateName),UnPackStr(model.title)] variable:SCREEN_WIDTH - self.price.left*2.0];
    self.title.leftTop = XY(self.price.left,self.price.bottom+W(17));
    
    CGFloat bottom = [self addLineFrame:CGRectMake(W(20), self.title.bottom + W(25), SCREEN_WIDTH - W(40), 1)];
    
    [self.houseModeDetail fitTitle:model.layoutShow variable:SCREEN_WIDTH/4.0-5];
    self.houseModeDetail.centerXTop = XY(SCREEN_WIDTH/5.0,bottom+W(25));
    [self.floorageDetail fitTitle:[NSString stringWithFormat:@"%@㎡",[NSDecimalNumber numberWithDouble:model.floorage].stringValue] variable:SCREEN_WIDTH/4.0-5];
    self.floorageDetail.centerXTop = XY(SCREEN_WIDTH/5.0*2.0,bottom+W(25));
    [self.directionDetail fitTitle:model.directionShow variable:SCREEN_WIDTH/4.0-5];
    self.directionDetail.centerXTop = XY(SCREEN_WIDTH/5.0*3.0,bottom+W(25));
    [self.floorDetail fitTitle:model.floorShow variable:SCREEN_WIDTH/4.0-5];
    self.floorDetail.centerXTop = XY(SCREEN_WIDTH/5.0*4.0,bottom+W(25));


    self.houseMode.centerXTop = XY(self.houseModeDetail.centerX,self.houseModeDetail.bottom+W(15));
    self.floorage.centerXTop = XY(self.floorageDetail.centerX,self.houseMode.top);
    self.direction.centerXTop = XY(self.directionDetail.centerX,self.houseMode.top);
    self.floor.centerXTop = XY(self.floorDetail.centerX,self.houseMode.top);
    
    bottom = [self addLineFrame:CGRectMake(W(20), self.floor.bottom + W(25), SCREEN_WIDTH - W(40), 1)];

    
    self.remark.leftTop = XY(self.price.left,bottom+W(17));
    [self.remarkDetail fitTitle:UnPackStr(model.body) variable:SCREEN_WIDTH - self.price.left*2.0];
    self.remarkDetail.leftTop = XY(self.price.left,self.remark.bottom+W(17));
    
    //设置总高度
    self.height = self.remarkDetail.bottom + self.price.top;
    self.viewBG.widthHeight = XY(SCREEN_WIDTH, self.height);
    [self.viewBG addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight radius:15 lineWidth:0 lineColor:[UIColor clearColor]];
    


}

@end
