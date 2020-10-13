//
//  HailuoCompanyView.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/8/15.
//Copyright © 2020 ping. All rights reserved.
//

#import "HailuoCompanyView.h"

@interface HailuoCompanyInfoView ()

@end

@implementation HailuoCompanyInfoView
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


#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];//背景色
        self.width = SCREEN_WIDTH;//默认宽度
        [self addSubView];//添加子视图
    }
    return self;
}
//添加subview
- (void)addSubView{
    //初始化页面
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.logo];
        [self addSubview:self.name];
        [self addSubview:self.age];
    //    [self addSubview:self.rmb];
        [self addSubview:self.star];
        [self addSubview:self.grade];
        [self addSubview:self.comment];
    //    [self addSubview:self.price];
    [self resetViewWithModel:nil];
}

#pragma mark 刷新cell
- (void)resetViewWithModel:(ModelHailuoCompany *)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    self.model = model;
      [self removeSubViewWithTag:TAG_LINE];//移除线
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
    self.height = self.logo.bottom + W(20);
    [self addLineFrame:CGRectMake(W(15), self.height - 1, SCREEN_WIDTH - W(30), 1)];
}


@end



@implementation HailuoCompanyQualificationView

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.width = SCREEN_WIDTH;
        [self resetViewWithModel:nil];
    }
    return self;
}

- (void)resetViewWithModel:(ModelHailuoCompany *)model{
    [self removeAllSubViews];
    UILabel * l = [UILabel new];
       l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightMedium];
       l.textColor = COLOR_333;
       l.backgroundColor = [UIColor clearColor];
       [l fitTitle:@"资质认证" variable:0];
       l.leftTop = XY(W(15), W(20));
       [self addSubview:l];
       
       CGFloat top = l.bottom + W(10);
       NSArray * ary = @[@"实名商家",@"审核通过",@"资质认证",@"身份认证",@"营业执照"];
    NSArray * aryImageName = @[@"houseKeepingQualification5",@"houseKeepingQualification4",@"houseKeepingQualification1",@"houseKeepingQualification0",@"houseKeepingQualification6"];

    NSArray * aryCertify = @[NSNumber.lon(model.isReal == 0),NSNumber.lon(model.isCheck == 1),NSNumber.lon(1),NSNumber.lon(model.isIdentityCheck == 1),NSNumber.lon(isStr(model.charter))];

    NSArray * aryLeft = @[NSNumber.dou(W(15)),NSNumber.dou(W(89)),NSNumber.dou(W(162.5)),NSNumber.dou(W(236.5)),NSNumber.dou(W(310))];
       for (int i = 0; i<ary.count; i++) {
           NSString * strTitle = ary[i];
           CGFloat left = [aryLeft[i] doubleValue];
           BOOL checked = [aryCertify[i] boolValue];
           UIImageView * iv = [UIImageView new];
           iv.backgroundColor = [UIColor clearColor];
           iv.contentMode = UIViewContentModeScaleAspectFill;
           iv.clipsToBounds = true;
           iv.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@",aryImageName[i],checked?@"":@"_anti"]];
           iv.widthHeight = XY(W(50),W(50));
           iv.leftTop = XY(left,top);
           [self addSubview:iv];

           UILabel * l = [UILabel new];
           l.font = [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
           l.textColor = [UIColor colorWithHexString:@"#717273"];
           l.backgroundColor = [UIColor clearColor];
           [l fitTitle:strTitle variable:SCREEN_WIDTH - W(30)];
           l.centerXTop = XY(iv.centerX,iv.bottom + W(5));
           [self addSubview:l];
           
           self.height =l.bottom + W(20);
       }
       [self addLineFrame:CGRectMake(W(15), self.height - 1, SCREEN_WIDTH - W(30), 1)];
}


@end


@implementation HailuoCompanyAddressView
#pragma mark 懒加载
- (UILabel *)address{
    if (_address == nil) {
        _address = [UILabel new];
        _address.textColor = COLOR_333;
        _address.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _address.numberOfLines = 1;
    }
    return _address;
}
- (UILabel *)phone{
    if (_phone == nil) {
        _phone = [UILabel new];
        _phone.textColor = COLOR_333;
        _phone.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _phone.numberOfLines = 1;
    }
    return _phone;
}
- (UIImageView *)iconPhone{
    if (_iconPhone == nil) {
        _iconPhone = [UIImageView new];
        _iconPhone.image = [UIImage imageNamed:@"houseKeeping_phone"];
        _iconPhone.widthHeight = XY(W(20),W(20));
    }
    return _iconPhone;
}
- (UIImageView *)iconAddress{
    if (_iconAddress == nil) {
        _iconAddress = [UIImageView new];
        _iconAddress.image = [UIImage imageNamed:@"houseKeeping_address"];
        _iconAddress.widthHeight = XY(W(20),W(20));
    }
    return _iconAddress;
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
        [self addSubview:self.address];
    [self addSubview:self.phone];
    [self addSubview:self.iconPhone];
    [self addSubview:self.iconAddress];

   
    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelHailuoCompany *)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    self.iconAddress.leftTop = XY(W(15),W(17.5));
    self.iconPhone.leftTop = XY(W(15),self.iconAddress.bottom + W(15));

    [self.address fitTitle:UnPackStr(model.address) variable:W(300) ];
    self.address.leftCenterY = XY(self.iconAddress.right + W(13), self.iconAddress.centerY);
    
    [self.phone fitTitle:UnPackStr(model.tel) variable:W(300)];
    self.phone.leftCenterY = XY(self.iconPhone.right + W(13), self.iconPhone.centerY);
    
    //设置总高度
    self.height = self.iconPhone.bottom + W(17.5);
    [self addLineFrame:CGRectMake(W(15), self.height -1, SCREEN_WIDTH - W(30), 1)];
}

