//
//  FJResumeDetailListView.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/9/16.
//Copyright © 2020 ping. All rights reserved.
//

#import "FJResumeDetailListView.h"

@implementation FJResumeDetailEducationView
- (FJResumeDetailAddView *)addView{
    if (!_addView) {
        _addView = [FJResumeDetailAddView new];
        [_addView resetViewWithTitle:@"教育经历" iconView:@"findjob_教育"];
    }
    return _addView;
}
#pragma mark 刷新view
- (void)resetViewWithModel:(ModelResumeDetail *)model{
    self.model = model;
    [self removeAllSubViews];
    [self addSubview:self.addView];
    CGFloat top = self.addView.bottom + W(10);
    
    for (int i = 0; i<model.educationList.count; i++) {
        ModelFJEducation * item = model.educationList[i];
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(13) weight:UIFontWeightMedium];
        l.textColor = COLOR_333;
        l.backgroundColor = [UIColor clearColor];
        l.numberOfLines = 1;
        [l fitTitle:UnPackStr(item.school) variable: W(290)];
        l.leftTop = XY(W(15),top);
        [self addSubview:l];
        top = l.bottom;
        
        UIImageView * iv = [UIImageView new];
        iv.backgroundColor = [UIColor clearColor];
        iv.contentMode = UIViewContentModeScaleAspectFill;
        iv.clipsToBounds = true;
        iv.image = [UIImage imageNamed:@"findjob_编辑"];
        iv.widthHeight = XY(W(15),W(15));
        iv.rightCenterY = XY(SCREEN_WIDTH - W(15),l.centerY);
        [self addSubview:iv];
        
        UIView * view = [self addControlFrame:CGRectInset(iv.frame, -W(10), -W(10)) target:self action:@selector(editClick:)];
        view.tag = i+ 100;
        
        iv = [UIImageView new];
        iv.backgroundColor = [UIColor clearColor];
        iv.contentMode = UIViewContentModeScaleAspectFill;
        iv.clipsToBounds = true;
        iv.image = [UIImage imageNamed:@"findjob_删除"];
        iv.widthHeight = XY(W(15),W(15));
        iv.rightCenterY = XY(SCREEN_WIDTH - W(50),l.centerY);
        [self addSubview:iv];

        view = [self addControlFrame:CGRectInset(iv.frame, -W(10), -W(10)) target:self action:@selector(deleteClick:)];
        view.tag = i+ 100;

         l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
        l.textColor = COLOR_666;
        l.backgroundColor = [UIColor clearColor];
        l.numberOfLines = 0;
        l.lineSpace = W(3);
        [l fitTitle:[NSString stringWithFormat:@"%@.%@-%@.%@ | %@ | %@",item.startyear,item.startmonth,item.endyear,item.endmonth,item.educationCn,item.speciality] variable:SCREEN_WIDTH - W(30)];
        l.leftTop = XY(W(15),top + W(12));
        [self addSubview:l];
        top = l.bottom + W(20);
    }
    //设置总高度
    self.height = top;
    [self addLineFrame:CGRectMake(W(15), self.height -1, SCREEN_WIDTH - W(15), 1)];
}
- (void)editClick:(UIControl *)con{
    ModelFJEducation * model = self.model.educationList[con.tag - 100];
    if (self.blockEdit) {
        self.blockEdit(model);
    }
}
- (void)deleteClick:(UIControl *)con{
    ModelFJEducation * model = self.model.educationList[con.tag - 100];
    if (self.blockDelete) {
        self.blockDelete(model);
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
}@end


@implementation FJResumeDetailWorkView
- (FJResumeDetailAddView *)addView{
    if (!_addView) {
        _addView = [FJResumeDetailAddView new];
        [_addView resetViewWithTitle:@"工作经历" iconView:@"findjob_工作"];
    }
    return _addView;
}
#pragma mark 刷新view
- (void)resetViewWithModel:(ModelResumeDetail *)model{
    self.model = model;
    [self removeAllSubViews];
    [self addSubview:self.addView];
    CGFloat top = self.addView.bottom + W(10);
    
    for (int i = 0; i<model.workList.count; i++) {
        ModelFJWorkExperience * item = model.workList[i];
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(13) weight:UIFontWeightMedium];
        l.textColor = COLOR_333;
        l.backgroundColor = [UIColor clearColor];
        l.numberOfLines = 1;
        [l fitTitle:UnPackStr(item.companyname) variable: W(290)];
        l.leftTop = XY(W(15),top);
        [self addSubview:l];
        top = l.bottom;
        
        UIImageView * iv = [UIImageView new];
        iv.backgroundColor = [UIColor clearColor];
        iv.contentMode = UIViewContentModeScaleAspectFill;
        iv.clipsToBounds = true;
        iv.image = [UIImage imageNamed:@"findjob_编辑"];
        iv.widthHeight = XY(W(15),W(15));
        iv.rightCenterY = XY(SCREEN_WIDTH - W(15),l.centerY);
        [self addSubview:iv];
        
        UIView * view = [self addControlFrame:CGRectInset(iv.frame, -W(10), -W(10)) target:self action:@selector(editClick:)];
        view.tag = i+ 100;
        
        iv = [UIImageView new];
        iv.backgroundColor = [UIColor clearColor];
        iv.contentMode = UIViewContentModeScaleAspectFill;
        iv.clipsToBounds = true;
        iv.image = [UIImage imageNamed:@"findjob_删除"];
        iv.widthHeight = XY(W(15),W(15));
        iv.rightCenterY = XY(SCREEN_WIDTH - W(50),l.centerY);
        [self addSubview:iv];

        view = [self addControlFrame:CGRectInset(iv.frame, -W(10), -W(10)) target:self action:@selector(deleteClick:)];
        view.tag = i+ 100;

         l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
        l.textColor = COLOR_666;
        l.backgroundColor = [UIColor clearColor];
        l.numberOfLines = 0;
        l.lineSpace = W(3);
        [l fitTitle:[NSString stringWithFormat:@"%@ | %@.%@-%@.%@ ",item.jobs,item.startyear,item.startmonth,item.endyear,item.endmonth] variable:SCREEN_WIDTH - W(30)];
        l.leftTop = XY(W(15),top + W(12));
        [self addSubview:l];
        top = l.bottom + W(12);
        
        
        l = [UILabel new];
               l.font = [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
               l.textColor = COLOR_666;
               l.backgroundColor = [UIColor clearColor];
               l.numberOfLines = 0;
               l.lineSpace = W(3);
        [l fitTitle:isStr(item.achievements)?item.achievements:@"暂无工作描述" variable:SCREEN_WIDTH - W(30)];
               l.leftTop = XY(W(15),top);
               [self addSubview:l];
        top = l.bottom + W(20);
    }
    //设置总高度
    self.height = top;
    [self addLineFrame:CGRectMake(W(15), self.height -1, SCREEN_WIDTH - W(15), 1)];
}
- (void)editClick:(UIControl *)con{
    ModelFJWorkExperience * model = self.model.workList[con.tag - 100];
    if (self.blockEdit) {
        self.blockEdit(model);
    }
}
- (void)deleteClick:(UIControl *)con{
    ModelFJWorkExperience * model = self.model.workList[con.tag - 100];
    if (self.blockDelete) {
        self.blockDelete(model);
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
}@end


@implementation FJResumeDetailTrainView
- (FJResumeDetailAddView *)addView{
    if (!_addView) {
        _addView = [FJResumeDetailAddView new];
        [_addView resetViewWithTitle:@"培训经历" iconView:@"findjob_培训"];
    }
    return _addView;
}
#pragma mark 刷新view
- (void)resetViewWithModel:(ModelResumeDetail *)model{
    self.model = model;
    [self removeAllSubViews];
    [self addSubview:self.addView];
    CGFloat top = self.addView.bottom + W(10);
    
    for (int i = 0; i<model.trainingList.count; i++) {
        ModelJFTrainexperience * item = model.trainingList[i];
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(13) weight:UIFontWeightMedium];
        l.textColor = COLOR_333;
        l.backgroundColor = [UIColor clearColor];
        l.numberOfLines = 1;
        [l fitTitle:UnPackStr(item.agency) variable: W(290)];
        l.leftTop = XY(W(15),top);
        [self addSubview:l];
        top = l.bottom;
        
        UIImageView * iv = [UIImageView new];
        iv.backgroundColor = [UIColor clearColor];
        iv.contentMode = UIViewContentModeScaleAspectFill;
        iv.clipsToBounds = true;
        iv.image = [UIImage imageNamed:@"findjob_编辑"];
        iv.widthHeight = XY(W(15),W(15));
        iv.rightCenterY = XY(SCREEN_WIDTH - W(15),l.centerY);
        [self addSubview:iv];
        
        UIView * view = [self addControlFrame:CGRectInset(iv.frame, -W(10), -W(10)) target:self action:@selector(editClick:)];
        view.tag = i+ 100;
        
        iv = [UIImageView new];
        iv.backgroundColor = [UIColor clearColor];
        iv.contentMode = UIViewContentModeScaleAspectFill;
        iv.clipsToBounds = true;
        iv.image = [UIImage imageNamed:@"findjob_删除"];
        iv.widthHeight = XY(W(15),W(15));
        iv.rightCenterY = XY(SCREEN_WIDTH - W(50),l.centerY);
        [self addSubview:iv];

        view = [self addControlFrame:CGRectInset(iv.frame, -W(10), -W(10)) target:self action:@selector(deleteClick:)];
        view.tag = i+ 100;

         l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
        l.textColor = COLOR_666;
        l.backgroundColor = [UIColor clearColor];
        l.numberOfLines = 0;
        l.lineSpace = W(3);
        [l fitTitle:[NSString stringWithFormat:@"%@ | %@.%@-%@.%@ ",item.course,item.startyear,item.startmonth,item.endyear,item.endmonth] variable:SCREEN_WIDTH - W(30)];
        l.leftTop = XY(W(15),top + W(12));
        [self addSubview:l];
        top = l.bottom;
        
        l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
        l.textColor = COLOR_666;
        l.backgroundColor = [UIColor clearColor];
        l.numberOfLines = 0;
        l.lineSpace = W(3);
        [l fitTitle:isStr(item.iDPropertyDescription)?item.iDPropertyDescription:@"暂无培训描述" variable:SCREEN_WIDTH - W(30)];

        l.leftTop = XY(W(15),top + W(12));
        [self addSubview:l];
        top = l.bottom + W(20);

    }
    //设置总高度
    self.height = top;
    [self addLineFrame:CGRectMake(W(15), self.height -1, SCREEN_WIDTH - W(15), 1)];
}
- (void)editClick:(UIControl *)con{
    ModelJFTrainexperience * model = self.model.trainingList[con.tag - 100];
    if (self.blockEdit) {
        self.blockEdit(model);
    }
}
- (void)deleteClick:(UIControl *)con{
    ModelJFTrainexperience * model = self.model.trainingList[con.tag - 100];
    if (self.blockDelete) {
        self.blockDelete(model);
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
}@end


@implementation FJResumeDetailProjectView
- (FJResumeDetailAddView *)addView{
    if (!_addView) {
        _addView = [FJResumeDetailAddView new];
        [_addView resetViewWithTitle:@"项目经历" iconView:@"findjob_项目"];
    }
    return _addView;
}
#pragma mark 刷新view
- (void)resetViewWithModel:(ModelResumeDetail *)model{
    self.model = model;
    [self removeAllSubViews];
    [self addSubview:self.addView];
    CGFloat top = self.addView.bottom + W(10);
    
    for (int i = 0; i<model.projectList.count; i++) {
        ModelFJProjectExp * item = model.projectList[i];
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(13) weight:UIFontWeightMedium];
        l.textColor = COLOR_333;
        l.backgroundColor = [UIColor clearColor];
        l.numberOfLines = 1;
        [l fitTitle:UnPackStr(item.projectname) variable: W(290)];
        l.leftTop = XY(W(15),top);
        [self addSubview:l];
        top = l.bottom;
        
        UIImageView * iv = [UIImageView new];
        iv.backgroundColor = [UIColor clearColor];
        iv.contentMode = UIViewContentModeScaleAspectFill;
        iv.clipsToBounds = true;
        iv.image = [UIImage imageNamed:@"findjob_编辑"];
        iv.widthHeight = XY(W(15),W(15));
        iv.rightCenterY = XY(SCREEN_WIDTH - W(15),l.centerY);
        [self addSubview:iv];
        
        UIView * view = [self addControlFrame:CGRectInset(iv.frame, -W(10), -W(10)) target:self action:@selector(editClick:)];
        view.tag = i+ 100;
        
        iv = [UIImageView new];
        iv.backgroundColor = [UIColor clearColor];
        iv.contentMode = UIViewContentModeScaleAspectFill;
        iv.clipsToBounds = true;
        iv.image = [UIImage imageNamed:@"findjob_删除"];
        iv.widthHeight = XY(W(15),W(15));
        iv.rightCenterY = XY(SCREEN_WIDTH - W(50),l.centerY);
        [self addSubview:iv];

        view = [self addControlFrame:CGRectInset(iv.frame, -W(10), -W(10)) target:self action:@selector(deleteClick:)];
        view.tag = i+ 100;

          l = [UILabel new];
               l.font = [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
               l.textColor = COLOR_666;
               l.backgroundColor = [UIColor clearColor];
               l.numberOfLines = 0;
               l.lineSpace = W(3);
               [l fitTitle:[NSString stringWithFormat:@"%@ | %@.%@-%@.%@ ",item.role,item.startyear,item.startmonth,item.endyear,item.endmonth] variable:SCREEN_WIDTH - W(30)];
               l.leftTop = XY(W(15),top + W(12));
               [self addSubview:l];
               top = l.bottom;
               
               l = [UILabel new];
               l.font = [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
               l.textColor = COLOR_666;
               l.backgroundColor = [UIColor clearColor];
               l.numberOfLines = 0;
               l.lineSpace = W(3);
        [l fitTitle:isStr(item.iDPropertyDescription)?item.iDPropertyDescription:@"暂无项目描述" variable:SCREEN_WIDTH - W(30)];

               l.leftTop = XY(W(15),top + W(12));
               [self addSubview:l];
               top = l.bottom + W(20);
    }
    //设置总高度
    self.height = top;
    [self addLineFrame:CGRectMake(W(15), self.height -1, SCREEN_WIDTH - W(15), 1)];
}
- (void)editClick:(UIControl *)con{
    ModelFJProjectExp * model = self.model.projectList[con.tag - 100];
    if (self.blockEdit) {
        self.blockEdit(model);
    }
}
- (void)deleteClick:(UIControl *)con{
    ModelFJProjectExp * model = self.model.projectList[con.tag - 100];
    if (self.blockDelete) {
        self.blockDelete(model);
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
}@end


@implementation FJResumeDetailCredientView
- (FJResumeDetailAddView *)addView{
    if (!_addView) {
        _addView = [FJResumeDetailAddView new];
        [_addView resetViewWithTitle:@"获得证书" iconView:@"findjob_证书"];
    }
    return _addView;
}
#pragma mark 刷新view
- (void)resetViewWithModel:(ModelResumeDetail *)model{
    self.model = model;
    [self removeAllSubViews];
    [self addSubview:self.addView];
    CGFloat top = self.addView.bottom + W(10);
    
    for (int i = 0; i<model.credentList.count; i++) {
        ModelFJCredentExp * item = model.credentList[i];
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(13) weight:UIFontWeightMedium];
        l.textColor = COLOR_333;
        l.backgroundColor = [UIColor clearColor];
        l.numberOfLines = 1;
        [l fitTitle:UnPackStr(item.name) variable: W(290)];
        l.leftTop = XY(W(15),top);
        [self addSubview:l];
        top = l.bottom;
        
        UIImageView * iv = [UIImageView new];
        iv.backgroundColor = [UIColor clearColor];
        iv.contentMode = UIViewContentModeScaleAspectFill;
        iv.clipsToBounds = true;
        iv.image = [UIImage imageNamed:@"findjob_编辑"];
        iv.widthHeight = XY(W(15),W(15));
        iv.rightCenterY = XY(SCREEN_WIDTH - W(15),l.centerY);
        [self addSubview:iv];
        
        UIView * view = [self addControlFrame:CGRectInset(iv.frame, -W(10), -W(10)) target:self action:@selector(editClick:)];
        view.tag = i+ 100;
        
        iv = [UIImageView new];
        iv.backgroundColor = [UIColor clearColor];
        iv.contentMode = UIViewContentModeScaleAspectFill;
        iv.clipsToBounds = true;
        iv.image = [UIImage imageNamed:@"findjob_删除"];
        iv.widthHeight = XY(W(15),W(15));
        iv.rightCenterY = XY(SCREEN_WIDTH - W(50),l.centerY);
        [self addSubview:iv];

        view = [self addControlFrame:CGRectInset(iv.frame, -W(10), -W(10)) target:self action:@selector(deleteClick:)];
        view.tag = i+ 100;

         l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
        l.textColor = COLOR_666;
        l.backgroundColor = [UIColor clearColor];
        l.numberOfLines = 0;
        l.lineSpace = W(3);
        [l fitTitle:[NSString stringWithFormat:@"%@.%@",item.year,item.month] variable:SCREEN_WIDTH - W(30)];
        l.leftTop = XY(W(15),top + W(12));
        [self addSubview:l];
        top = l.bottom + W(20);
    }
    //设置总高度
    self.height = top;
    [self addLineFrame:CGRectMake(W(15), self.height -1, SCREEN_WIDTH - W(15), 1)];
}
- (void)editClick:(UIControl *)con{
    ModelFJCredentExp * model = self.model.credentList[con.tag - 100];
    if (self.blockEdit) {
        self.blockEdit(model);
    }
}
- (void)deleteClick:(UIControl *)con{
    ModelFJCredentExp * model = self.model.credentList[con.tag - 100];
    if (self.blockDelete) {
        self.blockDelete(model);
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
}@end


@implementation FJResumeDetailLanguageView
- (FJResumeDetailAddView *)addView{
    if (!_addView) {
        _addView = [FJResumeDetailAddView new];
        [_addView resetViewWithTitle:@"语言能力" iconView:@"findjob_语言"];
    }
    return _addView;
}
#pragma mark 刷新view
- (void)resetViewWithModel:(ModelResumeDetail *)model{
    self.model = model;
    [self removeAllSubViews];
    [self addSubview:self.addView];
    CGFloat top = self.addView.bottom + W(10);
    
    for (int i = 0; i<model.languageList.count; i++) {
        ModelFJLanguageExp * item = model.languageList[i];
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
        l.textColor = COLOR_666;
        l.backgroundColor = [UIColor clearColor];
        l.numberOfLines = 1;
        [l fitTitle:[NSString stringWithFormat:@"%@(%@)",item.languageCn,item.levelCn] variable: W(290)];
        l.leftTop = XY(W(15),top);
        [self addSubview:l];
        top = l.bottom + W(20);

        UIImageView * iv = [UIImageView new];
        iv.backgroundColor = [UIColor clearColor];
        iv.contentMode = UIViewContentModeScaleAspectFill;
        iv.clipsToBounds = true;
        iv.image = [UIImage imageNamed:@"findjob_编辑"];
        iv.widthHeight = XY(W(15),W(15));
        iv.rightCenterY = XY(SCREEN_WIDTH - W(15),l.centerY);
        [self addSubview:iv];
        
        UIView * view = [self addControlFrame:CGRectInset(iv.frame, -W(10), -W(10)) target:self action:@selector(editClick:)];
        view.tag = i+ 100;
        
        iv = [UIImageView new];
        iv.backgroundColor = [UIColor clearColor];
        iv.contentMode = UIViewContentModeScaleAspectFill;
        iv.clipsToBounds = true;
        iv.image = [UIImage imageNamed:@"findjob_删除"];
        iv.widthHeight = XY(W(15),W(15));
        iv.rightCenterY = XY(SCREEN_WIDTH - W(50),l.centerY);
        [self addSubview:iv];

        view = [self addControlFrame:CGRectInset(iv.frame, -W(10), -W(10)) target:self action:@selector(deleteClick:)];
        view.tag = i+ 100;

       
    }
    //设置总高度
    self.height = top;
    [self addLineFrame:CGRectMake(W(15), self.height -1, SCREEN_WIDTH - W(15), 1)];
}
- (void)editClick:(UIControl *)con{
    ModelFJLanguageExp * model = self.model.languageList[con.tag - 100];
    if (self.blockEdit) {
        self.blockEdit(model);
    }
}
- (void)deleteClick:(UIControl *)con{
    ModelFJLanguageExp * model = self.model.languageList[con.tag - 100];
    if (self.blockDelete) {
        self.blockDelete(model);
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
}@end
