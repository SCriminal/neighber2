//
//  PersonalRentListCell.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/26.
//Copyright © 2020 ping. All rights reserved.
//

#import "PersonalRentListCell.h"

@interface PersonalRentListCell ()

@end

@implementation PersonalRentListCell
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
-(UIButton *)btnUpDown{
    if (_btnUpDown == nil) {
        _btnUpDown = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnUpDown.tag = 1;
        [_btnUpDown addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _btnUpDown.backgroundColor = [UIColor clearColor];
        _btnUpDown.titleLabel.font = [UIFont systemFontOfSize:F(13)];
        _btnUpDown.widthHeight = XY(W(65),W(25));

    }
    return _btnUpDown;
}
-(UIButton *)btnEdit{
    if (_btnEdit == nil) {
        _btnEdit = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnEdit.tag = 2;
        [_btnEdit addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _btnDelete.backgroundColor = [UIColor clearColor];
        [_btnEdit setTitle:@"编辑" forState:(UIControlStateNormal)];
        _btnEdit.titleLabel.font = [UIFont systemFontOfSize:F(13)];
        _btnEdit.widthHeight = XY(W(65),W(25));
        [_btnEdit addRoundCorner:UIRectCornerAllCorners radius:_btnEdit.height/2.0 lineWidth:1 lineColor:COLOR_ORANGE];
        [_btnEdit setTitleColor:COLOR_ORANGE forState:UIControlStateNormal];

    }
    return _btnEdit;
}
-(UIButton *)btnDelete{
    if (_btnDelete == nil) {
        _btnDelete = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnDelete.tag = 3;
        [_btnDelete addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _btnDelete.backgroundColor = [UIColor clearColor];
        [_btnDelete setTitle:@"删除" forState:(UIControlStateNormal)];
        _btnDelete.titleLabel.font = [UIFont systemFontOfSize:F(13)];
        _btnDelete.widthHeight = XY(W(65),W(25));
        [_btnDelete addRoundCorner:UIRectCornerAllCorners radius:_btnDelete.height/2.0 lineWidth:1 lineColor:COLOR_RED];
        [_btnDelete setTitleColor:COLOR_RED forState:UIControlStateNormal];

    }
    return _btnDelete;
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
        [self.contentView addSubview:self.btnUpDown];
        [self.contentView addSubview:self.btnEdit];
        [self.contentView addSubview:self.btnDelete];

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

    self.btnDelete.rightTop = XY(SCREEN_WIDTH - W(20),self.icon.bottom+W(15));


    self.btnEdit.rightTop = XY(self.btnDelete.left - W(15),self.btnDelete.top);
    
    self.btnUpDown.rightTop = XY(self.btnEdit.left - W(15),self.btnDelete.top);
    self.btnUpDown.hidden = !(self.model.status == 21||self.model.status == 9);

    if (self.model.status == 99) {
        self.btnEdit.hidden = true;
        self.btnDelete.hidden = true;
        //设置总高度
        self.height = self.icon.bottom + self.icon.top;
        [self.contentView addLineFrame:CGRectMake(W(20), self.height -1, SCREEN_WIDTH - W(40), 1)];
    }else{
        //交易板状态 1提交 2审核中 11未通过 9已上架 21已下架 99关闭
        self.btnEdit.hidden = false;
        self.btnDelete.hidden = false;
        self.height = self.btnDelete.bottom + self.icon.top;
        if (self.model.status == 9) {
            [self.btnUpDown setTitle:@"下架" forState:UIControlStateNormal];
            [self.btnUpDown setTitleColor:COLOR_999 forState:UIControlStateNormal];
            [self.btnUpDown addRoundCorner:UIRectCornerAllCorners radius:self.btnUpDown.height/2.0 lineWidth:1 lineColor:COLOR_999];

        }else if (self.model.status == 21){
            [self.btnUpDown setTitle:@"上架" forState:UIControlStateNormal];
            [self.btnUpDown setTitleColor:COLOR_GREEN forState:UIControlStateNormal];
            [self.btnUpDown addRoundCorner:UIRectCornerAllCorners radius:self.btnUpDown.height/2.0 lineWidth:1 lineColor:COLOR_GREEN];
        }
        [self.contentView addLineFrame:CGRectMake(W(20), self.height -1, SCREEN_WIDTH - W(40), 1)];

    }
}


#pragma mark 点击事件
- (void)btnClick:(UIButton *)sender{
    switch (sender.tag) {
        case 1://up down
        {
            if (self.blockUpDown) {
                self.blockUpDown(self.model);
            }
        }
            break;
        case 2://edit
        {
            if (self.blockEdit) {
                self.blockEdit(self.model);
            }
        }
            break;
        case 3://delete
        {
            [GlobalMethod showEditAlertWithTitle:@"提示" content:@"确定要删除吗" dismiss:^{
                
            } confirm:^{
                if (self.blockDelete) {
                    self.blockDelete(self.model);
                }
            } view:GB_Nav.lastVC.view];
        }
            break;
        default:
            break;
    }
}

@end
