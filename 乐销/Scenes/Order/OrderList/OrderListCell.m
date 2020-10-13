//
//  OrderListCell.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/10.
//Copyright © 2020 ping. All rights reserved.
//

#import "OrderListCell.h"

@interface OrderListCell ()

@end

@implementation OrderListCell
#pragma mark 懒加载
- (UIImageView *)productImage{
    if (_productImage == nil) {
        _productImage = [UIImageView new];
        _productImage.widthHeight = XY(W(50),W(50));
        _productImage.contentMode = UIViewContentModeScaleAspectFill;
        _productImage.clipsToBounds = true;
        [_productImage addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:5 lineWidth:0 lineColor:[UIColor clearColor]];

    }
    return _productImage;
}
- (UIImageView *)arrow{
    if (_arrow == nil) {
        _arrow = [UIImageView new];
        _arrow.widthHeight = XY(W(15),W(15));
        _arrow.image = [UIImage imageNamed:@"arrow_right"];
    }
    return _arrow;
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
- (UILabel *)shop{
    if (_shop == nil) {
        _shop = [UILabel new];
        _shop.textColor = COLOR_333;
        _shop.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightMedium];
        _shop.numberOfLines = 1;
        _shop.lineSpace = 0;
    }
    return _shop;
}
- (UILabel *)price{
    if (_price == nil) {
        _price = [UILabel new];
        _price.textColor = COLOR_666;
        _price.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        _price.numberOfLines = 1;
        _price.lineSpace = 0;
    }
    return _price;
}
- (UILabel *)num{
    if (_num == nil) {
        _num = [UILabel new];
        _num.textColor = COLOR_666;
        _num.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        _num.numberOfLines = 1;
        _num.lineSpace = 0;
    }
    return _num;
}
- (UILabel *)time{
    if (_time == nil) {
        _time = [UILabel new];
        _time.textColor = COLOR_666;
        _time.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        _time.numberOfLines = 1;
        _time.lineSpace = 0;
    }
    return _time;
}
- (UILabel *)status{
    if (_status == nil) {
        _status = [UILabel new];
        _status.textColor = COLOR_ORANGE;
        _status.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        _status.numberOfLines = 1;
        _status.lineSpace = 0;
    }
    return _status;
}

#pragma mark 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.productImage];
        [self.contentView addSubview:self.name];
        [self.contentView addSubview:self.price];
        [self.contentView addSubview:self.shop];
        [self.contentView addSubview:self.arrow];
        [self.contentView addSubview:self.num];
        [self.contentView addSubview:self.time];
        [self.contentView addSubview:self.status];
        
    }
    return self;
}


#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelOrderDetail *)model{
    self.model = model;
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    [self.shop fitTitle:UnPackStr(model.storeName) variable:SCREEN_HEIGHT - W(40)];
    self.shop.leftTop = XY(W(20), W(20));
    self.arrow.leftCenterY = XY(self.shop.right + W(3), self.shop.centerY);
    
    ModelIntegralProduct * pro = model.skus.lastObject;
    [self.productImage sd_setImageWithURL:[NSURL URLWithString:pro.coverUrl] placeholderImage:[UIImage imageNamed:IMAGE_BIG_DEFAULT]];
    self.productImage.leftTop = XY(W(20),self.shop.bottom + W(20));
    [self.name fitTitle:UnPackStr(pro.name) variable:SCREEN_WIDTH - self.productImage.right-W(40)];
    self.name.leftTop = XY(self.productImage.right+ W(10),self.productImage.top);
    [self.price fitTitle:[NSString stringWithFormat:@"￥%@",NSNumber.price(pro.price).stringValue] variable:W(75)];
    self.price.leftBottom = XY(self.productImage.right + W(10),self.productImage.bottom-W(7));
    
    [self.num fitTitle:[NSString stringWithFormat:@"数量x%@",NSNumber.dou(pro.qty).stringValue] variable:W(75)];
    self.num.leftBottom = XY(self.productImage.right + W(90),self.productImage.bottom-W(5));

    [self.time fitTitle:[NSString stringWithFormat:@"下单时间：%@",[GlobalMethod exchangeTimeWithStamp:model.createTime andFormatter:TIME_MIN_SHOW]] variable:0];
    self.time.rightTop = XY(SCREEN_WIDTH - W(20),self.productImage.bottom+W(10));
    
    [self.status fitTitle:model.statusShow variable:0];
    self.status.textColor = model.orderStatus == ENUM_ORDER_STATUS_CLOSE?COLOR_999:COLOR_ORANGE;
    self.status.rightTop = XY(SCREEN_WIDTH - W(20),self.time.bottom+W(15));
    self.status.hidden = false;
    //设置size
    self.height = self.status.hidden?(self.time.bottom + W(20)):(self.status.bottom + W(20));
    [self.contentView addLineFrame:CGRectMake(W(20), self.height -1, SCREEN_WIDTH - W(40), 1)];
}

