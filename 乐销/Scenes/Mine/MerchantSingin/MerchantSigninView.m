//
//  MerchantSigninView.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/11.
//Copyright © 2020 ping. All rights reserved.
//

#import "MerchantSigninView.h"
#import "UIView+SelectImageView.h"

@interface MerchantSigninTopView ()
@property (nonatomic, strong) BaseNavView *nav;
@property (nonatomic, strong) UIImageView *BG;

@end

@implementation MerchantSigninTopView

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
        _BG.image = [UIImage imageNamed:@"merchant_topBG"];

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
- (SwitchView *)switchView{
    if (_switchView == nil) {
        _switchView =  [SwitchView new];
        _switchView.backgroundColor = [UIColor clearColor];
        [_switchView resetViewWith:@"直接申请入驻" :@"联系咨询"];
        WEAKSELF
        _switchView.blockClick = ^(int index) {
            if (weakSelf.blockClick) {
                weakSelf.blockClick(index);
            }
        };
    }
    return _switchView;
}
#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = COLOR_GRAY;
        self.width = SCREEN_WIDTH;
        self.height = W(135)+iphoneXTopInterval+W(10)+self.switchView.height + W(10);
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
    [self addSubview:self.switchView];

    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view


    self.switchView.centerXBottom = XY(SCREEN_WIDTH/2.0,self.height-W(10));
    
    self.BG.widthHeight = XY(SCREEN_WIDTH, self.switchView.top-W(10));

    self.whiteBG.top = self.BG.bottom-15;
}

@end



@implementation MerchantSigninBottomView
#pragma mark 懒加载
- (UILabel *)businessLicense{
    if (_businessLicense == nil) {
        _businessLicense = [UILabel new];
        _businessLicense.textColor = COLOR_999;
        _businessLicense.font =  [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
        _businessLicense.numberOfLines = 1;
        _businessLicense.lineSpace = 0;
    }
    return _businessLicense;
}
- (UILabel *)identity{
    if (_identity == nil) {
        _identity = [UILabel new];
        _identity.textColor = COLOR_999;
        _identity.font =  [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
        _identity.numberOfLines = 1;
        _identity.lineSpace = 0;
    }
    return _identity;
}
- (UIImageView *)businessLicenseIV{
    if (_businessLicenseIV == nil) {
        _businessLicenseIV = [UIImageView new];
        _businessLicenseIV.image = [UIImage imageNamed:@"signin_business"];
        _businessLicenseIV.widthHeight = XY(W(100),W(100));
        _businessLicenseIV.contentMode = UIViewContentModeScaleAspectFill;
        _businessLicenseIV.clipsToBounds = true;
        [_businessLicenseIV addTarget:self action:@selector(ivLicenseClick)];
    }
    return _businessLicenseIV;
}
- (UIImageView *)identityHeadIV{
    if (_identityHeadIV == nil) {
        _identityHeadIV = [UIImageView new];
        _identityHeadIV.image = [UIImage imageNamed:@"signin_identity_head"];
        _identityHeadIV.widthHeight = XY(W(150),W(100));
        _identityHeadIV.contentMode = UIViewContentModeScaleAspectFill;
        _identityHeadIV.clipsToBounds = true;
        [_identityHeadIV addTarget:self action:@selector(ivIdentityHeadClick)];


    }
    return _identityHeadIV;
}
- (UIImageView *)identityCountryIV{
    if (_identityCountryIV == nil) {
        _identityCountryIV = [UIImageView new];
        _identityCountryIV.image = [UIImage imageNamed:@"signin_identity_country"];
        _identityCountryIV.widthHeight = XY(W(150),W(100));
        _identityCountryIV.contentMode = UIViewContentModeScaleAspectFill;
        _identityCountryIV.clipsToBounds = true;
        [_identityCountryIV addTarget:self action:@selector(ivIdentityCountryClick)];

    }
    return _identityCountryIV;
}
- (UILabel *)alert{
    if (_alert == nil) {
        _alert = [UILabel new];
        {
            
            NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"我已阅读并同意《商家入驻协议》"attributes: @{NSFontAttributeName: [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular],NSForegroundColorAttributeName: [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0]}];
            
            [string addAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:255/255.0 green:169/255.0 blue:0/255.0 alpha:1.0]} range:NSMakeRange(7, 8)];
            
            _alert.attributedText = string;
            _alert.textAlignment = NSTextAlignmentLeft;
            _alert.widthHeight = XY(W(200), [GlobalMethod fetchHeightFromFont:F(12)]);
        }
    }
    return _alert;
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
        [_btnBottom resetViewWithWidth:W(335) :W(45) :@"提交入驻申请"];
        _btnBottom.blockClick = ^{
            
        };
    }
    return _btnBottom;
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
    [self addSubview:self.businessLicense];
    [self addSubview:self.identity];
    [self addSubview:self.businessLicenseIV];
    [self addSubview:self.identityHeadIV];
    [self addSubview:self.identityCountryIV];
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
    [self.businessLicense fitTitle:@"营业执照" variable:0];
    self.businessLicense.leftTop = XY(W(25),W(15));
    
    UIView *whiteBG = [UIView new];
    whiteBG.backgroundColor = [UIColor whiteColor];
    whiteBG.widthHeight = XY(W(345),W(126));
    whiteBG.centerXTop = XY(SCREEN_WIDTH/2.0, self.businessLicense.bottom + W(15));
    [whiteBG addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:10 lineWidth:0 lineColor:[UIColor clearColor]];
    [self insertSubview:whiteBG belowSubview:self.businessLicense];
    
