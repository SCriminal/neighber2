//
//  HailuoOrderListCell.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/8/19.
//Copyright © 2020 ping. All rights reserved.
//

#import "HailuoOrderListCell.h"

@interface HailuoOrderListCell ()

@end

@implementation HailuoOrderListCell
#pragma mark 懒加载
- (UIView *)BG{
    if (_BG == nil) {
        _BG = [UIView new];
        _BG.backgroundColor = [UIColor whiteColor];
        [GlobalMethod setRoundView:_BG color:[UIColor clearColor] numRound:10 width:0];
    }
    return _BG;
}
- (UILabel *)status{
    if (_status == nil) {
        _status = [UILabel new];
        _status.textColor = COLOR_ORANGE;
        _status.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
    }
    return _status;
}
- (UIImageView *)logo{
    if (_logo == nil) {
        _logo = [UIImageView new];
        _logo.widthHeight = XY(W(65),W(65));
        [_logo addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:5 lineWidth:1 lineColor:[UIColor colorWithHexString:@"#EFF2F1"]];
        

    }
    return _logo;
}
- (UILabel *)serveName{
    if (_serveName == nil) {
        _serveName = [UILabel new];
        _serveName.textColor = COLOR_666;
        _serveName.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        _serveName.numberOfLines = 1;
    }
    return _serveName;
}
- (UILabel *)serveTime{
    if (_serveTime == nil) {
        _serveTime = [UILabel new];
        _serveTime.textColor = COLOR_666;
        _serveTime.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        _serveTime.numberOfLines = 1;
    }
    return _serveTime;
}
- (UILabel *)companyName{
    if (_companyName == nil) {
        _companyName = [UILabel new];
        _companyName.textColor = COLOR_666;
        _companyName.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        _companyName.numberOfLines = 1;
    }
    return _companyName;
}
- (UILabel *)phone{
    if (_phone == nil) {
        _phone = [UILabel new];
        _phone.textColor = COLOR_666;
        _phone.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        _phone.numberOfLines = 1;

    }
    return _phone;
}

- (UIButton *)btnDismiss{
    if (!_btnDismiss) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.widthHeight = XY(W(85), W(25));
        btn.backgroundColor = [UIColor clearColor];
        [btn setTitle:@"取消申请" forState:UIControlStateNormal];
        btn.titleLabel.fontNum = F(13);
        [btn setTitleColor:COLOR_999 forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnDismissClick) forControlEvents:UIControlEventTouchUpInside];
        _btnDismiss = btn;
        [_btnDismiss addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:_btnDismiss.height/2.0 lineWidth:1 lineColor:COLOR_999];
        

    }
    return _btnDismiss;
}
#pragma mark 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = COLOR_GRAY;
        self.backgroundColor = COLOR_GRAY;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.BG];
    [self.contentView addSubview:self.status];
    [self.contentView addSubview:self.logo];
    [self.contentView addSubview:self.serveName];
    [self.contentView addSubview:self.serveTime];
    [self.contentView addSubview:self.companyName];
    [self.contentView addSubview:self.phone];
        [self.contentView addSubview:self.btnDismiss];

    }
    return self;
}
#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelHailuoOrder *)model{
    self.model = model;
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    [self.status fitTitle:model.statusMessage variable:0];
    self.status.rightTop = XY(SCREEN_WIDTH - W(20),W(20));

    CGFloat top = [self.contentView addLineFrame:CGRectMake(W(25), self.status.bottom + W(15), SCREEN_WIDTH - W(50), 1)];
    [self.logo sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:IMAGE_HEAD_COMPANY_DEFAULT]];
    self.logo.leftTop = XY(W(25),top+W(14));
    [self.serveName fitTitle:[NSString stringWithFormat:@"服务名称：%@",UnPackStr(model.name)] variable:W(220)];
    self.serveName.leftTop = XY(self.logo.right + W(10),self.logo.top+W(1));
    [self.serveTime fitTitle:[NSString stringWithFormat:@"服务时间：%@",UnPackStr(model.beginTime)] variable:W(220)];
    self.serveTime.leftTop = XY(self.logo.right + W(10),self.serveName.bottom+W(10));
    [self.companyName fitTitle:[NSString stringWithFormat:@"企业名称：%@",UnPackStr(model.companyName)] variable:W(220)];
    self.companyName.leftTop = XY(self.logo.right + W(10),self.serveTime.bottom+W(11));
    [self.phone fitTitle:[NSString stringWithFormat:@"企业电话：%@",UnPackStr(model.tel)] variable:W(220)];
    self.phone.leftTop = XY(self.logo.right + W(10),self.companyName.bottom+W(11));
    
    top = [self configBtn:self.phone.bottom + W(15)];
//    //设置总高度
    self.height = top;
}

- (CGFloat)configBtn:(CGFloat)top{
    CGFloat bottom = 0;
    self.btnDismiss.hidden = true;
     if (self.model.orderStatus == 0) {
        [self.contentView addLineFrame:CGRectMake(W(25), bottom, SCREEN_WIDTH - W(50), 1)];
        self.btnDismiss.hidden = false;
        self.btnDismiss.rightTop = XY(SCREEN_WIDTH -W(23.5), top + W(15));
        bottom = self.btnDismiss.bottom + W(15);
    }else  {
        bottom = top;
    }
    self.BG.frame = CGRectMake(W(10), W(5), SCREEN_WIDTH - W(20), bottom - W(5));
    
    return bottom+W(5);

}

- (void)btnDismissClick{
    if (self.blockDismiss) {
        self.blockDismiss(self.model);
    }
}
@end

