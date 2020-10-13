//
//  AuthenticationView.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/4/22.
//Copyright © 2020 ping. All rights reserved.
//

#import "AuthenticationView.h"
#import "UIView+SelectImageView.h"

@interface AuthenticationBottomView ()

@end

@implementation AuthenticationBottomView
#pragma mark 懒加载
- (UIImageView *)identityHeadIV{
    if (_identityHeadIV == nil) {
        _identityHeadIV = [UIImageView new];
        _identityHeadIV.image = [UIImage imageNamed:@"authentication_head"];
        _identityHeadIV.widthHeight = XY(W(160),W(100));
        _identityHeadIV.contentMode = UIViewContentModeScaleAspectFill;
        _identityHeadIV.clipsToBounds = true;
        [_identityHeadIV addTarget:self action:@selector(ivIdentityHeadClick)];
        
        
    }
    return _identityHeadIV;
}
- (UIImageView *)identityCountryIV{
    if (_identityCountryIV == nil) {
        _identityCountryIV = [UIImageView new];
        _identityCountryIV.image = [UIImage imageNamed:@"authentication_country"];
        _identityCountryIV.widthHeight = XY(W(160),W(100));
        _identityCountryIV.contentMode = UIViewContentModeScaleAspectFill;
        _identityCountryIV.clipsToBounds = true;
        [_identityCountryIV addTarget:self action:@selector(ivIdentityCountryClick)];
        
    }
    return _identityCountryIV;
}
- (YellowButton *)btnBottom{
    if (!_btnBottom) {
        _btnBottom = [YellowButton new];
        [_btnBottom resetViewWithWidth:W(335) :W(45) :@"提交"];
        
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
    [self addSubview:self.identityHeadIV];
    [self addSubview:self.identityCountryIV];
    [self addSubview:self.btnBottom];
    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelAuthentication *)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    
    UIView *whiteBG = [UIView new];
    whiteBG.backgroundColor = [UIColor whiteColor];
    whiteBG.widthHeight = XY(W(345),W(126));
    whiteBG.centerXTop = XY(SCREEN_WIDTH/2.0, W(13));
    [whiteBG addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:10 lineWidth:0 lineColor:[UIColor clearColor]];
    [self insertSubview:whiteBG belowSubview:self.identityHeadIV];
    
    WEAKSELF
    self.identityHeadIV.centerXCenterY = whiteBG.centerXCenterY;
    [self.identityHeadIV sd_setImageWithURL:[NSURL URLWithString:model.idPortrait] placeholderImage:[UIImage imageNamed:@"authentication_head"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (error == nil && image) {
            weakSelf.identityHeadIV.image = [BaseImage imageWithImage:image url:imageURL];
        }
    }];
    
    
    whiteBG = [UIView new];
    whiteBG.backgroundColor = [UIColor whiteColor];
    whiteBG.widthHeight = XY(W(345),W(126));
    whiteBG.centerXTop = XY(SCREEN_WIDTH/2.0, self.identityHeadIV.bottom + W(26));
    [whiteBG addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:10 lineWidth:0 lineColor:[UIColor clearColor]];
    [self insertSubview:whiteBG belowSubview:self.identityCountryIV];
    
    self.identityCountryIV.centerXCenterY = whiteBG.centerXCenterY;
    [self.identityCountryIV sd_setImageWithURL:[NSURL URLWithString:model.idEmblem] placeholderImage:[UIImage imageNamed:@"authentication_country"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (error == nil && image) {
            weakSelf.identityCountryIV.image = [BaseImage imageWithImage:image url:imageURL];
        }
    }];
    [self.btnBottom resetViewWithWidth:W(335) :W(45) :model.status == 11?@"重新提交":@"提交"];
    self.btnBottom.centerXTop = XY(SCREEN_WIDTH/2.0,whiteBG.bottom + W(18));
    
    //设置总高度
    self.height = self.btnBottom.bottom  + W(25) ;
}

#pragma mark click

- (void)ivIdentityHeadClick{
    self.ivSelected = self.identityHeadIV;
    [self showImageVC:1];
}

- (void)ivIdentityCountryClick{
    self.ivSelected = self.identityCountryIV;
    [self showImageVC:1];
    
}


//选择图片
- (void)imageSelect:(BaseImage *)image{
    if (self.ivSelected == self.identityHeadIV) {
        self.identityHeadIV.image = image;
    }else if(self.ivSelected == self.identityCountryIV){
        self.identityCountryIV.image = image;
    }
    [AliClient sharedInstance].imageType = ENUM_UP_IMAGE_TYPE_USER_AUTHORITY;
    [[AliClient sharedInstance]updateImageAry:@[image] storageSuccess:^{
        
    } upSuccess:^{
        
    } fail:^{
        
    }];
}


@end



@implementation AuthenticationTopView
#pragma mark 懒加载
- (UILabel *)title{
    if (_title == nil) {
        _title = [UILabel new];
        _title.textColor = [UIColor colorWithHexString:@"#FE533F"];
        _title.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        _title.numberOfLines = 0;
        _title.lineSpace = W(4);
        
    }
    return _title;
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"#FFE5E5"];
        self.width = SCREEN_WIDTH;
        [self addSubView];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.title];
}

#pragma mark 刷新view
- (void)resetViewWithTitle:(NSString *)title{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    [self.title fitTitle:title variable:SCREEN_WIDTH - W(30)];
    self.title.leftTop = XY(W(15),W(10));
    
    //设置总高度
    self.height = self.title.bottom + self.title.top;
}

@end



@implementation AuthenticationStatusView
#pragma mark 懒加载
- (UIImageView *)statusIcon{
    if (_statusIcon == nil) {
        _statusIcon = [UIImageView new];
        _statusIcon.image = [UIImage imageNamed:@"authentication_success"];
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
    
    //初始化页面
    [self resetViewWithState:1];
}

#pragma mark 刷新view
- (void)resetViewWithState:(int)state{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    //审核状态  1-未提交  2-审核中  10审核通过  11-审核未通过
    NSString * str0 = @"";
    NSString * strImageName = @"";
    switch (state) {
        case 2:
            str0 = @"认证审核中";
            strImageName = @"authentication_auditing";
            break;
        case 10:
            str0 = @"认证已完成！";
            strImageName = @"authentication_success";
            break;
        default:
            break;
    }
    self.statusIcon.centerXTop = XY(SCREEN_WIDTH/2.0,W(150));
    self.statusIcon.image = [UIImage imageNamed:strImageName];
    [self.alert fitTitle:str0 variable:0];
    self.alert.centerXTop = XY(SCREEN_WIDTH/2.0,self.statusIcon.bottom+W(50));
    //设置总高度
    self.height = SCREEN_HEIGHT;
}

@end
