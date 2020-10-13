//
//  ShopDetailCell.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/12.
//Copyright © 2020 ping. All rights reserved.
//

#import "ShopDetailCell.h"


@implementation ShopDetailLeftCell
#pragma mark 懒加载
- (UIView *)BG{
    if (_BG == nil) {
        _BG = [UIView new];
        
    }
    return _BG;
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

#pragma mark 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.BG];
        [self.contentView addSubview:self.name];
        
    }
    return self;
}
#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelShopDetailCategory *)model{
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    self.BG.widthHeight = XY(W(102.5), W(55));

    [self.name fitTitle:model.name variable:0];
    self.name.leftTop = XY(W(20),W(20));
    self.name.textColor = model.isSelected?COLOR_333:COLOR_666;
    //设置总高度
    self.height = self.name.bottom + W(20);
    self.BG.widthHeight = self.widthHeight;
    self.BG.backgroundColor = model.isSelected?COLOR_GRAY:[UIColor whiteColor];
}

@end



@implementation ShopDetailRightCell
#pragma mark 懒加载
- (UIImageView *)productIV{
    if (_productIV == nil) {
        _productIV = [UIImageView new];
        _productIV.contentMode = UIViewContentModeScaleAspectFill;
        _productIV.clipsToBounds = true;
        _productIV.widthHeight = XY(W(65),W(65));
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
- (UIImageView *)add{
    if (_add == nil) {
        _add = [UIImageView new];
        _add.image = [UIImage imageNamed:@"shope_add"];
        _add.widthHeight = XY(W(19),W(19));
#ifdef UP_APP_STORE
        _add.hidden = true;
#endif
    }
    return _add;
}
- (UIControl *)conAdd{
    if (!_conAdd) {
        _conAdd = [UIControl new];
        [_conAdd addTarget:self action:@selector(addClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _conAdd;
}
#pragma mark 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.productIV];
        [self.contentView addSubview:self.name];
        [self.contentView addSubview:self.num];
        [self.contentView addSubview:self.rmb];
        [self.contentView addSubview:self.price];
        [self.contentView addSubview:self.add];
        [self.contentView addSubview:self.conAdd];
    }
    return self;
}
#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelShopDetailProduct *)model{
    self.model = model;
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    
    [self.productIV sd_setImageWithURL:[NSURL URLWithString:UnPackStr(model.coverUrl)] placeholderImage:[UIImage imageNamed:IMAGE_BIG_DEFAULT]];
//    self.productIV.image = [UIImage imageNamed:@"temp_computer"];
    self.productIV.leftTop = XY(W(20),W(12.5));
    [self.name fitTitle:UnPackStr(model.name) variable:W(170)];
    self.name.leftTop = XY(self.productIV.right+ W(10),self.productIV.top+W(2));
    [self.num fitTitle:[NSString stringWithFormat:@"月售%.f",model.monthAmount] variable:W(170)];
    self.num.leftTop = XY(self.productIV.right +W(10),self.productIV.top+W(28));

    self.rmb.leftBottom = XY(self.productIV.right+W(10),self.productIV.bottom);
    
    [self.price fitTitle:[NSString stringWithFormat:@"%.2f",model.price/100.0] variable:W(90)];
    self.price.leftBottom = XY(self.rmb.right + W(5),self.productIV.bottom+W(2));
    

    self.add.leftBottom = XY( W(234),self.productIV.bottom);
    self.conAdd.frame = CGRectInset(self.add.frame, -W(30), -W(30));
    //设置总高度
    self.height = self.productIV.bottom + W(12.5);
}
- (void)addClick{
#ifdef UP_APP_STORE
    return;
#endif
    [GlobalMethod judgeLoginState:^{
        if (self.blockClick) {
                  self.blockClick(self.model);
        }
    }];
   
}
@end
