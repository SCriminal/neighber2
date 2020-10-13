//
//  HailuoOrderDetailView.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/8/20.
//Copyright © 2020 ping. All rights reserved.
//

#import "HailuoOrderDetailView.h"



@implementation HailuoOrderDetailTopView

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelHailuoOrder *)modelOrder{
    [self removeAllSubViews];
    //重置视图坐标
    CGFloat top = W(15);
    top = [HailuoOrderDetailTopView addLabels:@[^(){
        ModelBaseData * model = [ModelBaseData new];
        model.string = [NSString stringWithFormat:@"订单编号：%@",UnPackStr(modelOrder.orderNumber)];
        return model;
    }(),^(){
        ModelBaseData * model = [ModelBaseData new];
        model.string = [NSString stringWithFormat:@"下单时间：%@",[GlobalMethod exchangeTimeWithStamp:modelOrder.createTime andFormatter:TIME_MIN_SHOW]];
        return model;
    }()] top:top view:self];
    
    UIView * viewOrder = [self viewWithTag:100];
    UILabel * l = [UILabel new];
    l.font = [UIFont systemFontOfSize:F(11) weight:UIFontWeightRegular];
    l.textColor = [UIColor whiteColor];
    l.backgroundColor = modelOrder.statusColorShow;
    l.textAlignment = NSTextAlignmentCenter;
    [l fitTitle:modelOrder.statusMessage variable:SCREEN_WIDTH - W(30)];
    l.widthHeight = XY([UILabel fetchWidthFontNum:l.fontNum text:l.text]+W(10), W(18));
    l.rightCenterY = XY(SCREEN_WIDTH - W(25), viewOrder.centerY);
    [l addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:5 lineWidth:0 lineColor:[UIColor clearColor]];
    

    [self addSubview:l];

    //设置总高度
    self.height = top + W(15);
    [HailuoOrderDetailTopView addBG:self frame:CGRectMake(W(10), 0, SCREEN_WIDTH-W(20), self.height)];

}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = COLOR_GRAY;//背景色
        self.width = SCREEN_WIDTH;//默认宽度
        [self addSubView];//添加子视图
    }
    return self;
}
//添加subview
- (void)addSubView{
    //初始化页面
    [self resetViewWithModel:nil];
}

+ (CGFloat)addLabels:(NSArray *)ary top:(CGFloat)top view:(UIView *)view{
    for (int i = 0; i<ary.count; i++) {
        ModelBaseData * model = ary[i];
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
        l.textColor = COLOR_333;
        l.backgroundColor = [UIColor clearColor];
        l.numberOfLines = 1;
        l.lineSpace = W(0);
        [l fitTitle:UnPackStr(model.string) variable:W(325)];
        l.leftTop = XY(W(25), top);
        l.tag = 100+i;
        [view addSubview:l];
        top = l.bottom+W(15);
    }
    return top - W(15);
}

+ (CGFloat)addTitle:(NSString *)title top:(CGFloat)top view:(UIView *)view{
     UILabel * l = [UILabel new];
    l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightMedium];
    l.textColor = COLOR_333;
    l.backgroundColor = [UIColor clearColor];
    l.numberOfLines = 1;
    l.lineSpace = W(0);
    [l fitTitle:UnPackStr(title) variable:W(325)];
    l.leftTop = XY(W(25), top);
    [view addSubview:l];
    return l.bottom;
}

+ (void)addBG:(UIView *)view frame:(CGRect)frame{
    UIView * BG = [UIView new];
    BG.backgroundColor = [UIColor whiteColor];
    BG.frame = frame;
    [BG addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:10 lineWidth:0 lineColor:[UIColor clearColor]];
    

    [view insertSubview:BG atIndex:0];
}
@end


