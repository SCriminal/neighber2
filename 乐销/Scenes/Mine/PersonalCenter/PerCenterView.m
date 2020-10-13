//
//  PerCenterView.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/8/14.
//Copyright © 2020 ping. All rights reserved.
//

#import "PerCenterView.h"
//request
#import "RequestApi+Neighbor.h"
#import "JournalismListVC.h"
#import "OrderListManagementVC.h"
#import "CertificateDealTabVC.h"
#import "ShopDetailVC.h"

@implementation PerCenterTopView
#pragma mark 懒加载
- (UIImageView *)bg{
    if (_bg == nil) {
        _bg = [UIImageView new];
        _bg.image = [UIImage imageNamed:@"personal_top_bg"];
        _bg.contentMode = UIViewContentModeScaleAspectFill;
        _bg.widthHeight = XY(SCREEN_WIDTH,W(15));
    }
    return _bg;
}
- (UIImageView *)head{
    if (_head == nil) {
        _head = [UIImageView new];
        _head.image = [UIImage imageNamed:@"personal_head"];
        _head.widthHeight = XY(W(65),W(65));
        _head.contentMode = UIViewContentModeScaleAspectFill;
        _head.clipsToBounds = true;
        [_head addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:_head.width/2.0 lineWidth:0 lineColor:[UIColor clearColor]];
        [_head addTarget:self action:@selector(headClick)];
    }
    return _head;
}
- (UILabel *)name{
    if (_name == nil) {
        _name = [UILabel new];
        _name.textColor = [UIColor blackColor];
        _name.font =  [UIFont systemFontOfSize:F(20) weight:UIFontWeightRegular];
        _name.numberOfLines = 1;
        _name.lineSpace = 0;
    }
    return _name;
}
- (UIImageView *)vertification{
    if (_vertification == nil) {
        _vertification = [UIImageView new];
        _vertification.image = [UIImage imageNamed:@"personal_vertification"];
        _vertification.highlightedImage = [UIImage imageNamed:@"personal_vertificated"];
        _vertification.widthHeight = XY(W(15),W(15));
    }
    return _vertification;
}
- (UIImageView *)setting{
    if (_setting == nil) {
        _setting = [UIImageView new];
        _setting.image = [UIImage imageNamed:@"personal_setting"];
        _setting.widthHeight = XY(W(22),W(22));
    }
    return _setting;
}
- (UIImageView *)msg{
    if (_msg == nil) {
        _msg = [UIImageView new];
        _msg.image = [UIImage imageNamed:@"personal_msg"];
        _msg.widthHeight = XY(W(22),W(22));
    }
    return _msg;
}
- (UILabel *)msgNum{
    if (_msgNum == nil) {
        _msgNum = [UILabel new];
        _msgNum.textColor = COLOR_RED;
        _msgNum.font =  [UIFont systemFontOfSize:F(7) weight:UIFontWeightRegular];
    }
    return _msgNum;
}
#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.width = SCREEN_WIDTH;
        self.height = W(154) + iphoneXTopInterval;
        self.clipsToBounds = true;
        [self addSubView];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(resetViewWithModel) name:NOTICE_SELFMODEL_CHANGE object:nil];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.bg];
    [self addSubview:self.head];
    [self addSubview:self.name];
    [self addSubview:self.vertification];
    [self addSubview:self.setting];
    [self addSubview:self.msg];
    [self addSubview:self.msgNum];
    
    //刷新view
    ModelUser * model = [GlobalData sharedInstance].GB_UserModel;
    
    [self.head sd_setImageWithURL:[NSURL URLWithString:model.headUrl] placeholderImage:[UIImage imageNamed:@"personal_head"]];
    self.head.leftTop = XY(W(20), W(55)+iphoneXTopInterval);
    
    [self.name fitTitle:[GlobalMethod isLoginSuccess]?UnPackStr(model.nickname):@"您好，请登录" variable:0];
    self.name.leftCenterY = XY(self.head.right + W(20),self.head.centerY);
    
    self.vertification.rightBottom = XY(self.head.right - W(5), self.head.bottom);
    
    self.msg.rightTop = XY(SCREEN_WIDTH - W(25), iphoneXTopInterval + W(45));
    
    [self addControlFrame:CGRectInset(self.msg.frame, -W(10), -W(20)) target:self action:@selector(msgClick)];
    self.setting.rightTop = XY(self.msg.left - W(25), self.msg.top);
    [self addControlFrame:CGRectInset(self.setting.frame, -W(10), -W(20)) target:self action:@selector(setClick)];
    
    self.msgNum.rightTop = XY(self.msg.right - W(3), self.msg.top - W(3));
    
    //设置总高度
    self.bg.height = self.height;
    //初始化页面
    [self resetViewWithModel];
}
- (void)msgClick{
    [GlobalMethod judgeLoginState:^{
        [GB_Nav pushVCName:@"MessageManagementCenterVC" animated:true];
    }];
}
- (void)setClick{
    [GB_Nav pushVCName:@"SettingVC" animated:true];
}
#pragma mark 刷新view
- (void)resetViewWithModel{
    ModelUser * model = [GlobalData sharedInstance].GB_UserModel;
    
    [self.head sd_setImageWithURL:[NSURL URLWithString:model.headUrl] placeholderImage:[UIImage imageNamed:@"personal_head"]];
    
    [self.name fitTitle:[GlobalMethod isLoginSuccess]?UnPackStr(model.nickname):@"您好，请登录" variable:0];
    self.name.leftCenterY = XY(self.head.right + W(20),self.head.centerY);
    
}
- (void)exchangeLabel:(UILabel *)label count:(int)count {
    label.hidden = count <=0;
    if (!label ) return;
    count = count>99?99:count;
    NSString * strNum = count < 10? @"AA": @"AAA";
    [GlobalMethod setLabel:label widthLimit:0 numLines:0 fontNum:F(7) textColor:COLOR_RED text:strNum];
    label.backgroundColor = [UIColor whiteColor];
    [GlobalMethod setRoundView:label color:[UIColor clearColor] numRound:label.height / 2.0 width:0];
    label.text = [NSString stringWithFormat:@"%d",count];
    label.textAlignment = NSTextAlignmentCenter;
}
- (void)headClick{
    if ([GlobalMethod isLoginSuccess]) {
        [GB_Nav pushVCName:@"PersonalInfoVC" animated:true];
    }else{
        [GB_Nav pushVCName:@"LoginViewController" animated:true];
    }
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)requestMsgNum{
    self.msgNum.hidden = ![GlobalMethod isLoginSuccess];
    if ([GlobalMethod isLoginSuccess]) {
        //        [self exchangeLabel:self.msgNum count:6];
    }
}
- (void)requestCertificate{
    self.vertification.hidden = ![GlobalMethod isLoginSuccess];
    if ([GlobalMethod isLoginSuccess]) {
        [RequestApi requestAuthenticationDetailWithDelegate:nil success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
            ModelAuthentication * model = [ModelAuthentication modelObjectWithDictionary:response];
            //        审核状态  1-未提交  2-审核中  10审核通过  11-审核未通过
            self.vertification.highlighted = model.status == 10;
            
        } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
            
        }];
    }
}
@end


