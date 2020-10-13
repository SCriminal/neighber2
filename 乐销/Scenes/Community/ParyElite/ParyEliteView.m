//
//  ParyEliteView.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/11.
//Copyright © 2020 ping. All rights reserved.
//

#import "ParyEliteView.h"
#import "UIView+SelectImageView.h"
#import "WebVC.h"
@interface ParyEliteTopView ()
@property (nonatomic, strong) BaseNavView *nav;
@property (nonatomic, strong) UIImageView *BG;
@property (nonatomic, strong) UILabel *title;

@end

@implementation ParyEliteTopView
- (UILabel *)title{
    if (_title == nil) {
        _title = [UILabel new];
        _title.font =  [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
        _title.textColor = COLOR_999;
        _title.numberOfLines = 0;
        _title.lineSpace = 0;
        [_title fitTitle:@"基本信息" variable:0];
    }
    return _title;
}
- (BaseNavView *)nav{
    if (!_nav) {
        _nav = [BaseNavView initNavBackTitle:@"" rightView:nil];
        _nav.backgroundColor = [UIColor clearColor];
    }
    return _nav;
}
- (UIImageView *)BG{
    if (_BG == nil) {
        _BG = [UIImageView new];
        _BG.image = [UIImage imageNamed:@"ParyEliteTopBG"];

        _BG.contentMode = UIViewContentModeScaleAspectFill;
        _BG.clipsToBounds = true;
    }
    return _BG;
}
- (UIView *)whiteBG{
    if (_whiteBG == nil) {
        _whiteBG = [UIView new];
        _whiteBG.backgroundColor = COLOR_GRAY;
        _whiteBG.widthHeight = XY(SCREEN_WIDTH,30);
        [_whiteBG addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight radius:15 lineWidth:0 lineColor:[UIColor clearColor]];

    }
    return _whiteBG;
}
#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = COLOR_GRAY;
        self.width = SCREEN_WIDTH;
        self.clipsToBounds = true;
        [self addSubView];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.BG];
    [self addSubview:self.whiteBG];
    [self addSubview:self.nav];
    [self addSubview:self.title];

    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view


    
    self.BG.widthHeight = XY(SCREEN_WIDTH, W(135)+iphoneXTopInterval);
    self.title.leftTop = XY(W(25), self.BG.bottom);
    self.whiteBG.top = self.BG.bottom-15;
    self.height = W(135)+iphoneXTopInterval + self.title.height + W(15);

}

@end



@implementation ParyEliteBottomView
#pragma mark 懒加载

