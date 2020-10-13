//
//  OrderDetailView.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/4/21.
//Copyright © 2020 ping. All rights reserved.
//4d5ae06d51db29e42a88186ccd73b08da99038dc

#import "OrderDetailView.h"

@interface OrderDetailTopView ()

@end

@implementation OrderDetailTopView
#pragma mark 懒加载
- (UILabel *)title{
    if (_title == nil) {
        _title = [UILabel new];
        _title.textColor = [UIColor whiteColor];
        _title.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightMedium];
    }
    return _title;
}
- (UILabel *)subTitle{
    if (_subTitle == nil) {
        _subTitle = [UILabel new];
        _subTitle.textColor = [UIColor whiteColor];
        _subTitle.font =  [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
    }
    return _subTitle;
}
- (UIImageView *)icon{
    if (_icon == nil) {
        _icon = [UIImageView new];
        _icon.widthHeight = XY(W(75),W(75));
        _icon.image = [UIImage imageNamed:@"order_top_close"];
        
    }
    return _icon;
}
- (UIImageView *)BG{
    if (_BG == nil) {
        _BG = [UIImageView new];
        _BG.image = [UIImage imageNamed:@"order_top_bg"];
        _BG.widthHeight = XY(SCREEN_WIDTH,W(91));
    }
    return _BG;
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
    [self addSubview:self.BG];
    [self addSubview:self.title];
    [self addSubview:self.subTitle];
    [self addSubview:self.icon];
    
}

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelOrderDetail *)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    
    //设置总高度
    self.height = self.BG.height;
    NSString * strStatus = model.statusShow;
    NSDate * date = [GlobalMethod exchangeTimeStampToDate:model.createTime];
    date = [date dateByAddingTimeInterval:86400];
    int min = fabs(date.timeIntervalSinceNow/60.0);
    NSString * strLimit = [NSString stringWithFormat:@"剩余%d小时%d分自动关闭",min/60,min%60];
    //刷新view
    [self.title fitTitle:strStatus variable:0];
    self.title.leftTop = XY(W(30),W(25));
    [self.subTitle fitTitle:strLimit variable:0];
    self.subTitle.leftTop = XY(self.title.left,self.title.bottom+W(12));
    self.subTitle.hidden = model.orderStatus != ENUM_ORDER_STATUS_SUBMIT;
    
    self.icon.rightTop = XY(SCREEN_WIDTH - W(45),W(8));
    if (model.orderStatus != ENUM_ORDER_STATUS_SUBMIT) {
        self.title.centerY = self.icon.centerY;
    }
    NSString * orderBG = nil;
    switch (model.orderStatus) {
        case ENUM_ORDER_STATUS_CLOSE:
            orderBG = @"order_top_close";
            break;
            case ENUM_ORDER_STATUS_SUBMIT:
            orderBG = @"order_top_waitpay";
            break;
            case ENUM_ORDER_STATUS_PAY:
            orderBG = @"order_top_pay";
            break;
            case ENUM_ORDER_STATUS_SEND:
            orderBG = @"order_top_send";
            break;
            case ENUM_ORDER_STATUS_COMPLETE:
            orderBG = @"order_top_complete";
            break;
        default:
            break;
    }
    self.icon.image = [UIImage imageNamed:orderBG];

}

@end



@implementation OrderDetailBottomView

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.width = SCREEN_WIDTH;
        self.height = W(49)+iphoneXBottomInterval;
        self.clipsToBounds = true;
    }
    return self;
}