@implementation PerCenterSignView
#pragma mark 懒加载
- (UILabel *)integralNum{
    if (_integralNum == nil) {
        _integralNum = [UILabel new];
        _integralNum.textColor = COLOR_333;
        _integralNum.font =  [UIFont systemFontOfSize:F(20) weight:UIFontWeightMedium];
    }
    return _integralNum;
}
- (UILabel *)integral{
    if (_integral == nil) {
        _integral = [UILabel new];
        _integral.textColor = COLOR_333;
        _integral.font =  [UIFont systemFontOfSize:F(11) weight:UIFontWeightRegular];
    }
    return _integral;
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = COLOR_GRAY;
        self.width = SCREEN_WIDTH;
        self.height = W(71);
        [self addSubView];
    }
    return self;
}
//添加subview
- (void)addSubView{
    {
        UIView * view = [UIView new];
        view.backgroundColor = [UIColor whiteColor];
        view.widthHeight = XY(W(172), W(71));
        view.leftTop = XY(W(10), 0);
        [view addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:10 lineWidth:0 lineColor:[UIColor clearColor]];
        [view addTarget:self action:@selector(integralClick)];
        [self addSubview:view];
        
        [self addSubview:self.integralNum];
        [self addSubview:self.integral];
        {
            UILabel * l = [UILabel new];
            l.font = [UIFont systemFontOfSize:F(11) weight:UIFontWeightRegular];
            l.textColor = COLOR_666;
            l.backgroundColor = [UIColor clearColor];
            [l fitTitle:@"进入积分商城兑换商品" variable:SCREEN_WIDTH - W(30)];
            l.leftTop = XY(W(25), W(45));
            [self addSubview:l];
        }
        {
            UIImageView * iv = [UIImageView new];
            iv.backgroundColor = [UIColor clearColor];
            iv.contentMode = UIViewContentModeScaleAspectFill;
            iv.clipsToBounds = true;
            iv.image = [UIImage imageNamed:@"arrow_right"];
            iv.widthHeight = XY(W(15),W(15));
            iv.leftCenterY = XY(W(160),view.centerY);
            [self addSubview:iv];
        }
    }
    {
        UIView * view = [UIView new];
        view.backgroundColor = [UIColor whiteColor];
        view.widthHeight = XY(W(172), W(71));
        view.leftTop = XY(W(193), 0);
        [view addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:10 lineWidth:0 lineColor:[UIColor clearColor]];
        [self addSubview:view];
        [view addTarget:self action:@selector(signClick)];
        
        {
            UILabel * l = [UILabel new];
            l.font = [UIFont systemFontOfSize:F(16) weight:UIFontWeightMedium];
            l.textColor = COLOR_333;
            l.backgroundColor = [UIColor clearColor];
            [l fitTitle:@"签到" variable:SCREEN_WIDTH - W(30)];
            l.leftTop = XY(view.left + W(15), W(16));
            [self addSubview:l];
        }
        {
            UILabel * l = [UILabel new];
            l.font = [UIFont systemFontOfSize:F(11) weight:UIFontWeightRegular];
            l.textColor = COLOR_666;
            l.backgroundColor = [UIColor clearColor];
            [l fitTitle:@"点击签到领积分" variable:SCREEN_WIDTH - W(30)];
            l.leftTop = XY(view.left + W(15), W(45));
            [self addSubview:l];
        }
        {
            UIImageView * iv = [UIImageView new];
            iv.backgroundColor = [UIColor clearColor];
            iv.contentMode = UIViewContentModeScaleAspectFill;
            iv.clipsToBounds = true;
            iv.image = [UIImage imageNamed:@"arrow_right"];
            iv.widthHeight = XY(W(15),W(15));
            iv.leftCenterY = XY(view.left + W(150),view.centerY);
            [self addSubview:iv];
        }
    }
    //初始化页面
    [self resetViewWithModel:0];
}
#pragma mark 刷新view
- (void)resetViewWithModel:(double)num{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    [self.integralNum fitTitle:NSNumber.dou(num).stringValue variable:0];
    self.integralNum.leftTop = XY(W(25),W(15));
    [self.integral fitTitle:@"积分" variable:0];
    self.integral.leftBottom = XY(self.integralNum.right + W(2),self.integralNum.bottom-W(2));
    
    
}