//    [self.businessLicenseIV sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:IMAGE_HEAD_DEFAULT]];
    
    self.businessLicenseIV.centerXCenterY = whiteBG.centerXCenterY;
    

    
    [self.identity fitTitle:@"身份证照" variable:0];
    self.identity.leftTop = XY(W(25),whiteBG.bottom+W(15));

//    [self.identityHeadIV sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:IMAGE_HEAD_DEFAULT]];
    whiteBG = [UIView new];
    whiteBG.backgroundColor = [UIColor whiteColor];
    whiteBG.widthHeight = XY(W(345),W(126));
    whiteBG.centerXTop = XY(SCREEN_WIDTH/2.0, self.identity.bottom + W(15));
    [whiteBG addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:10 lineWidth:0 lineColor:[UIColor clearColor]];
    [self insertSubview:whiteBG belowSubview:self.identityHeadIV];
    
    self.identityHeadIV.leftTop = XY(whiteBG.left+ W(20),whiteBG.top+W(13));
    

//    [self.identityCountryIV sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:IMAGE_HEAD_DEFAULT]];
    self.identityCountryIV.rightTop = XY(whiteBG.right - W(20),whiteBG.top+W(13));

    
    self.iconAlert.leftTop = XY(W(25),whiteBG.bottom+ W(13.5));

    self.alert.leftCenterY = XY(self.iconAlert.right + W(7),self.iconAlert.centerY);
    
    [self addControlFrame:CGRectMake(0, self.alert.top - W(10), SCREEN_WIDTH, self.alert.height + W(20)) belowView:self.alert target:self action:@selector(alertClick)];
    self.btnBottom.centerXTop = XY(SCREEN_WIDTH/2.0, self.alert.bottom + W(23.5));
    //设置总高度
    self.height = self.btnBottom.bottom  + W(25) ;
}

#pragma mark click
- (void)alertClick{
    self.iconAlert.highlighted = !self.iconAlert.highlighted;
}
- (void)ivIdentityHeadClick{
    self.ivSelected = self.identityHeadIV;
    [self showImageVC:1];
    
}

- (void)ivIdentityCountryClick{
    self.ivSelected = self.identityCountryIV;
    [self showImageVC:1];
    
}
- (void)ivLicenseClick{
    self.ivSelected = self.businessLicenseIV;
    [self showImageVC:1];
    
}

//选择图片
- (void)imageSelect:(BaseImage *)image{
    if (self.ivSelected == self.identityHeadIV) {
        self.identityHeadIV.image = image;
    }else if(self.ivSelected == self.identityCountryIV){
        self.identityCountryIV.image = image;
    }else if(self.ivSelected == self.businessLicenseIV){
        self.businessLicenseIV.image = image;
    }
    [AliClient sharedInstance].imageType = ENUM_UP_IMAGE_TYPE_USER_AUTHORITY;
    [[AliClient sharedInstance]updateImageAry:@[image] storageSuccess:^{
        
    } upSuccess:^{
        
    } fail:^{
        
    }];
}
@end



