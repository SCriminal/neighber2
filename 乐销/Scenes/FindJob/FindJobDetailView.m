//
//  FindJobDetailView.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/9/1.
//Copyright © 2020 ping. All rights reserved.
//

#import "FindJobDetailView.h"


@implementation FindJobDetailTopView

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelFJJobDetail *)model{
       [self removeAllSubViews];
    CGFloat top = 0;
    {
        UILabel * l = [UILabel new];
           l.font = [UIFont systemFontOfSize:F(17) weight:UIFontWeightMedium];
           l.textColor = COLOR_333;
           l.backgroundColor = [UIColor clearColor];
        [l fitTitle:UnPackStr(model.jobsName) variable:W(200)];
           l.leftTop = XY(W(15), W(20));
           [self addSubview:l];
           top = l.bottom;
        
        UILabel* l1 = [UILabel new];
        l1.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightMedium];
        l1.textColor = COLOR_ORANGE;
        l1.backgroundColor = [UIColor clearColor];
        [l1 fitTitle:UnPackStr(model.wageCn) variable:SCREEN_WIDTH - W(30)];
        l1.rightCenterY = XY(SCREEN_WIDTH - W(15), l.centerY);
        [self addSubview:l1];
    }
    {
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        l.textColor = COLOR_666;
        l.backgroundColor = [UIColor clearColor];
        [l fitTitle:UnPackStr(model.districtCn) variable:SCREEN_WIDTH - W(30)];
        l.leftTop = XY(W(15),top + W(13));
        [self addSubview:l];
        top = l.bottom;
    }
    self.height = top + W(20);
    [self addLineFrame:CGRectMake(W(15), self.height - 1, SCREEN_WIDTH - W(30), 1)];
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];//背景色
        self.width = SCREEN_WIDTH;//默认宽度
        [self resetViewWithModel:nil];
    }
    return self;
}
@end


@implementation FindJobDetailLabelView

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelFJJobDetail *)model{
       [self removeAllSubViews];
    CGFloat top = W(15);
    NSArray * aryLeft = @[@15,@125,@235];
    NSArray * aryLabel = @[^(){
        ModelBtn * m = [ModelBtn new];
        m.imageName = @"findJob_label_num";
        m.title = [NSString stringWithFormat:@"招聘%@人",UnPackStr(model.amount)];
        return m;
    }(),^(){
        ModelBtn * m = [ModelBtn new];
        m.imageName = @"findJob_label_school";
        m.title = UnPackStr(model.educationCn);
        return m;
    }(),^(){
        ModelBtn * m = [ModelBtn new];
        m.imageName = @"findJob_label_year";
        m.title = UnPackStr(model.experienceCn);
        return m;
    }(),^(){
        ModelBtn * m = [ModelBtn new];
        m.imageName = @"findJob_label_quan";
        m.title = UnPackStr(model.natureCn);
        return m;
    }(),^(){
        ModelBtn * m = [ModelBtn new];
        m.imageName = @"findJob_label_age";
        m.title = UnPackStr(model.age);
        return m;
    }(),^(){
        ModelBtn * m = [ModelBtn new];
        m.imageName = @"findJob_label_dep";
        m.title = UnPackStr(model.department);
        return m;
    }()];
    for (int i = 0; i<aryLabel.count; i++) {
        ModelBtn * m = aryLabel[i];
        UIImageView * iv = [UIImageView new];
        iv.backgroundColor = [UIColor clearColor];
        iv.contentMode = UIViewContentModeScaleAspectFill;
        iv.clipsToBounds = true;
        iv.image = [UIImage imageNamed:m.imageName];
        iv.widthHeight = XY(W(20),W(20));
        iv.leftTop = XY([aryLeft[i%3] doubleValue],top);
        [self addSubview:iv];
        
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        l.textColor = COLOR_333;
        l.backgroundColor = [UIColor clearColor];
        [l fitTitle:m.title variable:SCREEN_WIDTH - W(30)];
        l.leftCenterY = XY(iv.right + W(6), iv.centerY);
        [self addSubview:l];
        
        if ((i+1)%3 == 0) {
            top = W(50);
        }
    }
    
    self.height = W(85);
    [self addLineFrame:CGRectMake(W(15), self.height - 1, SCREEN_WIDTH - W(30), 1)];
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];//背景色
        self.width = SCREEN_WIDTH;//默认宽度
        [self resetViewWithModel:nil];
    }
    return self;
}
@end