- (void)signClick{
    if (self.blockSignClick) {
        self.blockSignClick();
    }
}
- (void)integralClick{
    if (self.blockIntegralClick) {
        self.blockIntegralClick();
    }
}
- (void)requestIntegralNum{
    if (![GlobalMethod isLoginSuccess]) {
        [self resetViewWithModel:0];
        return;
    }
    [RequestApi requestIntegralTotalDelegate:nil success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        [self resetViewWithModel:[response intValueForKey:@"score"]];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}


@end



@implementation PerCenterOrderView
#pragma mark 懒加载
- (UILabel *)integralOrderNum{
    if (_integralOrderNum == nil) {
        _integralOrderNum = [UILabel new];
        _integralOrderNum.textColor = COLOR_333;
        _integralOrderNum.font =  [UIFont systemFontOfSize:F(20) weight:UIFontWeightMedium];
    }
    return _integralOrderNum;
}
- (UILabel *)orderNum{
    if (_orderNum == nil) {
        _orderNum = [UILabel new];
        _orderNum.textColor = COLOR_333;
        _orderNum.font =  [UIFont systemFontOfSize:F(20) weight:UIFontWeightMedium];
    }
    return _orderNum;
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
    UIView * view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    view.widthHeight = XY(W(355), W(75));
    view.leftTop = XY(W(10), 0);
    [view addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:10 lineWidth:0 lineColor:[UIColor clearColor]];
    [self addSubview:view];
    
    
    {
        UIImageView * iv = [UIImageView new];
        iv.backgroundColor = [UIColor clearColor];
        iv.contentMode = UIViewContentModeScaleAspectFill;
        iv.clipsToBounds = true;
        iv.image = [UIImage imageNamed:@"per_订单"];
        iv.widthHeight = XY(W(40),W(40));
        iv.leftTop = XY(W(35),W(7));
        [self addSubview:iv];
        
        [self addControlFrame:CGRectInset(iv.frame, -W(20), -W(20)) target:self action:@selector(orderClick)];

        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(11) weight:UIFontWeightRegular];
        l.textColor = [UIColor colorWithHexString:@"#717273"];
        l.backgroundColor = [UIColor clearColor];
        [l fitTitle:@"我的订单" variable:SCREEN_WIDTH - W(30)];
        l.centerXTop = XY(iv.centerX,iv.bottom + W(5));
        [self addSubview:l];
    }
    {
        UIImageView * iv = [UIImageView new];
        iv.backgroundColor = [UIColor clearColor];
        iv.contentMode = UIViewContentModeScaleAspectFill;
        iv.clipsToBounds = true;
        iv.image = [UIImage imageNamed:@"per_shadow"];
        iv.widthHeight = XY(W(10),W(61));
        iv.leftTop = XY(W(100),W(7));
        [self addSubview:iv];
    }
    [self addSubview:self.integralOrderNum];
    [self addSubview:self.orderNum];
    {
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(11) weight:UIFontWeightRegular];
        l.textColor = COLOR_333;
        l.backgroundColor = [UIColor clearColor];
        [l fitTitle:@"单" variable:SCREEN_WIDTH - W(30)];
        l.leftTop = XY(W(176), W(21));
        [self addSubview:l];
    }
    {
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(11) weight:UIFontWeightRegular];
        l.textColor = COLOR_666;
        l.backgroundColor = [UIColor clearColor];
        [l fitTitle:@"购物订单" variable:SCREEN_WIDTH - W(30)];
        l.leftTop = XY(W(151), W(49));
        [self addSubview:l];
    }
    {
        [self addLineFrame:CGRectMake(W(237), W(17.5), 1, W(40)) tag:1];
    }
    {
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(11) weight:UIFontWeightRegular];
        l.textColor = COLOR_333;
        l.backgroundColor = [UIColor clearColor];
        [l fitTitle:@"单" variable:SCREEN_WIDTH - W(30)];
        l.rightTop = XY(SCREEN_WIDTH - W(60), W(21));
        [self addSubview:l];
    }
    {
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(11) weight:UIFontWeightRegular];
        l.textColor = COLOR_666;
        l.backgroundColor = [UIColor clearColor];
        [l fitTitle:@"积分订单" variable:SCREEN_WIDTH - W(30)];
        l.rightTop = XY(SCREEN_WIDTH - W(51), W(49));
        [self addSubview:l];
    }
    [self addControlFrame:CGRectMake(W(110), 0, W(127), view.height) target:self action:@selector(orderClick)];
    [self addControlFrame:CGRectMake(W(237), 0, W(127), view.height) target:self action:@selector(integralOrderClick)];
    
    //初始化页面
    [self resetViewWithIntegralNum:0 orderNum:0];
}

