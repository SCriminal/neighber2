//
//  PartyMapView.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/6/30.
//Copyright © 2020 ping. All rights reserved.
//

#import "PartyMapView.h"
#import <MapKit/MKMapItem.h>//用于苹果自带地图

#import <MapKit/MKTypes.h>//用于苹果自带地图
#import "ThirdMap.h"

@interface PartyMapSearchView ()

@end

@implementation PartyMapSearchView

- (UIButton *)btnSearch{
    if (_btnSearch == nil) {
        
        _btnSearch = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnSearch addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
        _btnSearch.backgroundColor = [UIColor clearColor];
        _btnSearch.widthHeight = XY(W(65),NAVIGATIONBAR_HEIGHT-STATUSBAR_HEIGHT);
        STRUCT_XY wh = _btnSearch.widthHeight;
        [_btnSearch addSubview:^(){
            UIImageView * iv = [UIImageView new];
            iv.image = [UIImage imageNamed:@"shopping_Seach"];
            iv.widthHeight = XY(W(25), W(25));
            iv.rightCenterY = XY(wh.horizonX-W(30), wh.verticalY/2.0);
            return iv;
        }()];
    }
    return _btnSearch;
}
- (UITextField *)tfSearch{
    if (_tfSearch == nil) {
        _tfSearch = [UITextField new];
        _tfSearch.font = [UIFont systemFontOfSize:F(13)];
        _tfSearch.textAlignment = NSTextAlignmentLeft;
        _tfSearch.placeholder = @"请输入党群服务中心名称";
        _tfSearch.borderStyle = UITextBorderStyleNone;
        _tfSearch.backgroundColor = [UIColor clearColor];
        _tfSearch.returnKeyType = UIReturnKeySearch;
        _tfSearch.delegate = self;
        [_tfSearch addTarget:self action:@selector(textFileAction:) forControlEvents:(UIControlEventEditingChanged)];
    }
    return _tfSearch;
}

- (UIView *)viewBG{
    if (_viewBG == nil) {
        _viewBG = [UIView new];
        _viewBG.backgroundColor = [UIColor colorWithHexString:@"#FCFCFC"];
        _viewBG.widthHeight = XY(W(321), W(37));
        [_viewBG addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:10 lineWidth:1 lineColor:[UIColor colorWithHexString:@"#EFF2F1"]];
        
        [_viewBG addTarget:self action:@selector(viewBGClick)];
    }
    return _viewBG;
}
- (UIControl *)backBtn{
    if (!_backBtn) {
        _backBtn = [UIControl new];
        _backBtn.tag = TAG_KEYBOARD;
        [_backBtn addTarget:self action:@selector(btnBackClick) forControlEvents:UIControlEventTouchUpInside];
        [BaseNavView resetControl:_backBtn imageName:@"back_black" imageSize:CGSizeMake(W(25), W(25)) isLeft:true];
        _backBtn.width = W(40);
    }
    return _backBtn;
}
#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.width = SCREEN_WIDTH;
        self.height = NAVIGATIONBAR_HEIGHT+W(10);
        [self addSubView];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.viewBG];
    [self addSubview:self.btnSearch];
    [self addSubview:self.tfSearch];
    [self addSubview:self.backBtn];
    
    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    
    //刷新view
    self.backBtn.leftTop = XY(0, (NAVIGATIONBAR_HEIGHT + STATUSBAR_HEIGHT)/2.0-self.backBtn.height/2.0);
    
    self.viewBG.leftTop = XY(W(39),(NAVIGATIONBAR_HEIGHT + STATUSBAR_HEIGHT)/2.0-self.viewBG.height/2.0);
    
    self.btnSearch.rightCenterY = XY(SCREEN_WIDTH,self.viewBG.centerY);
    self.tfSearch.widthHeight = XY(self.viewBG.width - W(60), self.tfSearch.font.lineHeight);
    self.tfSearch.leftCenterY = XY( self.viewBG.left + W(15),self.viewBG.centerY+W(2));
}
#pragma mark 点击事件
- (void)btnClick{
    [GlobalMethod endEditing];
    if (self.blockSearch) {
        self.blockSearch(self.tfSearch.text);
    }
}

#pragma mark click
- (void)btnBackClick{
    [GB_Nav popViewControllerAnimated:true];
}
#pragma mark textfield delegate
- (void)textFileAction:(UITextField *)tf{
    if (self.blockSearch) {
           self.blockSearch(self.tfSearch.text);
       }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self btnClick];
    return true;
}
- (void)viewBGClick{
    [self.tfSearch becomeFirstResponder];
}