@end

@implementation HailuoCompanyServeView

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.width = SCREEN_WIDTH;
    }
    return self;
}


#pragma mark 刷新view
- (void)resetViewWithModel:(NSArray *)aryModels{
    self.aryModels = aryModels;
    
    [self removeAllSubViews];//移除线
    CGFloat top = W(20);
    CGFloat left = 0;
    CGFloat bottom = 0;
    for (int i = 0; i<aryModels.count; i++) {
        left = i%2==0?W(15):W(195);
        
        ModelHailuoCompanyServe * modelServe = aryModels[i];
        
        UIView * view = [UIView new];
        view.backgroundColor = [UIColor clearColor];
        view.widthHeight = XY(W(165), W(45));
        view.leftTop = XY(left, top);
        [view addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:10 lineWidth:1 lineColor:[UIColor colorWithHexString:@"#EFF2F1"]];
        view.tag = i;
        [view addTarget:self action:@selector(click:)];
        [self addSubview:view];
        
        UIImageView * iv = [UIImageView new];
        iv.backgroundColor = [UIColor clearColor];
        iv.contentMode = UIViewContentModeScaleAspectFill;
        iv.clipsToBounds = true;
        [iv sd_setImageWithURL:[NSURL URLWithString:UnPackStr(modelServe.img)]];
        iv.widthHeight = XY(W(18),W(18));
        iv.leftCenterY = XY(view.left + W(38.5),view.centerY);
        [self addSubview:iv];
        
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        l.textColor = COLOR_333;
        l.backgroundColor = [UIColor clearColor];
        [l fitTitle:UnPackStr(modelServe.name) variable:SCREEN_WIDTH - W(30)];
        l.leftCenterY = XY(iv.right + W(10), iv.centerY);
        [self addSubview:l];
        
        if (i%2 != 0) {
           top = view.bottom + W(15);
        }
        bottom = view.bottom;
    }
    
    //设置总高度
    self.height = bottom + W(17.5);
    [self addLineFrame:CGRectMake(W(15), self.height -1, SCREEN_WIDTH - W(30), 1)];
}

- (void)click:(UITapGestureRecognizer *)tap{
    UIView * view = tap.view;
    if (view.tag < self.aryModels.count) {
        if (self.blockServeClick) {
            self.blockServeClick(self.aryModels[view.tag]);
        }
    }
}
@end

@implementation HailuoCompanyCell
#pragma mark 懒加载
- (UIImageView *)head{
    if (_head == nil) {
        _head = [UIImageView new];
        _head.image = [UIImage imageNamed:@"houseKeeping_head"];
        _head.widthHeight = XY(W(40),W(40));
        [_head addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:_head.width/2.0 lineWidth:0 lineColor:[UIColor clearColor]];
        

    }
    return _head;
}
- (UILabel *)phone{
    if (_phone == nil) {
        _phone = [UILabel new];
        _phone.textColor = COLOR_333;
        _phone.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightMedium];
    }
    return _phone;
}
- (CommentStarView *)starView{
    if (!_starView) {
        _starView = [CommentStarView new];
        _starView.isShowGrayStarBg = false;
        _starView.interval = W(5);
        [_starView configDefaultView];
        _starView.userInteractionEnabled = false;
        _starView.backgroundColor = [UIColor clearColor];
    }
    return _starView;
}
- (UILabel *)date{
    if (_date == nil) {
        _date = [UILabel new];
        _date.textColor = COLOR_666;
        _date.font =  [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
    }
    return _date;
}
- (UILabel *)comment{
    if (_comment == nil) {
        _comment = [UILabel new];
        _comment.textColor = COLOR_333;
        _comment.font =  [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
        _comment.numberOfLines = 0;
    }
    return _comment;
}

#pragma mark 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.head];
    [self.contentView addSubview:self.phone];
    [self.contentView addSubview:self.starView];
    [self.contentView addSubview:self.date];
    [self.contentView addSubview:self.comment];

    }
    return self;
}
#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelHailuoComment *)model{
    self.model = model;
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    
    [self.head sd_setImageWithURL:[NSURL URLWithString:UnPackStr(model.icon)] placeholderImage:[UIImage imageNamed:@"houseKeeping_head"]];
    self.head.leftTop = XY(W(15),W(20));
    [self.phone fitTitle:UnPackStr(model.nickName) variable:0];
    self.phone.leftTop = XY(self.head.right + W(10),self.head.top);

    self.starView.leftBottom = XY(self.head.right + W(10),self.head.bottom+W(5));
    self.starView.currentScore = model.start;
    
    [self.date fitTitle:[GlobalMethod exchangeTimeWithStamp:model.createTime andFormatter:TIME_DAY_SHOW] variable:0];
    self.date.rightBottom = XY(SCREEN_WIDTH - W(20),self.head.bottom);
    [self.comment fitTitle:UnPackStr(model.comment) variable:SCREEN_WIDTH - W(30)];
    self.comment.leftTop = XY(W(15),self.head.bottom+W(12));

    //设置总高度
    self.height = self.comment.bottom + W(0);
}

@end