@implementation HailuoOrderDetailOrderInfoView

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelHailuoOrder *)modelOrder{
    self.model = modelOrder;
    [self removeAllSubViews];
    //重置视图坐标
    CGFloat top = W(15);
    top = [HailuoOrderDetailTopView addTitle:@"订单信息" top:top view:self];
    top = [HailuoOrderDetailTopView addLabels:@[^(){
        ModelBaseData * model = [ModelBaseData new];
        model.string = [NSString stringWithFormat:@"企业信息：%@",UnPackStr(modelOrder.company)];
        return model;
    }(),^(){
        ModelBaseData * model = [ModelBaseData new];
        model.string = [NSString stringWithFormat:@"服务名称：%@",UnPackStr(modelOrder.serveName)];
        return model;
    }(),^(){
        ModelBaseData * model = [ModelBaseData new];
        model.string = [NSString stringWithFormat:@"服务时间：%@",UnPackStr(modelOrder.serveTime)];
        return model;
    }(),^(){
        ModelBaseData * model = [ModelBaseData new];
        model.string = [NSString stringWithFormat:@"服务金额：¥%@",UnPackStr(modelOrder.price)];
        return model;
    }(),^(){
        ModelBaseData * model = [ModelBaseData new];
        model.string = [NSString stringWithFormat:@"支付定金：¥%@",UnPackStr(modelOrder.earnestPrice)];
        return model;
    }(),^(){
        ModelBaseData * model = [ModelBaseData new];
        model.string = [NSString stringWithFormat:@"支付尾款：¥%@",UnPackStr(modelOrder.servePrice)];
        return model;
    }()] top:top+W(15) view:self];
    
    top = [self addLineFrame:CGRectMake(W(25), top +W(15), SCREEN_WIDTH - W(50), 1)];
    
    {
        UIImageView * iv = [UIImageView new];
        iv.backgroundColor = [UIColor clearColor];
        iv.contentMode = UIViewContentModeScaleAspectFill;
        iv.clipsToBounds = true;
        iv.image = [UIImage imageNamed:@"houseKeeping_complaint"];
        iv.widthHeight = XY(W(20),W(20));
        iv.leftTop = XY(W(56),W(11)+top);
        [self addSubview:iv];
        
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
        l.textColor = COLOR_333;
        l.backgroundColor = [UIColor clearColor];
        [l fitTitle:@"联系商家" variable:SCREEN_WIDTH - W(30)];
        l.leftCenterY = XY(iv.right + W(10), iv.centerY);
        [self addSubview:l];
        
        [self addControlFrame:CGRectInset(l.frame, -W(40), -W(20)) target:self action:@selector(connectClick)];

        [self addLineFrame:CGRectMake(SCREEN_WIDTH/2.0, iv.top, 1, iv.height)];

    }
    {
        UIImageView * iv = [UIImageView new];
        iv.backgroundColor = [UIColor clearColor];
        iv.contentMode = UIViewContentModeScaleAspectFill;
        iv.clipsToBounds = true;
        iv.image = [UIImage imageNamed:@"houseKeeping_phone"];
        iv.widthHeight = XY(W(20),W(20));
        iv.rightTop = XY(SCREEN_WIDTH - W(120),top + W(11));
        [self addSubview:iv];
        
        UILabel * l = [UILabel new];
               l.font = [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
               l.textColor = COLOR_333;
               l.backgroundColor = [UIColor clearColor];
               [l fitTitle:@"投诉申诉" variable:SCREEN_WIDTH - W(30)];
               l.leftCenterY = XY(iv.right + W(10), iv.centerY);
               [self addSubview:l];
               
               [self addControlFrame:CGRectInset(l.frame, -W(40), -W(20)) target:self action:@selector(complainClick)];
        top = iv.bottom + W(11);
    }

    //设置总高度
    self.height = top;
    [HailuoOrderDetailTopView addBG:self frame:CGRectMake(W(10), 0, SCREEN_WIDTH-W(20), self.height)];

}
- (void)connectClick {
    NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel://%@",self.model.companyTel];
              [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    
}
- (void)complainClick {
    NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel://%@",NSNumber.dou(self.model.complaintTel).stringValue];
              [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}
#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = COLOR_GRAY;//背景色
        self.width = SCREEN_WIDTH;//默认宽度
        [self addSubView];//添加子视图
    }
    return self;
}
//添加subview
- (void)addSubView{
    //初始化页面
    [self resetViewWithModel:nil];
}

@end


@implementation HailuoOrderDetailPayInfoView

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelHailuoOrder *)modelOrder{
    [self removeAllSubViews];
    //重置视图坐标
    CGFloat top = W(15);
    top = [HailuoOrderDetailTopView addTitle:@"支付信息" top:top view:self];
    top = [HailuoOrderDetailTopView addLabels:@[^(){
        ModelBaseData * model = [ModelBaseData new];
        model.string = [NSString stringWithFormat:@"服务金额：¥%@",UnPackStr(modelOrder.price)];
        return model;
    }(),^(){
        ModelBaseData * model = [ModelBaseData new];
        model.string = [NSString stringWithFormat:@"支付定金：¥%@",UnPackStr(modelOrder.earnestPrice)];
        return model;
    }(),^(){
        ModelBaseData * model = [ModelBaseData new];
        model.string = [NSString stringWithFormat:@"支付尾款：¥%@",UnPackStr(modelOrder.servePrice)];
        return model;
    }()] top:top+W(15) view:self];
    
    top = [self addLineFrame:CGRectMake(W(25), top +W(15), SCREEN_WIDTH - W(50), 1)]+W(15);
    
    top = [HailuoOrderDetailTopView addLabels:@[^(){
        ModelBaseData * model = [ModelBaseData new];
        model.string = [NSString stringWithFormat:@"已续费：%@次",NSNumber.dou(modelOrder.renewCount).stringValue];
        return model;
    }()] top:top view:self];
    //设置总高度
    self.height = top + W(15);
    [HailuoOrderDetailTopView addBG:self frame:CGRectMake(W(10), 0, SCREEN_WIDTH-W(20), self.height)];

}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = COLOR_GRAY;//背景色
        self.width = SCREEN_WIDTH;//默认宽度
        [self addSubView];//添加子视图
    }
    return self;
}
//添加subview
- (void)addSubView{
    //初始化页面
    [self resetViewWithModel:nil];
}