@end


@implementation OrderListMultiImageCell
#pragma mark 懒加载
- (UIImageView *)productImage{
    if (_productImage == nil) {
        _productImage = [UIImageView new];
        _productImage.widthHeight = XY(W(50),W(50));
        _productImage.contentMode = UIViewContentModeScaleAspectFill;
        _productImage.clipsToBounds = true;
        [_productImage addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:5 lineWidth:0 lineColor:[UIColor clearColor]];

    }
    return _productImage;
}
- (UIImageView *)productImage1{
    if (_productImage1 == nil) {
        _productImage1 = [UIImageView new];
        _productImage1.widthHeight = XY(W(50),W(50));
        _productImage1.contentMode = UIViewContentModeScaleAspectFill;
        _productImage1.clipsToBounds = true;
        [_productImage1 addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:5 lineWidth:0 lineColor:[UIColor clearColor]];

    }
    return _productImage1;
}
- (UIImageView *)productImage2{
    if (_productImage2 == nil) {
        _productImage2 = [UIImageView new];
        _productImage2.widthHeight = XY(W(50),W(50));
        _productImage2.contentMode = UIViewContentModeScaleAspectFill;
        _productImage2.clipsToBounds = true;
        [_productImage2 addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:5 lineWidth:0 lineColor:[UIColor clearColor]];

    }
    return _productImage2;
}
- (UIImageView *)productImage3{
    if (_productImage3 == nil) {
        _productImage3 = [UIImageView new];
        _productImage3.widthHeight = XY(W(50),W(50));
        _productImage3.contentMode = UIViewContentModeScaleAspectFill;
        _productImage3.clipsToBounds = true;
        [_productImage3 addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:5 lineWidth:0 lineColor:[UIColor clearColor]];

    }
    return _productImage3;
}
- (UIImageView *)more{
    if (_more == nil) {
        _more = [UIImageView new];
        _more.widthHeight = XY(W(9),W(9));
        _more.image = [UIImage imageNamed:@"order_more"];
    }
    return _more;
}
- (UIImageView *)arrow{
    if (_arrow == nil) {
        _arrow = [UIImageView new];
        _arrow.widthHeight = XY(W(15),W(15));
        _arrow.image = [UIImage imageNamed:@"arrow_right"];
    }
    return _arrow;
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
- (UILabel *)shop{
    if (_shop == nil) {
        _shop = [UILabel new];
        _shop.textColor = COLOR_333;
        _shop.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightMedium];
        _shop.numberOfLines = 1;
        _shop.lineSpace = 0;
    }
    return _shop;
}
- (UILabel *)price{
    if (_price == nil) {
        _price = [UILabel new];
        _price.textColor = COLOR_333;
        _price.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _price.numberOfLines = 1;
        _price.lineSpace = 0;
    }
    return _price;
}
- (UILabel *)num{
    if (_num == nil) {
        _num = [UILabel new];
        _num.textColor = COLOR_666;
        _num.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        _num.numberOfLines = 1;
        _num.lineSpace = 0;
    }
    return _num;
}
- (UILabel *)time{
    if (_time == nil) {
        _time = [UILabel new];
        _time.textColor = COLOR_666;
        _time.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        _time.numberOfLines = 1;
        _time.lineSpace = 0;
    }
    return _time;
}
- (UILabel *)status{
    if (_status == nil) {
        _status = [UILabel new];
        _status.textColor = COLOR_ORANGE;
        _status.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        _status.numberOfLines = 1;
        _status.lineSpace = 0;
    }
    return _status;
}

#pragma mark 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.productImage];
        [self.contentView addSubview:self.productImage1];
        [self.contentView addSubview:self.productImage2];
        [self.contentView addSubview:self.productImage3];
        [self.contentView addSubview:self.more];
