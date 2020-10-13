//
//  HouseKeepingView.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/8/14.
//Copyright © 2020 ping. All rights reserved.
//

#import "HouseKeepingView.h"

@implementation HouseKeepingTopView
#pragma mark 懒加载
- (UIImageView *)BG{
    if (_BG == nil) {
        _BG = [UIImageView new];
        _BG.image = [UIImage imageNamed:@"houseKeeping_topBG"];
    }
    return _BG;
}
- (BaseNavView *)nav{
    if (!_nav) {
        _nav = [BaseNavView initNavBackTitle:@"家政服务" rightView:nil];
        _nav.backgroundColor = [UIColor clearColor];
        WEAKSELF
        _nav.blockBack = ^{
            if (weakSelf.blockBack) {
                weakSelf.blockBack();
            }
        };
    }
    return _nav;
}
- (UIImageView *)icon{
    if (_icon == nil) {
        _icon = [UIImageView new];
        _icon.image = [UIImage imageNamed:@"houseKeeping_topIcon"];
        _icon.widthHeight = XY(W(148),W(48));
    }
    return _icon;
}
- (UILabel *)runningNum{
    if (_runningNum == nil) {
        _runningNum = [UILabel new];
        _runningNum.textColor = COLOR_333;
        _runningNum.font =  [UIFont systemFontOfSize:F(20) weight:UIFontWeightMedium];
    }
    return _runningNum;
}
- (UILabel *)commentNum{
    if (_commentNum == nil) {
        _commentNum = [UILabel new];
        _commentNum.textColor = COLOR_333;
        _commentNum.font =  [UIFont systemFontOfSize:F(20) weight:UIFontWeightMedium];
    }
    return _commentNum;
}
- (UILabel *)completeNum{
    if (_completeNum == nil) {
        _completeNum = [UILabel new];
        _completeNum.textColor = COLOR_333;
        _completeNum.font =  [UIFont systemFontOfSize:F(20) weight:UIFontWeightMedium];
    }
    return _completeNum;
}
- (UILabel *)sellAfterNum{
    if (_sellAfterNum == nil) {
        _sellAfterNum = [UILabel new];
        _sellAfterNum.textColor = COLOR_333;
        _sellAfterNum.font =  [UIFont systemFontOfSize:F(20) weight:UIFontWeightMedium];
    }
    return _sellAfterNum;
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.widthHeight = XY(SCREEN_WIDTH,W(154)+iphoneXTopInterval);
        [self addSubView];
    }
    return self;
}
//添加subview
- (void)addSubView{
        [self addSubview:self.BG];
    [self addSubview:self.nav];
    [self addSubview:self.icon];
//    [self addSubview:self.runningNum];
//    [self addSubview:self.commentNum];
//    [self addSubview:self.completeNum];
//    [self addSubview:self.sellAfterNum];

    //初始化页面
    [self configView];
}

#pragma mark 刷新view
- (void)configView{
    //刷新view
    self.BG.widthHeight = XY(SCREEN_WIDTH,self.height);
    
    self.icon.leftTop = XY(W(26),self.nav.bottom+W(16));
    
    UIImageView * iv = [UIImageView new];
    iv.backgroundColor = [UIColor clearColor];
    iv.contentMode = UIViewContentModeScaleAspectFill;
    iv.clipsToBounds = true;
    iv.image = [UIImage imageNamed:@"arrow_right"];
    iv.widthHeight = XY(W(15),W(15));
    iv.rightCenterY = XY(SCREEN_WIDTH - W(15),self.icon.centerY);
    [self addSubview:iv];
    
    UILabel * l = [UILabel new];
    l.font = [UIFont systemFontOfSize:F(16) weight:UIFontWeightRegular];
    l.textColor = COLOR_333;
    l.backgroundColor = [UIColor clearColor];
    [l fitTitle:@"我的服务订单" variable:SCREEN_WIDTH - W(30)];
    l.rightCenterY = XY(iv.left - W(5), self.icon.centerY);
    [self addSubview:l];
    
    [self addControlFrame:CGRectInset(l.frame, -W(10), -W(20)) target:self action:@selector(orderListClick)];

    //    [self.runningNum fitTitle:@"0" variable:0];
//    self.runningNum.rightTop = XY(W(121),self.icon.top);
//
//    [self.commentNum fitTitle:@"0" variable:0];
//    self.commentNum.rightTop = XY(W(186),self.icon.top);
//
//    [self.completeNum fitTitle:@"0" variable:0];
//    self.completeNum.rightTop = XY(W(250),self.icon.top);
//
//    [self.sellAfterNum fitTitle:@"0" variable:0];
//    self.sellAfterNum.rightTop = XY(W(315),self.icon.top);
//
//    [self addLabel:@[self.runningNum,self.commentNum,self.completeNum,self.sellAfterNum] :@[@"进行中",@"待评价",@"已完成",@"售后"]];
    
}
- (void)orderListClick{
    [GlobalMethod judgeLoginState:^{
        [GB_Nav pushVCName:@"HailuoOrderManagementVC" animated:true];
    }];
}
- (void)addLabel:(NSArray *)ary :(NSArray *)aryTitle{
    for (int i = 0; i< ary.count; i++) {
        UIView * label = ary[i];
        NSString * str = aryTitle[i];
        {
                   UILabel * l = [UILabel new];
                   l.font = [UIFont systemFontOfSize:F(11) weight:UIFontWeightRegular];
                   l.textColor = COLOR_333;
                   l.backgroundColor = [UIColor clearColor];
                   l.numberOfLines = 0;
                   l.lineSpace = W(0);
                   [l fitTitle:@"单" variable:0];
                   l.leftTop = XY(label.right + W(3),label.top + W(8));
                   [self addSubview:l];
               }
               {
                   UILabel * l = [UILabel new];
                   l.font = [UIFont systemFontOfSize:F(11) weight:UIFontWeightRegular];
                   l.textColor = COLOR_333;
                   l.backgroundColor = [UIColor clearColor];
                   l.numberOfLines = 0;
                   l.lineSpace = W(0);
                   [l fitTitle:str variable:0];
                   l.centerXBottom = XY(label.right + W(1.5),self.icon.bottom - W(1));
                   [self addSubview:l];
               }
    }
   
    
}
#pragma mark 刷新view
- (void)resetViewWithModel:(id)model{
    
}
@end