@end




@implementation HailuoOrderAddressView
#pragma mark 懒加载
- (UIImageView *)location{
    if (_location == nil) {
        _location = [UIImageView new];
        _location.image = [UIImage imageNamed:@"order_location"];
        _location.widthHeight = XY(W(15),W(15));
    }
    return _location;
}
- (UILabel *)name{
    if (_name == nil) {
        _name = [UILabel new];
        _name.textColor = COLOR_333;
        _name.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightMedium];
    }
    return _name;
}
- (UILabel *)phone{
    if (_phone == nil) {
        _phone = [UILabel new];
        _phone.textColor = COLOR_333;
        _phone.font =  [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
    }
    return _phone;
}
- (UILabel *)address{
    if (_address == nil) {
        _address = [UILabel new];
        _address.textColor = COLOR_333;
        _address.font =  [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
        _address.numberOfLines = 0;
        _address.lineSpace = W(4);

    }
    return _address;
}

- (UIView *)BG{
    if (!_BG) {
        _BG = [UIView new];
        _BG.backgroundColor = [UIColor whiteColor];
    }
    return _BG;
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
    [self addSubview:self.BG];
    [self addSubview:self.location];
    [self addSubview:self.name];
    [self addSubview:self.phone];
    [self addSubview:self.address];

}

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelShopAddress *)model{
    self.model = model;
   
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    self.location.leftTop = XY(W(25) ,W(14));
    [self.name fitTitle:UnPackStr(model.contact) variable:W(150)];
    self.name.leftCenterY = XY(self.location.right + W(7),self.location.centerY);
    [self.phone fitTitle:UnPackStr(model.phone) variable:W(150)];
    self.phone.leftBottom = XY(self.name.right+ W(8),self.name.bottom);
    [self.address fitTitle:UnPackStr(model.addressDetailShow) variable:W(300)];
    self.address.leftTop = XY(self.name.left,self.location.bottom+W(11));

    self.height = self.address.bottom + W(15);

   
    
    self.BG.widthHeight = XY(W(355), self.height);
    self.BG.centerXTop = XY(SCREEN_WIDTH/2.0, 0);
    [self.BG removeCorner];
    [self.BG addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:10 lineWidth:0 lineColor:[UIColor clearColor]];
}

@end