#pragma mark 刷新view
- (void)resetViewWithModel:(ModelOrderDetail *)model{
    self.model = model;
    switch (model.orderStatus) {
        case ENUM_ORDER_STATUS_CLOSE:
            {
                self.height = 0;
            }
            break;
            case ENUM_ORDER_STATUS_COMPLETE:
            {
                self.height = 0;
            }
            break;
            case ENUM_ORDER_STATUS_SEND:
            {
                self.height = W(49)+iphoneXBottomInterval;
                  [self addBtns:@[^(){
                                     ModelBtn * item = [ModelBtn new];
                                     item.title = @"确认收货";
                                     item.color = COLOR_ORANGE;
                                     item.colorSelect = COLOR_ORANGE;
                                     item.tag = ENUM_ORDER_OPERATE_CONFIRM_RECEIVE;
                                     return item;
                                 }()]];
            }
            break;
            case ENUM_ORDER_STATUS_PAY:
            {
                self.height = W(49)+iphoneXBottomInterval;
                [self addBtns:@[^(){
                       ModelBtn * item = [ModelBtn new];
                       item.title = @"修改地址";
                       item.color = COLOR_999;
                       item.colorSelect = [UIColor colorWithHexString:@"#AEAEAE"];
                       item.tag = ENUM_ORDER_OPERATE_CHANGE_ADDRESS;
                       return item;
                   }()]];
            }
            break;
            case ENUM_ORDER_STATUS_SUBMIT:
            {
                self.height = W(49)+iphoneXBottomInterval;
                [self addBtns:@[^(){
                       ModelBtn * item = [ModelBtn new];
                       item.title = @"付款";
                       item.color = COLOR_ORANGE;
                       item.colorSelect = COLOR_ORANGE;
                       item.tag = ENUM_ORDER_OPERATE_PAY;
                       return item;
                   }(),^(){
                       ModelBtn * item = [ModelBtn new];
                       item.title = @"取消订单";
                       item.color = COLOR_999;
                       item.colorSelect = [UIColor colorWithHexString:@"#AEAEAE"];
                       item.tag = ENUM_ORDER_OPERATE_CANCEL;
                       return item;
                   }(),^(){
                       ModelBtn * item = [ModelBtn new];
                       item.title = @"修改地址";
                       item.color = COLOR_999;
                       item.colorSelect = [UIColor colorWithHexString:@"#AEAEAE"];
                       item.tag = ENUM_ORDER_OPERATE_CHANGE_ADDRESS;
                       return item;
                   }()]];
            }
            break;
        default:
            break;
    }
   
    
}
-(void)addBtns:(NSArray *)ary{
    [self removeAllSubViews];//移除线
    CGFloat right = SCREEN_WIDTH - W(10);
    for (int i = 0; i<ary.count; i++) {
        ModelBtn * model = ary[i];
        UIButton *ensureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [ensureBtn setTitle:model.title forState:0];
        [ensureBtn setTitleColor:model.color forState:0];
        ensureBtn.titleLabel.fontNum = F(15);
        ensureBtn.widthHeight = XY(model.title.length == 2?W(81):W(103), W(37));
        ensureBtn.rightTop = XY(right, W(6));
        right = ensureBtn.left - W(10);
        ensureBtn.tag = model.tag;
        [ensureBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [GlobalMethod setRoundView:ensureBtn color:model.colorSelect numRound:ensureBtn.height/2.0 width:1];
        [self addSubview:ensureBtn];
    }
}

#pragma mark 点击事件
- (void)btnClick:(UIButton *)sender{
    if (self.blockClick) {
        self.blockClick(sender.tag);
    }
}
@end

@implementation OrderDetailInfoView

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.width = SCREEN_WIDTH;
    }
    return self;
}