@implementation HouseKeepingAuntCell
#pragma mark 懒加载
- (UIImageView *)logo{
    if (_logo == nil) {
        _logo = [UIImageView new];
        _logo.image = [UIImage imageNamed:IMAGE_HEAD_COMPANY_DEFAULT];
        _logo.widthHeight = XY(W(65),W(65));
        [_logo addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:5 lineWidth:1 lineColor:[UIColor colorWithHexString:@"#EFF2F1"]];
    }
    return _logo;
}
- (UILabel *)name{
    if (_name == nil) {
        _name = [UILabel new];
        _name.textColor = COLOR_333;
        _name.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightMedium];
        _name.numberOfLines = 1;
    }
    return _name;
}
- (UILabel *)age{
    if (_age == nil) {
        _age = [UILabel new];
        _age.textColor = COLOR_666;
        _age.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        _age.numberOfLines = 1;
    }
    return _age;
}
- (UILabel *)label{
    if (_label == nil) {
        _label = [UILabel new];
        _label.textColor = [UIColor whiteColor];
        _label.backgroundColor = COLOR_ORANGE;
        _label.font =  [UIFont systemFontOfSize:F(11) weight:UIFontWeightMedium];
        _label.numberOfLines = 1;
        _label.textAlignment = NSTextAlignmentCenter;
        _label.height = W(18);
        [GlobalMethod setRoundView:_label color:[UIColor clearColor] numRound:2 width:0];
    }
    return _label;
}

- (UIImageView *)star{
    if (_star == nil) {
        _star = [UIImageView new];
        _star.image = [UIImage imageNamed:@"shope_star"];
        _star.widthHeight = XY(W(12),W(12));
    }
    return _star;
}
- (UILabel *)grade{
    if (_grade == nil) {
        _grade = [UILabel new];
        _grade.textColor = COLOR_ORANGE;
        _grade.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
    }
    return _grade;
}
- (UILabel *)comment{
    if (_comment == nil) {
        _comment = [UILabel new];
        _comment.textColor = COLOR_666;
        _comment.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
    }
    return _comment;
}
- (UILabel *)price{
    if (_price == nil) {
        _price = [UILabel new];
        _price.textColor = COLOR_RED;
        _price.font =  [UIFont systemFontOfSize:F(20) weight:UIFontWeightMedium];
    }
    return _price;
}
- (UILabel *)rmb{
    if (_rmb == nil) {
        _rmb = [UILabel new];
        _rmb.textColor = COLOR_RED;
        _rmb.font =  [UIFont systemFontOfSize:F(13) weight:UIFontWeightMedium];
        [_rmb fitTitle:@"¥" variable:0];
    }
    return _rmb;
}
#pragma mark 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.logo];
        [self.contentView addSubview:self.label];
    [self.contentView addSubview:self.name];
    [self.contentView addSubview:self.age];
    [self.contentView addSubview:self.rmb];
    [self.contentView addSubview:self.star];
    [self.contentView addSubview:self.grade];
    [self.contentView addSubview:self.comment];
    [self.contentView addSubview:self.price];

    }
    return self;
}
#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelHailuoAunt *)model{
    self.model = model;
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    
    [self.logo sd_setImageWithURL:[NSURL URLWithString:UnPackStr(model.photo)] placeholderImage:[UIImage imageNamed:IMAGE_HEAD_DEFAULT]];
    self.logo.leftTop = XY(W(20),W(15));
    
    [self.name fitTitle:UnPackStr(model.name) variable:W(150)];
    self.name.leftTop = XY(self.logo.right + W(10),self.logo.top);
    
    self.label.text =  model.creditShow;
    self.label.width = [UILabel fetchWidthFontNum:self.label.fontNum text:self.label.text]+ W(12);
    self.label.leftCenterY = XY(self.name.right + W(10), self.name.centerY);
    
    [self.age fitTitle:[NSString stringWithFormat:@"%@岁 从业%@年 %@",NSNumber.lon(model.age),NSNumber.lon(model.workingYears),UnPackStr(model.address)] variable:W(270)];
    self.age.leftTop = XY(self.name.left,self.logo.top+W(27));

    self.star.leftBottom = XY(self.name.left,self.logo.bottom-W(2));
    [self.grade fitTitle:UnPackStr(model.start) variable:0];
    self.grade.leftCenterY = XY(self.star.right + W(6),self.star.centerY);
    
    [self.comment fitTitle:[NSString stringWithFormat:@"已售%@单 满意度%@%% （%@条评价）",NSNumber.lon(model.orderCount),NSNumber.lon(model.good.doubleValue*100.0),NSNumber.lon(model.commentCount)] variable:W(220)];
    self.comment.leftCenterY = XY(self.grade.right + W(10),self.grade.centerY);
    [self.price fitTitle:[NSString stringWithFormat:@"%@",NSNumber.lon(model.estimatePrice)] variable:0];
    self.price.rightTop = XY(SCREEN_WIDTH - W(20),self.logo.top);
    self.rmb.rightBottom = XY(self.price.left - W(3),self.price.bottom);

    //设置总高度
    self.height = self.logo.bottom + W(15);
}

