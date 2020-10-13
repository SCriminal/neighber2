//
//  RentInfoListCell.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/21.
//Copyright © 2020 ping. All rights reserved.
//

#import "RentInfoListCell.h"

@interface RentInfoListCell ()

@end

@implementation RentInfoListCell
#pragma mark 懒加载
- (UIImageView *)icon{
    if (_icon == nil) {
        _icon = [UIImageView new];
        _icon.contentMode = UIViewContentModeScaleAspectFill;
        _icon.clipsToBounds = true;
        _icon.widthHeight = XY(W(65),W(65));
        [_icon addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:5 lineWidth:0 lineColor:[UIColor clearColor]];
        

    }
    return _icon;
}
- (UILabel *)info{
    if (_info == nil) {
        _info = [UILabel new];
        _info.textColor = COLOR_333;
        _info.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightMedium];
        _info.numberOfLines = 1;
        _info.lineSpace = 0;
    }
    return _info;
}
- (UILabel *)square{
    if (_square == nil) {
        _square = [UILabel new];
        _square.textColor = COLOR_666;
        _square.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        _square.numberOfLines = 1;
        _square.lineSpace = 0;
    }
    return _square;
}
- (UILabel *)direction{
    if (_direction == nil) {
        _direction = [UILabel new];
        _direction.textColor = COLOR_666;
        _direction.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        _direction.numberOfLines = 1;
        _direction.lineSpace = 0;
    }
    return _direction;
}
- (UILabel *)price{
    if (_price == nil) {
        _price = [UILabel new];
        _price.textColor = [UIColor colorWithHexString:@"#FE533F"];
        _price.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightMedium];
        _price.numberOfLines = 1;
        _price.lineSpace = 0;
    }
    return _price;
}
- (UILabel *)unit{
    if (_unit == nil) {
        _unit = [UILabel new];
        _unit.textColor = [UIColor colorWithHexString:@"#FE533F"];
        _unit.font =  [UIFont systemFontOfSize:F(11) weight:UIFontWeightRegular];
        _unit.numberOfLines = 1;
        _unit.lineSpace = 0;
    }
    return _unit;
}

#pragma mark 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.icon];
        [self.contentView addSubview:self.info];
        [self.contentView addSubview:self.square];
        [self.contentView addSubview:self.direction];
        [self.contentView addSubview:self.price];
        [self.contentView addSubview:self.unit];
        
    }
    return self;
}
#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelRentInfo *)model{
    self.model = model;
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    
    [self.icon sd_setImageWithURL:[NSURL URLWithString:model.coverUrl] placeholderImage:[UIImage imageNamed:IMAGE_BIG_DEFAULT]];
    self.icon.leftTop = XY(W(20),W(15));
    
    [self.info fitTitle:[NSString stringWithFormat:@"%@ | %@ %@",model.rentModeShow,UnPackStr(model.estateName),UnPackStr(model.title)] variable:W(260)];
    self.info.leftTop = XY(self.icon.right + W(10),self.icon.top+W(2));
    
    [self.square fitTitle:[NSString stringWithFormat:@"%@㎡",[NSDecimalNumber numberWithDouble:model.floorage].stringValue] variable:W(100)];
    self.square.leftTop = XY(self.info.left,self.icon.top+W(28));
    [self.direction fitTitle:model.directionShow variable:W(100)];
    self.direction.leftTop = XY(self.square.right + W(20),self.square.top);
    [self.price fitTitle:NSNumber.price(model.price).stringValue variable:W(100)];
    self.price.leftBottom = XY(self.info.left,self.icon.bottom-W(2));
    [self.unit fitTitle:model.rentPriceUnitShow variable:0];
    self.unit.leftBottom = XY(self.price.right + W(2),self.price.bottom);
    
    //设置总高度
    self.height = self.icon.bottom + self.icon.top;
}

@end
