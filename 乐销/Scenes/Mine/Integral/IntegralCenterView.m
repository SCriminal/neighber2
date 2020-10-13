//
//  IntegralCenterView.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/10.
//Copyright © 2020 ping. All rights reserved.
//

#import "IntegralCenterView.h"

@interface IntegralCenterView ()

@end

@implementation IntegralCenterView
#pragma mark 懒加载
- (UIImageView *)BG{
    if (_BG == nil) {
        _BG = [UIImageView new];
        _BG.image = [UIImage imageNamed:@"integral_BG"];
        _BG.widthHeight = XY(W(345),W(125));
    }
    return _BG;
}
- (UILabel *)scoreNum{
    if (_scoreNum == nil) {
        _scoreNum = [UILabel new];
        _scoreNum.textColor = [UIColor whiteColor];
        _scoreNum.font =  [UIFont systemFontOfSize:F(35) weight:UIFontWeightMedium];
        _scoreNum.numberOfLines = 1;
        _scoreNum.lineSpace = 0;
    }
    return _scoreNum;
}
- (UILabel *)score{
    if (_score == nil) {
        _score = [UILabel new];
        _score.textColor = [UIColor whiteColor];
        _score.font =  [UIFont systemFontOfSize:F(14) weight:UIFontWeightRegular];
        _score.numberOfLines = 1;
        _score.lineSpace = 0;
    }
    return _score;
}
- (UILabel *)time{
    if (_time == nil) {
        _time = [UILabel new];
        _time.textColor =  [UIColor whiteColor];
        _time.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        _time.numberOfLines = 1;
        _time.lineSpace = 0;
    }
    return _time;
}
-(UIButton *)btnRecord{
    if (_btnRecord == nil) {
        _btnRecord = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnRecord.tag = 1;
        [_btnRecord addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _btnRecord.backgroundColor = [UIColor clearColor];
        _btnRecord.titleLabel.font = [UIFont systemFontOfSize:F(12)];
        _btnRecord.widthHeight = XY(W(70),W(25));
        [_btnRecord addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:_btnRecord.height/2.0 lineWidth:1 lineColor:[UIColor whiteColor]];
        [_btnRecord setTitle:@"积分账单" forState:(UIControlStateNormal)];
    }
    return _btnRecord;
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
    [self addSubview:self.scoreNum];
    [self addSubview:self.score];
    [self addSubview:self.time];
    [self addSubview:self.btnRecord];
    
    //初始化页面
    [self resetViewWithModel:0];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(int)score{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    
    self.BG.centerX = SCREEN_WIDTH/2.0;
    [self.scoreNum fitTitle:[NSString stringWithFormat:@"%d",score] variable:0];
    self.scoreNum.centerXTop = XY(SCREEN_WIDTH/2.0,W(25));
    
    [self.score fitTitle:@"积分" variable:0];
    self.score.leftBottom = XY(self.scoreNum.right+W(3),self.scoreNum.bottom- W(6));

    [self.time fitTitle:[NSString stringWithFormat:@"%@，您的排名为1000",[GlobalMethod exchangeDate:[NSDate date] formatter:@"yyyy年截止MM月dd日"]] variable:0];
    self.time.centerXTop = XY(SCREEN_WIDTH/2.0,self.scoreNum.bottom+W(17));

    self.btnRecord.rightTop = XY(SCREEN_WIDTH - W(26),W(11));
    
    //设置总高度
    self.height = W(125);
}
#pragma mark 点击事件
- (void)btnClick:(UIButton *)sender{
    if (self.blockBillClick) {
        self.blockBillClick();
    }
}

@end