@end

@implementation HouseKeepingOrganizeCell
#pragma mark 懒加载
- (UIImageView *)logo{
    if (_logo == nil) {
        _logo = [UIImageView new];
        _logo.image = [UIImage imageNamed:IMAGE_HEAD_COMPANY_DEFAULT];
        _logo.widthHeight = XY(W(65),W(65));
        [_logo addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:5 lineWidth:1 lineColor:[UIColor colorWithHexString:@"#EFF2F1"]];
    }
    return _logo;
}
- (UILabel *)name{
    if (_name == nil) {
        _name = [UILabel new];
        _name.textColor = COLOR_333;
        _name.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightMedium];
        _name.numberOfLines = 1;
    }
    return _name;
}
- (UILabel *)age{
    if (_age == nil) {
        _age = [UILabel new];
        _age.textColor = COLOR_666;
        _age.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        _age.numberOfLines = 1;
    }
    return _age;
}

- (UIImageView *)star{
    if (_star == nil) {
        _star = [UIImageView new];
        _star.image = [UIImage imageNamed:@"shope_star"];
        _star.widthHeight = XY(W(12),W(12));
    }
    return _star;
}
- (UILabel *)grade{
    if (_grade == nil) {
        _grade = [UILabel new];
        _grade.textColor = COLOR_ORANGE;
        _grade.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
    }
    return _grade;
}
- (UILabel *)comment{
    if (_comment == nil) {
        _comment = [UILabel new];
        _comment.textColor = COLOR_666;
        _comment.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
    }
    return _comment;
}
- (UILabel *)price{
    if (_price == nil) {
        _price = [UILabel new];
        _price.textColor = COLOR_RED;
        _price.font =  [UIFont systemFontOfSize:F(20) weight:UIFontWeightMedium];
    }
    return _price;
}
- (UILabel *)rmb{
    if (_rmb == nil) {
        _rmb = [UILabel new];
        _rmb.textColor = COLOR_RED;
        _rmb.font =  [UIFont systemFontOfSize:F(13) weight:UIFontWeightMedium];
        [_rmb fitTitle:@"¥" variable:0];
    }
    return _rmb;
}
#pragma mark 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.logo];
    [self.contentView addSubview:self.name];
    [self.contentView addSubview:self.age];
//    [self.contentView addSubview:self.rmb];
    [self.contentView addSubview:self.star];
    [self.contentView addSubview:self.grade];
    [self.contentView addSubview:self.comment];
//    [self.contentView addSubview:self.price];

    }
    return self;
}
#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelHailuoCompany *)model{
    self.model = model;
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    
    [self.logo sd_setImageWithURL:[NSURL URLWithString:model.companyImg] placeholderImage:[UIImage imageNamed:IMAGE_HEAD_COMPANY_DEFAULT]];
    self.logo.leftTop = XY(W(20),W(15));
    [self.name fitTitle:UnPackStr(model.companyName) variable:W(270)];
    self.name.leftTop = XY(self.logo.right + W(10),self.logo.top);
    [self.age fitTitle:[NSString stringWithFormat:@"满意度%@%% （%@条评价）",NSNumber.lon(model.satisfaction.doubleValue*100.0),NSNumber.lon(model.commentCount)] variable:W(270)];
    self.age.leftTop = XY(self.name.left,self.logo.top+W(27));

    self.star.leftBottom = XY(self.name.left,self.logo.bottom-W(2));
    [self.grade fitTitle:@"5.0" variable:0];
    self.grade.leftCenterY = XY(self.star.right + W(6),self.star.centerY);
    
    [self.comment fitTitle:[NSString stringWithFormat:@"已售%@单",NSNumber.lon(model.orderCount)] variable:W(220)];
    self.comment.leftCenterY = XY(self.grade.right + W(10),self.grade.centerY);

    //设置总高度
    self.height = self.logo.bottom + W(15);
}
@end
