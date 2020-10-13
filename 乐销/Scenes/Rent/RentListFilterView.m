//
//  RentListFilterView.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/27.
//Copyright © 2020 ping. All rights reserved.
//

#import "RentListFilterView.h"

@interface RentListFilterView ()
@property (strong, nonatomic) UIView *layoutBG;
@property (strong, nonatomic) UILabel *layout;
@property (strong, nonatomic) UIView *directionBG;
@property (strong, nonatomic) UILabel *direction;
@property (strong, nonatomic) UIView *priceBG;
@property (strong, nonatomic) UILabel *price;
@property (strong, nonatomic) UIView *rentModeBG;
@property (strong, nonatomic) UILabel *rentMode;
@property (strong, nonatomic) UIImageView *layoutArrow;
@property (strong, nonatomic) UIImageView *directionArrow;
@property (strong, nonatomic) UIImageView *priceArrow;
@property (strong, nonatomic) UIImageView *rentModeArrow;

@end

@implementation RentListFilterView
#pragma mark 懒加载
- (UIView *)layoutBG{
    if (_layoutBG == nil) {
        _layoutBG = [UIView new];
        _layoutBG.backgroundColor = [UIColor colorWithHexString:@"#FCFCFC"];
        _layoutBG.tag = 0;
        [_layoutBG addTarget:self action:@selector(click:)];
    }
    return _layoutBG;
}
- (UILabel *)layout{
    if (_layout == nil) {
        _layout = [UILabel new];
        _layout.textColor = COLOR_999;
        _layout.font =  [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
    }
    return _layout;
}
- (UIView *)directionBG{
    if (_directionBG == nil) {
        _directionBG = [UIView new];
        _directionBG.backgroundColor = [UIColor colorWithHexString:@"#FCFCFC"];
        _directionBG.tag = 1;
        [_directionBG addTarget:self action:@selector(click:)];
    }
    return _directionBG;
}
- (UILabel *)direction{
    if (_direction == nil) {
        _direction = [UILabel new];
        _direction.textColor = COLOR_999;
        _direction.font =  [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
    }
    return _direction;
}
- (UIView *)priceBG{
    if (_priceBG == nil) {
        _priceBG = [UIView new];
        _priceBG.backgroundColor = [UIColor colorWithHexString:@"#FCFCFC"];
        _priceBG.tag = 2;
        [_priceBG addTarget:self action:@selector(click:)];

    }
    return _priceBG;
}
- (UILabel *)price{
    if (_price == nil) {
        _price = [UILabel new];
        _price.textColor = COLOR_999;
        _price.font =  [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
    }
    return _price;
}
- (UIView *)rentModeBG{
    if (_rentModeBG == nil) {
        _rentModeBG = [UIView new];
        _rentModeBG.backgroundColor = [UIColor colorWithHexString:@"#FCFCFC"];
        _rentModeBG.tag = 3;
        [_rentModeBG addTarget:self action:@selector(click:)];

    }
    return _rentModeBG;
}
- (UILabel *)rentMode{
    if (_rentMode == nil) {
        _rentMode = [UILabel new];
        _rentMode.textColor = COLOR_999;
        _rentMode.font =  [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
    }
    return _rentMode;
}
- (UIImageView *)layoutArrow{
    if (_layoutArrow == nil) {
        _layoutArrow = [UIImageView new];
        _layoutArrow.image = [UIImage imageNamed:@"rent_arrow_up"];
        _layoutArrow.widthHeight = XY(W(9),W(9));
    }
    return _layoutArrow;
}
- (UIImageView *)directionArrow{
    if (_directionArrow == nil) {
        _directionArrow = [UIImageView new];
        _directionArrow.image = [UIImage imageNamed:@"rent_arrow_up"];
        _directionArrow.widthHeight = XY(W(9),W(9));
    }
    return _directionArrow;
}
- (UIImageView *)priceArrow{
    if (_priceArrow == nil) {
        _priceArrow = [UIImageView new];
        _priceArrow.image = [UIImage imageNamed:@"rent_arrow_up"];
        _priceArrow.widthHeight = XY(W(9),W(9));
    }
    return _priceArrow;
}
- (UIImageView *)rentModeArrow{
    if (_rentModeArrow == nil) {
        _rentModeArrow = [UIImageView new];
        _rentModeArrow.image = [UIImage imageNamed:@"rent_arrow_up"];
        _rentModeArrow.widthHeight = XY(W(9),W(9));
    }
    return _rentModeArrow;
}
- (ModelRentInfo *)modelFilter{
    if (!_modelFilter) {
        _modelFilter = [ModelRentInfo new];
    }
    return _modelFilter;
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.clipsToBounds = true;
        self.width = SCREEN_WIDTH;
        [self addSubView];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.layoutBG];
    [self addSubview:self.layout];
    [self addSubview:self.directionBG];
    [self addSubview:self.direction];
    [self addSubview:self.priceBG];
    [self addSubview:self.price];
    [self addSubview:self.rentModeBG];
    [self addSubview:self.rentMode];
    [self addSubview:self.layoutArrow];
    [self addSubview:self.directionArrow];
    [self addSubview:self.priceArrow];
    [self addSubview:self.rentModeArrow];

    //初始化页面
    [self resetViewWithModel];
}
#pragma mark click
- (void)click:(UITapGestureRecognizer *)tap{
    UIView * view = tap.view;
    if (self.blockClick) {
        self.blockClick((int)view.tag);
    }
}
#pragma mark 刷新view
- (void)resetViewWithModel{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    self.layoutBG.widthHeight = XY(W(70), W(37));
    self.layoutBG.leftTop = XY(W(15),W(15));
    self.directionBG.widthHeight = self.layoutBG.widthHeight;
    self.directionBG.leftTop = XY(self.layoutBG.right+ W(12),self.layoutBG.top);
    self.priceBG.widthHeight = self.layoutBG.widthHeight;
    self.priceBG.leftTop = XY(self.directionBG.right+ W(12),self.layoutBG.top);
    self.rentModeBG.widthHeight = XY(W(99), W(37));
    self.rentModeBG.leftTop = XY(self.priceBG.right + W(12),self.layoutBG.top);

    
    [self reconfigView];
    
    
    self.layoutArrow.rightCenterY = XY(self.layoutBG.right - W(8),self.layoutBG.centerY);
    
    self.directionArrow.rightCenterY = XY(self.directionBG.right -W(8),self.layoutBG.centerY);
    
    self.priceArrow.rightCenterY = XY(self.priceBG.right -W(8),self.layoutBG.centerY);
    
    self.rentModeArrow.rightCenterY = XY(self.rentModeBG.right -W(8),self.layoutBG.centerY);

    //设置总高度
    self.height = self.layoutBG.bottom+W(15);
}
- (void)reconfigView{
    ModelRentInfo * model = self.modelFilter;
    [self.layout fitTitle:model.layoutParlor?[NSString stringWithFormat:@"%.f室",model.layoutParlor]:@"户型" variable:0];
    self.layout.leftCenterY = XY(self.layoutBG.left + W(10),self.layoutBG.centerY);
    [self.direction fitTitle:isStr(model.directionShow)?model.directionShow:@"朝向" variable:0];
    self.direction.leftCenterY = XY(self.directionBG.left +W(10),self.layoutBG.centerY);
    [self.price fitTitle:@"价格" variable:0];
    self.price.leftCenterY = XY(self.priceBG.left +W(10),self.layoutBG.centerY);
    [self.rentMode fitTitle:isStr(model.rentModeShow)?model.rentModeShow:@"租赁方式" variable:0];
    self.rentMode.leftCenterY = XY(self.rentModeBG.left +W(10),self.layoutBG.centerY);
}
@end
