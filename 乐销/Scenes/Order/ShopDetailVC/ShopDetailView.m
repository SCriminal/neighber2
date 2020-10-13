//
//  ShopDetailView.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/12.
//Copyright © 2020 ping. All rights reserved.
//

#import "ShopDetailView.h"
#import <MapKit/MKMapItem.h>//用于苹果自带地图

#import <MapKit/MKTypes.h>//用于苹果自带地图

@interface ShopDetailTopView ()

@end

@implementation ShopDetailTopView




#pragma mark 懒加载
- (UIImageView *)logo{
    if (_logo == nil) {
        _logo = [UIImageView new];
        _logo.image = [UIImage imageNamed:IMAGE_BIG_DEFAULT];
        _logo.widthHeight = XY(W(65),W(65));
        _logo.contentMode = UIViewContentModeScaleAspectFill;
        _logo.clipsToBounds = true;
        [_logo addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:5 lineWidth:1 lineColor:[UIColor colorWithHexString:@"#EFF2F1"]];
        
    }
    return _logo;
}
- (UILabel *)name{
    if (_name == nil) {
        _name = [UILabel new];
        _name.textColor = COLOR_333;
        _name.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _name.numberOfLines = 1;
        _name.lineSpace = 0;
    }
    return _name;
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
- (UIImageView *)star{
    if (_star == nil) {
        _star = [UIImageView new];
        _star.image = [UIImage imageNamed:@"shope_star"];
        _star.widthHeight = XY(W(12),W(12));
    }
    return _star;
}
- (UILabel *)score{
    if (_score == nil) {
        _score = [UILabel new];
        _score.textColor = COLOR_ORANGE;
        _score.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        _score.numberOfLines = 1;
        _score.lineSpace = 0;
    }
    return _score;
}
- (UILabel *)overturn{
    if (_overturn == nil) {
        _overturn = [UILabel new];
        _overturn.textColor = COLOR_666;
        _overturn.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        _overturn.numberOfLines = 1;
        _overturn.lineSpace = 0;
    }
    return _overturn;
}
- (UILabel *)phone{
    if (_phone == nil) {
        _phone = [UILabel new];
        _phone.textColor = COLOR_666;
        _phone.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        _phone.numberOfLines = 1;
        _phone.lineSpace = 0;
    }
    return _phone;
}
- (UILabel *)address{
    if (_address == nil) {
        _address = [UILabel new];
        _address.textColor = COLOR_666;
        _address.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        _address.numberOfLines = 0;
        _address.lineSpace = W(5);
    }
    return _address;
}
- (UILabel *)addressTitle{
    if (_addressTitle == nil) {
        _addressTitle = [UILabel new];
        _addressTitle.textColor = COLOR_666;
        _addressTitle.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        _addressTitle.numberOfLines = 0;
        [_addressTitle fitTitle:@"地址：" variable:0];
    }
    return _addressTitle;
}
- (UILabel *)navigation{
    if (_navigation == nil) {
        _navigation = [UILabel new];
        _navigation.textColor = COLOR_ORANGE;
        _navigation.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        _navigation.numberOfLines = 1;
        _navigation.lineSpace = 0;
    }
    return _navigation;
}
- (UIImageView *)navIV{
    if (_navIV == nil) {
        _navIV = [UIImageView new];
        _navIV.image = [UIImage imageNamed:@"shope_nav"];
        _navIV.widthHeight = XY(W(13),W(13));
    }
    return _navIV;
}
#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];//背景色
        self.width = SCREEN_WIDTH;//默认宽度
        [self addSubView];//添加子视图
    }
    return self;
}
//添加subview
- (void)addSubView{
    //初始化页面
    [self addSubview:self.logo];
    [self addSubview:self.name];
    [self addSubview:self.time];
    [self addSubview:self.star];
    [self addSubview:self.score];
    [self addSubview:self.overturn];
    [self addSubview:self.phone];
    [self addSubview:self.address];
    [self addSubview:self.addressTitle];
    [self addSubview:self.navigation];
    [self addSubview:self.navIV];
    
    [self resetViewWithModel:nil];
}

#pragma mark 刷新cell
- (void)resetViewWithModel:(ModelShopList *)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    self.model = model;
        [self.logo sd_setImageWithURL:[NSURL URLWithString:model.coverUrl] placeholderImage:[UIImage imageNamed:IMAGE_HEAD_COMPANY_DEFAULT]];
