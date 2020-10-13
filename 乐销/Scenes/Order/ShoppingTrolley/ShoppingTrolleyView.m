//
//  ShoppingTrolleyView.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/12.
//Copyright © 2020 ping. All rights reserved.
//

#import "ShoppingTrolleyView.h"

@interface ShoppingTrolleySectionTopView ()

@end

@implementation ShoppingTrolleySectionTopView
#pragma mark 懒加载
- (UIImageView *)iconSelected{
    if (_iconSelected == nil) {
        _iconSelected = [UIImageView new];
        _iconSelected.image = [UIImage imageNamed:@"select_default"];
        _iconSelected.highlightedImage =[UIImage imageNamed:@"select_highlighted"];
        _iconSelected.widthHeight = XY(W(16),W(16));
    }
    return _iconSelected;
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
- (UIImageView *)arrow{
    if (_arrow == nil) {
        _arrow = [UIImageView new];
        _arrow.image = [UIImage imageNamed:@"arrow_right"];
        _arrow.widthHeight = XY(W(15),W(15));
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
- (UIControl *)conSelect{
    if (!_conSelect) {
        _conSelect = [UIControl new];
        [_conSelect addTarget:self action:@selector(selectClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _conSelect;
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
    [self addSubview:self.iconSelected];
    [self addSubview:self.name];
    [self addSubview:self.arrow];
    [self addSubview:self.conSelect];

    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelTrolley *)model{
    self.model = model;
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    

    self.iconSelected.leftTop = XY(W(27.5),W(29.5));
    [self.name fitTitle:UnPackStr(model.name) variable:W(280)];
    self.name.leftCenterY = XY(self.iconSelected.right + W(9.5),self.iconSelected.centerY);
    
    self.arrow.leftCenterY = XY(self.name.right + W(5),self.name.centerY);
    
    //设置总高度
    self.height = self.name.bottom + W(10);
    self.whiteBG.widthHeight = XY(W(345),self.height - W(15));
    [self.whiteBG addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight radius:(10)];
    self.whiteBG.centerXTop = XY(SCREEN_WIDTH/2.0,W(15));
    self.conSelect.widthHeight = XY(W(53), self.height);
    self.iconSelected.highlighted = model.selected;
}
-(void)selectClick{
    self.iconSelected.highlighted = !self.iconSelected.highlighted;
    if (self.blockSelect) {
        self.blockSelect(self.iconSelected.highlighted,self.model);
    }
}
@end



@implementation ShoppingTrolleySectionBottomView
#pragma mark 懒加载
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
        self.clipsToBounds = true;
        self.width = SCREEN_WIDTH;
        [self addSubView];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.whiteBG];
    
    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    
    
    //设置总高度
    self.height =  W(10);
    self.whiteBG.widthHeight = XY(W(345), 20);
    [self.whiteBG addRoundCorner:UIRectCornerBottomLeft|UIRectCornerBottomRight radius:(10)];
    self.whiteBG.centerXBottom = XY(SCREEN_WIDTH/2.0,self.height);
    
}

@end



@implementation ShoppingTrolleyCell
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
        _add.image = [UIImage imageNamed:@"shope_num"];
        _add.widthHeight = XY(W(90 ),W(25));
    }
    return _add;
}
- (UIImageView *)iconSelected{
    if (_iconSelected == nil) {
        _iconSelected = [UIImageView new];
        _iconSelected.image = [UIImage imageNamed:@"select_default"];
        _iconSelected.highlightedImage =[UIImage imageNamed:@"select_highlighted"];
        _iconSelected.widthHeight = XY(W(16),W(16));
        _iconSelected.highlighted = true;
    }
    return _iconSelected;
}
- (UIView *)whiteBG{
    if (_whiteBG == nil) {
        _whiteBG = [UIView new];
        _whiteBG.backgroundColor = [UIColor whiteColor];
    }
    return _whiteBG;
}
- (UIControl *)conAdd{
    if (!_conAdd) {
        _conAdd = [UIControl new];
        [_conAdd addTarget:self action:@selector(addClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _conAdd;
}
- (UIControl *)conMinus{
    if (!_conMinus) {
        _conMinus = [UIControl new];
        [_conMinus addTarget:self action:@selector(minusClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _conMinus;
}
- (UIControl *)conSelect{
    if (!_conSelect) {
        _conSelect = [UIControl new];
        [_conSelect addTarget:self action:@selector(selectClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _conSelect;
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
        [self.contentView addSubview:self.add];
        [self.contentView addSubview:self.number];
        [self.contentView addSubview:self.iconSelected];
        [self.contentView addSubview:self.conAdd];
        [self.contentView addSubview:self.conMinus];
        [self.contentView addSubview:self.conSelect];

    }
    return self;
}
#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelIntegralProduct *)model{
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    self.modelProduct = model;
    [self.productIV sd_setImageWithURL:[NSURL URLWithString:model.coverUrl] placeholderImage:[UIImage imageNamed:IMAGE_BIG_DEFAULT]];
    self.productIV.leftTop = XY(W(53),W(10));
    [self.name fitTitle:UnPackStr(model.name) variable:W(170)];
    self.name.leftTop = XY(self.productIV.right+ W(10),self.productIV.top);
    
    self.rmb.leftBottom = XY(self.productIV.right+W(10),self.productIV.bottom-W(3));
    
    [self.price fitTitle:NSNumber.price(model.price).stringValue variable:W(90)];
    self.price.leftBottom = XY(self.rmb.right + W(5),self.productIV.bottom-W(3));
    
    
    self.add.rightBottom = XY( SCREEN_WIDTH - W(30),self.productIV.bottom);
    [self.number fitTitle:NSNumber.dou(model.qty).stringValue variable:0];
    self.number.centerXCenterY = self.add.centerXCenterY;
    
    self.conAdd.frame = CGRectMake(self.add.right - W(25), self.add.top-W(10), W(50), self.add.height + W(20));
    self.conMinus.frame = CGRectMake(self.add.left - W(25), self.add.top-W(10), W(50), self.add.height + W(20));

    //设置总高度
    self.height = self.productIV.bottom + W(10);
    
    self.iconSelected.leftCenterY = XY(W(28), self.height/2.0);
    self.iconSelected.highlighted = model.selected;
    self.conSelect.widthHeight = XY(self.productIV.left, self.height);

    self.whiteBG.widthHeight = XY(W(345), self.height);
    self.whiteBG.centerX = SCREEN_WIDTH/2.0;
}
#pragma mark click
-(void)addClick{
    if (self.blockAddClick) {
        self.blockAddClick(self.modelProduct);
    }
}
-(void)minusClick{
    if (self.blockMinusClick) {
        self.blockMinusClick(self.modelProduct);
    }
}
-(void)selectClick{
    self.modelProduct.selected = !self.modelProduct.selected;
    if (self.blockSelected) {
        self.blockSelected(self.modelProduct);
    }
}
@end



@implementation ShoppingTrolleyBottomView
#pragma mark 懒加载
- (UILabel *)price{
    if (_price == nil) {
        _price = [UILabel new];
        _price.textColor = [UIColor colorWithHexString:@"#FE533F"];
        _price.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
    }
    return _price;
}
- (UILabel *)all{
    if (_all == nil) {
        _all = [UILabel new];
        _all.textColor = COLOR_333;
        _all.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
    }
    return _all;
}
- (UILabel *)num{
    if (_num == nil) {
        _num = [UILabel new];
        _num.textColor = COLOR_333;
        _num.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        [_num fitTitle:@"全选" variable:0];
    }
    return _num;
}
- (UIImageView *)ivSelected{
    if (!_ivSelected) {
        _ivSelected = [UIImageView new];
        _ivSelected.image = [UIImage imageNamed:@"select_default"];
        _ivSelected.highlightedImage = [UIImage imageNamed:@"select_highlighted"];
        _ivSelected.widthHeight = XY(W(15), W(15));
    }
    return _ivSelected;
}
- (YellowButton *)submit{
    if (!_submit) {
        _submit = [YellowButton new];
        [_submit resetViewWithWidth:W(96.5) :W(37) :@"结算"];
        WEAKSELF
        _submit.blockClick = ^{
            if (weakSelf.blockSubmitClick) {
                weakSelf.blockSubmitClick();
            }
        };
    }
    return _submit;
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
        [self addSubview:self.price];
    [self addSubview:self.all];
    [self addSubview:self.num];
    [self addSubview:self.submit];
    [self addSubview:self.ivSelected];

    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(NSMutableArray *)arys{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    self.submit.rightTop = XY(SCREEN_WIDTH - W(10),W(6));

    self.ivSelected.leftCenterY = XY(W(15), self.submit.centerY);
    self.num.leftCenterY = XY(self.ivSelected.right + W(10),self.submit.centerY);
    [self addControlFrame:CGRectMake(0, 0, W(70), W(50)) target:self action:@selector(selectAllClick)];
    
    CGFloat numAll = 0;
    for (ModelIntegralProduct * modelPro in arys) {
        if (modelPro.selected) {
            numAll += modelPro.qty*modelPro.price;
        }
    }
    
    [self.price fitTitle:[
                          NSString stringWithFormat:@"¥ %@",NSNumber.price(numAll).stringValue]
 variable:0];
    self.price.rightCenterY = XY(self.submit.left - W(15),self.submit.centerY);
    [self.all fitTitle:@"合计: " variable:0];
    self.all.rightCenterY = XY(self.price.left - W(0),self.price.centerY);

    //设置总高度
    self.height = self.submit.bottom + self.submit.top + iphoneXBottomInterval;
}

- (void)selectAllClick{
    self.ivSelected.highlighted = !self.ivSelected.highlighted;
    if (self.blockSelectAll) {
        self.blockSelectAll(self.ivSelected.highlighted);
    }
}

@end
