//
//  HailuoAppointmentView.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/8/15.
//Copyright © 2020 ping. All rights reserved.
//

#import "HailuoAuntResumeView.h"

@interface HailuoAuntResumeView ()

@end

@implementation HailuoAuntResumeView
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
    [self addSubview:self.label];
    [self addSubview:self.name];
    [self addSubview:self.age];
    [self addSubview:self.rmb];
    [self addSubview:self.star];
    [self addSubview:self.grade];
    [self addSubview:self.comment];
    [self addSubview:self.price];
    [self resetViewWithModel:nil];
}

#pragma mark 刷新cell
- (void)resetViewWithModel:(ModelHailuoAunt *)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
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
    self.height = self.logo.bottom + W(20);
    [self addLineFrame:CGRectMake(W(15), self.height - 1, SCREEN_WIDTH - W(30), 1)];
}


@end



@implementation HailuoAppointmentQualificationView

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

- (void)resetViewWithModel:(ModelHailuoAunt *)model{
    [self removeAllSubViews];
    UILabel * l = [UILabel new];
       l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightMedium];
       l.textColor = COLOR_333;
       l.backgroundColor = [UIColor clearColor];
       [l fitTitle:@"资质认证" variable:0];
       l.leftTop = XY(W(15), W(20));
       [self addSubview:l];
       
       CGFloat top = l.bottom + W(10);
       NSArray * ary = @[@"身份认证",@"背景合格",@"健康认证",@"技能认证"];
    NSArray * aryCertify = @[NSNumber.lon(model.checkIdCard == 1),NSNumber.lon(model.checkBackground == 1),NSNumber.lon(model.health == 1),NSNumber.lon(model.skill == 1)];

       NSArray * aryLeft = @[NSNumber.dou(W(25)),NSNumber.dou(W(115)),NSNumber.dou(W(210)),NSNumber.dou(W(300))];
       for (int i = 0; i<ary.count; i++) {
           NSString * strTitle = ary[i];
           CGFloat left = [aryLeft[i] doubleValue];
           BOOL checked = [aryCertify[i] boolValue];
           UIImageView * iv = [UIImageView new];
           iv.backgroundColor = [UIColor clearColor];
           iv.contentMode = UIViewContentModeScaleAspectFill;
           iv.clipsToBounds = true;
           iv.image = [UIImage imageNamed:[NSString stringWithFormat:@"houseKeepingQualification%d%@",i,checked?@"":@"_anti"]];
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


@implementation HailuoAppointmentCommentView
#pragma mark 懒加载
- (UILabel *)comment{
    if (_comment == nil) {
        _comment = [UILabel new];
        _comment.textColor = COLOR_333;
        _comment.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _comment.numberOfLines = 0;
        _comment.lineSpace = W(8);
    }
    return _comment;
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
        [self addSubview:self.comment];
    
    UILabel * l = [UILabel new];
       l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightMedium];
       l.textColor = COLOR_333;
       l.backgroundColor = [UIColor clearColor];
       [l fitTitle:@"综合评价" variable:0];
       l.leftTop = XY(W(15), W(20));
       [self addSubview:l];
    
    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelHailuoAunt *)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    self.comment.leftTop = XY(W(15),W(55));
    [self.comment fitTitle:isStr(model.estimate)?model.estimate:@"暂无评价" variable:SCREEN_WIDTH - W(30)];

    //设置总高度
    self.height = self.comment.bottom + W(20);
    [self addLineFrame:CGRectMake(W(15), self.height -1, SCREEN_WIDTH - W(30), 1)];
}

@end


@implementation HailuoAppointmentCommentLabelView
#pragma mark 懒加载
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
        self.backgroundColor = [UIColor whiteColor];
        self.width = SCREEN_WIDTH;
        [self addSubView];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.comment];
    
    UILabel * l = [UILabel new];
    l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightMedium];
    l.textColor = COLOR_333;
    l.backgroundColor = [UIColor clearColor];
    [l fitTitle:@"用户评价" variable:0];
    l.leftTop = XY(W(15), W(20));
    [self addSubview:l];
    
    self.height = l.bottom + W(20);
    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelHailuoAunt *)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    [self.comment fitTitle:[NSString stringWithFormat:@"满意度%@%%",NSNumber.lon(model.good.doubleValue*100.0)] variable:0];
    self.comment.rightCenterY = XY(SCREEN_WIDTH - W(15),self.height/2.0);
}

@end

@implementation HailuoAppointmentMoreView
#pragma mark 懒加载
- (UIButton *)more{
    if (!_more) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.widthHeight = XY(W(120), W(30));
        btn.backgroundColor = [UIColor whiteColor];
        [btn setTitle:@"查看全部评价" forState:UIControlStateNormal];
        btn.titleLabel.fontNum = F(12);
        [btn setTitleColor:COLOR_666 forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnMoreClick) forControlEvents:UIControlEventTouchUpInside];
        [btn addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:btn.height/2.0 lineWidth:1 lineColor:[UIColor colorWithHexString:@"#AEAEAE"]];
        _more = btn;
        
    }
    return _more;
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
    [self addSubview:self.more];
    self.more.centerXTop = XY(SCREEN_WIDTH/2.0, 0);
    
    self.height = self.more.bottom + W(20)+ W(10);
    //初始化页面
    [self addLineFrame:CGRectMake(0, self.height - W(10), SCREEN_WIDTH, W(10)) color:[UIColor colorWithHexString:@"#F7F8F9"]];
}
- (void)btnMoreClick{
    if (self.blockMoreClick ) {
        self.blockMoreClick(true);
    }
}


@end



@implementation HailuoAppointmentCell
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
    self.head.leftTop = XY(W(15),W(0));
    [self.phone fitTitle:UnPackStr(model.nickName) variable:0];
    self.phone.leftTop = XY(self.head.right + W(10),self.head.top);

    self.starView.leftBottom = XY(self.head.right + W(10),self.head.bottom+W(5));
    self.starView.currentScore = model.start;
    
    [self.date fitTitle:[GlobalMethod exchangeTimeWithStamp:model.createTime andFormatter:TIME_DAY_SHOW] variable:0];
    self.date.rightBottom = XY(SCREEN_WIDTH - W(20),self.head.bottom);
    [self.comment fitTitle:UnPackStr(model.comment) variable:SCREEN_WIDTH - W(30)];
    self.comment.leftTop = XY(W(15),self.head.bottom+W(12));

    //设置总高度
    self.height = self.comment.bottom + W(20);
}

@end

@implementation HailuoAppointmentTraningView

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
    UILabel * l = [UILabel new];
    l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightMedium];
    l.textColor = COLOR_333;
    l.backgroundColor = [UIColor clearColor];
    [l fitTitle:@"培训经历" variable:0];
    l.leftTop = XY(W(15), W(20));
    [self addSubview:l];
    
}

#pragma mark 刷新view
- (void)resetViewWithAry:(NSArray *)ary{
    self.ary = ary;
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    CGFloat top = W(55);
    for (int i = 0; i<  ary.count; i++) {
        NSDictionary * dic = ary[i];
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        l.textColor = COLOR_333;
        l.backgroundColor = [UIColor clearColor];
        l.numberOfLines = 0;
        l.lineSpace = W(8);
        [l fitTitle:[NSString stringWithFormat:@"%@",[dic stringValueForKey:@"undergo"]] variable:SCREEN_WIDTH - W(30)];
        l.leftTop = XY(W(15), top);
        [self addSubview:l];
        top = l.bottom + W(8);
    }
    self.height = top;
}

@end