@end


@implementation PartyMapJumpSearchView

- (UIButton *)btnSearch{
    if (_btnSearch == nil) {
        
        _btnSearch = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnSearch.tag = 1;
        _btnSearch.backgroundColor = [UIColor clearColor];
        _btnSearch.widthHeight = XY(W(65),NAVIGATIONBAR_HEIGHT-STATUSBAR_HEIGHT);
        STRUCT_XY wh = _btnSearch.widthHeight;
        [_btnSearch addSubview:^(){
            UIImageView * iv = [UIImageView new];
            iv.image = [UIImage imageNamed:@"shopping_Seach"];
            iv.widthHeight = XY(W(25), W(25));
            iv.rightCenterY = XY(wh.horizonX-W(30), wh.verticalY/2.0);
            return iv;
        }()];
        _btnSearch.userInteractionEnabled = false;
    }
    return _btnSearch;
}
- (UITextField *)tfSearch{
    if (_tfSearch == nil) {
        _tfSearch = [UITextField new];
        _tfSearch.font = [UIFont systemFontOfSize:F(13)];
        _tfSearch.textAlignment = NSTextAlignmentLeft;
        _tfSearch.placeholder = @"请输入党群服务中心名称";
        _tfSearch.borderStyle = UITextBorderStyleNone;
        _tfSearch.backgroundColor = [UIColor clearColor];
        _tfSearch.userInteractionEnabled = false;
    }
    return _tfSearch;
}

- (UIView *)viewBG{
    if (_viewBG == nil) {
        _viewBG = [UIView new];
        _viewBG.backgroundColor = [UIColor colorWithHexString:@"#FCFCFC"];
        _viewBG.widthHeight = XY(W(321), W(37));
        [_viewBG addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:10 lineWidth:1 lineColor:[UIColor colorWithHexString:@"#EFF2F1"]];
        
        [_viewBG addTarget:self action:@selector(viewBGClick)];
    }
    return _viewBG;
}
- (UIControl *)backBtn{
    if (!_backBtn) {
        _backBtn = [UIControl new];
        _backBtn.tag = TAG_KEYBOARD;
        [_backBtn addTarget:self action:@selector(btnBackClick) forControlEvents:UIControlEventTouchUpInside];
        [BaseNavView resetControl:_backBtn imageName:@"back_black" imageSize:CGSizeMake(W(25), W(25)) isLeft:true];
    }
    return _backBtn;
}
#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.width = SCREEN_WIDTH;
        self.height = NAVIGATIONBAR_HEIGHT+W(10);
        [self addSubView];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.viewBG];
    [self addSubview:self.btnSearch];
    [self addSubview:self.tfSearch];
    [self addSubview:self.backBtn];
    
    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    
    //刷新view
    self.backBtn.leftTop = XY(0, (NAVIGATIONBAR_HEIGHT + STATUSBAR_HEIGHT)/2.0-self.backBtn.height/2.0);
    
    self.viewBG.leftTop = XY(W(39),(NAVIGATIONBAR_HEIGHT + STATUSBAR_HEIGHT)/2.0-self.viewBG.height/2.0);
    
    self.btnSearch.rightCenterY = XY(SCREEN_WIDTH,self.viewBG.centerY);
    self.tfSearch.widthHeight = XY(self.viewBG.width - W(60), self.tfSearch.font.lineHeight);
    self.tfSearch.leftCenterY = XY( self.viewBG.left + W(15),self.viewBG.centerY+W(2));
}
#pragma mark 点击事件
- (void)btnClick:(UIButton *)sender{
    [GlobalMethod endEditing];
    if (self.blockSearchClick) {
        self.blockSearchClick();
    }
}

#pragma mark click
- (void)btnBackClick{
    [GB_Nav popViewControllerAnimated:true];
}
- (void)viewBGClick{
    if (self.blockSearchClick) {
        self.blockSearchClick();
    }
}

@end