@implementation FindJobDetailCompanyView

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelFJJobDetail *)model{
       [self removeAllSubViews];
    
    UIImageView * iv = [UIImageView new];
    iv.backgroundColor = [UIColor clearColor];
    iv.contentMode = UIViewContentModeScaleAspectFill;
    iv.clipsToBounds = true;
    [iv sd_setImageWithURL:[NSURL URLWithString:UnPackStr(model.company.logo)] placeholderImage:[UIImage imageNamed:IMAGE_HEAD_COMPANY_DEFAULT]];

    iv.widthHeight = XY(W(65),W(65));
    iv.leftTop = XY(15,15);
    [iv addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:5 lineWidth:0 lineColor:[UIColor clearColor]];
    [self addSubview:iv];

    UILabel * l = [UILabel new];
    l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
    l.textColor = COLOR_333;
    l.backgroundColor = [UIColor clearColor];
    [l fitTitle:UnPackStr(model.companyname) variable:W(200)];
    l.leftTop = XY(iv.right + W(10), iv.top + W(2));
    [self addSubview:l];
    
    CGFloat right = l.right + W(8);
    if ([model.company.audit isEqualToString:@"1"]) {
        UIImageView * icon = [UIImageView new];
        icon.backgroundColor = [UIColor clearColor];
        icon.image = [UIImage imageNamed:@"findjob_rz"];
        icon.widthHeight = XY(W(15),W(15));
        icon.leftCenterY = XY(right,l.centerY);
        [self addSubview:icon];
        right = icon.right + W(8);
    }
    if (model.company.setmealId.doubleValue > 1) {
        UIImageView * icon = [UIImageView new];
        icon.backgroundColor = [UIColor clearColor];
        icon.image = [UIImage imageNamed:@"findjob_hy"];
        icon.widthHeight = XY(W(15),W(15));
        icon.leftCenterY = XY(right,l.centerY);
        [self addSubview:icon];
    }
    
    
    l = [UILabel new];
    l.font = [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
    l.textColor = COLOR_666;
    l.backgroundColor = [UIColor clearColor];
    [l fitTitle:[NSString stringWithFormat:@"%@ | %@",UnPackStr(model.company.scaleCn),UnPackStr(model.company.natureCn)] variable:W(250)];
    l.leftTop = XY(iv.right + W(10), iv.top + W(28));
    [self addSubview:l];

    l = [UILabel new];
    l.font = [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
    l.textColor = COLOR_666;
    l.backgroundColor = [UIColor clearColor];
    [l fitTitle:UnPackStr(model.company.tradeCn) variable:W(250)];
    l.leftBottom = XY(iv.right + W(10), iv.bottom - W(1));
    [self addSubview:l];
    
    [self addLineFrame:CGRectMake(W(15), W(95) - 1, SCREEN_WIDTH - W(30), 1)];
    
    l = [UILabel new];
    l.font = [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
    l.textColor = COLOR_666;
    l.backgroundColor = [UIColor clearColor];
    l.numberOfLines = 0;
    l.lineSpace = W(5);
    [l fitTitle:[NSString stringWithFormat:@"地址：%@",UnPackStr(model.company.address)] variable:W(310)];
    l.leftTop = XY(W(15), W(95) + W(15));
    [self addSubview:l];
    
    iv = [UIImageView new];
    iv.backgroundColor = [UIColor clearColor];
    iv.image = [UIImage imageNamed:@"houseKeeping_address"];
    iv.widthHeight = XY(W(20),W(20));
    iv.rightCenterY = XY(SCREEN_WIDTH - W(15),l.centerY);
    [self addSubview:iv];
    
    self.height = l.bottom + W(15);

}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];//背景色
        self.width = SCREEN_WIDTH;//默认宽度
        [self resetViewWithModel:nil];
    }
    return self;
}
@end


