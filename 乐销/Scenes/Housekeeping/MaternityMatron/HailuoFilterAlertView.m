//
//  HailuoFilterAlertView.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/8/15.
//Copyright © 2020 ping. All rights reserved.
//

#import "HailuoFilterAlertView.h"
//date picker
#import "DatePicker.h"
//list view
#import "ListAlertView.h"
//date
#import "NSDate+YYAdd.h"
#import "SelectDistrictView.h"

@interface HailuoFilterAlertView ()<UITextFieldDelegate>
@property (nonatomic, assign) CGRect borderFrame;
@end

@implementation HailuoFilterAlertView

#pragma mark 懒加载
- (UIView *)viewBG{
    if (_viewBG == nil) {
        _viewBG = [UIView new];
        _viewBG.backgroundColor = [UIColor whiteColor];
    }
    return _viewBG;
}

- (UITextField *)tfAgeStart{
    if (_tfAgeStart == nil) {
        _tfAgeStart = [UITextField new];
        _tfAgeStart.font = [UIFont systemFontOfSize:F(15)];
        _tfAgeStart.textAlignment = NSTextAlignmentLeft;
        _tfAgeStart.textColor = COLOR_333;
        _tfAgeStart.borderStyle = UITextBorderStyleNone;
        _tfAgeStart.backgroundColor = [UIColor clearColor];
        _tfAgeStart.delegate = self;
        _tfAgeStart.placeholder = @"填写年龄";
    }
    return _tfAgeStart;
}
- (UITextField *)tfAgeEnd{
    if (_tfAgeEnd == nil) {
        _tfAgeEnd = [UITextField new];
        _tfAgeEnd.font = [UIFont systemFontOfSize:F(15)];
        _tfAgeEnd.textAlignment = NSTextAlignmentLeft;
        _tfAgeEnd.textColor = COLOR_333;
        _tfAgeEnd.borderStyle = UITextBorderStyleNone;
        _tfAgeEnd.backgroundColor = [UIColor clearColor];
        _tfAgeEnd.delegate = self;
        _tfAgeEnd.placeholder = @"填写年龄";
    }
    return _tfAgeEnd;
}
- (UILabel *)selectAddress{
    if (_selectAddress == nil) {
        _selectAddress = [UILabel new];
        _selectAddress.font = [UIFont systemFontOfSize:F(15)];
        _selectAddress.textColor = COLOR_999;
        _selectAddress.backgroundColor = [UIColor clearColor];
        [_selectAddress fitTitle:@"请选择服务地址" variable:0];
    }
    return _selectAddress;
}
- (UILabel *)selectStartTime{
    if (_selectStartTime == nil) {
        _selectStartTime = [UILabel new];
        _selectStartTime.font = [UIFont systemFontOfSize:F(15)];
        _selectStartTime.textColor = COLOR_999;
        _selectStartTime.backgroundColor = [UIColor clearColor];
        [_selectStartTime fitTitle:@"请选择服务开始时间" variable:0];
    }
    return _selectStartTime;
}

-(UIButton *)btnSearch{
    if (_btnSearch == nil) {
        _btnSearch = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnSearch.backgroundColor = COLOR_ORANGE;
        _btnSearch.titleLabel.font = [UIFont systemFontOfSize:F(15)];
        [_btnSearch setTitle:@"筛选" forState:(UIControlStateNormal)];
        [_btnSearch setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btnSearch addTarget:self action:@selector(btnSearchClick) forControlEvents:UIControlEventTouchUpInside];
        [GlobalMethod setRoundView:_btnSearch color:[UIColor clearColor] numRound:5 width:0];
    }
    return _btnSearch;
}
-(UIButton *)btnReset{
    if (_btnReset == nil) {
        _btnReset = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnReset.backgroundColor = COLOR_ORANGE;
        _btnReset.titleLabel.font = [UIFont systemFontOfSize:F(15)];
        [_btnReset setTitle:@"重置" forState:(UIControlStateNormal)];
        [_btnReset setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btnReset addTarget:self action:@selector(btnResetClick) forControlEvents:UIControlEventTouchUpInside];
        [GlobalMethod setRoundView:_btnReset color:[UIColor clearColor] numRound:5 width:0];
    }
    return _btnReset;
}
- (UIView *)viewBlackAlpha{
    if (!_viewBlackAlpha) {
        _viewBlackAlpha = [UIView new];
        _viewBlackAlpha.frame = CGRectMake(0, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT);
        _viewBlackAlpha.backgroundColor =  [[UIColor blackColor] colorWithAlphaComponent:0.5];
    }
    return _viewBlackAlpha;
}
#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.widthHeight = XY(SCREEN_WIDTH, SCREEN_HEIGHT);
        [self addSubView];
        [self addTarget:self action:@selector(closeClick)];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.viewBlackAlpha];
    [self addSubview:self.viewBG];
    [self.viewBG addSubview:self.btnSearch];
    [self.viewBG addSubview:self.btnReset];
    [self.viewBG addSubview:self.tfAgeStart];
    [self.viewBG addSubview:self.tfAgeEnd];