@implementation PartySearchListCell
#pragma mark 懒加载
- (UILabel *)communityName{
    if (_communityName == nil) {
        _communityName = [UILabel new];
        _communityName.textColor = COLOR_333;
        _communityName.font =  [UIFont systemFontOfSize:F(17) weight:UIFontWeightMedium];
        _communityName.numberOfLines = 1;
        
    }
    return _communityName;
}
- (UILabel *)address{
    if (_address == nil) {
        _address = [UILabel new];
        _address.textColor = COLOR_666;
        _address.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _address.numberOfLines = 1;
    }
    return _address;
}
- (UILabel *)people{
    if (_people == nil) {
        _people = [UILabel new];
        _people.textColor = COLOR_666;
        _people.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _people.numberOfLines = 1;
        
    }
    return _people;
}
- (UILabel *)phone{
    if (_phone == nil) {
        _phone = [UILabel new];
        _phone.textColor = COLOR_666;
        _phone.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _phone.numberOfLines = 1;
        
    }
    return _phone;
}
- (UIImageView *)iconPhone{
    if (_iconPhone == nil) {
        _iconPhone = [UIImageView new];
        _iconPhone.image = [UIImage imageNamed:@"map_phone"];
        _iconPhone.widthHeight = XY(W(25),W(25));
    }
    return _iconPhone;
}
- (UILabel *)labelPhone{
    if (_labelPhone == nil) {
        _labelPhone = [UILabel new];
        _labelPhone.textColor = COLOR_ORANGE;
        _labelPhone.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        [_labelPhone fitTitle:@"电话" variable:0];
    }
    return _labelPhone;
}
- (UIImageView *)iconNav{
    if (_iconNav == nil) {
        _iconNav = [UIImageView new];
        _iconNav.image = [UIImage imageNamed:@"map_nav"];
        _iconNav.widthHeight = XY(W(25),W(25));
    }
    return _iconNav;
}
- (UILabel *)labelNav{
    if (_labelNav == nil) {
        _labelNav = [UILabel new];
        _labelNav.textColor = COLOR_ORANGE;
        _labelNav.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        [_labelNav fitTitle:@"导航" variable:0];
    }
    return _labelNav;
}
- (UILabel *)leader{
    if (_leader == nil) {
        _leader = [UILabel new];
        _leader.textColor = COLOR_666;
        _leader.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _leader.numberOfLines = 1;
        
    }
    return _leader;
}
#pragma mark 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.communityName];
        [self.contentView addSubview:self.address];
        [self.contentView addSubview:self.people];
        [self.contentView addSubview:self.phone];
        [self.contentView addSubview:self.iconPhone];
        [self.contentView addSubview:self.labelPhone];
        [self.contentView addSubview:self.iconNav];
        [self.contentView addSubview:self.labelNav];
        [self.contentView addSubview:self.leader];
    }
    return self;
}
#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelParty *)model{
    self.model = model;
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    [self.communityName fitTitle:UnPackStr(model.name) variable:W(237)];
    self.communityName.leftTop = XY(W(20),W(15));
    [self.address fitTitle:UnPackStr(model.addr) variable:W(237)];
    self.address.leftTop = XY(self.communityName.left,self.communityName.bottom+W(10));
    
    CGFloat top = self.address.bottom+W(10);
    if (self.model.areaLv == 6) {//community
        [self.leader fitTitle:isStr(self.model.secretaryName)?[NSString stringWithFormat:@"社区书记：%@",self.model.secretaryName]:@"" variable:W(237)];
        self.leader.leftTop = XY(self.communityName.left, top);
        if (isStr(self.leader.text)) {
            top = self.leader.bottom + W(10);
        }
    }else if (self.model.areaLv == 5){//street
        [self.leader fitTitle:@"" variable:W(237)];
        self.leader.leftTop = XY(self.communityName.left, top);
    }
    [self.people fitTitle:isStr(self.model.cadreDescription)?[NSString stringWithFormat:@"党务干部：%@",self.model.cadreDescription]:@"暂无" variable:W(237)];
    self.people.leftTop = XY(self.communityName.left, top);
    
    
    [self.phone fitTitle:[NSString stringWithFormat:@"联系电话：%@",UnPackStr(model.phone)] variable:W(237)];
    self.phone.leftTop = XY(self.communityName.left,self.people.bottom+W(10));
    
    self.iconNav.rightCenterY = XY(SCREEN_WIDTH - W(15),self.address.centerY);
    self.labelNav.centerXTop = XY(self.iconNav.centerX,self.iconNav.bottom+W(5));
    [self.contentView addControlFrame:CGRectInset(self.iconNav.frame, -W(20), -W(30)) belowView:self.iconNav target:self action:@selector(navClick)];
    
    self.iconPhone.rightCenterY = XY(self.iconNav.left - W(30),self.address.centerY);
    self.labelPhone.centerXTop = XY(self.iconPhone.centerX,self.iconPhone.bottom+W(5));
    [self.contentView addControlFrame:CGRectInset(self.iconPhone.frame, -W(20), -W(30)) belowView:self.iconPhone target:self action:@selector(phoneClick)];
    
    
    //设置总高度
    self.height = [self.contentView addLineFrame:CGRectMake(W(20), self.phone.bottom + W(15), SCREEN_WIDTH - W(40), 1)];
}