- (UIImageView *)ivLeft{
    if (_ivLeft == nil) {
        _ivLeft = [UIImageView new];
        _ivLeft.image = [UIImage imageNamed:@"ParyEliteLicense"];
        _ivLeft.widthHeight = XY(W(143),W(89));
        _ivLeft.contentMode = UIViewContentModeScaleAspectFill;
        _ivLeft.clipsToBounds = true;
        [_ivLeft addTarget:self action:@selector(ivIdentityHeadClick)];


    }
    return _ivLeft;
}
- (UIImageView *)ivRight{
    if (_ivRight == nil) {
        _ivRight = [UIImageView new];
        _ivRight.image = [UIImage imageNamed:@"ParyElitePromise"];
        _ivRight.widthHeight = XY(W(143),W(89));
        _ivRight.contentMode = UIViewContentModeScaleAspectFill;
        _ivRight.clipsToBounds = true;
        [_ivRight addTarget:self action:@selector(ivIdentityCountryClick)];

    }
    return _ivRight;
}
- (UITextView *)alert{
    if (_alert == nil) {
        {
            
            UITextView *textView = [[UITextView alloc] init];
            textView.backgroundColor = [UIColor clearColor];
            textView.widthHeight = XY(W(300), [UIFont fetchHeight:F(12)]*2+W(5));
            textView.clipsToBounds = false;
            textView.editable = NO;

            textView.delegate = self;
            textView.linkTextAttributes = @{NSForegroundColorAttributeName:COLOR_ORANGE};

            NSString *str1 = @"我已阅读并同意";
            NSString *str2 = @"《奎文区党员经营户承诺书》";
            NSString *str3 = @"《奎文区党员经营户评选标准》";
            NSString *str = [NSString stringWithFormat:@"%@%@%@",str1,str2,str3];
            NSRange range1 = [str rangeOfString:str1];
            NSRange range2 = [str rangeOfString:str2];
            NSRange range3 = [str rangeOfString:str3];
            NSMutableAttributedString *mastring = [[NSMutableAttributedString alloc] initWithString:str attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular]}];

            [mastring addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0] range:range1];
            
            NSString *valueString1 = [[NSString stringWithFormat:@"first://%@",str2] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];

            NSString *valueString2 = [[NSString stringWithFormat:@"second://%@",str3] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];

            [mastring addAttribute:NSLinkAttributeName value:valueString1 range:range2];

            [mastring addAttribute:NSLinkAttributeName value:valueString2 range:range3];

            [mastring addAttribute:NSForegroundColorAttributeName value:COLOR_ORANGE range:range2];

            [mastring addAttribute:NSForegroundColorAttributeName value:COLOR_ORANGE range:range3];

            // 1.必须要用前缀（firstPerson，secondPerson），随便写但是要有

            // 2.要有后面的方法，如果含有中文，url会无效，所以转码
            textView.textContainerInset = UIEdgeInsetsMake(-1, 0, 0, 0);

            textView.attributedText = mastring;
            _alert = textView;

        }
    }
    return _alert;
}
- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {

    if ([[URL scheme] isEqualToString:@"first"]) {

        
        WebVC * vc = [WebVC new];
        vc.navTitle = @"奎文区党员经营户承诺书";
        vc.url = @"https://wsq.hongjiafu.cn/community/news/detail?id=59";
        [GB_Nav pushViewController:vc animated:true];

        return NO;

    } else if ([[URL scheme] isEqualToString:@"second"]) {
        WebVC * vc = [WebVC new];
        vc.navTitle = @"奎文区党员经营户评选标准";
        vc.url = @"https://wsq.hongjiafu.cn/community/news/detail?id=58";
        [GB_Nav pushViewController:vc animated:true];


        return NO;

    }

    return YES;

}
- (UIImageView *)iconAlert{
    if (_iconAlert == nil) {
        _iconAlert = [UIImageView new];
        _iconAlert.image = [UIImage imageNamed:@"signin_select_default"];
        _iconAlert.highlightedImage = [UIImage imageNamed:@"signin_select_highlight"];

        
        _iconAlert.widthHeight = XY(W(15),W(15));
    }
    return _iconAlert;
}
- (YellowButton *)btnBottom{
    if (!_btnBottom) {
        _btnBottom = [YellowButton new];
        [_btnBottom resetViewWithWidth:W(335) :W(45) :@"提交"];
        _btnBottom.blockClick = ^{
            
        };
    }
    return _btnBottom;
}
- (PlaceHolderTextView *)textView{
    if (_textView == nil) {
        _textView = [PlaceHolderTextView new];
        _textView.backgroundColor = [UIColor clearColor];
        _textView.delegate = self;
        _textView.textContainerInset = UIEdgeInsetsMake(-W(2), 0, 0, 0);
        [GlobalMethod setLabel:_textView.placeHolder widthLimit:0 numLines:0 fontNum:F(15) textColor:COLOR_999 text:@"500字以内"];
        [_textView setTextColor:COLOR_333];
    }
    return _textView;
}
- (PlaceHolderTextView *)textView1{
    if (_textView1 == nil) {
        _textView1 = [PlaceHolderTextView new];
        _textView1.backgroundColor = [UIColor clearColor];
        _textView1.delegate = self;
        _textView1.textContainerInset = UIEdgeInsetsMake(-W(2), 0, 0, 0);
        [GlobalMethod setLabel:_textView1.placeHolder widthLimit:0 numLines:0 fontNum:F(15) textColor:COLOR_999 text:@"选填"];
        [_textView1 setTextColor:COLOR_333];
    }
    return _textView1;
}
#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = COLOR_GRAY;
        self.width = SCREEN_WIDTH;
        [self addSubView];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.textView];
    [self addSubview:self.textView1];
    [self addSubview:self.ivLeft];
    [self addSubview:self.ivRight];
    [self addSubview:self.alert];
    [self addSubview:self.iconAlert];
    [self addSubview:self.btnBottom];

    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    CGFloat top = 0;
    {
        UILabel * l = [UILabel new];
           l.font = [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
           l.textColor = COLOR_999;
           [l fitTitle:@"企业 (店铺) 简介" variable:0];
           l.leftTop = XY(W(25), W(15));
           [self addSubview:l];
        top = l.bottom;
    }
    {
        UIView *whiteBG = [UIView new];
        whiteBG.backgroundColor = [UIColor whiteColor];
        whiteBG.widthHeight = XY(W(345),W(75));
        whiteBG.centerXTop = XY(SCREEN_WIDTH/2.0, top + W(15));
        [whiteBG addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:10 lineWidth:0 lineColor:[UIColor clearColor]];
        [self insertSubview:whiteBG belowSubview:self.textView];
        
        self.textView.widthHeight = XY(SCREEN_WIDTH - W(60), W(45));
        self.textView.centerXCenterY = whiteBG.centerXCenterY;
        top = whiteBG.bottom;
    }
    {
        UILabel * l = [UILabel new];
           l.font = [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
           l.textColor = COLOR_999;
           [l fitTitle:@"其他补充简介" variable:0];
           l.leftTop = XY(W(25),top + W(15));
           [self addSubview:l];
        top = l.bottom;
    }
    {
        UIView *whiteBG = [UIView new];
        whiteBG.backgroundColor = [UIColor whiteColor];
        whiteBG.widthHeight = XY(W(345),W(75));
        whiteBG.centerXTop = XY(SCREEN_WIDTH/2.0, top + W(15));
        [whiteBG addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:10 lineWidth:0 lineColor:[UIColor clearColor]];
        [self insertSubview:whiteBG belowSubview:self.textView1];
        
        self.textView1.widthHeight = XY(SCREEN_WIDTH - W(60), W(45));
        self.textView1.centerXCenterY = whiteBG.centerXCenterY;
        top = whiteBG.bottom;
    }
    {
           UILabel * l = [UILabel new];
              l.font = [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
              l.textColor = COLOR_999;
              [l fitTitle:@"上传材料" variable:0];
              l.leftTop = XY(W(25),top + W(15));
              [self addSubview:l];
        
        UILabel * l1 = [UILabel new];
           l1.font = [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
           l1.textColor = COLOR_ORANGE;
           [l1 fitTitle:@"《奎文区党员经营户承诺书》下载" variable:0];
           l1.rightTop = XY(SCREEN_WIDTH - W(25),top + W(15));
           [self addSubview:l1];
        
        [self addControlFrame:CGRectInset(l1.frame, -W(30), -W(5)) target:self action:@selector(downloadClick)];
        
        top = l.bottom;

       }
        
    {
         UIView *whiteBG = [UIView new];
            whiteBG.backgroundColor = [UIColor whiteColor];
            whiteBG.widthHeight = XY(W(345),W(113));
            whiteBG.centerXTop = XY(SCREEN_WIDTH/2.0, top + W(15));
            [whiteBG addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:10 lineWidth:0 lineColor:[UIColor clearColor]];
            [self insertSubview:whiteBG belowSubview:self.ivLeft];
            
            self.ivLeft.leftTop = XY(whiteBG.left+ W(20),whiteBG.top+W(12));
            
            self.ivRight.rightTop = XY(whiteBG.right - W(20),whiteBG.top+W(12));
        top = whiteBG.bottom;
    }
   
    self.iconAlert.leftTop = XY(W(25),top+ W(13.5));

    self.alert.leftTop = XY(self.iconAlert.right + W(7),self.iconAlert.top);
    
    [self addControlFrame:CGRectInset(self.iconAlert.frame, -W(30), -W(20)) belowView:self.alert target:self action:@selector(alertClick)];
    self.btnBottom.centerXTop = XY(SCREEN_WIDTH/2.0, self.alert.bottom + W(23.5));
    //设置总高度
    self.height = self.btnBottom.bottom  + W(25) ;
}

#pragma mark click
- (void)alertClick{
    self.iconAlert.highlighted = !self.iconAlert.highlighted;
}
- (void)ivIdentityHeadClick{
    self.ivSelected = self.ivLeft;
    [self showImageVC:1];
    
}

- (void)ivIdentityCountryClick{
    self.ivSelected = self.ivRight;
    [self showImageVC:1];
    
}
- (void)downloadClick{
    [GB_Nav pushVCName:@"PartyEliteDownloadVC" animated:true];
}

//选择图片
- (void)imageSelect:(BaseImage *)image{
    if (self.ivSelected == self.ivLeft) {
        self.ivLeft.image = image;
        [AliClient sharedInstance].imageType = ENUM_UP_IMAGE_TYPE_PARTY_BIZ;
    }else if(self.ivSelected == self.ivRight){
        self.ivRight.image = image;
        [AliClient sharedInstance].imageType = ENUM_UP_IMAGE_TYPE_PARTY_COMMITMENT;
    }
    [[AliClient sharedInstance]updateImageAry:@[image] storageSuccess:^{
        
    } upSuccess:^{
        
    } fail:^{
        
    }];
}
@end




@implementation ParyEliteStatusView

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.width = SCREEN_WIDTH;
        self.height = SCREEN_HEIGHT;
        [self addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight radius:15 lineWidth:0 lineColor:[UIColor clearColor]];

    }
    return self;
}

#pragma mark 刷新view
- (void)resetViewWithState:(int)state model:(ModelPartyElite* )model{
    [self removeAllSubViews];//移除线
    CGFloat top = 15;
    NSString * iconName = nil;
    NSString * alert = nil;
    BOOL isUnpass = state == 6||state == 16;
    if (state == 15) {//1审核中5审核通过6审核未通过 11备案中 15备案通过 16备案未通过
        alert = @"您的申请审核已通过";
        iconName = @"archive_states_success";
    }else if (isUnpass){
        alert = @"您的申请审核未通过";
        iconName = @"archive_states_failure";
    }else {
        alert = @"您的申请正在审核中";
        iconName = @"archive_states_audit";
    }
    {
        UIImageView * iv = [UIImageView new];
        iv.backgroundColor = [UIColor clearColor];
        iv.contentMode = UIViewContentModeScaleAspectFill;
        iv.clipsToBounds = true;
        iv.image = [UIImage imageNamed:iconName];
        iv.widthHeight = XY(W(260),W(148));
        iv.centerXTop = XY(SCREEN_WIDTH/2.0,isUnpass? W(55):W(75));
        [self addSubview:iv];
        top = iv.bottom;
    }
    {
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        l.textColor = COLOR_999;
        l.backgroundColor = [UIColor clearColor];
        [l fitTitle:alert variable:SCREEN_WIDTH - W(30)];
        l.centerXTop = XY(SCREEN_WIDTH/2.0, isUnpass?top + W(30):top + W(50));
        [self addSubview:l];
        top = l.bottom;
    }
    {
        if (isUnpass) {
             YellowButton *btnBottom = [YellowButton new];
                   [btnBottom resetViewWithWidth:W(255) :W(45) :@"重新提交"];
            WEAKSELF
            btnBottom.blockClick = ^{
                if (weakSelf.blockResubmitClick) {
                    weakSelf.blockResubmitClick();
                }
            };
            [self addSubview:btnBottom];
            btnBottom.centerXTop = XY(SCREEN_WIDTH/2.0, top + W(30));
            top = btnBottom.bottom;
        }
    }
    {
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        l.textColor = COLOR_666;
        l.backgroundColor = [UIColor clearColor];
        [l fitTitle:@"企业资料" variable:SCREEN_WIDTH - W(30)];
        l.centerXTop = XY(SCREEN_WIDTH/2.0, isUnpass?top + W(58):top + W(93));
        [self addSubview:l];
        top = l.bottom;
        
        [self addLineFrame:CGRectMake(l.left - W(87) - W(26), l.centerY, W(87), 1)];
        [self addLineFrame:CGRectMake(l.right + W(26), l.centerY, W(87), 1)];

    }
    {
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
        l.textColor = COLOR_666;
        l.backgroundColor = [UIColor clearColor];
        [l fitTitle:[NSString stringWithFormat:@"企业名称：%@",UnPackStr(model.entName)] variable:SCREEN_WIDTH - W(30)];
        l.leftTop = XY(W(45), top + W(30));
        [self addSubview:l];
        top = l.bottom;
    }
    {
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
        l.textColor = COLOR_666;
        l.backgroundColor = [UIColor clearColor];
        [l fitTitle:[NSString stringWithFormat:@"党员姓名：%@",UnPackStr(model.legalPersonName)] variable:SCREEN_WIDTH - W(30)];
        l.leftTop = XY(W(45), top + W(20));
        [self addSubview:l];
        top = l.bottom;
    }
}

@end
