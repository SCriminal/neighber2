//
//  ConfirmOrderCell.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/4/26.
//Copyright © 2020 ping. All rights reserved.
//

#import "ConfirmOrderCell.h"

@interface ConfirmOrderSectionTopView ()

@end

@implementation ConfirmOrderSectionTopView
#pragma mark 懒加载
- (UILabel *)name{
    if (_name == nil) {
        _name = [UILabel new];
        _name.textColor = COLOR_333;
        _name.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightMedium];
        _name.numberOfLines = 1;
        _name.lineSpace = 0;
    }
    return _name;
}
- (UIImageView *)arrow{
    if (_arrow == nil) {
        _arrow = [UIImageView new];
        _arrow.image = [UIImage imageNamed:@"arrow_right"];
        _arrow.widthHeight = XY(W(15),W(15));
        _arrow.hidden = true;
    }
    return _arrow;
}
- (UIView *)whiteBG{
    if (_whiteBG == nil) {
        _whiteBG = [UIView new];
        _whiteBG.backgroundColor = [UIColor whiteColor];
    }
    return _whiteBG;
}
#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {

        self.backgroundColor = [UIColor clearColor];
        self.width = SCREEN_WIDTH;
        [self addSubView];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.whiteBG];
    [self addSubview:self.name];
    [self addSubview:self.arrow];

    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelTrolley *)model{
    self.model = model;
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    CGFloat topInterval = W(0);

    [self.name fitTitle:isStr(model.name)?model.name:@" " variable:W(280)];
    self.name.leftTop = XY(self.isOrderDetail?W(25):W(30),W(15)+topInterval);
    
    self.arrow.leftCenterY = XY(self.name.right + W(5),self.name.centerY);
    
    //设置总高度
    self.height = self.name.bottom + W(10);
    self.whiteBG.widthHeight = XY(self.isOrderDetail?W(355): W(345),self.height - topInterval);
    [self.whiteBG addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight radius:(10)];
    self.whiteBG.centerXTop = XY(SCREEN_WIDTH/2.0,topInterval);
}

@end



@implementation ConfirmOrderSectionBottomView
#pragma mark 懒加载
- (UIView *)whiteBG{
    if (_whiteBG == nil) {
        _whiteBG = [UIView new];
        _whiteBG.backgroundColor = [UIColor whiteColor];
    }
    return _whiteBG;
}
- (UILabel *)price{
    if (_price == nil) {
        _price = [UILabel new];
        _price.textColor = [UIColor colorWithHexString:@"FE533F"];
        _price.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _price.numberOfLines = 1;
        _price.lineSpace = 0;
    }
    return _price;
}

- (UILabel *)number{
    if (_number == nil) {
        _number = [UILabel new];
        _number.textColor = COLOR_999;
        _number.font =  [UIFont systemFontOfSize:F(14) weight:UIFontWeightRegular];
        _number.numberOfLines = 1;
        _number.lineSpace = 0;
    }
    return _number;
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.clipsToBounds = true;
        self.width = SCREEN_WIDTH;
        [self addSubView];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.whiteBG];
    [self addSubview:self.number];
    [self addSubview:self.price];

    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelTrolley *)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    CGFloat priceAll = 0;
    CGFloat numAll = 0;
    for (ModelIntegralProduct * modelPro in model.skus) {
            priceAll += modelPro.qty*modelPro.price;
        numAll += modelPro.qty;
    }
    
    [self.price fitTitle:[
                          NSString stringWithFormat:@"¥ %@",NSNumber.price(priceAll).stringValue] variable:0];
    self.price.rightTop = XY(SCREEN_WIDTH - (self.isOrderDetail?W(25): W(30)), W(8));
    
    [self.number fitTitle:[NSString stringWithFormat:@"共%@件",NSNumber.dou(numAll)] variable:0];
    self.number.rightCenterY = XY(self.price.left - W(10), self.price.centerY);

    //设置总高度
    self.height = self.price.bottom + W(13.5);
    self.whiteBG.widthHeight = XY(self.isOrderDetail?W(355): W(345), self.height);
    [self.whiteBG removeCorner];
    [self.whiteBG addRoundCorner:UIRectCornerBottomLeft|UIRectCornerBottomRight radius:(10)];
    
    self.whiteBG.centerXTop = XY(SCREEN_WIDTH/2.0,0);
}