- (void)navClick{
       ModelAddress * modelStart = [GlobalMethod readModelForKey:LOCAL_LOCATION  modelName:@"ModelAddress" exchange:false];
    UIAlertController * vc = [ThirdMap getInstalledMapAppWithEndLocation:CLLocationCoordinate2DMake(self.model.lat, self.model.lng) currentLocation:CLLocationCoordinate2DMake(modelStart.lat, modelStart.lng)];
     [GB_Nav.lastVC presentViewController:vc animated:YES completion:nil];
}
- (void)phoneClick{
    if (isStr(self.model.phone)) {
        NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel://%@",self.model.phone];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }else{
        [GlobalMethod showAlert:@"暂无联系电话"];
    }
    
}
@end



@implementation PartySearchBottomView
#pragma mark 懒加载
- (UILabel *)communityName{
    if (_communityName == nil) {
        _communityName = [UILabel new];
        _communityName.textColor = COLOR_333;
        _communityName.font =  [UIFont systemFontOfSize:F(17) weight:UIFontWeightMedium];
        _communityName.numberOfLines = 1;
        
    }
    return _communityName;
}
- (UILabel *)brief{
    if (_brief == nil) {
        _brief = [UILabel new];
        _brief.textColor = COLOR_666;
        _brief.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _brief.numberOfLines = 0;
    }
    return _brief;
}
- (UILabel *)address{
    if (_address == nil) {
        _address = [UILabel new];
        _address.textColor = COLOR_666;
        _address.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _address.numberOfLines = 0;
    }
    return _address;
}
- (UILabel *)people{
    if (_people == nil) {
        _people = [UILabel new];
        _people.textColor = COLOR_666;
        _people.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _people.numberOfLines = 1;
        
    }
    return _people;
}
- (UILabel *)leader{
    if (_leader == nil) {
        _leader = [UILabel new];
        _leader.textColor = COLOR_666;
        _leader.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _leader.numberOfLines = 1;
        
    }
    return _leader;
}
- (UILabel *)phone{
    if (_phone == nil) {
        _phone = [UILabel new];
        _phone.textColor = COLOR_666;
        _phone.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _phone.numberOfLines = 1;
        
    }
    return _phone;
}
- (UIImageView *)iconPhone{
    if (_iconPhone == nil) {
        _iconPhone = [UIImageView new];
        _iconPhone.image = [UIImage imageNamed:@"map_phone"];
        _iconPhone.widthHeight = XY(W(25),W(25));
    }
    return _iconPhone;
}
- (UIImageView *)iconClose{
    if (_iconClose == nil) {
        _iconClose = [UIImageView new];
        _iconClose.image = [UIImage imageNamed:@"inputClose"];
        _iconClose.widthHeight = XY(W(25),W(25));
    }
    return _iconClose;
}

