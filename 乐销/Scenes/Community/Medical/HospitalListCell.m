//
//  HospitalListView.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/21.
//Copyright © 2020 ping. All rights reserved.
//

#import "HospitalListCell.h"




@implementation HospitalListCell
#pragma mark 懒加载
- (UIImageView *)logo{
    if (_logo == nil) {
        _logo = [UIImageView new];
        _logo.image = [UIImage imageNamed:@"medical_default"];
        _logo.widthHeight = XY(W(65),W(65));
        _logo.contentMode = UIViewContentModeScaleAspectFill;
        _logo.clipsToBounds = true;
        [_logo addRoundCorner:UIRectCornerAllCorners radius:15 lineWidth:1 lineColor:[UIColor colorWithHexString:@"#EFF2F1"]];
    }
    return _logo;
}
- (UIImageView *)iconPhone{
    if (_iconPhone == nil) {
        _iconPhone = [UIImageView new];
        _iconPhone.image = [UIImage imageNamed:@"medical_call"];
        _iconPhone.widthHeight = XY(W(25),W(25));
    }
    return _iconPhone;
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
- (UILabel *)phone{
    if (_phone == nil) {
        _phone = [UILabel new];
        _phone.textColor = COLOR_666;
        _phone.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        _phone.numberOfLines = 1;
        _phone.lineSpace = 0;
    }
    return _phone;
}
- (UILabel *)address{
    if (_address == nil) {
        _address = [UILabel new];
        _address.textColor = COLOR_666;
        _address.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        _address.numberOfLines = 1;
        _address.lineSpace = 0;
    }
    return _address;
}
-(UIButton *)btnPhone{
    if (_btnPhone == nil) {
        _btnPhone = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnPhone.tag = 1;
        [_btnPhone addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnPhone;
}

#pragma mark 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.logo];
        [self.contentView addSubview:self.iconPhone];
        [self.contentView addSubview:self.name];
        [self.contentView addSubview:self.phone];
        [self.contentView addSubview:self.address];
        [self.contentView addSubview:self.btnPhone];
        
    }
    return self;
}
#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelHospital *)model{
    self.model = model;
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    [self.logo sd_setImageWithURL:[NSURL URLWithString:model.logoUrl] placeholderImage:[UIImage imageNamed:@"medical_default"]];
    self.logo.leftTop = XY(W(24.5),W(15));
    
    self.iconPhone.rightCenterY = XY(SCREEN_WIDTH - W(20),self.logo.centerY);
    [self.name fitTitle:UnPackStr(model.name) variable:W(200)];
    self.name.leftTop = XY(self.logo.right + W(9.5),self.logo.top+W(2));
    [self.phone fitTitle:[NSString stringWithFormat:@"电话:%@",UnPackStr(model.phone)] variable:W(200)];
    self.phone.leftTop = XY(self.logo.right +W(9.5),self.logo.top+W(28.5));
    [self.address fitTitle:[NSString stringWithFormat:@"地址:%@",UnPackStr(model.addr)] variable:W(200)];
    self.address.leftBottom = XY(self.logo.right +W(9.5),self.logo.bottom-W(2));
    
    //设置总高度
    self.height = self.logo.bottom + self.logo.top;
    self.btnPhone.widthHeight = XY(W(60), self.height);
    self.btnPhone.rightTop = XY(SCREEN_WIDTH,0);

}
#pragma mark 点击事件
- (void)btnClick:(UIButton *)sender{
    switch (sender.tag) {
        case 1:
        {
            NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel://%@",self.model.phone];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];

        }
            break;
            
        default:
            break;
    }
}

@end