//        [self.contentView addSubview:self.name];
        [self.contentView addSubview:self.price];
        [self.contentView addSubview:self.shop];
        [self.contentView addSubview:self.arrow];
        [self.contentView addSubview:self.num];
        [self.contentView addSubview:self.time];
        [self.contentView addSubview:self.status];
        
    }
    return self;
}


#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelOrderDetail *)model{
    self.model = model;
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    [self.shop fitTitle:UnPackStr(model.storeName) variable:SCREEN_HEIGHT - W(40)];
    self.shop.leftTop = XY(W(20), W(20));
    self.arrow.leftCenterY = XY(self.shop.right + W(3), self.shop.centerY);
    
    self.productImage1.hidden = model.skus.count<2;
    self.productImage2.hidden = model.skus.count<3;
    self.productImage3.hidden = model.skus.count<4;
    self.more.hidden = model.skus.count<5;
    if (model.skus.count) {
        ModelIntegralProduct * pro = model.skus.firstObject;
        [self.productImage sd_setImageWithURL:[NSURL URLWithString:pro.coverUrl] placeholderImage:[UIImage imageNamed:IMAGE_BIG_DEFAULT]];
        self.productImage.leftTop = XY(W(20),self.shop.bottom + W(20));
    }
    if (model.skus.count>1) {
        ModelIntegralProduct * pro = model.skus[1];
        [self.productImage1 sd_setImageWithURL:[NSURL URLWithString:pro.coverUrl] placeholderImage:[UIImage imageNamed:IMAGE_BIG_DEFAULT]];
        self.productImage1.leftTop = XY(W(80),self.shop.bottom + W(20));
    }
    if (model.skus.count>2) {
        ModelIntegralProduct * pro = model.skus[2];
        [self.productImage2 sd_setImageWithURL:[NSURL URLWithString:pro.coverUrl] placeholderImage:[UIImage imageNamed:IMAGE_BIG_DEFAULT]];
        self.productImage2.leftTop = XY(W(140),self.shop.bottom + W(20));
    }
    if (model.skus.count>3) {
        ModelIntegralProduct * pro = model.skus[3];
        [self.productImage3 sd_setImageWithURL:[NSURL URLWithString:pro.coverUrl] placeholderImage:[UIImage imageNamed:IMAGE_BIG_DEFAULT]];
        self.productImage3.leftTop = XY(W(200),self.shop.bottom + W(20));
    }
    self.more.leftCenterY = XY(W(260), self.productImage.centerY);
    //刷新view
    CGFloat priceAll = 0;
    CGFloat numAll = 0;
         for (ModelIntegralProduct * modelPro in model.skus) {
            priceAll += modelPro.qty*modelPro.price;
             numAll += modelPro.qty;
         }
    [self.price fitTitle:[NSString stringWithFormat:@"￥%@",NSNumber.price(priceAll).stringValue] variable:W(100)];
    self.price.rightTop = XY(SCREEN_WIDTH - W(16.5),self.productImage.top+W(7));
    
    [self.num fitTitle:[NSString stringWithFormat:@"共%@件",NSNumber.dou(numAll).stringValue] variable:W(100)];
    self.num.rightBottom = XY(SCREEN_WIDTH - W(16.5),self.productImage.bottom-W(7));

    [self.time fitTitle:[NSString stringWithFormat:@"下单时间：%@",[GlobalMethod exchangeTimeWithStamp:model.createTime andFormatter:TIME_MIN_SHOW]] variable:0];
    self.time.rightTop = XY(SCREEN_WIDTH - W(20),self.productImage.bottom+W(13));
    
    [self.status fitTitle:model.statusShow variable:0];
    self.status.textColor = model.orderStatus == ENUM_ORDER_STATUS_CLOSE?COLOR_999:COLOR_ORANGE;
    self.status.rightTop = XY(SCREEN_WIDTH - W(20),self.time.bottom+W(15));
    self.status.hidden = false;
    //设置size
    self.height = self.status.hidden?(self.time.bottom + W(20)):(self.status.bottom + W(20));
    [self.contentView addLineFrame:CGRectMake(W(20), self.height -1, SCREEN_WIDTH - W(40), 1)];
}

@end