- (UILabel *)labelPhone{
    if (_labelPhone == nil) {
        _labelPhone = [UILabel new];
        _labelPhone.textColor = COLOR_ORANGE;
        _labelPhone.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        [_labelPhone fitTitle:@"电话" variable:0];
    }
    return _labelPhone;
}
- (UIImageView *)iconNav{
    if (_iconNav == nil) {
        _iconNav = [UIImageView new];
        _iconNav.image = [UIImage imageNamed:@"map_nav"];
        _iconNav.widthHeight = XY(W(25),W(25));
    }
    return _iconNav;
}
- (UILabel *)labelNav{
    if (_labelNav == nil) {
        _labelNav = [UILabel new];
        _labelNav.textColor = COLOR_ORANGE;
        _labelNav.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        [_labelNav fitTitle:@"导航" variable:0];
    }
    return _labelNav;
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.width = SCREEN_WIDTH;
        self.height = W(50);
        [self addSubView];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.communityName];
    [self addSubview:self.address];
    [self addSubview:self.brief];
    [self addSubview:self.iconClose];
    
    [self addSubview:self.people];
    [self addSubview:self.phone];
    [self addSubview:self.iconPhone];
    [self addSubview:self.labelPhone];
    [self addSubview:self.iconNav];
    [self addSubview:self.labelNav];
    [self addSubview:self.leader];
    
    //初始化页面
    [self resetViewWithModel:nil];
}
#pragma mark 刷新cell
- (void)resetViewWithModel:(ModelParty *)model{
    self.model = model;
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    [self.communityName fitTitle:UnPackStr(model.name) variable:W(300)];
    self.communityName.leftTop = XY(W(20),W(20));
    
    self.iconClose.rightCenterY = XY(SCREEN_WIDTH - W(15), self.communityName.centerY);
    [self addControlFrame:CGRectInset(self.iconClose.frame, -W(30), -W(30)) belowView:self.iconClose target:self action:@selector(closeClick)];
    
    [self.brief fitTitle:UnPackStr(model.introduction) variable:W(330)];
    self.brief.leftTop = XY(self.communityName.left, self.communityName.bottom + W(20));
    
    CGFloat top = self.brief.bottom+W(20);
    if (self.model.areaLv == 6) {//community
        [self.leader fitTitle:isStr(self.model.secretaryName)?[NSString stringWithFormat:@"社区书记：%@",self.model.secretaryName]:@"" variable:W(237)];
        self.leader.leftTop = XY(self.communityName.left, top);
        if (isStr(self.leader.text)) {
            top = self.leader.bottom + W(15);
        }
        
    }else if (self.model.areaLv == 5){//street
        [self.leader fitTitle:@"" variable:W(237)];
        self.leader.leftTop = XY(self.communityName.left, top);
    }
    
    [self.people fitTitle:isStr(self.model.cadreDescription)?[NSString stringWithFormat:@"党务干部：%@",self.model.cadreDescription]:@"暂无" variable:W(237)];
    self.people.leftTop = XY(self.communityName.left, top);
    
    
    [self.phone fitTitle:[NSString stringWithFormat:@"联系电话：%@",isStr(model.phone)?UnPackStr(model.phone):@"暂无"] variable:W(237)];
    self.phone.leftTop = XY(self.communityName.left,self.people.bottom+W(15));
    
    [self.address fitTitle:[NSString stringWithFormat:@"详细地址：%@",isStr(model.addr)?model.addr:@"暂无"] variable:W(237)];
    self.address.leftTop = XY(self.communityName.left,self.phone.bottom+W(15));
    
    self.iconNav.rightCenterY = XY(SCREEN_WIDTH - W(15),self.phone.bottom + W(6));
    self.labelNav.centerXTop = XY(self.iconNav.centerX,self.iconNav.bottom+W(5));
    [self addControlFrame:CGRectInset(self.iconNav.frame, -W(20), -W(30)) belowView:self.iconNav target:self action:@selector(navClick)];
    
    
    self.iconPhone.rightCenterY = XY(self.iconNav.left - W(30),self.iconNav.centerY);
    self.labelPhone.centerXTop = XY(self.iconPhone.centerX,self.iconPhone.bottom+W(5));
    [self addControlFrame:CGRectInset(self.iconPhone.frame, -W(20), -W(30)) belowView:self.iconPhone target:self action:@selector(phoneClick)];
    
    //设置总高度
    self.height = self.address.bottom + W(20)+iphoneXBottomInterval;
    [self removeCorner];
    [self addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight radius:15];
}
- (void)navClick{
    ModelAddress * modelStart = [GlobalMethod readModelForKey:LOCAL_LOCATION  modelName:@"ModelAddress" exchange:false];
    UIAlertController * vc = [ThirdMap getInstalledMapAppWithEndLocation:CLLocationCoordinate2DMake(self.model.lat, self.model.lng) currentLocation:CLLocationCoordinate2DMake(modelStart.lat, modelStart.lng)];
    [GB_Nav.lastVC presentViewController:vc animated:YES completion:nil];
}
- (void)phoneClick{
    if (isStr(self.model.phone)) {
        NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel://%@",self.model.phone];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }else{
        [GlobalMethod showAlert:@"暂无联系电话"];
    }
    
}
- (void)closeClick{
    [self removeFromSuperview];
}

@end
