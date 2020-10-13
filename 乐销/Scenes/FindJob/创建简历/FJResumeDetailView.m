//
//  FJResumeDetailView.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/9/16.
//Copyright © 2020 ping. All rights reserved.
//

#import "FJResumeDetailView.h"

@interface FJResumeDetailAddView ()

@end

@implementation FJResumeDetailAddView

#pragma mark 刷新view
- (void)resetViewWithTitle:(NSString *)title iconView:(NSString *)icon{
    [self resetViewWithTitle:title iconView:icon isEdit:false];
}
- (void)resetViewWithTitle:(NSString *)title iconView:(NSString *)icon isEdit:(BOOL)isEdit{
    [self removeAllSubViews];
    UIImageView * iv = [UIImageView new];
    iv.backgroundColor = [UIColor clearColor];
    iv.contentMode = UIViewContentModeScaleAspectFill;
    iv.clipsToBounds = true;
    iv.image = [UIImage imageNamed:icon];
    iv.widthHeight = XY(W(15),W(15));
    iv.leftTop = XY(W(15),W(20));
    [self addSubview:iv];

    UILabel * l = [UILabel new];
    l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightMedium];
    l.textColor = COLOR_333;
    l.backgroundColor = [UIColor clearColor];
    [l fitTitle:title variable:SCREEN_WIDTH - W(30)];
    l.leftCenterY = XY(iv.right + W(7), iv.centerY);
    [self addSubview:l];
    
    l = [UILabel new];
    l.font = [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
    l.textColor = COLOR_ORANGE;
    l.backgroundColor = [UIColor clearColor];
    [l fitTitle:@"添加" variable:SCREEN_WIDTH - W(30)];
    l.rightCenterY = XY(SCREEN_WIDTH - W(15), iv.centerY);
    [self addSubview:l];

    iv = [UIImageView new];
    iv.backgroundColor = [UIColor clearColor];
    iv.contentMode = UIViewContentModeScaleAspectFill;
    iv.clipsToBounds = true;
    iv.image = [UIImage imageNamed:isEdit?@"findjob_编辑":@"shope_add"];
    iv.widthHeight = XY(W(15),W(15));
    iv.rightCenterY = XY(l.left - W(5),l.centerY);
    [self addSubview:iv];
    
    [self addControlFrame:CGRectInset(l.frame, -W(30), -W(10)) target:self action:@selector(addClick)];
    //设置总高度
    self.height = iv.bottom + W(10);
}
- (void)addClick{
    if (self.blockAdd) {
        self.blockAdd();
    }
}
#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];//背景色
        self.width = SCREEN_WIDTH;//默认宽度
    }
    return self;
}

@end


@implementation FJResumeDetailJobintentionView
- (FJResumeDetailAddView *)addView{
    if (!_addView) {
        _addView = [FJResumeDetailAddView new];
        [_addView resetViewWithTitle:@"求职意向" iconView:@"findjob_意向" isEdit:true];
    }
    return _addView;
}
#pragma mark 刷新view
- (void)resetViewWithModel:(ModelResumeDetail *)model{
    self.model = model;
    [self removeAllSubViews];
    [self addSubview:self.addView];
    CGFloat top = self.addView.bottom + W(10);
    
    UILabel * l = [UILabel new];
           l.font = [UIFont systemFontOfSize:F(13) weight:UIFontWeightMedium];
           l.textColor = COLOR_333;
           l.backgroundColor = [UIColor clearColor];
           l.numberOfLines = 1;
           [l fitTitle:UnPackStr(model.intentionJobs) variable: W(290)];
           l.leftTop = XY(W(15),top);
           [self addSubview:l];
           top = l.bottom;
           
      
                  
                  l = [UILabel new];
                  l.font = [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
                  l.textColor = COLOR_666;
                  l.backgroundColor = [UIColor clearColor];
                  l.numberOfLines = 0;
                  l.lineSpace = W(3);
    [l fitTitle:[NSString stringWithFormat:@"%@ | %@ | %@ | %@ | %@",UnPackStr(model.natureCn),UnPackStr(model.wageCn),UnPackStr(model.tradeCn),UnPackStr(model.districtCn),UnPackStr(model.currentCn)] variable:SCREEN_WIDTH - W(30)];

                  l.leftTop = XY(W(15),top + W(12));
                  [self addSubview:l];
                  top = l.bottom + W(20);
    //设置总高度
    self.height = top;
    [self addLineFrame:CGRectMake(W(15), self.height -1, SCREEN_WIDTH - W(15), 1)];

}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];//背景色
        self.width = SCREEN_WIDTH;//默认宽度
    }
    return self;
}

@end