#pragma mark 刷新view
- (void)resetViewWithIntegralNum:(double)numIntegral orderNum:(double)orderNum{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    [self.integralOrderNum fitTitle:NSNumber.dou(numIntegral).stringValue variable:0];
    self.integralOrderNum.rightTop = XY(SCREEN_WIDTH - W(74.5),W(15));
    
    [self.orderNum fitTitle:NSNumber.dou(orderNum).stringValue variable:0];
    self.orderNum.rightTop = XY(W(173),W(15));
    
    //设置总高度
    self.height = W(75);
}

- (void)integralOrderClick{
    [GlobalMethod judgeLoginState:^{
        OrderListManagementVC * VC= [OrderListManagementVC new];
        VC.isIntegral = true;
        [GB_Nav pushViewController:VC animated:true];
    }];
}
- (void)orderClick{
    [GlobalMethod judgeLoginState:^{
        [GB_Nav pushVCName:@"OrderListManagementVC" animated:true];
    }];
}

- (void)requestOrderNum{
    if (![GlobalMethod isLoginSuccess]) {
        [self resetViewWithIntegralNum:0 orderNum:0];
        return;
    }
    [RequestApi requestIntetralOrderListWithId:0 page:1 count:1 delegate:nil success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        double numIntegral = [response doubleValueForKey:@"total"];
        [RequestApi requestOrderListWithStatuses:@"1,5,7,10,99" page:1 count:1 delegate:nil success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
            double numOrder = [response doubleValueForKey:@"total"];
            [self resetViewWithIntegralNum:numIntegral orderNum:numOrder];
        } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
            
        }];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}

@end