@implementation FindJobDetailJobView

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelFJJobDetail *)model{
       [self removeAllSubViews];
    self.modelDetail = model;
    CGFloat top = W(20);
    {
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightMedium];
        l.textColor = COLOR_333;
        l.backgroundColor = [UIColor clearColor];
        [l fitTitle:@"职位统计" variable:SCREEN_WIDTH - W(30)];
        l.leftTop = XY(W(15), top);
        [self addSubview:l];
        top = l.bottom;

        UILabel * l1 = [UILabel new];
        l1.font = [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        l1.textColor = COLOR_999;
        l1.backgroundColor = [UIColor clearColor];
        [l1 fitTitle:[NSString stringWithFormat:@"企业最近登录：%@",UnPackStr(model.company.lastLoginTimeCn)] variable:SCREEN_WIDTH - W(30)];
        l1.rightCenterY = XY(SCREEN_WIDTH - W(15), l.centerY);
        [self addSubview:l1];
    }
    {
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(20) weight:UIFontWeightBold];
        l.textColor = COLOR_333;
        l.backgroundColor = [UIColor clearColor];
        l.numberOfLines = 0;
        l.lineSpace = W(0);
        [l fitTitle:[NSString stringWithFormat:@"%@%%",NSNumber.dou(self.modelDetail.company.replyRatio).stringValue] variable:SCREEN_WIDTH - W(30)];
        l.centerXTop = XY(SCREEN_WIDTH/4.0,top + W(25));
        [self addSubview:l];
        
        [self addLineFrame:CGRectMake(SCREEN_WIDTH/2.0, l.top + W(6.5), 1, W(30))];
        
        UILabel * l1 = [UILabel new];
               l1.font = [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
               l1.textColor = COLOR_666;
               l1.backgroundColor = [UIColor clearColor];
               [l1 fitTitle:@"简历处理率" variable:SCREEN_WIDTH - W(30)];
               l1.centerXTop = XY(l.centerX ,l.bottom + W(11));
               [self addSubview:l1];
    }
    {
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(20) weight:UIFontWeightBold];
        l.textColor = COLOR_333;
        l.backgroundColor = [UIColor clearColor];
        l.numberOfLines = 0;
        l.lineSpace = W(0);
        
        [l fitTitle:[NSString stringWithFormat:@"%.f",self.modelDetail.company.replyTime.doubleValue] variable:SCREEN_WIDTH - W(30)];
        l.centerXTop = XY(SCREEN_WIDTH/4.0*3.0,top + W(25));
        [self addSubview:l];
        
        UILabel * l1 = [UILabel new];
        l1.font = [UIFont systemFontOfSize:F(11) weight:UIFontWeightRegular];
        l1.textColor = COLOR_333;
        l1.backgroundColor = [UIColor clearColor];
        [l1 fitTitle:@"天" variable:SCREEN_WIDTH - W(30)];
        l1.leftBottom = XY(l.right + W(2),l.bottom - W(2.5));
        [self addSubview:l1];
        
        UILabel * l2 = [UILabel new];
                     l2.font = [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
                     l2.textColor = COLOR_666;
                     l2.backgroundColor = [UIColor clearColor];
                     [l2 fitTitle:@"简历平均处理时长" variable:SCREEN_WIDTH - W(30)];
                     l2.centerXTop = XY(l.centerX ,l.bottom + W(11));
                     [self addSubview:l2];
        
        top = l2.bottom + W(20);
    }
    {
        UIView * view = [UIView new];
        view.backgroundColor = COLOR_GRAY;
        view.widthHeight = XY(SCREEN_WIDTH, W(10));
        view.leftTop = XY(W(0), top);
        [self addSubview:view];
        top = view.bottom;
    }
    {
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightMedium];
        l.textColor = COLOR_333;
        l.backgroundColor = [UIColor clearColor];
        [l fitTitle:@"职位描述" variable:SCREEN_WIDTH - W(30)];
        l.leftTop = XY(W(15), top + W(20));
        [self addSubview:l];

        UILabel * l1 = [UILabel new];
        l1.font = [UIFont systemFontOfSize:F(14) weight:UIFontWeightRegular];
        l1.textColor = COLOR_666;
        l1.backgroundColor = [UIColor clearColor];
        l1.lineSpace = W(8);
        l1.numberOfLines = 0;
        [l1 fitTitle:UnPackStr(model.contents) variable:SCREEN_WIDTH - W(30)];
        l1.leftTop = XY(W(15), l.bottom +W(20));
        [self addSubview:l1];
        top = l1.bottom;
    }
    self.height = top + W(20);
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];//背景色
        self.width = SCREEN_WIDTH;//默认宽度
        [self resetViewWithModel:nil];
    }
    return self;
}
@end

