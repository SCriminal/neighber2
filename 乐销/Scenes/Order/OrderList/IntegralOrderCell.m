//
//  IntegralOrderCell.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/4/26.
//Copyright © 2020 ping. All rights reserved.
//

#import "IntegralOrderCell.h"

@interface IntegralOrderCell ()

@end

@implementation IntegralOrderCell
#pragma mark 懒加载
- (UIImageView *)productImage{
    if (_productImage == nil) {
        _productImage = [UIImageView new];
        _productImage.widthHeight = XY(W(50),W(50));
        _productImage.contentMode = UIViewContentModeScaleAspectFill;
        _productImage.clipsToBounds = true;
        [_productImage addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:5 lineWidth:0 lineColor:[UIColor clearColor]];

    }
    return _productImage;
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
- (UILabel *)score{
    if (_score == nil) {
        _score = [UILabel new];
        _score.textColor = COLOR_666;
        _score.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        _score.numberOfLines = 1;
        _score.lineSpace = 0;
    }
    return _score;
}
- (UILabel *)num{
    if (_num == nil) {
        _num = [UILabel new];
        _num.textColor = COLOR_666;
        _num.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        _num.numberOfLines = 1;
        _num.lineSpace = 0;
    }
    return _num;
}
- (UILabel *)time{
    if (_time == nil) {
        _time = [UILabel new];
        _time.textColor = COLOR_666;
        _time.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        _time.numberOfLines = 1;
        _time.lineSpace = 0;
    }
    return _time;
}
- (UILabel *)status{
    if (_status == nil) {
        _status = [UILabel new];
        _status.textColor = COLOR_ORANGE;
        _status.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        _status.numberOfLines = 0;
        _status.lineSpace = W(2);
    }
    return _status;
}

#pragma mark 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.productImage];
        [self.contentView addSubview:self.name];
        [self.contentView addSubview:self.score];
        [self.contentView addSubview:self.num];
        [self.contentView addSubview:self.time];
        [self.contentView addSubview:self.status];
        
    }
    return self;
}


#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelIntegralOrder *)model{
    self.model = model;
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    
    [self.productImage sd_setImageWithURL:[NSURL URLWithString:UnPackStr(model.skuCoverUrl)] placeholderImage:[UIImage imageNamed:IMAGE_BIG_DEFAULT]];
    self.productImage.leftTop = XY(W(20),W(30));
    [self.name fitTitle:UnPackStr(model.skuName) variable:SCREEN_WIDTH - self.productImage.right-W(40)];
    self.name.leftTop = XY(self.productImage.right+ W(10),self.productImage.top+W(2));
    [self.score fitTitle:[NSString stringWithFormat:@"积分%@",NSNumber.dou(model.score).stringValue]  variable:W(75)];
    self.score.leftBottom = XY(self.productImage.right + W(10),self.productImage.bottom-W(7));
    
    [self.num fitTitle:[NSString stringWithFormat:@"数量x%@",NSNumber.dou(model.qty).stringValue]  variable:W(75)];
    self.num.leftBottom = XY(self.productImage.right + W(90),self.productImage.bottom-W(7));

    [self.time fitTitle: [NSString stringWithFormat:@"兑换时间：%@",[GlobalMethod exchangeTimeWithStamp:model.createTime andFormatter:TIME_MIN_SHOW]] variable:0];
    self.time.rightTop = XY(SCREEN_WIDTH - W(20),self.productImage.bottom+W(13));
    
    [self.status fitTitle:UnPackStr(model.reply) variable:SCREEN_WIDTH - W(40)];
    self.status.rightTop = XY(SCREEN_WIDTH - W(20),self.time.bottom+W(15));
    self.status.hidden = !isStr(model.reply);
    //设置size
    self.height = self.status.hidden?(self.time.bottom + W(20)):(self.status.bottom + W(20));
    [self.contentView addLineFrame:CGRectMake(W(20), self.height -1, SCREEN_WIDTH - W(40), 1)];
}

@end