#pragma mark 刷新view
- (void)resetViewWithModel:(ModelOrderDetail *)model{
    [self removeAllSubViews];//移除线
    CGFloat top = 0;
    top = [self addInfos:@[^(){
        ModelBaseData * item = [ModelBaseData new];
        item.string = @"订单编号：";
        item.subString = UnPackStr(model.number);
        return item;
    }(),^(){
        ModelBaseData * item = [ModelBaseData new];
        item.string = @"下单时间：";
        item.subString = [GlobalMethod exchangeTimeWithStamp:model.createTime andFormatter:TIME_MIN_SHOW];
        return item;
    }()] title:@"订单信息" top:top];
    
    //!(model.orderStatus == ENUM_ORDER_STATUS_SUBMIT||model.orderStatus == ENUM_ORDER_STATUS_PAY||model.orderStatus == ENUM_ORDER_STATUS_CLOSE)
    if (isStr(model.answer)) {
         top += W(10);
           top = [self addInfos:@[^(){
               ModelBaseData * item = [ModelBaseData new];
               item.string = @"";
               item.subString = UnPackStr(model.answer);
               return item;
           }()] title:@"发货信息" top:top];
    }
    self.height = top+W(20);
   
}
-(CGFloat)addInfos:(NSArray *)ary title:(NSString *)title top:(CGFloat)top{
    UILabel * l = [UILabel new];
    l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightMedium];
    l.textColor = COLOR_333;
    l.backgroundColor = [UIColor clearColor];
    [l fitTitle:title variable:SCREEN_WIDTH - W(30)];
    l.leftTop = XY(W(25), top + W(11));
    [self addSubview:l];
    
    CGFloat t = l.bottom+W(15);
    for (int i = 0; i<ary.count; i++) {
        ModelBaseData * model = ary[i];
        UILabel * left = [UILabel new];
        left.font = [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
        left.textColor = COLOR_333;
        left.backgroundColor = [UIColor clearColor];
        [left fitTitle:model.string variable:SCREEN_WIDTH - W(30)];
        left.leftTop = XY(W(25), t);
        [self addSubview:left];
        
        UILabel * right = [UILabel new];
        right.font = [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
        right.textColor = COLOR_333;
        right.backgroundColor = [UIColor clearColor];
        right.leftTop = XY(left.right, t);
        right.numberOfLines = 0;
        right.lineSpace = W(4);
        [right fitTitle:model.subString variable:SCREEN_WIDTH - W(25)-left.right];
        [self addSubview:right];
        t = MAX(left.bottom, right.bottom)+W(12);
    }
    UIView * viewBG = [UIView new];
    viewBG.backgroundColor = [UIColor whiteColor];
    viewBG.frame = CGRectMake(W(10), top, SCREEN_WIDTH - W(20), t - top);
    [viewBG addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:10 lineWidth:0 lineColor:[UIColor clearColor]];
    [self insertSubview:viewBG belowSubview:l];
    return viewBG.bottom;
}


@end


@implementation OrderDetailSectionBottomView
#pragma mark 懒加载
- (UIView *)whiteBG{
    if (_whiteBG == nil) {
        _whiteBG = [UIView new];
        _whiteBG.backgroundColor = [UIColor whiteColor];
    }
    return _whiteBG;
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
- (UILabel *)freight{
    if (_freight == nil) {
        _freight = [UILabel new];
        _freight.textColor = COLOR_666;
        _freight.font =  [UIFont systemFontOfSize:F(14) weight:UIFontWeightRegular];
        [_freight fitTitle:@"运费" variable:0];

    }
    return _freight;
}
- (UILabel *)freightPrice{
    if (_freightPrice == nil) {
        _freightPrice = [UILabel new];
        _freightPrice.textColor = COLOR_666;
        _freightPrice.font =  [UIFont systemFontOfSize:F(14) weight:UIFontWeightRegular];
    }
    return _freightPrice;
}
- (UILabel *)real{
    if (_real == nil) {
        _real = [UILabel new];
        _real.textColor = COLOR_666;
        _real.font =  [UIFont systemFontOfSize:F(14) weight:UIFontWeightRegular];
        [_real fitTitle:@"商品金额" variable:0];
    }
    return _real;
}
- (UILabel *)realPrice{
    if (_realPrice == nil) {
        _realPrice = [UILabel new];
        _realPrice.textColor = COLOR_666;
        _realPrice.font =  [UIFont systemFontOfSize:F(14) weight:UIFontWeightRegular];
    }
    return _realPrice;
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
    [self addSubview:self.number];
    [self addSubview:self.price];
     [self addSubview:self.freight];
    [self addSubview:self.freightPrice];
    [self addSubview:self.real];
    [self addSubview:self.realPrice];

    //初始化页面
    [self resetViewWithModel:nil modelDetail:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelTrolley *)model modelDetail:(ModelOrderDetail *)modelDetail{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    self.real.leftTop = XY(W(25), W(5));
    [self.realPrice fitTitle:[NSString stringWithFormat:@"¥ %@",NSNumber.price(modelDetail.price).stringValue] variable:0];
    self.realPrice.rightCenterY = XY(SCREEN_WIDTH - W(25), self.real.centerY);
    
    self.freight.leftTop = XY(W(25),self.real.bottom + W(12));
    [self.freightPrice fitTitle:[NSString stringWithFormat:@"¥ %@",NSNumber.price(modelDetail.freightPrice).stringValue] variable:0];
    self.freightPrice.rightCenterY = XY(SCREEN_WIDTH - W(25), self.freight.centerY);

    CGFloat top = [self addLineFrame:CGRectMake(W(25), self.freight.bottom + W(15), SCREEN_WIDTH - W(50), 1)];
    //刷新view
    CGFloat numAll = 0;
    for (ModelIntegralProduct * modelPro in model.skus) {
        numAll += modelPro.qty;
    }
    
    [self.price fitTitle:[
                          NSString stringWithFormat:@"¥ %@",NSNumber.price(modelDetail.totalPrice).stringValue] variable:0];
    self.price.rightTop = XY(SCREEN_WIDTH - W(25),top + W(15));
    
    [self.number fitTitle:[NSString stringWithFormat:@"共%@件",NSNumber.dou(numAll)] variable:0];
    self.number.rightCenterY = XY(self.price.left - W(10), self.price.centerY);

    //设置总高度
    self.height = self.price.bottom + W(13.5);
    self.whiteBG.widthHeight = XY(W(355), self.height);
    [self.whiteBG removeCorner];
    [self.whiteBG addRoundCorner:UIRectCornerBottomLeft|UIRectCornerBottomRight radius:(10)];
    
    self.whiteBG.centerXTop = XY(SCREEN_WIDTH/2.0,0);
}

@end