@implementation PerCenterDealView
#pragma mark 懒加载
- (UILabel *)num0{
    if (_num0 == nil) {
        _num0 = [UILabel new];
        _num0.textColor = COLOR_333;
        _num0.font =  [UIFont systemFontOfSize:F(20) weight:UIFontWeightMedium];
    }
    return _num0;
}
- (UILabel *)num1{
    if (_num1 == nil) {
        _num1 = [UILabel new];
        _num1.textColor = COLOR_333;
        _num1.font =  [UIFont systemFontOfSize:F(20) weight:UIFontWeightMedium];
    }
    return _num1;
}
- (UILabel *)num2{
    if (_num2 == nil) {
        _num2 = [UILabel new];
        _num2.textColor = COLOR_333;
        _num2.font =  [UIFont systemFontOfSize:F(20) weight:UIFontWeightMedium];
    }
    return _num2;
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
    UIView * view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    view.widthHeight = XY(W(355), W(75));
    view.leftTop = XY(W(10), 0);
    [view addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:10 lineWidth:0 lineColor:[UIColor clearColor]];
    [self addSubview:view];
    
    
    {
        UIImageView * iv = [UIImageView new];
        iv.backgroundColor = [UIColor clearColor];
        iv.contentMode = UIViewContentModeScaleAspectFill;
        iv.clipsToBounds = true;
        iv.image = [UIImage imageNamed:@"per_办理"];
        iv.widthHeight = XY(W(40),W(40));
        iv.leftTop = XY(W(35),W(7));
        [self addSubview:iv];
        
        [self addControlFrame:CGRectInset(iv.frame, -W(20), -W(20)) target:self action:@selector(leftClick)];

        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(11) weight:UIFontWeightRegular];
        l.textColor = [UIColor colorWithHexString:@"#717273"];
        l.backgroundColor = [UIColor clearColor];
        [l fitTitle:@"我的办理" variable:SCREEN_WIDTH - W(30)];
        l.centerXTop = XY(iv.centerX,iv.bottom + W(5));
        [self addSubview:l];
    }
    {
        UIImageView * iv = [UIImageView new];
        iv.backgroundColor = [UIColor clearColor];
        iv.contentMode = UIViewContentModeScaleAspectFill;
        iv.clipsToBounds = true;
        iv.image = [UIImage imageNamed:@"per_shadow"];
        iv.widthHeight = XY(W(10),W(61));
        iv.leftTop = XY(W(100),W(7));
        [self addSubview:iv];
    }
    [self addSubview:self.num0];
    [self addSubview:self.num1];
    [self addSubview:self.num2];
    {
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(11) weight:UIFontWeightRegular];
        l.textColor = COLOR_333;
        l.backgroundColor = [UIColor clearColor];
        [l fitTitle:@"件" variable:SCREEN_WIDTH - W(30)];
        l.leftTop = XY(W(159), W(21));
        [self addSubview:l];
    }
    {
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(11) weight:UIFontWeightRegular];
        l.textColor = COLOR_333;
        l.backgroundColor = [UIColor clearColor];
        [l fitTitle:@"件" variable:SCREEN_WIDTH - W(30)];
        l.leftTop = XY(W(240), W(21));
        [self addSubview:l];
    }
    {
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(11) weight:UIFontWeightRegular];
        l.textColor = COLOR_333;
        l.backgroundColor = [UIColor clearColor];
        [l fitTitle:@"件" variable:SCREEN_WIDTH - W(30)];
        l.leftTop = XY(W(325), W(21));
        [self addSubview:l];
    }
    {
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(11) weight:UIFontWeightRegular];
        l.textColor = COLOR_666;
        l.backgroundColor = [UIColor clearColor];
        [l fitTitle:@"待办理" variable:SCREEN_WIDTH - W(30)];
        l.leftTop = XY(W(135.5), W(49));
        [self addSubview:l];
    }
    {
        [self addLineFrame:CGRectMake(W(195), W(17.5), 1, W(40)) tag:1];
    }
    {
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(11) weight:UIFontWeightRegular];
        l.textColor = COLOR_666;
        l.backgroundColor = [UIColor clearColor];
        [l fitTitle:@"办理中" variable:SCREEN_WIDTH - W(30)];
        l.leftTop = XY(W(220.5), W(49));
        [self addSubview:l];
    }
    {
        [self addLineFrame:CGRectMake(SCREEN_WIDTH - W(95), W(17.5), 1, W(40)) tag:1];
    }{
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(11) weight:UIFontWeightRegular];
        l.textColor = COLOR_666;
        l.backgroundColor = [UIColor clearColor];
        [l fitTitle:@"已办结" variable:SCREEN_WIDTH - W(30)];
        l.rightTop = XY(SCREEN_WIDTH - W(35), W(49));
        [self addSubview:l];
    }
    
    [self addControlFrame:CGRectMake(W(110), 0, W(85), view.height) target:self action:@selector(leftClick)];
    [self addControlFrame:CGRectMake(W(195), 0, W(85), view.height) target:self action:@selector(middleClick)];
    [self addControlFrame:CGRectMake(SCREEN_WIDTH - W(95), 0, W(85), view.height) target:self action:@selector(rightClick)];
    
    //初始化页面
    [self resetViewWithSutmit:0 successNum:0 returnNum:0];
}