@implementation FJResumeDetailTopInfoView

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelResumeDetail *)model{
    self.model = model;
    [self removeAllSubViews];
    CGFloat top = 0;
        UIImageView * iv = [UIImageView new];
        iv.backgroundColor = [UIColor clearColor];
        iv.contentMode = UIViewContentModeScaleAspectFill;
        iv.clipsToBounds = true;
        [iv sd_setImageWithURL:[NSURL URLWithString:[GlobalData sharedInstance].GB_UserModel.headUrl] placeholderImage:[UIImage imageNamed:IMAGE_HEAD_DEFAULT]];
        iv.widthHeight = XY(W(50),W(50));
        [iv addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:iv.width/2.0 lineWidth:0 lineColor:[UIColor clearColor]];
        

        iv.leftTop = XY(W(15),W(15));
        [self addSubview:iv];
        top = iv.bottom;
        
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightMedium];
        l.textColor = COLOR_333;
        l.backgroundColor = [UIColor clearColor];
        l.numberOfLines = 1;
        [l fitTitle:model.fullname variable:W(220)];
        l.leftTop = XY(iv.right + W(10),iv.top + W(3));
        [self addSubview:l];
        
        l = [UILabel new];
              l.font = [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
              l.textColor = COLOR_666;
              l.backgroundColor = [UIColor clearColor];
              l.numberOfLines = 1;
              [l fitTitle:[NSString stringWithFormat:@"%@ | %@岁 | %@ | %@",UnPackStr(self.model.sexCn),NSNumber.dou(self.model.age).stringValue,UnPackStr(self.model.experienceCn),UnPackStr(self.model.marriageCn)] variable:W(220)];
              l.leftBottom = XY(iv.right + W(10),iv.bottom - W(3));
              [self addSubview:l];
        
        iv = [UIImageView new];
                 iv.backgroundColor = [UIColor clearColor];
                 iv.contentMode = UIViewContentModeScaleAspectFill;
                 iv.clipsToBounds = true;
                 iv.image = [UIImage imageNamed:@"findjob_编辑"];
                 iv.widthHeight = XY(W(15),W(15));
                 iv.rightCenterY = XY(SCREEN_WIDTH - W(15),l.centerY);
                 [self addSubview:iv];
        [self addControlFrame:CGRectInset(iv.frame, -W(30), -W(10)) target:self action:@selector(addClick)];

        
      
        
        NSArray * ary = @[^(){
            ModelBaseData * item = [ModelBaseData new];
            item.string = @"专业：";
            item.subString = model.majorCn;
            return item;
        }(),^(){
            ModelBaseData * item = [ModelBaseData new];
            item.string = @"现居：";
            item.subString = model.residence;
            return item;
        }(),^(){
            ModelBaseData * item = [ModelBaseData new];
            item.string = @"手机：";
            item.subString = model.telephone;
            return item;
        }(),^(){
            ModelBaseData * item = [ModelBaseData new];
            item.string = @"微信：";
            item.subString = model.weixin;
            return item;
        }(),^(){
            ModelBaseData * item = [ModelBaseData new];
            item.string = @"邮箱：";
            item.subString = model.email;
            return item;
        }(),^(){
            ModelBaseData * item = [ModelBaseData new];
            item.string = @"学历：";
            item.subString = model.educationCn;
            return item;
        }(),^(){
            ModelBaseData * item = [ModelBaseData new];
            item.string = @"籍贯：";
            item.subString = model.householdaddress;
            return item;
        }(),^(){
            ModelBaseData * item = [ModelBaseData new];
            item.string = @"QQ：";
            item.subString = model.qq;
            return item;
        }(),^(){
            ModelBaseData * item = [ModelBaseData new];
            item.string = @"身份证号：";
            item.subString = model.idcard;
            return item;
        }()];
        CGFloat left = W(15);
        CGFloat lTop = top + W(20);
        for (int i = 0; i<ary.count; i++) {
            ModelBaseData * item = ary[i];
            UILabel * l = [UILabel new];
            l.font = [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
            l.textColor = COLOR_666;
            l.backgroundColor = [UIColor clearColor];
            l.numberOfLines = 1;
            [l fitTitle:[NSString stringWithFormat:@"%@%@",item.string,isStr(item.subString)?item.subString:@"未填写"] variable: W(171)];
            l.leftTop = XY(left,lTop);
            [self addSubview:l];
            lTop = l.bottom + W(15);
            if ( i == 4) {
                left = W(205);
                lTop = top + W(20);
                top = l.bottom + W(20);
            }
        }
    
    //设置总高度
    self.height = top;
    [self addLineFrame:CGRectMake(W(15), self.height - 1, SCREEN_WIDTH - W(15), 1)];
}
- (void)addClick{
    if (self.blockAdd) {
        self.blockAdd();
    }
}
#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];//背景色
        self.width = SCREEN_WIDTH;//默认宽度
    }
    return self;
}

@end

@implementation FJResumeDetailIntroduceView
- (FJResumeDetailAddView *)addView{
    if (!_addView) {
        _addView = [FJResumeDetailAddView new];
        [_addView resetViewWithTitle:@"自我描述" iconView:@"findjob_描述" isEdit:true];
    }
    return _addView;
}
#pragma mark 刷新view
- (void)resetViewWithModel:(ModelResumeDetail *)model{
    self.model = model;
    [self removeAllSubViews];
    [self addSubview:self.addView];
    CGFloat top = self.addView.bottom + W(10);
      
             UILabel *     l = [UILabel new];
                  l.font = [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
                  l.textColor = COLOR_666;
                  l.backgroundColor = [UIColor clearColor];
                  l.numberOfLines = 0;
                  l.lineSpace = W(3);
    [l fitTitle:isStr(model.specialty)?model.specialty:@"暂无描述" variable:SCREEN_WIDTH - W(30)];

                  l.leftTop = XY(W(15),top);
                  [self addSubview:l];
                  top = l.bottom + W(20);
    //设置总高度
    self.height = top;
    [self addLineFrame:CGRectMake(W(15), self.height -1, SCREEN_WIDTH - W(15), 1)];

}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];//背景色
        self.width = SCREEN_WIDTH;//默认宽度
    }
    return self;
}

@end