//    self.logo.image = [UIImage imageNamed:@"temp_中百"];
    self.logo.leftTop = XY(W(20),W(15));
    
    
    [self.name fitTitle:UnPackStr(model.storeName)  variable:SCREEN_WIDTH - self.logo.right - W(40)];
    self.name.leftTop = XY(self.logo.right + W(10),self.logo.top+W(2));
    
    self.star.leftCenterY =XY(self.logo.right + W(10),self.logo.centerY + W(1));
    [self.score fitTitle:strDotF(model.storeScore) variable:0];
    self.score.leftCenterY = XY(self.star.right + W(6),self.star.centerY);
    [self.overturn fitTitle:[NSString stringWithFormat:@"月售%.f",model.monthAmount]  variable:0];
    self.overturn.leftCenterY = XY(self.score.right + W(20),self.star.centerY);
    
    
    [self.time fitTitle:[NSString stringWithFormat:@"营业时间：%@-%@",[self fetchTime:model.startTime],[self fetchTime:model.endTime]] variable: W(188)];
    self.time.leftBottom =  XY(self.logo.right + W(10),self.logo.bottom-W(2));

    [self.phone fitTitle:[NSString stringWithFormat:@"电话：%@",UnPackStr(model.contactPhone)] variable:SCREEN_WIDTH - W(90)];
    self.phone.leftTop = XY(W(20),self.logo.bottom + W(15));
    
    
    [self.navigation fitTitle:@"导航到店" variable:0];
       self.navigation.rightTop = XY(SCREEN_WIDTH - W(20),self.phone.bottom+ W(15));
    
    [self addControlFrame:CGRectInset(self.navigation.frame, -W(20), -W(20)) belowView:self.navigation target:self action:@selector(navClick)];
    self.navIV.rightCenterY = XY(self.navigation.left - W(6),self.navigation.centerY);

    
    //刷新view
    self.addressTitle.leftTop = XY(W(20),self.phone.bottom+ W(15));;
    [self.address fitTitle:[NSString stringWithFormat:@"%@",UnPackStr(model.bizAddr)] variable:self.navIV.left - self.addressTitle.right- W(30)];
    self.address.leftTop = self.addressTitle.rightTop;

    //设置总高度
    self.height = self.address.bottom + W(18);
}
- (NSString *)fetchTime:(double)time{
    time = strDotF(time).length >=8?time/1000.0:time;
    double hour = time/3600.0;
    double minute = (time - hour*3600.0)/60.0;
    return [NSString stringWithFormat:@"%02.lf:%02.lf",hour,minute];
}
- (void)navClick{
    //起点
    
    MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
//    CLLocationCoordinate2D desCorrdinate = CLLocationCoordinate2DMake(coord.latitude, coord.longitude);
 
    CLLocationCoordinate2D desCorrdinate = CLLocationCoordinate2DMake(self.model.lat, self.model.lng);
    
    //终点
    
    MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:desCorrdinate addressDictionary:nil]];
    
    //默认驾车
    
    [MKMapItem openMapsWithItems:@[currentLocation, toLocation]
     
                   launchOptions:@{MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving,
                                   
                                   MKLaunchOptionsMapTypeKey:[NSNumber numberWithInteger:MKMapTypeStandard],
                                   
                                   MKLaunchOptionsShowsTrafficKey:[NSNumber numberWithBool:YES]}];
    
 
}
@end



@implementation SearchDetailSearchView

- (UIButton *)btnSearch{
    if (_btnSearch == nil) {
        
        _btnSearch = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnSearch.tag = 1;
        [_btnSearch addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
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
        _tfSearch.placeholder = @"请输入商铺名称";
        _tfSearch.borderStyle = UITextBorderStyleNone;
        _tfSearch.backgroundColor = [UIColor clearColor];
        _tfSearch.delegate = self;
        [_tfSearch addTarget:self action:@selector(textFileAction:) forControlEvents:(UIControlEventEditingChanged)];
    }
    return _tfSearch;
}

- (UIView *)viewBG{
    if (_viewBG == nil) {
        _viewBG = [UIView new];
        _viewBG.backgroundColor = [UIColor whiteColor];
        _viewBG.widthHeight = XY(W(345), W(37));
        [_viewBG addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:10 lineWidth:0 lineColor:[UIColor clearColor]];

        [_viewBG addTarget:self action:@selector(viewBGClick)];
    }
    return _viewBG;
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = COLOR_GRAY;
        self.width = SCREEN_WIDTH;
        self.height = W(57);
        [self addSubView];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.viewBG];
    [self addSubview:self.btnSearch];
    [self addSubview:self.tfSearch];
    
    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    
    //刷新view
    
    self.viewBG.leftTop = XY(W(15),W(10));
    
    self.btnSearch.rightCenterY = XY(SCREEN_WIDTH,self.viewBG.centerY);
    self.tfSearch.widthHeight = XY(self.viewBG.width - W(60), self.tfSearch.font.lineHeight);
    self.tfSearch.leftCenterY = XY( self.viewBG.left + W(15),self.viewBG.centerY+W(2));
}
#pragma mark 点击事件
- (void)btnClick:(UIButton *)sender{
    [GlobalMethod endEditing];
    NSString * strKey = self.tfSearch.text;
    //    if (strKey.length <2) {
    //        [GlobalMethod showAlert:@"请输入有效数据"];
    //        return;
    //    }
    //    NSArray *aryStr = @[@"物流",@"公司",@"运输",@"集装箱",@"海运",@"货代",@"货",@"代",@"运",@"货运",@"货运代理"];
    //    for (NSString * strItem in aryStr) {
    //        if ([strItem rangeOfString:strKey].location != NSNotFound) {
    //            [GlobalMethod showAlert:@"请输入有效数据"];
    //            return;
    //        }
    //    }
    
    if (self.blockSearch) {
        self.blockSearch(strKey);
    }
}

#pragma mark click
- (void)btnBackClick{
    [GB_Nav popViewControllerAnimated:true];
}
#pragma mark textfield delegate
- (void)textFileAction:(UITextField *)tf{
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [GlobalMethod endEditing];
    return true;
}
- (void)viewBGClick{
    [self.tfSearch becomeFirstResponder];
}

@end