#pragma mark 刷新view
- (void)resetViewWithSutmit:(double)subNum successNum:(double)successNum returnNum:(double)returnNum{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    [self.num0 fitTitle:NSNumber.dou(subNum).stringValue variable:0];
    self.num0.rightTop = XY(W(156),W(15));
    [self.num1 fitTitle:NSNumber.dou(successNum).stringValue variable:0];
    self.num1.rightTop = XY(W(237),W(15));
    [self.num2 fitTitle:NSNumber.dou(returnNum).stringValue variable:0];
    self.num2.rightTop = XY(SCREEN_WIDTH - W(53),W(15));
    
    //设置总高度
    self.height = W(75);
}
- (void)requestNum{
    //    ENUM_CERTIFICATE_DISPOSAL_RESULT_SUBMIT = 1,
    //    ENUM_CERTIFICATE_DISPOSAL_RESULT_SUCCESS = 2,
    //    ENUM_CERTIFICATE_DISPOSAL_RESULT_RETURN = 3
    if (![GlobalMethod isLoginSuccess]) {
        [self resetViewWithSutmit:0 successNum:0 returnNum:0];
        return;
    }
    [RequestApi requestCertificateDealResultWithStatuses:strEnemy(1) page:1 count:1 delegate:nil success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        double numSubmit = [response doubleValueForKey:@"total"];
        [RequestApi requestCertificateDealResultWithStatuses:strEnemy(2) page:1 count:1 delegate:nil success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
            double numSuccess = [response doubleValueForKey:@"total"];
            [RequestApi requestCertificateDealResultWithStatuses:strEnemy(3) page:1 count:1 delegate:nil success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
                double numReturn = [response doubleValueForKey:@"total"];
                [self resetViewWithSutmit:numSubmit successNum:numSubmit returnNum:numReturn+numSuccess];
                
            } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
                
            }];
        } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
            
        }];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}

- (void)leftClick{
    [GlobalMethod judgeLoginState:^{
        [GB_Nav pushVCName:@"CertificateDealTabVC" animated:true];
    }];
}
- (void)middleClick{
    [GlobalMethod judgeLoginState:^{
        [GB_Nav pushVCName:@"CertificateDealTabVC" animated:true];
        
    }];
}
- (void)rightClick{
    [GlobalMethod judgeLoginState:^{
        CertificateDealTabVC * tabVC = [CertificateDealTabVC new];
        tabVC.isComplete = true;
        [GB_Nav pushViewController:tabVC animated:true];
    }];
}
@end


@implementation PerCenterBtnView

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
    UIView * view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    view.widthHeight = XY(W(355), W(81));
    view.leftTop = XY(W(10), 0);
    [view addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:10 lineWidth:0 lineColor:[UIColor clearColor]];
    [self addSubview:view];
    
    NSArray * aryImageName = @[@"per_档案",@"per_成员",@"per_地址",@"per_资料"];
    NSArray * aryLeft = @[@35,@123.5,@211.5,@300];
    NSArray * aryTitle = @[@"居民档案",@"成员管理",@"收货地址",@"个人资料"];
    for (int i = 0; i<aryImageName.count; i++) {
        NSString * imageName = aryImageName[i];
        double left = [aryLeft[i] doubleValue];
        NSString * title = aryTitle[i];
        
        UIImageView * iv = [UIImageView new];
        iv.backgroundColor = [UIColor clearColor];
        iv.contentMode = UIViewContentModeScaleAspectFill;
        iv.clipsToBounds = true;
        iv.image = [UIImage imageNamed:imageName];
        iv.widthHeight = XY(W(40),W(40));
        iv.leftTop = XY(left,W(10));
        [self addSubview:iv];
        
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(11) weight:UIFontWeightRegular];
        l.textColor = [UIColor colorWithHexString:@"#717273"];
        l.backgroundColor = [UIColor clearColor];
        [l fitTitle:title variable:SCREEN_WIDTH - W(30)];
        l.centerXTop = XY(iv.centerX,iv.bottom + W(5));
        [self addSubview:l];
        
        UIView * con = [self addControlFrame:CGRectInset(iv.frame, -W(20), -W(20)) target:self action:@selector(btnClick:)];
        con.tag = i+100;
    }
    self.height = W(81);
}

