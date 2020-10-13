//
//  TrolleyBtn.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/5/7.
//Copyright © 2020 ping. All rights reserved.
//

#import "TrolleyBtn.h"
//request
#import "RequestApi+Neighbor.h"

@interface TrolleyBtn ()

@end

@implementation TrolleyBtn


- (UILabel *)num{
    if (!_num) {
        _num = ^(){
            UILabel * l = [UILabel new];
            l.font = [UIFont systemFontOfSize:F(11) weight:UIFontWeightRegular];
            l.textColor = [UIColor whiteColor];
            l.backgroundColor = [UIColor colorWithHexString:@"#FE533F"];
            l.height = W(17);
            l.textAlignment = NSTextAlignmentCenter;
            [GlobalMethod setRoundView:l color:[UIColor whiteColor] numRound:W(17)/2.0 width:1];
            return l;
        }();
    }
    return _num;
}
#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];//背景色
        [self addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
        self.backgroundColor = [UIColor clearColor];
        [self setImage:[UIImage imageNamed:@"shopping_trolley"] forState:UIControlStateNormal];
        self.widthHeight = XY(W(89),W(89));
        [self addSubView];//添加子视图
        [self reconfig];
#ifdef UP_APP_STORE
        self.hidden = true;
#endif
    }
    return self;
}

//添加subview
- (void)addSubView{
    [self addSubview:self.num];
    
}
#pragma mark 点击事件
- (void)btnClick{
    [GlobalMethod judgeLoginState:^{
        [GB_Nav pushVCName:@"ShoppingTrolleyVC" animated:true];
    }];
}
- (void)reconfig{
    if (![GlobalMethod isLoginSuccess]) {
        return;
    }
    [RequestApi requestTrolleyDetailWithDelegate:nil success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        NSMutableArray * ary = [GlobalMethod exchangeDic:response toAryWithModelName:@"ModelTrolley"];
        CGFloat numAll = 0;
           for (ModelTrolley * modelTrolley in ary) {
                for (ModelIntegralProduct * modelPro in modelTrolley.skus) {
                      numAll += modelPro.qty;
                  }
           }
        self.num.hidden = !numAll;
        NSString * strNum = strDotF(numAll);
        self.num.width =  [strNum sizeWithAttributes:@{NSFontAttributeName: self.num.font}].width + W(10);
        self.num.text = strNum;
        self.num.rightTop = XY(self.width - W(11.5), W(9));
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];

}
@end
