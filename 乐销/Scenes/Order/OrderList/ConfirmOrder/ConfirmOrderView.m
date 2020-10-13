//
//  ConfirmOrderView.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/4/21.
//Copyright © 2020 ping. All rights reserved.
//

#import "ConfirmOrderView.h"
@interface ConfirmOrderView ()

@end

@implementation ConfirmOrderView
#pragma mark 懒加载
- (UILabel *)price{
    if (_price == nil) {
        _price = [UILabel new];
        _price.textColor = [UIColor colorWithHexString:@"#FE533F"];
        _price.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
    }
    return _price;
}
- (UILabel *)all{
    if (_all == nil) {
        _all = [UILabel new];
        _all.textColor = COLOR_333;
        _all.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
    }
    return _all;
}
- (UILabel *)num{
    if (_num == nil) {
        _num = [UILabel new];
        _num.textColor = COLOR_999;
        _num.font =  [UIFont systemFontOfSize:F(14) weight:UIFontWeightRegular];
    }
    return _num;
}
- (YellowButton *)submit{
    if (!_submit) {
        _submit = [YellowButton new];
        [_submit resetViewWithWidth:W(100) :W(37) :@"提交订单"];
        WEAKSELF
        _submit.blockClick = ^{
            if (weakSelf.blockSubmitClick) {
                weakSelf.blockSubmitClick();
            }
        };
    }
    return _submit;
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
        [self addSubview:self.price];
    [self addSubview:self.all];
    [self addSubview:self.num];
    [self addSubview:self.submit];

}

#pragma mark 刷新view
- (void)resetViewWithModel:(NSArray *)ary{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    self.submit.rightTop = XY(SCREEN_WIDTH - W(10),W(6));

    //刷新view
    CGFloat priceAll = 0;
    CGFloat numAll = 0;
    for (ModelTrolley * modelTrolley in ary) {
         for (ModelIntegralProduct * modelPro in modelTrolley.skus) {
                   priceAll += modelPro.qty*modelPro.price;
               numAll += modelPro.qty;
           }
    }
   
    [self.price fitTitle:[
                          NSString stringWithFormat:@"¥ %@",NSNumber.price(priceAll).stringValue]
 variable:0];
    self.price.rightCenterY = XY(self.submit.left - W(15),self.submit.centerY);
   
    [self.all fitTitle:@"合计: " variable:0];
    self.all.rightCenterY = XY(self.price.left - W(0),self.price.centerY);
    
    [self.num fitTitle:[NSString stringWithFormat:@"共%@件",NSNumber.dou(numAll)] variable:0];
    self.num.rightCenterY = XY(self.all.left - W(10),self.all.centerY);

    //设置总高度
    self.height = self.submit.bottom + self.submit.top + iphoneXBottomInterval;
}

@end
