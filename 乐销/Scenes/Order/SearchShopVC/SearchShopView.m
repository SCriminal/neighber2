//
//  SearchShopView.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/9.
//Copyright © 2020 ping. All rights reserved.
//

#import "SearchShopView.h"

@interface SearchShopNavView ()

@end

@implementation SearchShopNavView

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
        _viewBG = ^(){
            UIView *view = [[UIView alloc] init];
            view.widthHeight = XY(SCREEN_WIDTH - W(30), W(37));
            view.layer.borderWidth = 0.5;
            view.layer.borderColor = [UIColor colorWithRed:239/255.0 green:242/255.0 blue:241/255.0 alpha:1.0].CGColor;
            
            view.layer.backgroundColor = [UIColor colorWithRed:252/255.0 green:252/255.0 blue:252/255.0 alpha:1.0].CGColor;
            view.layer.cornerRadius = 10;
            return view;
        }();
        [_viewBG addTarget:self action:@selector(viewBGClick)];
    }
    return _viewBG;
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.width = SCREEN_WIDTH;
        self.height = self.viewBG.height +W(20);
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

    self.viewBG.leftCenterY = XY(W(15),self.height/2.0);
    
    self.btnSearch.rightCenterY = XY(SCREEN_WIDTH,self.viewBG.centerY);
    self.tfSearch.widthHeight = XY(self.viewBG.width - W(60), self.tfSearch.font.lineHeight);
    self.tfSearch.leftCenterY = XY( self.viewBG.left + W(15),self.viewBG.centerY);
}
#pragma mark 点击事件
- (void)btnClick:(UIButton *)sender{
    [GlobalMethod endEditing];
    NSString * strKey = self.tfSearch.text;
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
    if (self.blockSearch) {
        self.blockSearch(tf.text);
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [GlobalMethod endEditing];
    return true;
}
- (void)viewBGClick{
    [self.tfSearch becomeFirstResponder];
}

@end



@implementation SearchShopCategoryView
#pragma mark 懒加载
- (UIImageView *)arrow{
    if (_arrow == nil) {
        _arrow = [UIImageView new];
        _arrow.image = [UIImage imageNamed:@"shopping_search_down"];
        _arrow.widthHeight = XY(W(15),W(15));
    }
    return _arrow;
}
- (UILabel *)sale{
    if (_sale == nil) {
        _sale = [UILabel new];
        _sale.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _sale.numberOfLines = 1;
        _sale.lineSpace = 0;
    }
    return _sale;
}
- (UILabel *)comprehensive{
    if (_comprehensive == nil) {
        _comprehensive = [UILabel new];
        _comprehensive.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _comprehensive.numberOfLines = 1;
        _comprehensive.lineSpace = 0;
    }
    return _comprehensive;
}
- (UILabel *)distance{
    if (_distance == nil) {
        _distance = [UILabel new];
        _distance.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _distance.numberOfLines = 1;
        _distance.lineSpace = 0;
    }
    return _distance;
}
- (UILabel *)score{
    if (_score == nil) {
        _score = [UILabel new];
        _score.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _score.numberOfLines = 1;
        _score.lineSpace = 0;
    }
    return _score;
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.width = SCREEN_WIDTH;
        [self addSubView];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.arrow];
    [self addSubview:self.sale];
    [self addSubview:self.comprehensive];
    [self addSubview:self.distance];
    [self addSubview:self.score];
    
    //初始化页面
    [self resetViewWithModel:nil];
    [self reconfigTitle];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    [self.comprehensive fitTitle:@"综合排序" variable:0];
    self.comprehensive.leftTop = XY(W(20),W(15));

    self.arrow.leftCenterY = XY(self.comprehensive.right + W(2),self.comprehensive.centerY);
    [self.sale fitTitle:@"销量" variable:0];
    self.sale.leftCenterY = XY(self.arrow.right + W(30),self.comprehensive.centerY);
    [self.distance fitTitle:@"距离" variable:0];
    self.distance.leftCenterY = XY(self.sale.right + W(30),self.comprehensive.centerY);
    [self.score fitTitle:@"积分" variable:0];
    self.score.leftCenterY = XY(self.distance.right + W(30),self.comprehensive.centerY);
    
    //设置总高度
    self.height = self.comprehensive.bottom + W(15);
    
    UIView *view =  [self addControlFrame:CGRectInset(self.comprehensive.frame, -W(15), -W(15)) belowView:self.comprehensive target:self action:@selector(click:)];
    view.tag = 0;
    view =  [self addControlFrame:CGRectInset(self.sale.frame, -W(15), -W(15)) belowView:self.sale target:self action:@selector(click:)];
    view.tag = 1;
    view =  [self addControlFrame:CGRectInset(self.distance.frame, -W(15), -W(15)) belowView:self.distance target:self action:@selector(click:)];
    view.tag = 2;
    view =  [self addControlFrame:CGRectInset(self.score.frame, -W(15), -W(15)) belowView:self.score target:self action:@selector(click:)];
    view.tag = 3;
}

- (void)reconfigTitle{
    for (UILabel * label in self.subviews) {
        if ([label isKindOfClass:UILabel.class]) {
            label.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
            label.textColor = COLOR_666;
        }
    }
    UILabel *labelSelect = nil;
    switch (self.indexSelect) {
        case 0:
            labelSelect = self.comprehensive;
            break;
        case 1:
            labelSelect = self.sale;
            break;
        case 2:
            labelSelect = self.distance;
            break;
        case 3:
            labelSelect = self.score;
            break;
        default:
            break;
    }
    labelSelect.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightBold];
    labelSelect.textColor = COLOR_333;

}


#pragma mark click
- (void)click:(UIView *)view{
    self.indexSelect = (int)view.tag;
    if (self.blockSelect) {
        self.blockSelect(self.indexSelect);
    }
    [self reconfigTitle];
}
@end
