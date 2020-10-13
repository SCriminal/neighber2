//
//  EHomeWaitPayView.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/9/30.
//Copyright © 2020 ping. All rights reserved.
//

#import "EHomeWaitPayView.h"

@implementation EHomeWaitPayCell
#pragma mark 懒加载
- (UIImageView *)iconSelected{
    if (_iconSelected == nil) {
        _iconSelected = [UIImageView new];
        _iconSelected.image = [UIImage imageNamed:@"select_default"];
        _iconSelected.highlightedImage =[UIImage imageNamed:@"select_highlighted"];
        _iconSelected.widthHeight = XY(W(18),W(18));
    }
    return _iconSelected;
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

- (UILabel *)timePay{
    if (_timePay == nil) {
        _timePay = [UILabel new];
        _timePay.textColor = COLOR_666;
        _timePay.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        _timePay.numberOfLines = 1;
    }
    return _timePay;
}
- (UILabel *)numAll{
    if (_numAll == nil) {
        _numAll = [UILabel new];
        _numAll.textColor = COLOR_666;
        _numAll.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        _numAll.numberOfLines = 1;
    }
    return _numAll;
}
- (UILabel *)price{
    if (_price == nil) {
        _price = [UILabel new];
        _price.textColor = COLOR_333;
        _price.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightMedium];
        _price.numberOfLines = 1;
    }
    return _price;
}
- (UILabel *)overTime{
    if (_overTime == nil) {
        _overTime = [UILabel new];
        _overTime.textColor = COLOR_666;
        _overTime.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        _overTime.numberOfLines = 1;
    }
    return _overTime;
}
- (UILabel *)overTimeFee{
    if (_overTimeFee == nil) {
        _overTimeFee = [UILabel new];
        _overTimeFee.textColor = COLOR_333;
        _overTimeFee.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightMedium];
        _overTimeFee.numberOfLines = 1;
    }
    return _overTimeFee;
}

#pragma mark 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        [self.contentView addSubview:self.name];
        [self.contentView addSubview:self.numAll];
        [self.contentView addSubview:self.price];
        [self.contentView addSubview:self.overTime];
        [self.contentView addSubview:self.overTimeFee];

        [self.contentView addSubview:self.timePay];
        [self.contentView addSubview:self.iconSelected];
        [self.contentView addTarget:self action:@selector(selectClick)];
    }
    return self;
}
#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelEHomeWaitPayList *)model{
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    self.model = model;
    [self.name fitTitle:UnPackStr(model.feeStateName) variable:W(200)];
    self.name.leftTop = XY(W(48),W(18));
    
    self.overTime.hidden = true;
    self.overTimeFee.hidden = true;
    if (model.dueFineFee) {
        self.overTime.hidden = false;
        self.overTimeFee.hidden = false;
        [self.overTime fitTitle:@"滞纳金" variable:0];
        self.overTime.leftTop = XY(W(48),W(44));
        [self.overTimeFee fitTitle:[NSString stringWithFormat:@"￥%@",NSNumber.dou(model.dueFineFee).stringValue]  variable:0];
        self.overTimeFee.rightCenterY = XY(SCREEN_WIDTH - W(15),self.overTime.centerY);
    }
    
    [self.timePay fitTitle:[NSString stringWithFormat:@"缴费周期：%@-%@",UnPackStr(model.feesStartDate),UnPackStr(model.feesEndDate)]  variable:W(220)];
    self.timePay.leftTop = XY(W(48),self.overTimeFee.hidden?W(44):W(67));

    
    [self.price fitTitle:[NSString stringWithFormat:@"￥%@",NSNumber.dou(model.debtsAmount).stringValue]  variable:0];
    self.price.rightCenterY = XY(SCREEN_WIDTH - W(15),self.name.centerY);
    
    [self.numAll fitTitle:[NSString stringWithFormat:@"%@笔待缴",model.billCount]  variable:0];
    self.numAll.rightCenterY = XY(SCREEN_WIDTH - W(15),self.timePay.centerY);

    //设置总高度
    self.height =  W(74);
    
    self.iconSelected.leftCenterY = XY(W(15), self.height/2.0);
    self.iconSelected.highlighted = model.selected;

}
#pragma mark click

-(void)selectClick{
    self.model.selected = !self.model.selected;
    self.iconSelected.highlighted = self.model.selected;
    if (self.blockSelected) {
        self.blockSelected(self.model);
    }
}
@end



@implementation EHomeWaitPayBottomView
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
        _num.textColor = COLOR_333;
        _num.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        [_num fitTitle:@"全选" variable:0];
    }
    return _num;
}
- (UIImageView *)ivSelected{
    if (!_ivSelected) {
        _ivSelected = [UIImageView new];
        _ivSelected.image = [UIImage imageNamed:@"select_default"];
        _ivSelected.highlightedImage = [UIImage imageNamed:@"select_highlighted"];
        _ivSelected.widthHeight = XY(W(15), W(15));
    }
    return _ivSelected;
}
- (YellowButton *)submit{
    if (!_submit) {
        _submit = [YellowButton new];
        [_submit resetViewWithWidth:W(96.5) :W(37) :@"结算"];
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
    [self addSubview:self.ivSelected];

    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(NSMutableArray *)arys{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    self.submit.rightTop = XY(SCREEN_WIDTH - W(10),W(6));

    self.ivSelected.leftCenterY = XY(W(15), self.submit.centerY);
    self.num.leftCenterY = XY(self.ivSelected.right + W(10),self.submit.centerY);
    [self addControlFrame:CGRectMake(0, 0, W(70), W(50)) target:self action:@selector(selectAllClick)];
    
    CGFloat numAll = 0;
    bool isSelectAll = true;
    for (ModelEHomeWaitPayList * modelItem in arys) {
        if (modelItem.selected) {
            numAll += modelItem.debtsAmount;
            numAll += modelItem.dueFineFee;
        }else{
            isSelectAll = false;
        }
    }
    self.ivSelected.highlighted = isSelectAll && arys.count>0;

    [self.price fitTitle:[
                          NSString stringWithFormat:@"¥ %@",NSNumber.dou(numAll).stringValue]
 variable:0];
    self.price.rightCenterY = XY(self.submit.left - W(15),self.submit.centerY);
    [self.all fitTitle:@"合计: " variable:0];
    self.all.rightCenterY = XY(self.price.left - W(0),self.price.centerY);

    //设置总高度
    self.height = self.submit.bottom + self.submit.top + iphoneXBottomInterval;
}

- (void)selectAllClick{
    self.ivSelected.highlighted = !self.ivSelected.highlighted;
    if (self.blockSelectAll) {
        self.blockSelectAll(self.ivSelected.highlighted);
    }
}

@end
