//
//  IntegralCollectionCell.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/10.
//Copyright © 2020 ping. All rights reserved.
//

#import "IntegralCollectionCell.h"

@interface IntegralCollectionCell ()

@end

@implementation IntegralCollectionCell
#pragma mark 懒加载#pragma mark 懒加载
- (ShadowView *)viewBG{
    if (_viewBG == nil) {
        _viewBG = [ShadowView new];
    }
    return _viewBG;
}
- (UIView *)viewFather{
    if (_viewFather == nil) {
        _viewFather = [UIView new];
        _viewFather.backgroundColor = [UIColor clearColor];
        
    }
    return _viewFather;
}
- (UIImageView *)productImage{
    if (_productImage == nil) {
        _productImage = [UIImageView new];
        _productImage.widthHeight = XY(W(160),W(135));
        _productImage.contentMode = UIViewContentModeScaleAspectFill;
        _productImage.clipsToBounds = true;
    }
    return _productImage;
}
- (UILabel *)name{
    if (_name == nil) {
        _name = [UILabel new];
        _name.textColor = COLOR_333;
        _name.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _name.numberOfLines = 1;
        _name.lineSpace = 0;
    }
    return _name;
}
- (UILabel *)price{
    if (_price == nil) {
        _price = [UILabel new];
        _price.textColor = COLOR_333;
        _price.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        _price.numberOfLines = 1;
        _price.lineSpace = 0;
    }
    return _price;
}
- (UILabel *)limit{
    if (_limit == nil) {
        _limit = [UILabel new];
        _limit.textColor = COLOR_999;
        _limit.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        _limit.numberOfLines = 1;
        _limit.lineSpace = 0;
    }
    return _limit;
}
- (UILabel *)score{
    if (_score == nil) {
        _score = [UILabel new];
        _score.textColor = COLOR_ORANGE;
        _score.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightMedium];
        _score.numberOfLines = 1;
        _score.lineSpace = 0;
    }
    return _score;
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.viewBG];
        [self addSubview:self.viewFather];
        [self.viewFather addSubview:self.productImage];
        [self.viewFather addSubview:self.name];
        [self.viewFather addSubview:self.price];
        [self.viewFather addSubview:self.limit];
        [self.viewFather addSubview:self.score];
        
    }
    return self;
}

#pragma mark 刷新cell



#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelIntegralProduct *)model{
    self.model = model;
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
      
    [self.productImage sd_setImageWithURL:[NSURL URLWithString:model.coverUrl] placeholderImage:[UIImage imageNamed:IMAGE_BIG_DEFAULT]];
//    self.productImage.image = [UIImage imageNamed:@"temp_computer"];
    [self.name fitTitle:UnPackStr(model.name) variable:self.productImage.width - W(20)];
    self.name.leftTop = XY(W(10),self.productImage.bottom+W(15));
    [self.price fitTitle:[NSString stringWithFormat:@"%.2f元",model.price/100.0] variable:self.productImage.width/2.0-W(10)];
    self.price.leftTop = XY(W(10),self.name.bottom+W(12));
    [self.limit fitTitle:[NSString stringWithFormat:@"剩%.f份",model.stockAmount] variable:self.productImage.width/2.0-W(10)];
    self.limit.rightCenterY = XY(self.productImage.width - W(10),self.price.centerY);
    [self.score fitTitle:[NSString stringWithFormat:@"%.f积分",model.score] variable:self.productImage.width - W(20)];
    self.score.leftTop = XY(W(10),self.limit.bottom+W(12));
    
    
    self.viewFather.widthHeight = XY(self.productImage.width, self.score.bottom+W(15));
    self.viewFather.leftTop = XY(W(7.5),W(10));
    [self.viewFather   addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:self.viewBG.cornerRadius lineWidth:0 lineColor:[UIColor clearColor]];

    [self.viewBG resetViewWith:self.viewFather.frame];
    
    //设置size
    self.size = CGSizeMake(self.productImage.width+W(15), self.viewFather.bottom + W(5));
    
    
}

@end