@implementation FindJobDetailConnectView

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelFJJobDetail *)model{
    self.modelDetail = model;
       [self removeAllSubViews];
    CGFloat top = W(20);
    {
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightMedium];
        l.textColor = COLOR_333;
        l.backgroundColor = [UIColor clearColor];
        [l fitTitle:@"联系方式" variable:SCREEN_WIDTH - W(30)];
        l.leftTop = XY(W(15), top);
        [self addSubview:l];
        top = l.bottom;

    }
    {
        UIImageView * iv = [UIImageView new];
        iv.backgroundColor = [UIColor clearColor];
        iv.contentMode = UIViewContentModeScaleAspectFill;
        iv.clipsToBounds = true;
        iv.image = [UIImage imageNamed:@"houseKeeping_phone"];
        iv.widthHeight = XY(W(20),W(20));
        iv.leftTop = XY(W(15),top + W(20));
        [self addSubview:iv];
        
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        l.textColor = COLOR_333;
        l.backgroundColor = [UIColor clearColor];
        [l fitTitle:[NSString stringWithFormat:@"%@(%@)",UnPackStr(self.modelDetail.company.telephone),UnPackStr(self.modelDetail.company.contact)] variable: W(310)];
        l.leftCenterY = XY(iv.right + W(13), iv.centerY);
        [self addSubview:l];

        [self addControlFrame:CGRectInset(l.frame, -W(60), -W(20)) target:self action:@selector(phoneClick)];
        top = iv.bottom;
    }
    {
        UIImageView * iv = [UIImageView new];
        iv.backgroundColor = [UIColor clearColor];
        iv.contentMode = UIViewContentModeScaleAspectFill;
        iv.clipsToBounds = true;
        iv.image = [UIImage imageNamed:@"houseKeeping_address"];
        iv.widthHeight = XY(W(20),W(20));
        iv.leftTop = XY(W(15),top + W(15));
        [self addSubview:iv];
        
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        l.textColor = COLOR_333;
        l.backgroundColor = [UIColor clearColor];
        [l fitTitle:UnPackStr(self.modelDetail.company.address) variable: W(310)];
        l.leftCenterY = XY(iv.right + W(13), iv.centerY);
        [self addSubview:l];

        [self addControlFrame:CGRectInset(l.frame, -W(60), -W(20)) target:self action:@selector(addressClick)];

        top = iv.bottom;
    }
    
    self.height = top + W(20);
}
- (void)addressClick{
    
}
- (void)phoneClick{
    if (isStr(self.modelDetail.company.telephone)) {
        NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel://%@",self.modelDetail.company.telephone];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }else{
        [GlobalMethod showAlert:@"暂无联系电话"];
    }


}
#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];//背景色
        self.width = SCREEN_WIDTH;//默认宽度
        [self resetViewWithModel:nil];
    }
    return self;
}
@end