- (void)btnClick:(UIControl *)con{
    switch ((int)(con.tag - 100)) {
        case 0:
            [GlobalMethod judgeLoginState:^{
                [GB_Nav pushVCName:@"ArchiveListVC" animated:true];
            }];
            break;
        case 1:
            [GlobalMethod judgeLoginState:^{
                [GB_Nav pushVCName:@"MemberListVC" animated:true];
            }];
            break;
        case 2:
            [GlobalMethod judgeLoginState:^{
                [GB_Nav pushVCName:@"AddressListVC" animated:true];
            }];
            break;
        case 3:
            [GlobalMethod judgeLoginState:^{
                [GB_Nav pushVCName:@"PersonalInfoVC" animated:true];
            }];
            break;
        default:
            break;
    }
    ;
}
@end



@implementation PerCenterTitleAlertView
#pragma mark 懒加载
- (UILabel *)title{
    if (_title == nil) {
        _title = [UILabel new];
        _title.textColor = COLOR_999;
        _title.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightMedium];
    }
    return _title;
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
    self.height = [UIFont fetchHeight:F(12)];
    [self addLineFrame:CGRectMake(W(25), self.height/2.0, W(115), 1) tag:1];
    [self addLineFrame:CGRectMake(W(235), self.height/2.0, W(115), 1) tag:1];
    [self addSubview:self.title];
    
}
- (void)changeTitle:(NSString *)title{
    [self.title fitTitle:title variable:0];
    self.title.centerXTop = XY(SCREEN_WIDTH/2.0, 0);
}
@end



@implementation PerCenterShopView
#pragma mark 懒加载
- (UIImageView *)logo{
    if (_logo == nil) {
        _logo = [UIImageView new];
        _logo.image = [UIImage imageNamed:IMAGE_BIG_DEFAULT];
        _logo.widthHeight = XY(W(50),W(50));
        _logo.contentMode = UIViewContentModeScaleAspectFill;
        _logo.clipsToBounds = true;
        [_logo addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:5 lineWidth:1 lineColor:[UIColor colorWithHexString:@"#EFF2F1"]];
        
    }
    return _logo;
}
- (UIImageView *)arrow{
    if (_arrow == nil) {
        _arrow = [UIImageView new];
        _arrow.image = [UIImage imageNamed:@"arrow_right"];
        _arrow.widthHeight = XY(W(15),W(15));
    }
    return _arrow;
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

- (UIImageView *)star{
    if (_star == nil) {
        _star = [UIImageView new];
        _star.image = [UIImage imageNamed:@"shope_star"];
        _star.widthHeight = XY(W(12),W(12));
    }
    return _star;
}
- (UILabel *)score{
    if (_score == nil) {
        _score = [UILabel new];
        _score.textColor = COLOR_ORANGE;
        _score.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        _score.numberOfLines = 1;
        _score.lineSpace = 0;
    }
    return _score;
}
- (UILabel *)overturn{
    if (_overturn == nil) {
        _overturn = [UILabel new];
        _overturn.textColor = COLOR_999;
        _overturn.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        _overturn.numberOfLines = 1;
        _overturn.lineSpace = 0;
    }
    return _overturn;
}
- (UIView *)bg{
    if (!_bg) {
        _bg = [UIView new];
        _bg.backgroundColor = [UIColor whiteColor];
        _bg.widthHeight = XY(W(355), W(81));
        [_bg addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:10 lineWidth:0 lineColor:[UIColor clearColor]];
    }
    return _bg;
}
- (UIImageView *)ad{
    if (!_ad) {
        UIImageView * iv = [UIImageView new];
        iv.backgroundColor = [UIColor clearColor];
        iv.contentMode = UIViewContentModeScaleAspectFill;
        iv.clipsToBounds = true;
        iv.image = [UIImage imageNamed:@"per_入驻"];
        iv.widthHeight = self.bg.widthHeight;
        iv.left = W(10);
        _ad = iv;
    }
    return _ad;
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
    [self addSubview:self.logo];
    [self addSubview:self.name];
    [self addSubview:self.star];
    [self addSubview:self.score];
    [self addSubview:self.overturn];
    [self addSubview:self.arrow];
    [self addSubview:self.ad];
    [self addTarget:self action:@selector(click)];
    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelShopList *)model{
    self.model = model;
    //刷新view
    self.ad.hidden = model!=nil;
    [self.logo sd_setImageWithURL:[NSURL URLWithString:model.coverUrl] placeholderImage:[UIImage imageNamed:IMAGE_HEAD_COMPANY_DEFAULT]];
    self.logo.leftTop = XY(W(25),W(15));
    
    [self.name fitTitle:UnPackStr(model.storeName) variable:SCREEN_WIDTH - self.logo.right - W(40)];
    self.name.leftTop = XY(self.logo.right + W(10),self.logo.top+W(3));
    
    self.star.leftBottom = XY(self.logo.right + W(10),self.logo.bottom-W(4));
    [self.score fitTitle:strDotF(model.storeScore) variable:0];
    self.score.leftCenterY = XY(self.star.right + W(6),self.star.centerY);
    [self.overturn fitTitle:[NSString stringWithFormat:@"月售%.f",model.monthAmount] variable:0];
    self.overturn.leftCenterY = XY(self.score.right + W(20),self.star.centerY);
    
    //设置总高度
    self.height = self.logo.bottom + W(15);
    self.arrow.rightCenterY = XY(SCREEN_WIDTH - W(17), self.height/2.0);
}

- (void)click{
    [GlobalMethod judgeLoginState:^{
        if (self.model.iDProperty) {
            ShopDetailVC * detailVC = [ShopDetailVC new];
            detailVC.modelShop = self.model;
            [GB_Nav pushViewController:detailVC animated:true];
        }else{
            [GB_Nav pushVCName:@"MerchantSigninVC" animated:true];
        }
    }];
}
- (void)requestShop{
    [RequestApi requestMyShopListDelegate:nil success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        NSArray * ary = [GlobalMethod exchangeDic:response toAryWithModelName:@"ModelShopList"];
        if (ary.count) {
            ModelShopList * model = ary.firstObject;
            [RequestApi requestShopDetailWithId:NSNumber.dou(model.iDProperty).stringValue delegate:nil success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
                ModelShopList *modelDetail = [ModelShopList modelObjectWithDictionary:response];
                self.model = modelDetail;
                [self resetViewWithModel: self.model];
            } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
                
            }];
        }
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
    
}
@end