@end



@implementation ConfirmOrderCell
#pragma mark 懒加载
- (UIImageView *)productIV{
    if (_productIV == nil) {
        _productIV = [UIImageView new];
        _productIV.contentMode = UIViewContentModeScaleAspectFill;
        _productIV.clipsToBounds = true;
        _productIV.widthHeight = XY(W(55),W(55));
        [_productIV addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:5 lineWidth:0 lineColor:[UIColor clearColor]];
        
    }
    return _productIV;
}
- (UILabel *)name{
    if (_name == nil) {
        _name = [UILabel new];
        _name.textColor = COLOR_333;
        _name.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightMedium];
        _name.numberOfLines = 1;
        _name.lineSpace = 0;
    }
    return _name;
}
- (UILabel *)price{
    if (_price == nil) {
        _price = [UILabel new];
        _price.textColor = [UIColor colorWithHexString:@"FE533F"];
        _price.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _price.numberOfLines = 1;
        _price.lineSpace = 0;
    }
    return _price;
}

- (UILabel *)number{
    if (_number == nil) {
        _number = [UILabel new];
        _number.textColor = COLOR_999;
        _number.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _number.numberOfLines = 1;
        _number.lineSpace = 0;
    }
    return _number;
}
- (UILabel *)rmb{
    if (_rmb == nil) {
        _rmb = [UILabel new];
        _rmb.textColor = [UIColor colorWithHexString:@"FE533F"];
        _rmb.font =  [UIFont systemFontOfSize:F(11) weight:UIFontWeightRegular];
        _rmb.numberOfLines = 1;
        _rmb.lineSpace = 0;
        [_rmb fitTitle:@"¥" variable:0];
    }
    return _rmb;
}
- (UIView *)whiteBG{
    if (_whiteBG == nil) {
        _whiteBG = [UIView new];
        _whiteBG.backgroundColor = [UIColor whiteColor];
    }
    return _whiteBG;
}

#pragma mark 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.whiteBG];

        [self.contentView addSubview:self.productIV];
        [self.contentView addSubview:self.name];
        [self.contentView addSubview:self.rmb];
        [self.contentView addSubview:self.price];
        [self.contentView addSubview:self.number];
    }
    return self;
}
#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelIntegralProduct *)model{
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    self.modelProduct = model;
    [self.productIV sd_setImageWithURL:[NSURL URLWithString:model.coverUrl] placeholderImage:[UIImage imageNamed:IMAGE_BIG_DEFAULT]];
    self.productIV.leftTop = XY(self.isOrderDetail?W(25):W(30),W(10));
    [self.name fitTitle:UnPackStr(model.name) variable:W(170)];
    self.name.leftTop = XY(self.productIV.right+ W(10),self.productIV.top);
    
    self.rmb.leftBottom = XY(self.productIV.right+W(10),self.productIV.bottom-W(3));
    
    [self.price fitTitle:NSNumber.price(model.price).stringValue variable:W(90)];
    self.price.leftBottom = XY(self.rmb.right + W(5),self.productIV.bottom-W(3));
    
    [self.number fitTitle:[NSString stringWithFormat:@"x%@",NSNumber.dou(model.qty)] variable:0];
    self.number.rightCenterY = XY(SCREEN_WIDTH - (self.isOrderDetail?W(25):W(30)), self.productIV.centerY);
    
    //设置总高度
    self.height = self.productIV.bottom + W(10);
    
    self.whiteBG.widthHeight = XY(self.isOrderDetail?W(355):W(345), self.height);
    self.whiteBG.centerX = SCREEN_WIDTH/2.0;
}

@end

