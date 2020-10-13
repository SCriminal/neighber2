//
//  IntegralRecordCell.m
//  Driver
//
//  Created by 隋林栋 on 2019/4/11.
//Copyright © 2019 ping. All rights reserved.
//

#import "IntegralRecordCell.h"

@interface IntegralRecordCell ()
@property (nonatomic, strong) UILabel *labelTime;
@property (nonatomic, strong) UILabel *labelTitle;
@property (nonatomic, strong) UILabel *labelIntegral;

@end

@implementation IntegralRecordCell
#pragma mark 懒加载
- (UILabel *)labelTime{
    if (_labelTime == nil) {
        _labelTime = [UILabel new];
        _labelTime.textColor = COLOR_333;
        _labelTime.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];

    }
    return _labelTime;
}
- (UILabel *)labelTitle{
    if (_labelTitle == nil) {
        _labelTitle = [UILabel new];
        _labelTitle.textColor = COLOR_999;
        _labelTitle.font =  [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
    }
    return _labelTitle;
}
- (UILabel *)labelIntegral{
    if (_labelIntegral == nil) {
        _labelIntegral = [UILabel new];
        _labelIntegral.textColor = COLOR_333;
        _labelIntegral.font =  [UIFont systemFontOfSize:F(17) weight:UIFontWeightMedium];
    }
    return _labelIntegral;
}

#pragma mark 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.labelTime];
        [self.contentView addSubview:self.labelTitle];
        [self.contentView addSubview:self.labelIntegral];
        
    }
    return self;
}
#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelIntegralRecord *)model{
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    [self.labelTime fitTitle:[GlobalMethod exchangeTimeWithStamp:model.createTime andFormatter:TIME_DAY_SHOW] variable:W(250)];
    self.labelTime.leftTop = XY(W(15),W(20));
    [self.labelTitle fitTitle:model.channel == 1? @"每日签到":@"兑换商品" variable:W(300)];
    self.labelTitle.leftTop = XY(self.labelTime.left,self.labelTime.bottom+W(15));
    
    //设置总高度
    self.height = self.labelTitle.bottom +W(20);
    
    [self.labelIntegral fitTitle:[NSString stringWithFormat:@"%@%.f",model.direction==1?@"+":@"-",model.score] variable:0];
    self.labelIntegral.rightCenterY = XY(SCREEN_WIDTH - W(15),self.height/2.0);
    
    [self.contentView addLineFrame:CGRectMake(W(15), self.height -1, SCREEN_WIDTH-W(30), 1)];
}

@end