@implementation PerCenterUsView

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.width = SCREEN_WIDTH;
        self.height = W(45);
        [self addSubView];
    }
    return self;
}
//添加subview
- (void)addSubView{
    
    
    {
        UIView * view = [UIView new];
        view.backgroundColor = [UIColor whiteColor];
        view.widthHeight = XY(W(172), W(45));
        view.leftTop = XY(W(10), 0);
        [view addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:10 lineWidth:0 lineColor:[UIColor clearColor]];
        [view addTarget:self action:@selector(leftClick)];
        [self addSubview:view];
        
        UIImageView * iv = [UIImageView new];
        iv.backgroundColor = [UIColor clearColor];
        iv.contentMode = UIViewContentModeScaleAspectFill;
        iv.clipsToBounds = true;
        iv.image = [UIImage imageNamed:@"per_帮助"];
        iv.widthHeight = XY(W(18),W(18));
        iv.leftTop = XY(view.left + W(42),W(13.5));
        [self addSubview:iv];
        
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        l.textColor = COLOR_333;
        l.backgroundColor = [UIColor clearColor];
        [l fitTitle:@"帮助中心" variable:SCREEN_WIDTH - W(30)];
        l.leftCenterY = XY(iv.right + W(10),iv.centerY);
        [self addSubview:l];
    }
    
    {
        UIView * view = [UIView new];
        view.backgroundColor = [UIColor whiteColor];
        view.widthHeight = XY(W(172), W(45));
        view.rightTop = XY(SCREEN_WIDTH - W(10), 0);
        [view addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:10 lineWidth:0 lineColor:[UIColor clearColor]];
        [view addTarget:self action:@selector(rightClick)];
        [self addSubview:view];
        
        UIImageView * iv = [UIImageView new];
        iv.backgroundColor = [UIColor clearColor];
        iv.contentMode = UIViewContentModeScaleAspectFill;
        iv.clipsToBounds = true;
        iv.image = [UIImage imageNamed:@"per_关于"];
        iv.widthHeight = XY(W(18),W(18));
        iv.leftTop = XY(view.left + W(42),W(13.5));
        [self addSubview:iv];
        
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        l.textColor = COLOR_333;
        l.backgroundColor = [UIColor clearColor];
        NSString *appName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
        [l fitTitle:[NSString stringWithFormat:@"关于%@",appName] variable:SCREEN_WIDTH - W(30)];
        l.leftCenterY = XY(iv.right + W(10),iv.centerY);
        [self addSubview:l];
    }
    
}

- (void)leftClick{
    JournalismListVC * vc = [JournalismListVC new];
    vc.type = ENUM_NEWS_LIST_HELP;
    [GB_Nav pushViewController:vc animated:true];
}
- (void)rightClick{
    JournalismListVC * vc = [JournalismListVC new];
    vc.type = ENUM_NEWS_LIST_ABOUT;
    [GB_Nav pushViewController:vc animated:true];
}
@end