//    [self.viewBG addSubview:self.selectAddress];
    [self.viewBG addSubview:self.selectStartTime];
    //初始化页面
    [self configView];
}

#pragma mark 刷新view
- (void)configView{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    CGFloat remove = W(65);
    self.viewBG.widthHeight = XY(SCREEN_WIDTH, W(280) - remove);
    self.viewBG.centerXTop = XY(SCREEN_WIDTH/2.0,NAVIGATIONBAR_HEIGHT);
//    {
//        UIView * viewBorder = [self generateBorder:CGRectMake(W(96), W(20), W(259), W(45))];
//        [self.viewBG addSubview:viewBorder];
//        [viewBorder addTarget:self action:@selector(selectAddressClick)];
//        self.selectAddress.leftCenterY = XY(viewBorder.left + W(15),viewBorder.centerY);
//
//        UILabel * l = [UILabel new];
//        l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
//        l.textColor = COLOR_333;
//        l.backgroundColor = [UIColor clearColor];
//        [l fitTitle:@"服务地址" variable:0];
//        l.leftCenterY = XY(W(20), viewBorder.centerY);
//        [self.viewBG addSubview:l];
//
//        UIImageView *ivDown = [UIImageView new];
//        ivDown.image = [UIImage imageNamed:@"accountDown"];
//        ivDown.widthHeight = XY(W(25),W(25));
//        [self.viewBG addSubview:ivDown];
//        ivDown.rightCenterY = XY(viewBorder.right - W(10), viewBorder.centerY);
//
//    }
    
    {
        UIView * viewBorder = [self generateBorder:CGRectMake(W(96), W(85)-remove, W(259), W(45))];
        [self.viewBG addSubview:viewBorder];
        [viewBorder addTarget:self action:@selector(selectTimeStartClick)];
        self.selectStartTime.leftCenterY = XY(viewBorder.left + W(15),viewBorder.centerY);
        
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        l.textColor = COLOR_333;
        l.backgroundColor = [UIColor clearColor];
        [l fitTitle:@"服务时间" variable:0];
        l.leftCenterY = XY(W(20), viewBorder.centerY);
        [self.viewBG addSubview:l];
        
        UIImageView *ivDown = [UIImageView new];
        ivDown.image = [UIImage imageNamed:@"accountDown"];
        ivDown.widthHeight = XY(W(25),W(25));
        [self.viewBG addSubview:ivDown];
        ivDown.rightCenterY = XY(viewBorder.right - W(10), viewBorder.centerY);
        
    }
    
    {
        UIView * viewBorder = [self generateBorder:CGRectMake(W(96), W(150)-remove, W(111), W(45))];
        [self.viewBG addSubview:viewBorder];
        self.tfAgeStart.widthHeight = XY(viewBorder.width - W(30),viewBorder.height);
        self.tfAgeStart.leftCenterY = XY(viewBorder.left + W(15),viewBorder.centerY);
        [viewBorder addTarget:self action:@selector(startDateClick)];
        
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        l.textColor = COLOR_333;
        l.backgroundColor = [UIColor clearColor];
        [l fitTitle:@"年龄范围" variable:0];
        l.leftCenterY = XY(W(20), viewBorder.centerY);
        [self.viewBG addSubview:l];
        
        UIView * viewLine = [UIView new];
        viewLine.widthHeight = XY(W(9), 1);
        viewLine.backgroundColor = [UIColor colorWithHexString:@"#D9D9D9"];
        viewLine.rightCenterY = XY(viewBorder.right + W(14), viewBorder.centerY);
        [self.viewBG addSubview:viewLine];
        
    }
    {
        UIView * viewBorder = [self generateBorder:CGRectMake(W(244), W(150)-remove, W(111), W(45))];
        [self.viewBG addSubview:viewBorder];
        self.tfAgeEnd.widthHeight = XY(viewBorder.width - W(30),viewBorder.height);
        self.tfAgeEnd.leftCenterY = XY(viewBorder.left + W(15),viewBorder.centerY);
        [viewBorder addTarget:self action:@selector(endDateClick)];
        
    }
    
    
    self.btnSearch.widthHeight = XY(W(160),W(45));
    self.btnReset.widthHeight = XY(W(160),W(45));
    self.btnSearch.leftBottom = XY(self.viewBG.width/2.0 + W(7.5),self.viewBG.height- W(20));
    self.btnReset.rightBottom = XY(self.viewBG.width/2.0 - W(7.5),self.viewBG.height- W(20));
}
- (UIView *)generateBorder:(CGRect)frame{
    UIView * viewBorder = [UIView new];
    viewBorder.backgroundColor = [UIColor clearColor];
    [GlobalMethod setRoundView:viewBorder color:COLOR_LINE numRound:5 width:1];
    viewBorder.frame = frame;
    return viewBorder;
}
#pragma mark text delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [GlobalMethod endEditing];
    return true;
}