@implementation MerchantConnectBottomView
#pragma mark 懒加载
- (UILabel *)hotline{
    if (_hotline == nil) {
        _hotline = [UILabel new];
        _hotline.textColor = COLOR_999;
        _hotline.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
    }
    return _hotline;
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
    [self addSubview:self.hotline];
    [self addSubview:self.btnBottom];
    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    self.btnBottom.centerXTop = XY(SCREEN_WIDTH/2.0,   W(35));

    
    [self.hotline fitTitle:@"您可以直接拨打商务电话：0536-8888888 联系我们" variable:0];
    self.hotline.centerXTop = XY(SCREEN_WIDTH/2.0,self.btnBottom.bottom + W(25));
    //设置总高度
    self.height = self.hotline.bottom  + W(25) ;
}



@end




@implementation MerchantSigninStatusView
#pragma mark 懒加载
- (UIImageView *)statusIcon{
    if (_statusIcon == nil) {
        _statusIcon = [UIImageView new];
        _statusIcon.image = [UIImage imageNamed:@"archive_states_audit"];
        _statusIcon.widthHeight = XY(W(260  ),W(148));
    }
    return _statusIcon;
}
- (UILabel *)alert{
    if (_alert == nil) {
        _alert = [UILabel new];
        _alert.textColor = COLOR_999;
        _alert.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _alert.numberOfLines = 1;
        _alert.lineSpace = 0;
    }
    return _alert;
}
- (UILabel *)alert1{
    if (_alert1 == nil) {
        _alert1 = [UILabel new];
        _alert1.textColor = COLOR_999;
        _alert1.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _alert1.numberOfLines = 1;
        _alert1.lineSpace = 0;
    }
    return _alert1;
}
- (YellowButton *)btnBottom{
    if (!_btnBottom) {
        _btnBottom = [YellowButton new];
        [_btnBottom resetViewWithWidth:W(255) :W(45) :@"重新提交"];
        _btnBottom.hidden = true;
        
    }
    return _btnBottom;
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
    [self addSubview:self.statusIcon];
    [self addSubview:self.alert];
    [self addSubview:self.alert1];
    [self addSubview:self.btnBottom];
    
    //初始化页面
    [self resetViewWithState:1];
}

#pragma mark 刷新view
- (void)resetViewWithState:(int)state{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    //        1已提交 9通过 11拒绝
    self.statusIcon.centerXTop = XY(SCREEN_WIDTH/2.0,W(100));
    NSString * str0 = @"";
    NSString * str1 = @"";
    NSString * strImageName = @"";
    switch (state) {
        case 1:
            str0 = @"您的入驻申请已提交";
            str1 = @"我们将尽快联系您审核！";
            strImageName = @"archive_states_audit";
            self.btnBottom.hidden = true;
            break;
        case 9:
            str0 = @"您的入驻申请已通过";
            str1 = @"快登录商户平台发布商品吧！";
            strImageName = @"archive_states_success";
            self.btnBottom.hidden = true;
            break;
        case 11:
            str0 = @"您的入驻申请未通过";
            str1 = @"请重新修改！";
            strImageName = @"archive_states_failure";
            self.btnBottom.hidden = false;
            break;
        default:
            break;
    }
    self.statusIcon.image = [UIImage imageNamed:strImageName];
    [self.alert fitTitle:str0 variable:0];
    self.alert.centerXTop = XY(SCREEN_WIDTH/2.0,self.statusIcon.bottom+W(50));
    [self.alert1 fitTitle:str1 variable:0];
    self.alert1.centerXTop = XY(SCREEN_WIDTH/2.0,self.alert.bottom+W(10));
    self.btnBottom.centerXTop = XY(SCREEN_WIDTH/2.0, self.alert1.bottom +W(50));
    //设置总高度
    self.height = SCREEN_HEIGHT;
}

@end