#pragma mark 销毁
- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
#pragma mark click
- (void)startDateClick{
    [self.tfAgeStart becomeFirstResponder];
}
- (void)endDateClick{
    [self.tfAgeEnd becomeFirstResponder];
}
- (void)closeClick{
    if ([self fetchFirstResponder]) {
        [GlobalMethod endEditing];
        return;
    }
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
- (void)show{
    self.alpha = 1;
    [GB_Nav.lastVC.view addSubview:self];
}


- (void)selectTimeStartClick{
    [GlobalMethod endEditing];
    WEAKSELF
    DatePicker * datePickerView = [DatePicker initWithMinDate:[GlobalMethod exchangeStringToDate:@"1900" formatter:@"yyyy"] dateSelectBlock:^(NSDate *date) {
        weakSelf.dateStart = date;
        [weakSelf.selectStartTime fitTitle:[GlobalMethod exchangeDate:date formatter:TIME_DAY_SHOW] variable:0];
        weakSelf.selectStartTime.textColor = COLOR_333;
    } type:ENUM_PICKER_DATE_YEAR_MONTH_DAY];
    [GB_Nav.lastVC.view addSubview:datePickerView];
}

- (void)selectAddressClick{
    [GlobalMethod endEditing];
    WEAKSELF
    SelectDistrictView * selectView = [SelectDistrictView new];
    selectView.blockCitySeleted = ^(ModelProvince *pro, ModelProvince *city, ModelProvince *area) {
        [weakSelf.selectAddress fitTitle:[NSString stringWithFormat:@"%@%@%@",pro.name,[pro.name isEqualToString:city.name]?@"":city.name,area.name] variable:W(208)];
        weakSelf.selectAddress.textColor = COLOR_333;
        weakSelf.addressID = area.iDProperty;
    };
    [GB_Nav.lastVC.view addSubview:selectView];
}

- (void)btnSearchClick{
    if (self.blockSearchClick) {
        self.blockSearchClick(self.addressID,self.dateStart,self.tfAgeStart.text.intValue,self.tfAgeEnd.text.intValue);
    }
    [GlobalMethod endEditing];
    [self removeFromSuperview];
}

- (void)btnResetClick{
    self.addressID = 0;
    [self.selectAddress fitTitle:@"请选择服务地址" variable:0];
    self.selectAddress.textColor = COLOR_999;
    
    self.dateStart = nil;
    [self.selectStartTime fitTitle:@"请选择服务开始时间" variable:0];
    self.selectStartTime.textColor = COLOR_999;
    
    self.tfAgeEnd.text = nil;
    self.tfAgeStart.text = nil;
    
    [self btnSearchClick];
    
}
@end
